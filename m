Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVE3L0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVE3L0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE3L0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:26:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:36585 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261442AbVE3LVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:21:05 -0400
Date: Mon, 30 May 2005 13:21:01 +0200
From: Andi Kleen <ak@suse.de>
To: wim.coekaerts@oracle.com, mark.fasheh@oracle.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Cc: suparna@in.ibm.com
Subject: review of ocfs2
Message-ID: <20050530112101.GF15326@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Over the weekend I read the ocfs2 patch (without configfs). Overall
it looks pretty good and in good shape for merging.  Most of the
stuff I noted are nits, not major things.

One thing I would like to see is to combine it with a merging
of the more advanced file system level AIO code. ocfs2 adds quite
some hacks to do efficient aio without it, but that doesn't make
sense.  Perhaps some Oracle people could help out testing
and submitting the retry AIO patches and the clean it up?

-----

ocfs2 review.

I mostly commented on details, since I am not really qualified
to comment on the higher level algorithms right now.

It would be nice if at least the files for major subsystems each had a 
"high level overview" comment at the beginning. Overall more comments
are needed on the (internal) locking rules in various parts.

What seems to be definitely lacking is proper handling of on disk corruptions.
I suppose this will need some time to fix, so I would suggest
clear documentation of this shortcomming at least.

>From ocfs2.txt

Mount options
=============
None that should be manually specified by the user right now.

Note even noatime or ro? barrier=0/1 for JBD would be nice too and the
security related options (nodev,nosuid,noexec) which might be even
important in a cluster. How about the JBD journaling modi?

While reading the users_guide.txt in tools I noticed:

   myuser:/home/myuser> $ xhost +
   access control disabled, clients can connect from any host
   myuser:/home/myuser> $ su - root
   Password:
   root@localhost> # export DISPLAY=localhost:0.0
   root@localhost> # ocfs2console

Yuck. xhost + is the ultimative security hole. Fortunately
it doesn't work anymore on modern distros that don't let the X server
listen on the network anymore. How about recommending ssh -X here?

Back to the kernel:


diff -ruN linux-2.6.12-rc4.old/fs/Kconfig linux-2.6.12-rc4/fs/Kconfig
--- linux-2.6.12-rc4.old/fs/Kconfig	2005-05-06 22:20:31.000000000 -0700
+++ linux-2.6.12-rc4/fs/Kconfig	2005-05-17 22:42:59.473617421 -0700
 config EXT3_FS
 	tristate "Ext3 journalling file system support"
+	select JBD
 	help
 	  This is the journaling version of the Second extended file system
 	  (often called ext3), the de facto standard Linux file system
@@ -119,23 +120,20 @@
 	  extended attributes for file security labels, say N.
 
 config JBD
-# CONFIG_JBD could be its own option (even modular), but until there are
-# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
-# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-	tristate
-	default EXT3_FS
+	tristate "Journal Block Device support"

I would keep it hidden for now and just select from EXT3/OCFS2

 
 source "fs/xfs/Kconfig"
 
+config OCFS2_FS
+	tristate "OCFS2 file system support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && (X86 || IA64 || X86_64 || BROKEN)
+	select CONFIGFS_FS
+	select JBD
+	help
+	  OCFS2 is a shared disk cluster file system.
+
+	  To learn more about OCFS2 and to download the file system tools,
+	  visit the OCFS2 website at: http://oss.oracle.com/projects/ocfs2/

I think you need some more description here. Sometimes people even 
want to configure kernels without internet access. And cutting and
pasting URLs just configure a kernel is also not nice.

The introduction of ocfs2.txt might fit. I would note the mmap limitations
at least.

BTW if OCFS2 really is comparable in local performance to ext3 it
might be even an alternative for people who need a local 64bit, extend
enabled ext3. Perhaps note that there too?

<configfs not reviewed> 

+	spin_lock_irqsave(&osb->osb_okp_teardown_lock, flags);

I presume the irqsave is because of end_io callbacks. Most major
fs seem to have shifted to push them into workqueues and not disable
interrupts. Might be an alternative. It tends to be good for interrupt
latency at least.

