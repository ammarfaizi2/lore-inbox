Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVDYUmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVDYUmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDYUmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:42:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:6039 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261174AbVDYUhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:37:53 -0400
Date: Mon, 25 Apr 2005 22:41:07 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
In-Reply-To: <20050425165826.GB11938@redhat.com>
Message-ID: <Pine.LNX.4.62.0504252105430.2941@dragon.hyggekrogen.localhost>
References: <20050425165826.GB11938@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few small comments below. I just did a quick scan of the code - and 
damn, there's a lot of it in one patch... 


On Tue, 26 Apr 2005, David Teigland wrote:

> 
> The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> Creates lockspaces which give applications separate contexts/namespaces in
> which to do their locking.  Manages locks on resources' grant/convert/wait
> queues.  Sends and receives high level locking operations between nodes.
> Delivers completion and blocking callbacks (ast's) to lock holders.
> Manages the distributed directory that tracks the current master node for
> each resource.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
> ---
> 
> +void dlm_print_lkb(struct dlm_lkb *lkb)
> +{
> +	printk("lkb: nodeid %d id %x remid %x exflags %x flags %x\n"
             ^^^
              Explicit loglevel here?

[...]

> +void dlm_print_rsb(struct dlm_rsb *r)
> +{
> +	printk("rsb: nodeid %d flags %lx trial %x name %s\n",
             ^^^
              Loglevel?

[...]

> +static int can_be_queued(struct dlm_lkb *lkb)
> +{
> +	return (!(lkb->lkb_exflags & DLM_LKF_NOQUEUE));
return is not a function.

> +static int dir_remove(struct dlm_rsb *r)
> +{
> +	int to_nodeid = dlm_dir_nodeid(r);
> +
> +	if (to_nodeid != dlm_our_nodeid())
> +		send_remove(r);
> +	else
> +		dlm_dir_remove_entry(r->res_ls, to_nodeid,
> +				     r->res_name, r->res_length);
> +	return 0;
> +}
Always returning 0 - then why not just a void function?


> +static int _search_rsb(struct dlm_ls *ls, char *name, int len, int b,
> +		       unsigned int flags, struct dlm_rsb **r_ret)
> +{
> +	struct dlm_rsb *r;
> +	int error;
> +
> +	error = search_rsb_list(&ls->ls_rsbtbl[b].list, name, len, flags, &r);
> +	if (!error) {
> +		kref_get(&r->res_ref);
> +		goto out;
> +	}
> +	error = search_rsb_list(&ls->ls_rsbtbl[b].toss, name, len, flags, &r);
> +	if (!error) {
You could make this 
	if (error)
		goto out;
and save a level of indentation for the remaining code.

> +		list_move(&r->res_hashchain, &ls->ls_rsbtbl[b].list);
> +
> +		if (r->res_nodeid == -1) {
> +			clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
> +			clear_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags);
> +			r->res_trial_lkid = 0;
> +		} else if (r->res_nodeid > 0) {
> +			clear_bit(RESFL_MASTER_WAIT, &r->res_flags);
> +			set_bit(RESFL_MASTER_UNCERTAIN, &r->res_flags);
> +			r->res_trial_lkid = 0;
> +		} else {
> +			DLM_ASSERT(r->res_nodeid == 0,
> +				   dlm_print_rsb(r););
> +			DLM_ASSERT(!test_bit(RESFL_MASTER_WAIT, &r->res_flags),
> +				   dlm_print_rsb(r););
> +			DLM_ASSERT(!test_bit(RESFL_MASTER_UNCERTAIN,
> +					     &r->res_flags),);
> +		}
> +	}
> + out:
> +	*r_ret = r;
> +	return error;
> +}
[...]

> +void dlm_scan_rsbs(struct dlm_ls *ls)
> +{
> +	int i, count = 0;
> +
> +	if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
> +		return;
> +
> +	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
> +		count += shrink_bucket(ls, i);
> +		cond_resched();
> +	}
> +}
What's the use of the `count' variable here? it's a local variable, and 
all you ever do is add values to it, you don't ever use the value of 
`count' for anything. Why not just get rid of `count' alltogether?


> +static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
> +{
> +	struct dlm_lkb *lkb;
> +	uint32_t lkid;
> +	uint16_t bucket;
> +
> +	lkb = allocate_lkb(ls);
> +	if (!lkb)
> +		return -ENOMEM;
> +
> +	lkb->lkb_nodeid = -1;
> +	lkb->lkb_grmode = DLM_LOCK_IV;
> +	kref_init(&lkb->lkb_ref);
> +
> +	get_random_bytes(&bucket, sizeof(bucket));
> +	bucket &= (ls->ls_lkbtbl_size - 1);
> +
> +	write_lock(&ls->ls_lkbtbl[bucket].lock);
> +	lkid = bucket | (ls->ls_lkbtbl[bucket].counter++ << 16);
> +	/* FIXME: do a find to verify lkid not in use */
	   ^^^^^--- Why not fix that issue before merging with mainline?

> +
> +	DLM_ASSERT(lkid, );
                      ^^^--- looks like a parameter is mising.

[...]

> +/*
> + * Two stage 1 varieties:  dlm_lock() and dlm_unlock()
> + */
> +
> +int dlm_lock(dlm_lockspace_t *lockspace,
> +	     int mode,
> +	     struct dlm_lksb *lksb,
> +	     uint32_t flags,
> +	     void *name,
> +	     unsigned int namelen,
> +	     uint32_t parent_lkid,
> +	     void (*ast) (void *astarg),
> +	     void *astarg,
> +	     void (*bast) (void *astarg, int mode),
> +	     struct dlm_range *range)
> +{
             ^^^^^ Why this difference in style for the function 
                   parameters compared to the other functions?
                   Using a common style is often prefered.
[...]


> +/* change some property of an existing lkb, e.g. mode, range */
> +
> +static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)

This is just a personal preference of mine, but why the blank line between 
the comment describing the function and the function itself?  Many 
functions, many comments, lots of blank lines that are really not needed, 
lots of screen realestate wasted... Ohh well, no big deal, just my 
personal preference is to not waste screen space like that.

[...]

> +static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
> +{
> +	int error;
> +
> +	if (is_remote(r))
> +		/* receive_unlock() calls call do_unlock() on remote node */
                                    ^^^^^^^^^^^--- small typo there?
[...]

> +static void set_lvb_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
> +{
> +	int b;
> +
> +	/* b=1 lvb returned to caller
> +	   b=0 lvb written to rsb or invalidated
> +	   b=-1 do nothing */
      b==[1,0,-1] surely...?

[...]

> +static void set_lvb_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
> +{
> +	if (lkb->lkb_grmode < DLM_LOCK_PW)
> +		return;
goto out;
> +
> +	if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
> +		set_bit(RESFL_VALNOTVALID, &r->res_flags);
> +		return;
goto out;
> +	}
> +
> +	if (!lkb->lkb_lvbptr)
> +		return;
goto out;
> +
> +	if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
> +		return;
goto out;
> +
> +	if (!r->res_lvbptr)
> +		r->res_lvbptr = allocate_lvb(r->res_ls);
> +
> +	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);
> +	r->res_lvbseq++;
> +	clear_bit(RESFL_VALNOTVALID, &r->res_flags);
out:
	return;
> +}
A single return function exit point instead of multiple reduces the risk 
of errors when code is later modified.
Applies to many other functions besides this one (and this one may not 
even be the best example, but hey, I wanted to make that comment, and 
this function was at hand).

[...]

> +static int grant_pending_locks(struct dlm_rsb *r)
> +{
> +	struct dlm_lkb *lkb, *s;
> +	int high = DLM_LOCK_IV;
> +
> +	DLM_ASSERT(is_master(r), dlm_print_rsb(r););
> +
> +	high = grant_pending_convert(r, high);
> +	high = grant_pending_wait(r, high);
> +
> +	if (high == DLM_LOCK_IV)
> +		return 0;
> +
> +	/*
> +	 * If there are locks left on the wait/convert queue then send blocking
> +	 * ASTs to granted locks based on the largest requested mode (high)
> +	 * found above.  This can generate spurious blocking ASTs for range
> +	 * locks. FIXME: highbast < high comparison not valid for PR/CW.
> +	 */
> +
> +	list_for_each_entry_safe(lkb, s, &r->res_grantqueue, lkb_statequeue) {
> +		if (lkb->lkb_bastaddr && (lkb->lkb_highbast < high) &&
> +		    !__dlm_compat_matrix[lkb->lkb_grmode+1][high+1]) {
> +			queue_bast(r, lkb, high);
> +			lkb->lkb_highbast = high;
> +		}
> +	}
> +
> +	return 0;
> +}
This function only ever returns 0 - why not make it return void instead?

[...]

> +static int send_message(struct dlm_mhandle *mh, struct dlm_message *ms)
> +{
> +	dlm_message_out(ms);
> +	dlm_lowcomms_commit_buffer(mh);
> +	return 0;
> +}
make it return void instead? since you only ever return 0 anyway.

[...]

> +static int purge_queue(struct dlm_rsb *r, struct list_head *queue)
> +{
> +	struct dlm_ls *ls = r->res_ls;
> +	struct dlm_lkb *lkb, *safe;
> +
> +	list_for_each_entry_safe(lkb, safe, queue, lkb_statequeue) {
> +		if (!is_master_copy(lkb))
> +			continue;
> +
> +		if (dlm_is_removed(ls, lkb->lkb_nodeid)) {
> +			del_lkb(r, lkb);
> +			/* this put should free the lkb */
> +			if (!put_lkb(lkb))
> +				log_error(ls, "purged lkb not released");
> +		}
> +	}
> +	return 0;
> +}
If you only ever return 0, why return a value at all?
This is the case with many functions, a few of which I've most certainly 
missed (and I'm not going to keep repeatign myself with this any more), 
so take a closer look yourself :-)

[...]

> +}
> +
> +
Ok, this is nitpicking in the extreme; one newline at end-of-file is 
super, but surely you don't need two. ;-)

One other general thing; you seem to have a lot of functions that return 
0/1 and a lot that return TRUE/FALSE - why not be consistent?


-- 
Jesper Juhl


