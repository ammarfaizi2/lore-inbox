Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWCHAaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWCHAaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWCHAaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:30:13 -0500
Received: from mx1.suse.de ([195.135.220.2]:23493 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964841AbWCHAaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:30:11 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Date: Wed, 8 Mar 2006 11:29:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17422.9555.635650.460131@cse.unsw.edu.au>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Kirill Korotaev on Tuesday March 7
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>
	<17420.59580.915759.44913@cse.unsw.edu.au>
	<440D2536.60005@sw.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 7, dev@sw.ru wrote:
> >>The code changes look big, have you looked at
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=113817279225962&w=2
> > 
> > 
> > No I haven't.  I like it.
> >  - Holding the semaphore shouldn't be a problem.
> >  - calling down_read_trylock ought to be fast
> >  - I *think* the unwanted calls to prune_dcache are always under
> >    PF_MEMALLOC - they certainly seem to be.
> No, it looks as it is not :(
> Have you noticed my comment about "count" argument to prune_dcache()?
> For example, prune_dcache() is called from shrink_dcache_parent() which 
> is called in many places and not all of them have PF_MEMALLOC or 
> s_umount semaphore for write. But prune_dcache() doesn't care for super 
> blocks etc. It simply shrinks N dentries which are found _first_.
> 
> So the condition:
> +		if ((current->flags & PF_MEMALLOC) &&
> +			!(ret = down_read_trylock(&s->s_umount))) {
> is not always true when the race occurs, as PF_MEMALLOC is not always set.
> 
> > And it is a nice small change.
> > Have you had any other feedback on this?
> here it is :)

Thanks....

So: we seem to have two different approaches to solving this problem.

One is to stop any other thread from calling dentry_iput while the
umount is running generic_shutdown_super.  This cannot be done with
the PF_MEMALLOC trick and so would require calls to prune_dcache to
state their intentions (e.g. pass a 'struct super_block *').
With this approach, generic_shutdown_super needs to wait for stray
pruning to finish after marking the superblock as being unmounted, and
before shrinking the dcache.

The other is to allow other threads to call dentry_iput at any time,
but to keep track of them, and to wait for all to finish after
pruning all the filesystem's dentries.  This requires the extra
locking in prune_one_dentry to make sure we dput the parent before
releasing dcache_lock.

Of these two, I prefer the former, because fiddling with the locking
in prune_one_dentry is rather intrusive.

Also, the recent 
   nfs-permit-filesystem-to-override-root-dentry-on-mount.patch 
patch in -mm means that generic_shutdown_super does not call
prune_dcache but has it's own pruning code.  This means there is no
longer a need to pass intentions to prune_dcache.  Prune_dcache can
always ignore dentries with s->root==NULL, and shrink_dcache_sb only
works with it's own dentries.

So: blending the better bits of various patches together, I've come up
with the following.  It still needs a changelog entry, but does anyone
want to ACK it ???

Thanks,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c            |   32 ++++++++++++++++++++++++++++++--
 ./fs/super.c             |    3 +++
 ./include/linux/dcache.h |    1 +
 ./include/linux/fs.h     |    3 +++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-03-08 10:42:56.000000000 +1100
+++ ./fs/dcache.c	2006-03-08 11:24:11.000000000 +1100
@@ -364,17 +364,43 @@ restart:
  */
 static inline void prune_one_dentry(struct dentry * dentry)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct dentry * parent;
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
+	sb->s_prunes++;
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
 	if (parent != dentry)
 		dput(parent);
 	spin_lock(&dcache_lock);
+	sb->s_prunes--;
+	if (waitqueue_active(&sb->s_wait_prunes))
+		wake_up(&sb->s_wait_prunes);
+}
+
+/* As prune_one_dentry can hold an input with calling
+ * dentry_iput, generic_shutdown_super needs to wait for any
+ * pending pruning to stop before doing it's own dentry
+ * pruning.
+ */
+void wait_on_prunes(struct super_block *sb)
+{
+	DEFINE_WAIT(w);
+	spin_lock(&dcache_lock);
+	for (;;) {
+		prepare_to_wait(&sb->s_wait_prunes, &w, TASK_UNINTERRUPTIBLE);
+		if (sb->s_prunes == 0)
+			break;
+		spin_unlock(&dcache_lock);
+		schedule();
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
+	finish_wait(&sb->s_wait_prunes, &w);
 }
 
 /**
@@ -417,8 +443,10 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
+		/* If the dentry was recently referenced, or if the filesystem
+		 * is being unmounted, don't free it. */
+		if ((dentry->d_flags & DCACHE_REFERENCED) ||
+		    dentry->d_sb->s_root == NULL) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
  			list_add(&dentry->d_lru, &dentry_unused);
  			dentry_stat.nr_unused++;

diff ./fs/super.c~current~ ./fs/super.c
--- ./fs/super.c~current~	2006-03-08 10:50:37.000000000 +1100
+++ ./fs/super.c	2006-03-08 11:02:12.000000000 +1100
@@ -81,6 +81,8 @@ static struct super_block *alloc_super(v
 		mutex_init(&s->s_dquot.dqio_mutex);
 		mutex_init(&s->s_dquot.dqonoff_mutex);
 		init_rwsem(&s->s_dquot.dqptr_sem);
+		s->s_prunes = 0;
+		init_waitqueue_head(&s->s_wait_prunes);
 		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
@@ -231,6 +233,7 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
+		wait_on_prunes(sb);
 		shrink_dcache_sb(sb);
 		dput(root);
 		fsync_super(sb);

diff ./include/linux/dcache.h~current~ ./include/linux/dcache.h
--- ./include/linux/dcache.h~current~	2006-03-08 11:07:50.000000000 +1100
+++ ./include/linux/dcache.h	2006-03-08 11:25:14.000000000 +1100
@@ -220,6 +220,7 @@ extern void shrink_dcache_sb(struct supe
 extern void shrink_dcache_parent(struct dentry *);
 extern void shrink_dcache_anon(struct hlist_head *);
 extern int d_invalidate(struct dentry *);
+extern void wait_on_prunes(struct super_block *);
 
 /* only used at mount-time */
 extern struct dentry * d_alloc_root(struct inode *);

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2006-03-08 11:02:23.000000000 +1100
+++ ./include/linux/fs.h	2006-03-08 11:03:02.000000000 +1100
@@ -838,6 +838,9 @@ struct super_block {
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	unsigned int		s_prunes;	/* protected by dcache_lock */
+	wait_queue_head_t	s_wait_prunes;
+
 	int			s_frozen;
 	wait_queue_head_t	s_wait_unfrozen;
 


