Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFAA5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFAA5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFAA5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:57:16 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:1467 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261227AbVFAAxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:53:36 -0400
Date: Tue, 31 May 2005 17:53:04 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: wim.coekaerts@oracle.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com
Subject: Re: review of ocfs2
Message-ID: <20050601005304.GA1153@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050530112101.GF15326@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530112101.GF15326@wotan.suse.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, May 30, 2005 at 01:21:01PM +0200, Andi Kleen wrote:
> 
> Over the weekend I read the ocfs2 patch (without configfs). Overall
> it looks pretty good and in good shape for merging.  Most of the
> stuff I noted are nits, not major things.

Great!

> ocfs2 review.
> 
> I mostly commented on details, since I am not really qualified
> to comment on the higher level algorithms right now.

Well, thanks for the very thorough review. I'll try to get a good answer to
as many of your comments below as possible :)

> What seems to be definitely lacking is proper handling of on disk corruptions.
> I suppose this will need some time to fix, so I would suggest
> clear documentation of this shortcomming at least.

Yes, I'll make sure that gets noted in the proper documentation. The general
plan is to give the file system the ability to go into readonly mode when it
encounters a corruption. As it stands I think alot of those paths could
probably cleanly unwind themselves when they see a bad block.

> Mount options
> =============
> None that should be manually specified by the user right now.
> 
> Note even noatime or ro? barrier=0/1 for JBD would be nice too and the
> security related options (nodev,nosuid,noexec) which might be even
> important in a cluster. How about the JBD journaling modi?

'barrier=' just got added (and ocfs2.txt updated). That code is in
2.6.12-rc5-mm1. Many of the others are slated for the near future.

>  config JBD
> -# CONFIG_JBD could be its own option (even modular), but until there are
> -# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
> -# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
> -	tristate
> -	default EXT3_FS
> +	tristate "Journal Block Device support"
> 
> I would keep it hidden for now and just select from EXT3/OCFS2

Thanks, this also has been fixed in 2.6.12-rc5-mm1.

> +	  OCFS2 is a shared disk cluster file system.
> +
> +	  To learn more about OCFS2 and to download the file system tools,
> +	  visit the OCFS2 website at: http://oss.oracle.com/projects/ocfs2/
> 
> I think you need some more description here. Sometimes people even 
> want to configure kernels without internet access. And cutting and
> pasting URLs just configure a kernel is also not nice.

Thanks. I'll update the description and add some information on
features/limitations.

> +	new_eb_bhs = kmalloc(size, GFP_KERNEL);
> +	if (!new_eb_bhs) {
> +		status = -ENOMEM;
> +		mlog_errno(status);
> +		goto bail;
> +	}
> +	memset(new_eb_bhs, 0, size);
> 
> Should be kcalloc()

Thanks for catching those. Alot of that code (kmalloc / memset) was written
before kcalloc was introduced so we're slowly changing those remnants over.

> +		eb->h_next_leaf_blk = 0;
> +		eb_el->l_tree_depth = i;
> +		eb_el->l_next_free_rec = 1;
> +		eb_el->l_recs[0].e_cpos = fe->i_clusters;
> +		eb_el->l_recs[0].e_blkno = next_blkno;
> +		eb_el->l_recs[0].e_clusters = 0;
> 
> Doesn't this need some cpu_to_le... ? 

Yes, as does a large chunk of the rest of the code. Big endian friendliness
is another item on the short list of features once we've fixed some more
bugs.

> +	status = ocfs_journal_access(handle, inode, last_eb_bh, 
> +				     OCFS_JOURNAL_ACCESS_WRITE);
> +	if (status < 0) {
> +		mlog_errno(status);
> +		goto bail;
> +	}
> +	status = ocfs_journal_access(handle, inode, fe_bh, 
> +				     OCFS_JOURNAL_ACCESS_WRITE);
> 
> Don't you need to undo these write accesses in the bail case?
> Or does the brelse take care of it?

I'm not sure that needs to be undone. It should be perfectly legal to call
journal_access against a buffer and never dirty it, assuming you haven't
ever changed the buffer data.

> +	/* We traveled all the way to the bottom and found nothing. */
> 
> Very philosophical.

Heh, ok I can update that to be more descriptive :)

> +	BUG_ON(!down_trylock(&tl_inode->i_sem));
> 
> Don't do this. BUG_ONs are not supposed to have side effects
> and there is even a CONFIG_BUG that defines them away.