+
+/* see ocfs2_ki_dtor */
+void ocfs2_wait_for_okp_destruction(ocfs_super *osb)
+{
+	/* first wait for okps to enter the work queue */
+	wait_event(osb->osb_okp_pending_wq, okp_pending_empty(osb));

Don't you need some lock here?

+static struct ocfs2_kiocb_private *okp_alloc(struct kiocb *iocb)
+{
+	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
+	struct ocfs2_kiocb_private *okp;
+	unsigned long flags;
+	ocfs_super *osb;

	struct ocfs_super

+
+/* this is a hack until 2.6 gets its story straight regarding bubbling up
+ * EIOCBQUEUED and the like.  in mainline we'd pass an iocb down and do lots of
+ * is_sync() testing.  In suparna's patches the dlm would use waitqueues and
+ * the waiting primatives would test current->wait for sync.  until that gets
+ * settled we have a very limited async/cb mechanism in the dlm and have it
+ * call this which triggers a retry. */

If you really want it how about you help pushing Suparna's patches.
iirc one of the problems they never got anywhere is that nobody else
really used/tested them... <hint hint>. I suppose with some effort
of testing/reviewing on mailing lists/etc.  this could be all fixed properly 
in relatively short time. That would be much preferable to piling up hacks 
like this in new code.

+
+/* this is called as iocb->ki_retry so it is careful to only repeat
+ * what is needed */
+ssize_t ocfs2_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count,
+			    loff_t pos)
+{
+	struct ocfs2_kiocb_private *okp = iocb->private;
+	struct file *filp = iocb->ki_filp;
+	struct inode *inode = filp->f_dentry->d_inode;
+	ocfs2_backing_inode *target_binode;

	struct ocfs2_backing_inode

+out:
+	/* 
+	 * never hold i_sem when we leave this function, nor when we call
+	 * g_f_a_w().  we've done all extending and inode field updating under
+	 * the i_sem and we hold the ip_alloc_sem for reading across the ops.
+	 * ocfs2_direct_IO calls blockdev_direct_IO with NO_LOCKING. 
+	 */
+	if (okp->kp_info.wl_have_i_sem) {
+		up(&inode->i_sem);
+		okp->kp_info.wl_have_i_sem = 0;

Hmm, that is really ugly and mainteance unfriendly to have conditional 
locking like this. I understand i_sem is bit critical though, but it is
still ugly. Please put at least a comment somewhere that explains the rules 
clearly?  And maybe with some minor VFS work this could be cleaned up?


+	new_blocks = el->l_tree_depth;
+
+	/* allocate the number of new eb blocks we need */
+	size = sizeof(struct buffer_head *) * new_blocks;
+	new_eb_bhs = kmalloc(size, GFP_KERNEL);
+	if (!new_eb_bhs) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+	memset(new_eb_bhs, 0, size);

Should be kcalloc()

+					     OCFS_JOURNAL_ACCESS_CREATE);
+		if (status < 0) {
+			mlog_errno(status);
+			goto bail;
+		}
+
+		eb->h_next_leaf_blk = 0;
+		eb_el->l_tree_depth = i;
+		eb_el->l_next_free_rec = 1;
+		eb_el->l_recs[0].e_cpos = fe->i_clusters;
+		eb_el->l_recs[0].e_blkno = next_blkno;
+		eb_el->l_recs[0].e_clusters = 0;

Doesn't this need some cpu_to_le... ? 

+		if (!eb_el->l_tree_depth)
+			new_last_eb_blk = le64_to_cpu(eb->h_blkno);
+	status = ocfs_journal_access(handle, inode, last_eb_bh, 
+				     OCFS_JOURNAL_ACCESS_WRITE);
+	if (status < 0) {
+		mlog_errno(status);
+		goto bail;
+	}
+	status = ocfs_journal_access(handle, inode, fe_bh, 
+				     OCFS_JOURNAL_ACCESS_WRITE);

Don't you need to undo these write accesses in the bail case?
Or does the brelse take care of it?

+
+	/* Link the new branch into the rest of the tree (el will
+	 * either be on the fe, or the extent block passed in. */
+	i = el->l_next_free_rec;
+	el->l_recs[i].e_blkno = next_blkno;
+	el->l_recs[i].e_cpos = fe->i_clusters;
+	el->l_recs[i].e_clusters = 0;

Needs cpu_to_le* I guess.

+	/* update fe now */
+	fe_el->l_tree_depth++;
+	fe_el->l_recs[0].e_cpos = 0;
+	fe_el->l_recs[0].e_blkno = eb->h_blkno;
+	fe_el->l_recs[0].e_clusters = fe->i_clusters;
+	for(i = 1; i < fe_el->l_next_free_rec; i++) {
+		fe_el->l_recs[i].e_cpos = 0;
+		fe_el->l_recs[i].e_clusters = 0;
+		fe_el->l_recs[i].e_blkno = 0;
+	}
+	fe_el->l_next_free_rec = 1;

cpu_to_le* ?

+
+		eb_bhs = kmalloc(sizeof(struct buffer_head *) * num_bhs, 
+			      GFP_KERNEL);
+		if (!eb_bhs) {
+			status = -ENOMEM;
+			mlog_errno(status);
+			goto bail;
+		}
+		memset(eb_bhs, 0, sizeof(struct buffer_head *) * num_bhs);

kcalloc

+		el = &fe->id2.i_list;
+		/* If we have tree depth, then the fe update is
+		 * trivial, and we want to switch el out for the
+		 * bottom-most leaf in order to update it with the
+		 * actual extent data below. */
+		OCFS_ASSERT_RO(el->l_next_free_rec);
+		el->l_recs[el->l_next_free_rec - 1].e_clusters += new_clusters;

cpu_to_le*

+		/* (num_bhs - 1) to avoid the leaf */
+		for(i = 0; i < (num_bhs - 1); i++) {
+			eb = (ocfs2_extent_block *) eb_bhs[i]->b_data;
+			el = &eb->h_list;
+
+			/* finally, make our actual change to the
+			 * intermediate extent blocks. */
+			el->l_recs[el->l_next_free_rec - 1].e_clusters
+					+= new_clusters;

cpu_to_le

+		 * the loop above */
+		eb = (ocfs2_extent_block *) eb_bhs[num_bhs - 1]->b_data;
+		el = &eb->h_list;
+		OCFS_ASSERT(!el->l_tree_depth);
+	}
+
+	/* yay, we can finally add the actual extent now! */
+	i = el->l_next_free_rec - 1;
+	if (el->l_next_free_rec && ocfs_extent_contig(inode, 
+						      &el->l_recs[i], 
+						      start_blk)) {
+		el->l_recs[i].e_clusters += new_clusters;

cpu_to_le

+	status = 0;
+bail:
+	if (eb_bhs) {
+		for (i = 0; i < num_bhs; i++)
+			if (eb_bhs[i])
+				brelse(eb_bhs[i]);
+		kfree(eb_bhs);
+	}

You do this quite often. How about a helper? 

+	struct buffer_head *lowest_bh = NULL;
+
+	mlog_entry_void();
+
+	*target_bh = NULL;
+
+	fe = (ocfs2_dinode *) fe_bh->b_data;
+	el = &fe->id2.i_list;
+
+	while(el->l_tree_depth > 1) {

That should be in on disk format no? Endian conversion.
Further down this function too.

+	/* We traveled all the way to the bottom and found nothing. */

Very philosophical.

+	struct buffer_head *data_alloc_bh = NULL;
+	ocfs2_dinode *di;
+	ocfs2_truncate_log *tl;
+
+	mlog_entry();
+
+	BUG_ON(!down_trylock(&tl_inode->i_sem));

Don't do this. BUG_ONs are not supposed to have side effects
and there is even a CONFIG_BUG that defines them away.

+	}
+
+	di = (ocfs2_dinode *) tl_bh->b_data;
+	tl = &di->id2.i_dealloc;
+	OCFS2_BUG_ON_INVALID_DINODE(di);
+
+	if (le16_to_cpu(tl->tl_used)) {
+		mlog(0, "We'll have %u logs to recover\n",
+		     le16_to_cpu(tl->tl_used));
+
+		*tl_copy = kmalloc(tl_bh->b_size, GFP_KERNEL);

That should be usually PAGE_SIZE no? Perhaps use __get_free_page directly.

+	/* Make sure that this guy will actually be empty after we
+	 * clear away the data. */
+	if (el->l_recs[0].e_cpos < new_i_clusters)
+		goto bail;

le*_to_cpu?

Same further down the function.

+		}
+		OCFS_ASSERT(i >= 0);

Isn't that identical to BUG_ON()? How about you use that directly? 

BTW I hope you hardened all these BUGs against on disk corruption.
It would be bad to oops the kernel just because a disk returned
garbage.  The ones here start to look suspicious, also several
uses of OCFS2_BUG_ON_INVALID_EXTEND_BLOCK. Otherwise unbreakable
Linux might not stay unbreakable ;-) 

I suppose one of the error injecting DM or MD targets could be hacked
to return random garbage instead of erroring. Running with that
might be a good test.

+	*new_last_eb = bh;
+	get_bh(*new_last_eb);
+	mlog(0, "returning block %"MLFu64"\n", le64_to_cpu(eb->h_blkno));
+bail:
+	if (bh)
+		brelse(bh);

get to brelse - a bit ugly.

+				     OCFS_JOURNAL_ACCESS_WRITE);
+	if (status < 0) {
+		mlog_errno(status);
+		goto bail;
+	}
+	el = &(fe->id2.i_list);
+
+	spin_lock(&OCFS_I(inode)->ip_lock);
+	OCFS_I(inode)->ip_clusters = fe->i_clusters - clusters_to_del;
+	spin_unlock(&OCFS_I(inode)->ip_lock);
+	fe->i_clusters -= clusters_to_del;

Endian. Same further down.

+
+	down_write(&OCFS_I(inode)->ip_alloc_sem);

and 
+	down(&tl_inode->i_sem);

The locking order here looks a bit suspicious. Are you sure
that is ok? 

+	*tc = kmalloc(sizeof(ocfs2_truncate_context), GFP_KERNEL);
+	if (!(*tc)) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+	memset(*tc, 0, sizeof(ocfs2_truncate_context));

kcalloc

+		eb = (ocfs2_extent_block *) last_eb_bh->b_data;
+		OCFS2_BUG_ON_INVALID_EXTENT_BLOCK(eb);
+		el = &(eb->h_list);
+		if (el->l_recs[0].e_cpos >= new_i_clusters)

endian

+}
+
+void ocfs_free_truncate_context(ocfs2_truncate_context *tc)
+{
+	if (tc->tc_ext_alloc_inode) {
+		if (tc->tc_ext_alloc_locked)
+			ocfs2_meta_unlock(tc->tc_ext_alloc_inode, 1);
+
+		up(&tc->tc_ext_alloc_inode->i_sem);

Hmm. Really scary locking... Normally keeping locks around like
this is strongly discouraged.

+
+	mlog_entry("(0x%p, %llu, 0x%p, %d)\n", inode,
+		   (unsigned long long)iblock, bh_result, create);
+
+	OCFS_ASSERT(!ocfs2_inode_is_fast_symlink(inode));

Hopefully no side effect.



+
+	if ((iblock << inode->i_sb->s_blocksize_bits) > PATH_MAX + 1) {

PATH_MAX? 

+	}
+
+	/* We don't use the page cache to create symlink data, so if
+	 * need be, copy it over from the buffer cache. */
+	if (!buffer_uptodate(bh_result) && ocfs_inode_is_new(inode)) {

Races here?


+	set_buffer_new(bh_result);
+	OCFS_I(inode)->ip_mmu_private += inode->i_sb->s_blocksize;
+
+bail:
+	if (err < 0)
+		err = -EIO;

I would move that before the gotos.

+
+void ocfs_end_buffer_io_sync(struct buffer_head *bh,
+			     int uptodate)
+{
+//	mlog_entry("(bh->b_blocknr = %u, uptodate = %d)\n", bh->b_blocknr,
+//		       uptodate);

Please remove.

+static inline void CLEAR_BH_SEQNUM(struct buffer_head *bh)

Inlines should be normally not upper case.

+static inline int ocfs_write_block (ocfs_super * osb, struct buffer_head *bh, 
+				    struct inode *inode)
+{
+	int status;
+
+	status = ocfs_write_blocks (osb, &bh, 1, inode);
+
+	return status;
+}
+
+static inline int ocfs_read_block (ocfs_super * osb, u64 off, 
+				   struct buffer_head **bh, int flags, 
+				   struct inode *inode)
+{
+	int status = 0;
+
+	if (bh == NULL) {
+		printk("ocfs2: bh == NULL\n");
+		status = -EINVAL;
+		goto bail;
+	}
+
+	status = ocfs_read_blocks(osb, off, 1, bh,
+				  flags, inode);
+
+bail:
+
+	return status;

These two look quite redundant. Remove them?

heartbeat.c

I think it has too many #includes, e.g. I don't think it needs
seq_file. Perhaps strip them and readd only what is needed.

+
+	char			hr_dev_name[BDEVNAME_SIZE];

Wouldn't it be better to kmalloc this to avoid arbitary limits? 

+	atomic_set(&wc->wc_num_reqs, num_ios);
+	init_completion(&wc->wc_io_complete);
+}
+
+/* Used in error paths too */
+static inline void hb_bio_wait_dec(struct hb_bio_wait_ctxt *wc,
+				   unsigned int num)
+{
+	/* sadly atomic_sub_and_test() isn't available on all platforms.  The
+	 * good news is that the fast path only completes one at a time */

Really? Where is it missing? Most seem to have it. I would just use it
and let the platforms catch up.


+/*
+ * Compute the maximum number of sectors the bdev can handle in one bio,
+ * as a power of two.
+ *
+ * Stolen from oracleasm, thanks Joel!
+ */
+static int compute_max_sectors(struct block_device *bdev)
+{

This sounds like something that should be in the BIO layer. How
about adding it there? 

+	/* we don't care if these wrap.. the state transitions below
+	 * clear at the right places */
+	cputime = le64_to_cpu(hb_block->hb_seq);
+	if (slot->ds_last_time != cputime)
+		slot->ds_changed_samples++;
+	else
+		slot->ds_equal_samples++;
+	slot->ds_last_time = cputime;

This probably needs endian work too. Lots more occurrences further down.

+
+
+/* This could be faster if we just implmented a find_last_bit, but I
+ * don't think the circumstances warrant it. */
+static int hb_highest_node(unsigned long *nodes,
+			   int numbits)
+{
+	int highest, node;
+
+	highest = numbits;
+	node = -1;
+	while ((node = find_next_bit(nodes, numbits, node + 1)) != -1) {

Using fls over the words backwards would be much much faster.

+	/* let the person who launched us know when things are steady */
+	if (!change && (atomic_read(&reg->hr_steady_iterations) != 0)) {
+		if (atomic_dec_and_test(&reg->hr_steady_iterations))
+			wake_up(&hb_steady_queue);
+	}
+
+	/* Make sure the write hits disk before we return. */
+	hb_wait_on_io(reg, &write_wc);
+	bio_put(write_bio);

Hmm. I don't think DLM data writes are controlled by JBD right? So you
properly need to take care of barriers when setting up the BIO,
to make sure the write really reaches the platter
(but add an option to turn it off) 

+/*
+ * get a map of all nodes that are heartbeating in any regions
+ */
+void hb_fill_node_map(unsigned long *map, unsigned bytes)
+{
+	BUG_ON(bytes < (BITS_TO_LONGS(NM_MAX_NODES) * sizeof(unsigned long)));
+
+	/* callers want to serialize this map and callbacks so that they
+	 * can trust that they don't miss nodes coming to the party */
+	down_read(&hb_callback_sem);
+	spin_lock(&hb_live_lock);

This needs documentation on lock ordering. 

+	unsigned long bytes;
+	char *p = (char *)page;
+
+	bytes = simple_strtoul(p, &p, 0);
+	if (!p || (*p && (*p != '\n')))
+		return -EINVAL;
+
+	/* Heartbeat and fs min / max block sizes are the same. */
+	if (bytes > 4096 || bytes < 512)
+		return -ERANGE;

That hardcodes PAGE_SIZE? Nasty nasty...

ocfs will work on IA64 with 16k blocks, won't it?
Anyways even if it doesn't yet this should be defines and be gotten
from elsewhere.

+	ret = wait_event_interruptible(hb_steady_queue,
+				atomic_read(&reg->hr_steady_iterations) == 0);

What lock protects steady queue here?
+/* Makes sure our local node is configured with a node number, and is
+ * heartbeating. */
+int hb_check_local_node_heartbeating(void)
+{
+	unsigned long testing_map[BITS_TO_LONGS(NM_MAX_NODES)];

Perhaps better kmalloc in case someone defines NM_MAX_NODES to be very big.

[... mlog ...]

Hmm. Looks overall a bit overengineered. Are you sure there
can be nothing simplified here?

+
+static char ocfs2_hb_ctl_path[PATH_MAX] = "/sbin/ocfs2_hb_ctl";

PATH_MAX is quite a lot of memory for this.

+	struct nm_cluster *cluster = to_nm_cluster_from_node(node);
+	int ret, i;
+	struct rb_node **p, *parent;
+	unsigned int octets[4];
+	u32 ipv4_addr = 0; /* network order */
+
+	ret = sscanf(page, "%3u.%3u.%3u.%3u", &octets[3], &octets[2],
+		     &octets[1], &octets[0]);

The network stack has in_aton for this.

But it might be better to abstract a bit to handle IPv6 nicely in the future.


+
+struct nm_node {
+	spinlock_t		nd_lock;
+	struct config_item	nd_item; 
+	char			nd_name[NM_MAX_NAME_LEN+1]; /* replace? */

kmalloc

+ * Handlers for unsolicited messages are registered.  Each socket has a page
+ * that incoming data is copied into.  First the header, then the data.
+ * Handlers are called from only one thread with a reference to this per-socket
+ * page.  This page is destroyed after the handler call, so it can't be
+ * referenced beyond the call.  Handlers may block but are discouraged from
+ * doing so.
+ *
+ * Any framing errors (bad magic, large payload lengths) close a connection.

Have you considered adding a stronger checksum? That TCP default is quite
weak.

+
+
+#define __msg_fmt "[mag %u len %u typ %u stat %d sys_stat %d key %u num %u] "
+#define __msg_args __hdr->magic, __hdr->data_len, __hdr->msg_type, 	\
+ 	__hdr->status,	__hdr->sys_status, __hdr->key, __hdr->msg_num
+#define msglog(hdr, fmt, args...) do {					\
+	typeof(hdr) __hdr = (hdr);					\
+	mlog(ML_MSG, __msg_fmt fmt, __msg_args, ##args);		\

Looks quite obfuscated with the separate argument lists.

+} while (0)
+
+#define __sc_fmt 							\
+	"[sc %p refs %d sock %p node %p from_con %u item_on %d "	\
+	"page %p pg_off %zu] "
+#define __sc_args __sc, atomic_read(&__sc->sc_kref.refcount), 		\
+	__sc->sc_sock,	__sc->sc_node, __sc->sc_from_connect, 		\
+	!list_empty(&__sc->sc_item), __sc->sc_page, __sc->sc_page_off
+#define sclog(sc, fmt, args...) do {					\
+	typeof(sc) __sc = (sc);						\
+	mlog(ML_SOCKET, __sc_fmt fmt, __sc_args, ##args);		\
+} while (0)

Similar.

+{
+	struct socket *sock = data;
+
+	mlog(ML_KTHREAD, "net thread running...\n");
+
+       	while(!kthread_should_stop()) {

White space.

+		net_try_accept(sock);
+		net_check_cb_lists();
+		net_receive();
+
+		wait_event_interruptible(*sock->sk->sk_sleep,

That looks racy because of missing locking on sk_sleep.

+		       msg_type, func);
+		ret = -EINVAL;
+		goto out;
+	}
+
+       	nmh = kcalloc(1, sizeof(struct net_msg_handler), GFP_KERNEL);

white space.

+
+	return ret;
+}
+EXPORT_SYMBOL(net_register_handler);

This looks like name space polution to me.  You cannot really claim
to be _the_ net_. Give it some other prefix.

+	msg = kmalloc(sizeof(net_msg), GFP_KERNEL);
+	if (!msg) {
+		mlog(0, "failed to allocate a net_msg!\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(msg, 0, sizeof(net_msg));

kcalloc

+	/* wait on other node's handler */
+	wait_event(nsw.ns_wq, net_nsw_completed(node, &nsw));

Locking? Without an additional lock net_nsw_completed might be 
false again when you get around to look.

+int net_register_hb_callbacks(void)
+{
+	net_hb_down = kmalloc(sizeof(*net_hb_down), GFP_KERNEL);
+	if (!net_hb_down)
+		return -ENOMEM;
+	memset(net_hb_down, 0, sizeof(*net_hb_down));

kcalloc

+	NET_ERR_MAX
+};
+
+static int net_sys_err_translations[NET_ERR_MAX] =
+		{[NET_ERR_NONE] = 0,
+		 [NET_ERR_NO_HNDLR] = -ENOPROTOOPT,
+		 [NET_ERR_OVERFLOW]  = -EOVERFLOW,
+		 [NET_ERR_DIED] = -EHOSTDOWN,};

This shouldn't be in a header, where it is duplicated in all includers.

+	if (err >= 0)
+		return 0;
+	switch (err) {
+		/* ????????????????????????? */
+		case -ERESTARTSYS:
+		case -EBADF:
+		/* When the server has died, an ICMP port unreachable 
+		 * message prompts ECONNREFUSED. */
+		case -ECONNREFUSED:
+		case -ENOTCONN:
+		case -ECONNRESET:
+		case -EPIPE:
+			return 1;
+	}

You might want to use IP_RECVERR. It tells TCP to report errors much
quicker.

+
+#define CLUSTER_BUILD_VERSION "0.99.9"

Interesting version number.
It probably doesn't make much sense when merged into the kernel
anymore anyways, because then it will have a "rolling" version.

+
+void dlm_do_local_ast(dlm_ctxt *dlm, dlm_lock_resource *res, dlm_lock *lock)
+{
+	dlm_astlockfunc_t *fn;
+	dlm_lockstatus *lksb;
+
+	mlog_entry_void();
+
+	DLM_ASSERT(lock);
+	DLM_ASSERT(res);
+	lksb = lock->lksb;
+	DLM_ASSERT(lksb);
+	fn = lock->ast;
+	DLM_ASSERT(fn);

The asserts are not needed because the code should oops anyways
when they are NULL.

+	DLM_ASSERT(lock);
+	DLM_ASSERT(res);
+	lksb = lock->lksb;
+	DLM_ASSERT(lksb);

Similar.

+	DLM_ASSERT(lock->ml.node == dlm->node_num);
+	DLM_ASSERT(fn);

dito.

+	dlm_proxy_ast *past = (dlm_proxy_ast *) msg->buf;
+	char *name;
+	struct list_head *iter, *head=NULL;
+	u64 cookie;
+	u32 flags;
+
+	if (!dlm_grab(dlm))
+		return DLM_REJECTED;
+
+	DLM_ASSERT(dlm_domain_fully_joined(dlm));

side effects again...

+	if (locklen > DLM_LOCKID_NAME_MAX) {
+		ret = DLM_IVBUFLEN;
+		printk("Invalid name length in proxy ast handler!\n");

KERN_ERR ?

+	memset(&past, 0, sizeof(dlm_proxy_ast));
+	past.node_idx = dlm->node_num;
+	past.type = msg_type;
+	past.blocked_type = blocked_type;
+	past.namelen = res->lockname.len;
+	strncpy(past.name, res->lockname.name, past.namelen);

0 termination? (strncpy is a death trap) 

+#ifndef DLMCOMMON_H
+#define DLMCOMMON_H
+
+#include <linux/kref.h>
+
+#define DLM_ASSERT(x)       ({  if (!(x)) { printk("assert failed! %s:%d\n", __FILE__, __LINE__); BUG(); } })

define to BUG_ON(!(x)) will be more efficient probably. Architectures make
sure to optimize that properly.

+
+static inline void dlm_init_work_item(dlm_ctxt *dlm, dlm_work_item *i, 
+				      dlm_workfunc_t *f, void *data)
+{
+	DLM_ASSERT(i);
+	DLM_ASSERT(f);

Again useless asserts.

+	memset(i, 0, sizeof(dlm_work_item));
+	i->func = f;
+	INIT_LIST_HEAD(&i->list);
+	i->data = data;
+	i->dlm = dlm;  /* must have already done a dlm_grab on this! */
...
+	/* please keep these next 3 in this order 
+	 * some funcs want to iterate over all lists */

Nasty nasty. How about using a table with offsetof() somewhere? 

+	struct list_head granted;
+	struct list_head converting;
+	struct list_head blocked;
+
+
+typedef struct _dlm_migratable_lock
+{
+	u64 cookie;
+
+	/* these 3 are just padding for the in-memory structure, but 
+	 * list and flags are actually used when sent over the wire */ 
+	u16 pad1;
+	u8 list;  // 0=granted, 1=converting, 2=blocked
+	u8 flags; 

Make sure you always zero them then to not leak kernel data.

+	struct kref mle_refs;
+	unsigned long maybe_map[BITS_TO_LONGS(NM_MAX_NODES)];
+	unsigned long vote_map[BITS_TO_LONGS(NM_MAX_NODES)];
+	unsigned long response_map[BITS_TO_LONGS(NM_MAX_NODES)];
+	unsigned long node_map[BITS_TO_LONGS(NM_MAX_NODES)];
+	u8 master;
+	u8 new_master;

This limits the nodes to max 255 right? Is that a good thing? 

+// NET_MAX_PAYLOAD_BYTES is roughly 4080

Where does this strange number come from? 
+// 240 * 16 = 3840 
+// 3840 + 112 = 3952 bytes
+// leaves us about 128 bytes
+#define DLM_MAX_MIGRATABLE_LOCKS   240 

+static inline void dlm_node_iter_init(unsigned long *map, dlm_node_iter *iter)
+{
+	DLM_ASSERT(iter);

Useless assert

+	memcpy(iter->node_map, map, sizeof(iter->node_map));
+	iter->curnode = -1;
+}
+
+static inline int dlm_node_iter_next(dlm_node_iter *iter)
+{
+	int bit;
+	DLM_ASSERT(iter);
+	bit = find_next_bit(iter->node_map, NM_MAX_NODES, iter->curnode+1);

Similar. 

+	/* we are not in a network handler, this is fine */
+	__dlm_wait_on_lockres(res);
+	__dlm_lockres_reserve_ast(res);
+	res->state |= DLM_LOCK_RES_IN_PROGRESS;
+
+	status = __dlmconvert_master(dlm, res, lock, flags, type, 
+				     &call_ast, &kick_thread);
+
+	res->state &= ~DLM_LOCK_RES_IN_PROGRESS;
+	spin_unlock(&res->spinlock);
+	wake_up(&res->wq);

Hmm, locking for the resource passed? 

+	memset(&convert, 0, sizeof(dlm_convert_lock));
+	convert.node_idx = dlm->node_num;
+	convert.requested_type = type;
+	convert.cookie = lock->ml.cookie;
+	convert.namelen = res->lockname.len;
+	convert.flags = flags;
+	strncpy(convert.name, res->lockname.name, convert.namelen);

0 termination? 

+		
+	spin_lock(&dlm->spinlock);
+	for (i=0; i<DLM_HASH_SIZE; i++) {
+		bucket = &(dlm->resources[i]);
+		list_for_each(iter, bucket) {
+			res = list_entry(iter, dlm_lock_resource, list);
+			printk("lockres: %.*s, owner=%u, state=%u\n", 

Should be all KERN_DEBUG (same further down)

+static void dlm_trigger_migration(const char __user *data, int len)
+{
+	dlm_lock_resource *res;
+	dlm_ctxt *dlm;
+	char *resname;
+	char *domainname;
+	char *tmp, *buf = NULL;
+
+	if (len >= PAGE_SIZE) {
+		mlog(0, "user passed too much data: %d bytes\n", len);
+		return;
+	}

Make it PAGE_SIZE-1 otherwise you will get two pages in the kmalloc
below.  Also shouldn't this have some kind of error return (-EINVAL)? 
Nasty to silently ignore user input.

While code is not buggy it would be safer if len was unsigned

+		goto leave;
+	}
+
+       	res = dlm_lookup_lockres(dlm, resname, strlen(resname));

white space.

+					 unsigned int len)
+{
+	unsigned int hash;
+	struct list_head *iter;
+	dlm_lock_resource *tmpres=NULL;
+	struct list_head *bucket;
+
+	BUG_ON(!name);

Useless BUG_ON since it will just oops below.

+
+	mlog_entry("%.*s\n", len, name);
+
+	assert_spin_locked(&dlm->spinlock);
+
+	hash = full_name_hash(name, len);
...
+{
+	dlm_lock_resource *res;
+
+	BUG_ON(!dlm);

Also useless.

+{
+	dlm_ctxt *tmp = NULL;
+	struct list_head *iter;
+
+	assert_spin_locked(&dlm_domain_lock);
+
+	list_for_each(iter, &dlm_domains) {
+		tmp = list_entry (iter, dlm_ctxt, list);
+		if (strncmp(tmp->name, domain, len)==0)

strncmp? What happens when one of them is longer than len? 

Overall this code seems to go through quite some effort to handle
non 0 terminated strings, but is that really worth it? How about
you just always 0 terminate?  Does that come from VMS? @)



+static void dlm_free_ctxt_mem(dlm_ctxt *dlm)
+{
+	BUG_ON(!dlm);

Useless BUG_ON.

+
+	BUG_ON(!kref);

Useless BUG_ON
+
+void dlm_put(dlm_ctxt *dlm)
+{
+	BUG_ON(!dlm);

Useless BUG_ON

+void dlm_get(dlm_ctxt *dlm)
+{
+	BUG_ON(!dlm);

Useless.

+
+	spin_lock(&dlm_domain_lock);
+	__dlm_get(dlm);
+	spin_unlock(&dlm_domain_lock);
+}
+


..
+	/* Wake up anyone waiting for us to remove this domain */
+	wake_up(&dlm_domain_events);

Locks? Can't it be readded during the wakeup? 

+		if (status < 0 &&
+		    status != -ENOPROTOOPT &&
+		    status != -ENOTCONN) {
+			mlog(ML_NOTICE, "Error %d sending domain exit message "
+			     "to node %d\n", status, node);
+
+			/* Not sure what to do here but lets sleep for
+			 * a bit in case this was a transient
+			 * error... */
+			schedule();

This won't do much if you don't use set_current_state.
Most likely you want schedule_timeout(1) or somesuch here.

+void dlm_unregister_domain(dlm_ctxt *dlm)
+{
+	int leave = 0;
+
+	BUG_ON(!dlm);

Useless BUG_ON

+            joined into the domain. 
+	   -ENOTCONN is treated similarly -- it's returned from the
+            core kernel net code however and indicates that they don't
+            even have their cluster networking module loaded (bad
+            user!) */
+	if (status == -ENOPROTOOPT || status == -ENOTCONN) {

I bet there could be other errors too.

+		status = 0;
+		*response = JOIN_OK_NO_MAP;
+	status = 0;
+	node = -1;
+	while ((node = find_next_bit(node_map, NM_MAX_NODES, node + 1))
+	       != -1) {

Why does this check for -1?

+		if (node >= NM_MAX_NODES)
+			break;
+				/* give us some time between errors... */
+				if (live)
+					schedule();

schedule_timeout(1) 

+	ctxt = kmalloc(sizeof(struct domain_join_ctxt), GFP_KERNEL);
+	if (!ctxt) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+	memset(ctxt, 0, sizeof(*ctxt));

kcalloc

+
+	node = -1;
+	while ((node = find_next_bit(ctxt->live_map, NM_MAX_NODES, node + 1))
+	       != -1) {

-1 again?

+		if (node >= NM_MAX_NODES)
+			break;
+
+	dlm = kmalloc(sizeof(dlm_ctxt), GFP_KERNEL);
+	if (!dlm) {
+		mlog_errno(-ENOMEM);
+		goto leave;
+	}
+	memset(dlm, 0, sizeof(dlm_ctxt));

kcalloc

+
+	dlm->name = kmalloc(strlen(domain) + 1, GFP_KERNEL);

I hope this is limited.

+	if (new_ctxt)
+		dlm_free_ctxt_mem(new_ctxt);
+
+	return dlm;
+}
+EXPORT_SYMBOL(dlm_register_domain);

Since we might have multiple DLMs eventually perhaps adding 
a unique prefix would be a good idea.

+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
+
+	/* don't read past the lvb */
+	if ((count + *ppos) > i_size_read(inode))
+		readlen = i_size_read(inode) - *ppos;
+	else
+		readlen = count - *ppos;

Hopefully i_size_read is strictly limited.

+
+	lvb_buf = kmalloc(readlen, GFP_KERNEL);
+	if (!lvb_buf)
+		return -ENOMEM;
+
+	user_dlm_read_lvb(inode, lvb_buf, readlen);
+	bytes_left = __copy_to_user(buf, lvb_buf, readlen);

It is a bit suspicious that you do the __copy_to_user with a different
length parameter than the access_ok. Safer to just use copy_to_user

Similar comments on write.

+#include "dlmfsver.h"
+
+#define DLM_BUILD_VERSION "0.99.9"

Again earlier comment about the version number applies.

+ */
+static dlm_status dlmlock_master(dlm_ctxt *dlm, dlm_lock_resource *res, 
+				 dlm_lock *lock, int flags)
+{
+	int call_ast = 0, kick_thread = 0;
+	dlm_status status = DLM_NORMAL;
+
+	DLM_ASSERT(lock);
+	DLM_ASSERT(res);
+	DLM_ASSERT(dlm);
+	DLM_ASSERT(lock->lksb);

Useless asserts again. Please drop.

+	memset(&create, 0, sizeof(create));
+	create.node_idx = dlm->node_num;
+	create.requested_type = lock->ml.type;
+	create.cookie = lock->ml.cookie;
+	create.namelen = res->lockname.len;
+	create.flags = flags;
+	strncpy(create.name, res->lockname.name, create.namelen);

0 termination again?

+}
+
+static void dlm_lock_release(struct kref *kref)
+{
+	dlm_lock *lock;
+	dlm_lockstatus *lksb;
+
+	DLM_ASSERT(kref);

Useless assert.

+	lock = container_of(kref, dlm_lock, lock_refs);
+
+	lksb = lock->lksb;
+	DLM_ASSERT(lksb);

Useless assert.

+/* associate a lock with it's lockres, getting a ref on the lockres */
+void dlm_lock_attach_lockres(dlm_lock *lock, dlm_lock_resource *res)
+{
+	DLM_ASSERT(lock);
+	DLM_ASSERT(res);

Probably useless again.

+	dlm_lockres_get(res);
+	lock->lockres = res;
+}
+
+/* drop ref on lockres, if there is still one associated with lock */
+void dlm_lock_detach_lockres(dlm_lock *lock)
+{
+	dlm_lock_resource *res;
+	
+	DLM_ASSERT(lock);

Also useless.

+
+static void dlm_dump_mles(dlm_ctxt *dlm)
+{
+	dlm_master_list_entry *mle;
+	struct list_head *iter;
+	int i = 0, refs;
+	char *type;
+	char err, attached;
+	u8 master;
+	unsigned int namelen;
+	const char *name;
+
+	printk("dumping all mles for domain %s:\n", dlm->name);
+	printk("  ####: type refs owner events? err?     lockname\n");

KERN_INFO

And I suppose since this will be more commonly used by DLM users
how about adding a /sys file for it instead?

+{
+	dlm_ctxt *dlm;
+	DLM_ASSERT(mle);
+	DLM_ASSERT(mle->dlm);

Useless asserts

+static void dlm_put_mle(dlm_master_list_entry *mle)
+{
+	dlm_ctxt *dlm;
+	DLM_ASSERT(mle);
+	DLM_ASSERT(mle->dlm);

Also useless.

+void dlm_mle_node_down(dlm_ctxt *dlm, dlm_master_list_entry *mle,
+		       struct nm_node *node, int idx)
+{
+	DLM_ASSERT(mle);
+	DLM_ASSERT(dlm);

Again useless.

+void dlm_mle_node_up(dlm_ctxt *dlm, dlm_master_list_entry *mle,
+		     struct nm_node *node, int idx)
+{
+	DLM_ASSERT(mle);
+	DLM_ASSERT(dlm);

And again

+	dlm_master_list_entry *mle;
+	dlm_ctxt *dlm;
+
+	mlog_entry_void();
+
+	DLM_ASSERT(kref);

And dito.

+
+	mle = container_of(kref, dlm_master_list_entry, mle_refs);
+
+	DLM_ASSERT(mle->dlm);
+	dlm = mle->dlm;

Same.


+static void dlm_lockres_release(struct kref *kref)
+{
+	dlm_lock_resource *res;
+	
+	BUG_ON(!kref);

Dito.

+
+	res = container_of(kref, dlm_lock_resource, refs);
+ */

..

+dlm_lock_resource * dlm_get_lock_resource(dlm_ctxt *dlm, 
+					  const char *lockid,
+					  int flags)
+{
+	dlm_lock_resource *tmpres=NULL, *res=NULL;
+	dlm_master_list_entry *mle = NULL, *tmpmle = NULL;
+	int blocked = 0;
+	int ret, nodenum;
+	dlm_node_iter iter;
+	unsigned int namelen;
+
+	BUG_ON(!lockid);
+	BUG_ON(!dlm);

Second BUG_ON is useless.

+	/* sleep if we haven't finished voting yet */
+	if (sleep) {
+		atomic_set(&mle->woken, 0);
+		ret = wait_event_interruptible_timeout(mle->wq, 
+					(atomic_read(&mle->woken) == 1), 
+					msecs_to_jiffies(5000));
+
+		if (ret >= 0 && !atomic_read(&mle->woken)) {
+			mlog(0, "timed out during lock mastery: "
+			     "vote_map=%0lx, response_map=%0lx\n",
+			     mle->vote_map[0], mle->response_map[0]);
+		}
+		/* unless we are aborting, need to recheck and 
+		 * maybe sleep again */
+		if (ret != -ERESTARTSYS)
+			ret = -EAGAIN;
+		goto leave;

This looks racy.

+
+	DLM_ASSERT(item);
+	dlm = item->dlm;
+	DLM_ASSERT(dlm);
+
+	res = item->u.am.lockres;
+	DLM_ASSERT(res);

Useless asserts again.

+			lock = list_entry (iter, dlm_lock, list);
+			DLM_ASSERT(lock);

Double useless (list_entry can never return NULL, unless iter was exactly
-offsetof(typeof(*dlm_lock,list))

+
+int dlm_request_all_locks_handler(net_msg *msg, u32 len, void *data)
+{
+	dlm_ctxt *dlm = data;
+	dlm_lock_request *lr = (dlm_lock_request *)msg->buf;
+	char *buf = NULL;
+	dlm_work_item *item = NULL;
+	
+	if (!dlm_grab(dlm))
+		return -EINVAL;
+
+	dlm_lock_request_to_host(lr);
+	DLM_ASSERT(dlm);

Again useless

+	DLM_ASSERT(lr->dead_node == dlm->reco.dead_node);
+
+	dlm_ctxt *dlm;
+	LIST_HEAD(resources);
+	struct list_head *iter;
+	int ret;
+	u8 dead_node, reco_master;
+
+	/* do a whole s-load of asserts */

.. which are mostly useless (those checking pointers)

+			 * we must send it immediately. */
+			ret = dlm_send_mig_lockres_msg(dlm, mres, send_to, 
+						       res, total_locks);
+			if (ret < 0) {
+				// TODO
+			}
+		}
+		queue++;
+	}
+	/* flush any remaining locks */
+	ret = dlm_send_mig_lockres_msg(dlm, mres, send_to, res, total_locks);
+	if (ret < 0) {
+		// TODO

Make the todos BUG()s ?
+
+static void dlm_mig_lockres_worker(dlm_work_item *item, void *data)
+{
+	dlm_ctxt *dlm = data;
+	dlm_migratable_lockres *mres;
+	int ret = 0;
+	dlm_lock_resource *res;
+	u8 real_master;
+
+	DLM_ASSERT(item);
+	dlm = item->dlm;
+	DLM_ASSERT(dlm);
+
+	DLM_ASSERT(data);
+	mres = (dlm_migratable_lockres *)data;
+	
+	res = item->u.ml.lockres;
+	DLM_ASSERT(res);

Lots of useless asserts again.

+static inline struct list_head * dlm_list_num_to_pointer(dlm_lock_resource *res,
+							 int list_num)
+{
+	struct list_head *ret;
+	DLM_ASSERT(res);

Useless assert.

+
+void dlm_shuffle_lists(dlm_ctxt *dlm, dlm_lock_resource *res)
+{
+	dlm_lock *lock, *target;
+	struct list_head *iter;
+	struct list_head *head;
+	int can_grant = 1;
+
+	DLM_ASSERT(res);

Useless assert.

+
+		/* this will now do the dlm_shuffle_lists
+		 * while the dlm->spinlock is unlocked */

Does this comment really match the code?

+		spin_lock(&dlm->spinlock);
+		while (!list_empty(&dlm->dirty_list)) {
+			int delay = 0;
+			res = list_entry(dlm->dirty_list.next, 
+					 dlm_lock_resource, dirty);
+			
+			/* peel a lockres off, remove it from the list,
+			 * unset the dirty flag and drop the dlm lock */
+			DLM_ASSERT(res);
+			dlm_lockres_get(res);
+			
+			spin_lock(&res->spinlock);
+			res->state &= ~DLM_LOCK_RES_DIRTY;
+			list_del_init(&res->dirty);
+			spin_unlock(&res->spinlock);
+			spin_unlock(&dlm->spinlock);

Tricky locking deserves a comment? 

+
+
+			spin_lock(&res->spinlock);
	
+	/* according to spec and opendlm code

Could you add a reference to that specification somewhere? 

+ *
+ * userdlm.c
+ *
+ * Code which implements the kernel side of a minimal userspace
+ * interface to our DLM.

Could you add documentation on the user interface somewhere
in Documentation (or even better write a manpage and put it
with ocfs2-tools)  ? 

It would be nice if all these functions had a fast path
for the case of no other node existing right now. Was that considered?

+		       int *requeue)
+{
+	int status;
+	struct inode *inode;
+
+	mlog_entry_void();
+
+       	inode = ocfs2_lock_res_inode(lockres);

White space.

+	OCFS_ASSERT(lockres);

Useless assert.
+	OCFS_ASSERT(lockres->l_ops);
+	OCFS_ASSERT(lockres->l_ops->unblock);
+
+	mlog(0, "lockres %s blocked.\n", lockres->l_name);

...

DLM over. Main OCFS2 again. That was quite a lot of code, who
would have guessed that cluster locking is that complicated...


--- linux-2.6.12-rc4.old/fs/ocfs2/extent_map.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc4/fs/ocfs2/extent_map.c	2005-05-17 22:42:59.519618934 -0700
@@ -0,0 +1,904 @@

Can you expand a bit why ocfs2 doesn't just directly work on the on disk
data structures in BHs for this like most other fs do?  (in a comment) 

Actually we have quite a lot of code in the kernel that reimplements
such "range lists" (e.g. in mempolicy.c and I know of other patches who 
reimplement it again). It would be nice to just put an AST for
the in memory part of this into lib/ 

...
+#define _XOPEN_SOURCE 600 /* Triggers magic in features.h */
+#define _LARGEFILE64_SOURCE

Surely doesn't belong into the kernel?

+
+
+/*
+ * SUCK SUCK SUCK
+ * Our headers are so bad that struct ocfs2_extent_map is in ocfs.h

You could just fix it? 
+	while (el->l_tree_depth)
+	{
+		blkno = 0;
+		for (i = 0; i < el->l_next_free_rec; i++) {

I suppose this is on disk data again. Endian conversion?

+	if (ent->e_tree_depth)
+		BUG();  /* FIXME: Make sure this isn't a corruption */

Seems to be broken in lots of other code too. I suspect it will
quickly BUG for corrupted fs, which is not good. 

Actually there seems to be quite some mix with on disk data structures.
Perhaps the range list AST suggestion above would be too complicated with
that.

+int ocfs_set_inode_size(ocfs_journal_handle *handle,
+			struct inode *inode,
+			struct buffer_head *fe_bh,
+			u64 new_i_size)
...
+
+	/* FIXME: I think this should all be in the caller */
+	spin_lock(&oip->ip_lock);
+	if (!grow)
+		oip->ip_mmu_private = i_size_read(inode);

What is this private field good for? Seems redundant with the
field in the inode.

+int ocfs_extend_allocation(ocfs_super *osb, 
+			   struct inode *inode, 
+			   u32 clusters_to_add, 
+			   struct buffer_head *fe_bh,
+			   ocfs_journal_handle *handle, 
+			   struct _ocfs2_alloc_context *data_ac,
+			   struct _ocfs2_alloc_context *meta_ac,
+			   enum ocfs2_alloc_restarted *reason);

That's a complicated function... 

Some stuff can be determined from other arguments like inode -> super


+
+static int ocfs_node_map_stringify(ocfs_node_map *map, char **str)
+{
+	int i, n;
+	char *s;
+
+	OCFS_ASSERT(map->num_nodes > 0);
+
+	*str = kmalloc( strlen("123 ") * map->num_nodes, GFP_KERNEL);
+	if (!(*str))
+		return -ENOMEM;

This looks weird (even though it is #if 0) 

+
+	memset(*str, 0, strlen("123 ") * map->num_nodes);



+static int ocfs_find_actor(struct inode *inode, void *opaque)
+{
+	ocfs_find_inode_args *args = NULL;
+	int ret = 0;
+
+	mlog_entry ("(0x%p, %lu, 0x%p)\n", inode, inode->i_ino, opaque);
+
+	args = opaque;
+
+	/* XXX: Can this actually ever be passed in as NULL? */
+	if (inode == NULL)
+		goto bail;

I don't think so.

+
+	if (!inode->u.generic_ip) {
+		mlog(ML_ERROR, "inode %lu has no generic_ip (is_bad_inode = "
+			       "%d)!\n", inode->i_ino, is_bad_inode(inode));
+		if (args)
+			mlog(ML_ERROR, "args-blkno = %"MLFu64", "
+				       "args->ino = %lu, args->flags = 0x%x\n",
+			     args->blkno, args->ino, args->flags);
+		BUG();
+	}

This also should not happen. Make it a simple BUG_ON ?

+		    atomic_set(GET_INODE_CLEAN_SEQ(inode), atomic_read(&osb->clean_buffer_seq));
+		    if (ocfs2_inode_is_fast_symlink(inode))
+			inode->i_op = &ocfs_fast_symlink_inode_operations;
+		    else
+			inode->i_op = &ocfs_symlink_inode_operations;
+		    //inode->i_fop = &ocfs_fops;

Remove please.

+	inode_alloc_inode = ocfs_get_system_file_inode(osb, INODE_ALLOC_SYSTEM_INODE, le16_to_cpu(fe->i_suballoc_node));

This function name is surely too long.

+	/* clean out the inode private ... why?! */
+	memset(inode->u.generic_ip, 0, sizeof(ocfs_inode_private));

So that you don't leak into the next allocation from slab
The real slab way would be actually to preinitialize for the next
guy while it is still cache hot.

+int ocfs_mark_inode_dirty(ocfs_journal_handle *handle, 
+			  struct inode *inode, 
+			  struct buffer_head *bh)
+{
...
+	fe->i_atime = inode->i_atime.tv_sec;
+	fe->i_ctime = inode->i_ctime.tv_sec;
+	fe->i_mtime = inode->i_mtime.tv_sec;
+	/* XXX: Do we want to update i_dtime here? */
+	/* fe->i_dtime = inode->i_dtime.tv_sec; */

Only if you don't do it elsewhere on final iput after unlink.
Only unlink should set it.


journal.c:

+	OCFS_ASSERT(handle);

Useless assert

+int ocfs_journal_access(ocfs_journal_handle *handle,
+			struct inode *inode,
+			struct buffer_head *bh,
+			int type)
+{
+	int status;
+
+	OCFS_ASSERT(inode);
+	OCFS_ASSERT(handle);
+	OCFS_ASSERT(bh);

Lots of useless asserts again.

+		       (type == OCFS_JOURNAL_ACCESS_CREATE) ? 
+		       "OCFS_JOURNAL_ACCESS_CREATE" : 
+		       "OCFS_JOURNAL_ACCESS_WRITE", bh->b_size);
+
+	/* we can safely remove this assertion after testing. */

I suppose you have tested by now, so you could remove? 

+	if (!buffer_uptodate(bh)) {
+		mlog(ML_ERROR, "giving me a buffer that's not uptodate!\n");
+		mlog(ML_ERROR, "b_blocknr=%llu\n",
+		     (unsigned long long)bh->b_blocknr);
+		BUG();
+	}


+static void ocfs_handle_cleanup_locks(ocfs_journal *journal, 
+				      ocfs_journal_handle *handle,
+				      int set_id)
+{
+	struct list_head *p, *n;
+	ocfs_journal_lock *lock;
+	struct inode *inode;
+
+	list_for_each_safe(p, n, &(handle->locks)) {
+		lock = list_entry(p, ocfs_journal_lock, jl_lock_list);
+		list_del(&lock->jl_lock_list);
+		handle->num_locks--;

Locking comment? 

+		iput(inode);
+		kmem_cache_free(ocfs2_lock_cache, lock);
+	}
+}
+
+#define OCFS_DEFAULT_COMMIT_INTERVAL 	(HZ * 5)

This should be configurable I guess ...

+		status = -1;
+		goto done;
+	}
+
+	mlog(0, "Returned from journal_init_inode\n");
+	mlog(0, "j_journal->j_maxlen = %u\n", j_journal->j_maxlen);
+	j_journal->j_commit_interval = OCFS_DEFAULT_COMMIT_INTERVAL;
+
+	*dirty = (le32_to_cpu(fe->id1.journal1.ij_flags) &
+		  OCFS2_JOURNAL_DIRTY_FL);
+
+	journal->j_journal = j_journal;
+	journal->j_inode = inode;
+	journal->j_bh = bh;
+
+	journal->j_state = OCFS_JOURNAL_LOADED;

I suppose this should set barrier flags based on mount options.

+static void ocfs2_queue_recovery_completion(ocfs_journal *journal,
+					    int slot_num,
+					    ocfs2_dinode *la_dinode,
+					    ocfs2_dinode *tl_dinode)
+{
+	struct ocfs2_la_recovery_item *item;
+
+	item = kmalloc(sizeof(struct ocfs2_la_recovery_item), GFP_KERNEL);
+	if (!item) {
+		/* Though we wish to avoid it, we are in fact safe in
+		 * skipping local alloc cleanup as fsck.ocfs2 is more
+		 * than capable of reclaiming unused space. */

But I hope you don't require regular fsck just for this...
This is only needed on journal replay error, right?

+
+/*
+ * Do the most important parts of node recovery:
+ *  - Replay it's journal
+ *  - Stamp a clean local allocator file
+ *  - Stamp a clean truncate log
+ *  - Mark the node clean

... I think this file definitely needs a "10000 feet" overview comment
on who does what in the journaling and how the different nodes interact.

+
+			if (!ocfs_check_dir_entry(orphan_dir_inode,
+						  de, bh, local)) {
+				up(&orphan_dir_inode->i_sem);
+				status = -EINVAL;

Shouldn't this mark the fs readonly?   Also unconditional 
printk for all on disk corruptions would be good, errnos get lost too quickly
and I assume mlog is usually not enabled in production.

+	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) 
+	       != -1) {

-1? I don't think think that is the right check.

Overall I would just use find_next_zero_bit directly, that ext2_* 
has its own names is more historical and doesn't make much sense anymore.

+	/* We want to clear the local alloc before doing anything
+	 * else, so that if we error later during this operation,
+	 * local alloc shutdown won't try to double free main bitmap
+	 * bits. Make a copy so the sync function knows which bits to
+	 * free. */
+	alloc_copy = kmalloc(osb->local_alloc_bh->b_size, GFP_KERNEL);

It is not very nice to use kmalloc for such big buffers.

+	if (S_ISDIR(mode) && (dir->i_nlink >= OCFS2_LINK_MAX)) {

Why this arbitary small limit? Surely you could have extended
it beyond 16bits when you did some many other changes to the inode?

This means you cannot put more than 32k files into a directory.

+	if (fe->i_links_count >= OCFS2_LINK_MAX) {

Endian?

+	fe = (ocfs2_dinode *) fe_bh->b_data;
+	if (fe->i_links_count != inode->i_nlink) {
+		mlog(ML_NOTICE, "inode has nlink = %u, fe has link_cnt = %u. "
+		     "Setting inode from fe.\n", inode->i_nlink,
+		     fe->i_links_count);
+		inode->i_nlink = fe->i_links_count;

Shouldn't that be a BUG()? It looks dangerous.

+{
+	int status = 0;
+	struct inode *old_inode = old_dentry->d_inode;
+	struct inode *new_inode = new_dentry->d_inode;
+	ocfs2_dinode *newfe = NULL;
+	char orphan_name[OCFS2_ORPHAN_NAMELEN + 1];

Hopefully nobody extends that define.

+	struct buffer_head *insert_entry_bh = NULL;
+	ocfs_super *osb = NULL;
+	u64 newfe_blkno;
+	ocfs_journal_handle *handle = NULL;
+	struct buffer_head *old_dir_bh = NULL;
+	struct buffer_head *new_dir_bh = NULL;
+	struct ocfs2_dir_entry *old_de = NULL, *new_de = NULL; // dirent for old_dentry 
+							       // and new_dentry
+	struct buffer_head *new_de_bh = NULL, *old_de_bh = NULL; // bhs for above
+	struct buffer_head *old_inode_de_bh = NULL; // if old_dentry is a dir,
+						    // this is the 1st dirent bh
+	nlink_t old_dir_nlink = old_dir->i_nlink, new_dir_nlink = new_dir->i_nlink;

That's a lot of local variables. How about breaking up the function? 

+
+	/* At some point it might be nice to break this function up a
+	 * bit. */

Hehe.

+
+	/* In case we need to overwrite an existing file, we blow it
+	 * away first */

Overwrite new files? Since when does rename do that?
Shouldn't this just be a -EEXIST?

+#define OCFS_ASSERT(cond)	do { if (unlikely(!(cond))) BUG(); } while (0)

This should be defined to just BUG_ON

+	do { \
+		if (unlikely(!(x))) { \
+			printk(KERN_ERR "This should make the filesystem remount RO\n"); \

How can it ever do that if you don't pass the super block? 
And printing the device name then at least would be good.

+			BUG(); \
+		} \
+	} while (0)
+
+

+static inline unsigned long ino_from_blkno(struct super_block *sb,
+					   u64 blkno)
+{
+	return (unsigned long)(blkno & (u64)ULONG_MAX);

That's a nop, isn't it?
+#ifndef _OCFS2_FS_H
+#define _OCFS2_FS_H
+
+/* Version */
+#define OCFS2_MAJOR_REV_LEVEL		0
+#define OCFS2_MINOR_REV_LEVEL          	90
+
+/*
+ * An OCFS2 volume starts this way:
+ * Sector 0: Valid ocfs1_vol_disk_hdr that cleanly fails to mount OCFS.

That's bad actually because it means you cannot write an MBR to it.
It would be better to keep the first 4k free.

+ * Sector 1: Valid ocfs1_vol_label that cleanly fails to mount OCFS.
+ * Block OCFS2_SUPER_BLOCK_BLKNO: OCFS2 superblock.
+ *
+ * All other structures are found from the superblock information.
+
+#define OCFS2_FEATURE_COMPAT_SUPP	0
+#define OCFS2_FEATURE_RO_COMPAT_SUPP	0
+
+/* We're not big endian safe yet. But it has been decreed that the
+ * unwashed zLinux masses must be appeased, lest they storm the castle
+ * with rakes and pitchforks. Thus...
+ */
+#ifdef CONFIG_ARCH_S390
+#define OCFS2_FEATURE_INCOMPAT_B0RKEN_ENDIAN	0x0001

Kconfig seems to believe differently though...

Also I wouldn't be surprised if it still didn't work because
there is so much mixup with endians that you might sometimes convert
and sometimes not for the same fields.

Perhaps that should be removed? 

+/*
+ * superblock s_state flags
+ */
+#define OCFS2_ERROR_FS		(0x00000001)	/* FS saw errors */

Now just that must be set everywhere ...

+#define OCFS2_MAX_JOURNAL_SIZE		(500 * 1024 * 1024)

Why this arbitary limit? 

+#define OCFS2_LINK_MAX		32000

And that one looks bad.

+

I would be nice if you had a "10000 feet" disk format overview comment
here, describing how the clusters and extents and truncate records interact.


+ * slot_map.c

Comment? 

+		goto bail;
+	}
+
+	cl->cl_recs[alloc_rec].c_free  += bg->bg_free_bits_count;
+	cl->cl_recs[alloc_rec].c_total += bg->bg_bits;
+	cl->cl_recs[alloc_rec].c_blkno  = bg_blkno;

Endian?

+static inline void debug_bg(ocfs2_group_desc *bg) 

Shouldn't this be conditional on something? 
Same with the other debug functions.

+/* From xfs_super.c:xfs_max_file_offset
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.
+ */
+static unsigned long long ocfs2_max_file_offset(unsigned int blockshift)

This sounds like it should just be somewhere in VFS. 

+	}
+
+	/* Can this really happen? */
+	if (*sector_size < OCFS2_MIN_BLOCKSIZE)
+		*sector_size = OCFS2_MIN_BLOCKSIZE;

I don't think it can.

+/* we can't grab the goofy sem lock from inside wait_event, so we use
+ * memory barriers to make sure that we'll see the null task before
+ * being woken up */
+static int ocfs2_recovery_thread_running(ocfs_super *osb)
+{
+	mb();

If anything you need to do that on the writer.
It looks quite suspicious.

+#ifdef CONFIG_ARCH_S390
+	if (!OCFS2_HAS_INCOMPAT_FEATURE(osb->sb, OCFS2_FEATURE_INCOMPAT_B0RKEN_ENDIAN)) {
+		mlog(ML_ERROR, "couldn't mount because of endian mismatch\n");
+		status = -EINVAL;
+		goto bail;
+	}
+#endif

I would suggest to drop that.

+#endif /* OCFS2_VER_H */
diff -ruN linux-2.6.12-rc4.old/fs/ocfs2/vote.c linux-2.6.12-rc4/fs/ocfs2/vote.c
--- linux-2.6.12-rc4.old/fs/ocfs2/vote.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc4/fs/ocfs2/vote.c	2005-05-17 22:42:59.546619823 -0700
@@ -0,0 +1,992 @@
+ * vote.c
+ *
+ * description here

Yep. 

+static int ocfs2_do_request_vote(ocfs_super *osb,
+				 u64 blkno,
+				 unsigned int generation,
+				 enum ocfs2_vote_request type,
+				 int orphaned_slot,
+				 struct ocfs2_net_response_cb *callback)
...
+	request = kmalloc(sizeof(*request), GFP_KERNEL);
+	if (!request) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+	memset(request, 0, sizeof(*request));

kcalloc

-Andi
