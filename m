Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVDYQKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVDYQKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVDYQIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:08:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:31875 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262689AbVDYQG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:06:28 -0400
Date: Mon, 25 Apr 2005 18:09:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/7] dlm: device interface
In-Reply-To: <20050425151303.GF6826@redhat.com>
Message-ID: <Pine.LNX.4.62.0504251754330.2941@dragon.hyggekrogen.localhost>
References: <20050425151303.GF6826@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, David Teigland wrote:

>  
> This is a separate module from the dlm.  It exports the dlm api to user
> space through a misc device.  Applications use a library (libdlm) which
> communicates with the kernel through this device.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
[...]
> +static void release_lockinfo(struct lock_info *li)
> +{
> +	put_file_info(li->li_file);
> +
> +	down_write(&lockinfo_lock);
> +	idr_remove(&lockinfo_idr, li->li_lksb.sb_lkid);
> +	up_write(&lockinfo_lock);
> +
> +	if (li->li_lksb.sb_lvbptr)
> +		kfree(li->li_lksb.sb_lvbptr);
> +	kfree(li);

checking li->li_lksb.sb_lvbptr for NULL here is redundant. kfree() checks 
for NULL itself - kfree(0) is perfectly valid, so just do 
	kfree(li->li_lksb.sb_lvbptr);
	kfree(li);
and get rid if the  if (li->li_lksb.sb_lvbptr)  bit.

> +static void bast_routine(void *param, int mode)
> +{
> +	struct lock_info *li = param;
> +
> +	if (li && li->li_bastaddr) {
> +		add_to_astqueue(li, li->li_bastaddr, li->li_bastparam, 0);
> +	}
       ^^^
       superfluous bracket.

[...]
> +static void ast_routine(void *param)
> +{
> +	struct lock_info *li = param;
> +
> +	/* Param may be NULL if a persistent lock is unlocked by someone else */
> +	if (!li)
> +		return;
> +
> +	/* If this is a succesful conversion then activate the blocking ast
> +	 * args from the conversion request */
> +	if (!test_bit(LI_FLAG_FIRSTLOCK, &li->li_flags) &&
> +	    li->li_lksb.sb_status == 0) {
> +
> +		li->li_bastparam = li->li_pend_bastparam;
> +		li->li_bastaddr = li->li_pend_bastaddr;
> +		li->li_pend_bastaddr = NULL;
> +	}
> +
> +	/* If it's an async request then post data to the user's AST queue. */
> +	if (li->li_castaddr) {
> +		int lvb_updated = 0;
> +
> +		/* See if the lvb has been updated */
> +		if (dlm_lvb_operations[li->li_grmode+1][li->li_rqmode+1] == 1)
> +			lvb_updated = 1;
> +
> +		if (li->li_lksb.sb_status == 0)
> +			li->li_grmode = li->li_rqmode;
> +
> +		/* Only queue AST if the device is still open */
> +		if (test_bit(1, &li->li_file->fi_flags))
> +			add_to_astqueue(li, li->li_castaddr, li->li_castparam, lvb_updated);
> +
> +		/* If it's a new lock operation that failed, then
> +		 * remove it from the owner queue and free the
> +		 * lock_info.
> +		 */
> +		if (test_and_clear_bit(LI_FLAG_FIRSTLOCK, &li->li_flags) &&
> +		    li->li_lksb.sb_status != 0) {
> +
> +			/* Wait till dlm_lock() has finished */
> +			down(&li->li_firstlock);
> +			up(&li->li_firstlock);
> +
> +			spin_lock(&li->li_file->fi_li_lock);
> +			list_del(&li->li_ownerqueue);
> +			spin_unlock(&li->li_file->fi_li_lock);
> +			release_lockinfo(li);
> +			return;
> +		}
> +		/* Free unlocks & queries */
> +		if (li->li_lksb.sb_status == -DLM_EUNLOCK ||
> +		    li->li_cmd == DLM_USER_QUERY) {
> +			release_lockinfo(li);
> +		}
> +	}
> +	else {
else should be on same line as bracket according to 
Documentation/CodingStyle
	if (foo) {
		/* ... */
	} else {
		/* ... */
	}

[...]

> +/* Open on control device */
> +static int dlm_ctl_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = NULL;
> +	return 0;
> +}
If you are always going to return zero, then why not just have the 
function return void instead?


> +/* Close on control device */
> +static int dlm_ctl_close(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
return void? and what's the purpose of this function? seems silly to me to 
have a function that does nothing but return 0 ever.

[...]
> +		if (lsinfo->ls_lockspace) {
> +			if (test_bit(LS_FLAG_AUTOFREE, &lsinfo->ls_flags)) {
> +//TODO this breaks!				unregister_lockspace(lsinfo, 1);
> +			}
> +		}
> +		else {
should be "} else {" - there are more cases of this elsewhere, but I'm not 
going to point them all out.

> +static int do_user_lock(struct file_info *fi, uint8_t cmd, struct dlm_lock_params *kparams)
> +{
> +	struct lock_info *li;
> +	int status;
> +
> +	/*
> +	 * Validate things that we need to have correct.
> +	 */
> +	if (!kparams->castaddr)
> +		return -EINVAL;
> +
> +	if (!kparams->lksb)
> +		return -EINVAL;
> +
> +	/* Persistent child locks are not available yet */
> +	if ((kparams->flags & DLM_LKF_PERSISTENT) && kparams->parent)
> +		return -EINVAL;
> +
> +        /* For conversions, there should already be a lockinfo struct,
> +	   unless we are adopting an orphaned persistent lock */
	^^^^Why indent this comment with two extra spaces and not just a 
tab like the other ones?

> +	if (kparams->flags & DLM_LKF_CONVERT) {
> +
> +		li = get_lockinfo(kparams->lkid);

Why the extra blank line between the if statement and the first statement 
inside the if?


-- 
Jesper Juhl