Well the side effect here is that it grabbed the lock in which case we want
to BUG. Otherwise, it already has the sem and this does nothing. it would be
better if there was something like assert_spin_locked() for sems.

> +		*tl_copy = kmalloc(tl_bh->b_size, GFP_KERNEL);
> 
> That should be usually PAGE_SIZE no? Perhaps use __get_free_page directly.

What about non PAGE_SIZE block sizes? Is it still worth using
__get_free_page when those are taken into consideration?

> Same further down the function.
> 
> +		}
> +		OCFS_ASSERT(i >= 0);
> 
> Isn't that identical to BUG_ON()? How about you use that directly? 

Thanks. We've been slowly moving OCFS_ASSERT to BUG_ON.

> BTW I hope you hardened all these BUGs against on disk corruption.
> It would be bad to oops the kernel just because a disk returned
> garbage.  The ones here start to look suspicious, also several
> uses of OCFS2_BUG_ON_INVALID_EXTEND_BLOCK. Otherwise unbreakable
> Linux might not stay unbreakable ;-) 

ACK - see my comment above.

> +	down_write(&OCFS_I(inode)->ip_alloc_sem);
> 
> and 
> +	down(&tl_inode->i_sem);
> 
> The locking order here looks a bit suspicious. Are you sure
> that is ok? 

Yes :)

The long story is that the truncate log inode (tl_inode) always gets locked
*after* and regular files are fully locked. Truncated bits are put into the
log, and it is then unlocked for any other concurrent truncates. If the
truncate needs to loop again (to remove more data) then the truncate log is
relocked in the same place, but lock ordering is preserved as the inode
undergoing a truncate has remained locked.

> +void ocfs_free_truncate_context(ocfs2_truncate_context *tc)
> +{
> +	if (tc->tc_ext_alloc_inode) {
> +		if (tc->tc_ext_alloc_locked)
> +			ocfs2_meta_unlock(tc->tc_ext_alloc_inode, 1);
> +
> +		up(&tc->tc_ext_alloc_inode->i_sem);
> 
> Hmm. Really scary locking... Normally keeping locks around like
> this is strongly discouraged.

Well that's simply a convenience function... If you look at where it's
called, the lock isn't really held for any longer than necessary.

> +	OCFS_ASSERT(!ocfs2_inode_is_fast_symlink(inode));
> 
> Hopefully no side effect.

No side effect there, that function only tests the fast-symlinkness of an
inode.

> +
> +	if ((iblock << inode->i_sb->s_blocksize_bits) > PATH_MAX + 1) {
> 
> PATH_MAX? 

Yikes!

I think what that code was trying to do is make sure that we don't read off
the end of the file. That is a horrible way to do so. I'll get
that fixed ASAP.

> +	/* We don't use the page cache to create symlink data, so if
> +	 * need be, copy it over from the buffer cache. */
> +	if (!buffer_uptodate(bh_result) && ocfs_inode_is_new(inode)) {
> 
> Races here?

I'm not sure... I was fairly certain the symlink code was fine. At any rate
perhaps a better comment is in order.

> +	set_buffer_new(bh_result);
> +	OCFS_I(inode)->ip_mmu_private += inode->i_sb->s_blocksize;
> +
> +bail:
> +	if (err < 0)
> +		err = -EIO;
> 
> I would move that before the gotos.

I think the goto's were trying to avoid that actually...

> +//	mlog_entry("(bh->b_blocknr = %u, uptodate = %d)\n", bh->b_blocknr,
> +//		       uptodate);
> 
> Please remove.

No problem.

> +static inline void CLEAR_BH_SEQNUM(struct buffer_head *bh)
> 
> Inlines should be normally not upper case.

Agreed. I'll fix that.

> heartbeat.c
> 
> I think it has too many #includes, e.g. I don't think it needs
> seq_file. Perhaps strip them and readd only what is needed.

Yes definitely too many defines. Actually some other parts of cluster/ were
also pulling in way more than they needed to.

> +
> +	char			hr_dev_name[BDEVNAME_SIZE];
> 
> Wouldn't it be better to kmalloc this to avoid arbitary limits? 

That's part of a larger structure which is always kmalloc'd.
 
> +	/* we don't care if these wrap.. the state transitions below
> +	 * clear at the right places */
> +	cputime = le64_to_cpu(hb_block->hb_seq);
> +	if (slot->ds_last_time != cputime)
> +		slot->ds_changed_samples++;
> +	else
> +		slot->ds_equal_samples++;
> +	slot->ds_last_time = cputime;
> 
> This probably needs endian work too. Lots more occurrences further down.

Actually 'slot' there is *not* a disk structure.

> +	/* let the person who launched us know when things are steady */
> +	if (!change && (atomic_read(&reg->hr_steady_iterations) != 0)) {
> +		if (atomic_dec_and_test(&reg->hr_steady_iterations))
> +			wake_up(&hb_steady_queue);
> +	}
> +
> +	/* Make sure the write hits disk before we return. */
> +	hb_wait_on_io(reg, &write_wc);
> +	bio_put(write_bio);
> 
> Hmm. I don't think DLM data writes are controlled by JBD right? So you
> properly need to take care of barriers when setting up the BIO,
> to make sure the write really reaches the platter
> (but add an option to turn it off) 

Those are disk heartbeats and yes they are not controlled by JBD. We could
certainly use a barrier to ensure that our reads complete before the write,
but are you saying that the write may never hit the platter without one?

> +	/* Heartbeat and fs min / max block sizes are the same. */
> +	if (bytes > 4096 || bytes < 512)
> +		return -ERANGE;
> 
> That hardcodes PAGE_SIZE? Nasty nasty...

That's actually meant to be a block size check.

> ocfs will work on IA64 with 16k blocks, won't it?

No it won't though there's no technical reason why it couldn't. Usually
though in OCFS2 we have folks bump up their cluster sizes which can go up to
1 meg. Cluster size of course only affects data blocks.

> Anyways even if it doesn't yet this should be defines and be gotten
> from elsewhere.

Ok, that's a good idea.

> +static char ocfs2_hb_ctl_path[PATH_MAX] = "/sbin/ocfs2_hb_ctl";
> 
> PATH_MAX is quite a lot of memory for this.

Hmm, it seems hotplug_path is only 256 characters. This has similar usage in
that it's a sysctl which user sets. We can definitely shrink that down.

> +static int net_sys_err_translations[NET_ERR_MAX] =
> +		{[NET_ERR_NONE] = 0,
> +		 [NET_ERR_NO_HNDLR] = -ENOPROTOOPT,
> +		 [NET_ERR_OVERFLOW]  = -EOVERFLOW,
> +		 [NET_ERR_DIED] = -EHOSTDOWN,};
> 
> This shouldn't be in a header, where it is duplicated in all includers.

Agreed, that can be easily moved.

> You might want to use IP_RECVERR. It tells TCP to report errors much
> quicker.

Excellent, I'll look into this.
 
> +	DLM_ASSERT(lock);
> +	DLM_ASSERT(res);
> +	lksb = lock->lksb;
> +	DLM_ASSERT(lksb);
> +	fn = lock->ast;
> +	DLM_ASSERT(fn);
> 
> The asserts are not needed because the code should oops anyways
> when they are NULL.

All those unnecessary asserts are in the process of being removed.

> +	if (locklen > DLM_LOCKID_NAME_MAX) {
> +		ret = DLM_IVBUFLEN;
> +		printk("Invalid name length in proxy ast handler!\n");
> 
> KERN_ERR ?

Good call. It seems the printks in dlm/ (and probably other parts of the
code) could be audited for the proper printk level.

> +	memset(&past, 0, sizeof(dlm_proxy_ast));
> +	past.node_idx = dlm->node_num;
> +	past.type = msg_type;
> +	past.blocked_type = blocked_type;
> +	past.namelen = res->lockname.len;
> +	strncpy(past.name, res->lockname.name, past.namelen);
> 
> 0 termination? (strncpy is a death trap) 

Yeah we're planning on moving to non zero terminated strings in there.

> +#ifndef DLMCOMMON_H
> +#define DLMCOMMON_H
> +
> +#include <linux/kref.h>
> +
> +#define DLM_ASSERT(x)       ({  if (!(x)) { printk("assert failed! %s:%d\n", __FILE__, __LINE__); BUG(); } })
> 
> define to BUG_ON(!(x)) will be more efficient probably. Architectures make
> sure to optimize that properly.

Yes thanks.

> +	/* please keep these next 3 in this order 
> +	 * some funcs want to iterate over all lists */
> 
> Nasty nasty. How about using a table with offsetof() somewhere? 

Ack. This has to get fixed...

> +	unsigned long maybe_map[BITS_TO_LONGS(NM_MAX_NODES)];
> +	unsigned long vote_map[BITS_TO_LONGS(NM_MAX_NODES)];
> +	unsigned long response_map[BITS_TO_LONGS(NM_MAX_NODES)];
> +	unsigned long node_map[BITS_TO_LONGS(NM_MAX_NODES)];
> +	u8 master;
> +	u8 new_master;
> 
> This limits the nodes to max 255 right? Is that a good thing? 

Right now that's our stated maximum.

> +// NET_MAX_PAYLOAD_BYTES is roughly 4080
> 
> Where does this strange number come from? 
> +// 240 * 16 = 3840 
> +// 3840 + 112 = 3952 bytes
> +// leaves us about 128 bytes
> +#define DLM_MAX_MIGRATABLE_LOCKS   240 

Yikes, that *really* should be math based on NET_MAX_PAYLOAD_BYTES and the
size of whatever structure is involved there.

I'll make sure that gets fixed...

> +		if (status < 0 &&
> +		    status != -ENOPROTOOPT &&
> +		    status != -ENOTCONN) {
> +			mlog(ML_NOTICE, "Error %d sending domain exit message "
> +			     "to node %d\n", status, node);
> +
> +			/* Not sure what to do here but lets sleep for
> +			 * a bit in case this was a transient
> +			 * error... */
> +			schedule();
> 
> This won't do much if you don't use set_current_state.
> Most likely you want schedule_timeout(1) or somesuch here.

Good idea.

> Since we might have multiple DLMs eventually perhaps adding 
> a unique prefix would be a good idea.

That wouldn't be a problem. Hmm, what to call it though :)

> +	lvb_buf = kmalloc(readlen, GFP_KERNEL);
> +	if (!lvb_buf)
> +		return -ENOMEM;
> +
> +	user_dlm_read_lvb(inode, lvb_buf, readlen);
> +	bytes_left = __copy_to_user(buf, lvb_buf, readlen);
> 
> It is a bit suspicious that you do the __copy_to_user with a different
> length parameter than the access_ok. Safer to just use copy_to_user

Good idea.

> +			list_del_init(&res->dirty);
> +			spin_unlock(&res->spinlock);
> +			spin_unlock(&dlm->spinlock);
> 
> Tricky locking deserves a comment? 

Agreed.

> +	/* according to spec and opendlm code
> 
> Could you add a reference to that specification somewhere? 

Yes, we'll add directions on how to find it.

> + * userdlm.c
> + *
> + * Code which implements the kernel side of a minimal userspace
> + * interface to our DLM.
> 
> Could you add documentation on the user interface somewhere
> in Documentation (or even better write a manpage and put it
> with ocfs2-tools)  ? 

Perhaps a Documentation/filesystems/userdlm.txt ?

> It would be nice if all these functions had a fast path
> for the case of no other node existing right now. Was that considered?

That actually exists but it's down in the dlm layer where the lock resource
can continue to be tracked for when nodes eventually join.

> --- linux-2.6.12-rc4.old/fs/ocfs2/extent_map.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.12-rc4/fs/ocfs2/extent_map.c	2005-05-17 22:42:59.519618934 -0700
> @@ -0,0 +1,904 @@
> 
> Can you expand a bit why ocfs2 doesn't just directly work on the on disk
> data structures in BHs for this like most other fs do?  (in a comment) 

Sure.

> ...
> +#define _XOPEN_SOURCE 600 /* Triggers magic in features.h */
> +#define _LARGEFILE64_SOURCE
> 
> Surely doesn't belong into the kernel?

No it doesn't. Removed.

> +int ocfs_set_inode_size(ocfs_journal_handle *handle,
> +			struct inode *inode,
> +			struct buffer_head *fe_bh,
> +			u64 new_i_size)
> ...
> +
> +	/* FIXME: I think this should all be in the caller */
> +	spin_lock(&oip->ip_lock);
> +	if (!grow)
> +		oip->ip_mmu_private = i_size_read(inode);
> 
> What is this private field good for? Seems redundant with the
> field in the inode.

That's used for tracking the currently zero'd part of an inode after extend,
so even though we set to i_size there, it isn't always equal to it.

> +int ocfs_extend_allocation(ocfs_super *osb, 
> +			   struct inode *inode, 
> +			   u32 clusters_to_add, 
> +			   struct buffer_head *fe_bh,
> +			   ocfs_journal_handle *handle, 
> +			   struct _ocfs2_alloc_context *data_ac,
> +			   struct _ocfs2_alloc_context *meta_ac,
> +			   enum ocfs2_alloc_restarted *reason);
> 
> That's a complicated function... 
> 
> Some stuff can be determined from other arguments like inode -> super

Ok

> +static int ocfs_node_map_stringify(ocfs_node_map *map, char **str)
> +{
> +	int i, n;
> +	char *s;
> +
> +	OCFS_ASSERT(map->num_nodes > 0);
> +
> +	*str = kmalloc( strlen("123 ") * map->num_nodes, GFP_KERNEL);
> +	if (!(*str))
> +		return -ENOMEM;
> 
> This looks weird (even though it is #if 0) 

Erf, that code shouldn't even be there any more. Removed.

> +		    //inode->i_fop = &ocfs_fops;
> 
> Remove please.

No problem.

> +	/* clean out the inode private ... why?! */
> +	memset(inode->u.generic_ip, 0, sizeof(ocfs_inode_private));
> 
> So that you don't leak into the next allocation from slab
> The real slab way would be actually to preinitialize for the next
> guy while it is still cache hot.

Yes. Actually since that initial patch, we've moved to use alloc_inode and
proper structure member lifetimes for inode.

> +int ocfs_mark_inode_dirty(ocfs_journal_handle *handle, 
> +			  struct inode *inode, 
> +			  struct buffer_head *bh)
> +{
> ...
> +	fe->i_atime = inode->i_atime.tv_sec;
> +	fe->i_ctime = inode->i_ctime.tv_sec;
> +	fe->i_mtime = inode->i_mtime.tv_sec;
> +	/* XXX: Do we want to update i_dtime here? */
> +	/* fe->i_dtime = inode->i_dtime.tv_sec; */
> 
> Only if you don't do it elsewhere on final iput after unlink.
> Only unlink should set it.

I assume you mean delete_inode but yes, thanks for verifying that. I'll
remove the comment now.

> I suppose you have tested by now, so you could remove? 

Yes

> I suppose this should set barrier flags based on mount options.

Yes, added.

> +static void ocfs2_queue_recovery_completion(ocfs_journal *journal,
> +					    int slot_num,
> +					    ocfs2_dinode *la_dinode,
> +					    ocfs2_dinode *tl_dinode)
> +{
> +	struct ocfs2_la_recovery_item *item;
> +
> +	item = kmalloc(sizeof(struct ocfs2_la_recovery_item), GFP_KERNEL);
> +	if (!item) {
> +		/* Though we wish to avoid it, we are in fact safe in
> +		 * skipping local alloc cleanup as fsck.ocfs2 is more
> +		 * than capable of reclaiming unused space. */
> 
> But I hope you don't require regular fsck just for this...

Oh certainly not - that should be a rare enough error and even if it's hit
the only side effect is that there may be space allocated in the main bitmap
which isn't marked in any file. Perhaps a console message if this condition
is hit would be in order.

> This is only needed on journal replay error, right?

This is actually node recovery.

> ... I think this file definitely needs a "10000 feet" overview comment
> on who does what in the journaling and how the different nodes interact.

No problem. I've tried to make as much of the journalling and file system
recovery bits as easy to read as possible but it would certainly help to
have a good overview of it all.

> +	if (S_ISDIR(mode) && (dir->i_nlink >= OCFS2_LINK_MAX)) {
> 
> Why this arbitary small limit? Surely you could have extended
> it beyond 16bits when you did some many other changes to the inode?
> 
> This means you cannot put more than 32k files into a directory.

It can certainly be fixed. When and how has to be weighed against our
current bugfix cycle and drive towards a '1.0' release.

> +	/* In case we need to overwrite an existing file, we blow it
> +	 * away first */
> 
> Overwrite new files? Since when does rename do that?

When you rename one file over another one? :)
 
> +/*
> + * An OCFS2 volume starts this way:
> + * Sector 0: Valid ocfs1_vol_disk_hdr that cleanly fails to mount OCFS.
> 
> That's bad actually because it means you cannot write an MBR to it.
> It would be better to keep the first 4k free.

That's strictly only there so that OCFS can cleanly identify the volume and
fail to mount it.

> +/*
> + * superblock s_state flags
> + */
> +#define OCFS2_ERROR_FS		(0x00000001)	/* FS saw errors */
> 
> Now just that must be set everywhere ...
> 
> +#define OCFS2_MAX_JOURNAL_SIZE		(500 * 1024 * 1024)
> 
> Why this arbitary limit? 

That should be easy enough to remove.

Ok, these comments should give us a little work to do, thanks!
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

