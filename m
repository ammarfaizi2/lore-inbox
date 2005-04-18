Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVDRIry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVDRIry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVDRIry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:47:54 -0400
Received: from [213.170.72.194] ([213.170.72.194]:18846 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261954AbVDRIrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:47:19 -0400
Subject: [PATC] small VFS change for JFFS2
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, dwmw2@lists.infradead.org
Content-Type: text/plain
Organization: MTD
Date: Mon, 18 Apr 2005 12:47:11 +0400
Message-Id: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

tracing out an JFFS2's SMP/PREEMPT bug I've realized that I need to make
a small change in VFS in order to fix the bug gracefully.

I refer to the fs/inode.c file from the 2.6.11.5 Linux kernel.

JFFS2 supports its own accounting of inodes by means of small 'struct
jffs2_inode_cache' objects. There is a field 'state' in these objects
which indicates whether the inode is built (i.e. it is in the Linux
inode cache at the moment) or not built (i.e., it isn't in the Linux
inode cache). This is needed to facilitate fast Garbage Collection,
which is the crucial part of the Flash File System.

JFFS2 assumes that the above mentioned 'state' field is always coherent
with the real state of the inode. The state is changed on read_inode()
and clear_inode() inode operation calls.

But there is a problem with this. When kswapd prunes the Linux inode
cache, there is an interval where clear_inode() was not yet called but
the inode is already removed from the inode hash (inode->i_hash). I mean
the following piece of code at fs/inode.c:467

        inodes_stat.nr_unused -= nr_pruned;
        spin_unlock(&inode_lock);
				// <-- Here
        dispose_list(&freeable); 
        up(&iprune_sem);

This is not a bug - VFS handles things by means of I_FREEING state. But,
for JFFS2 this means, that it may assume that the inode is built, while
it actually isn't (if, say, we are preempted at the above marked point
and the JFFS2 GC starts and picks a node belonging an inode being
pruned). This leads to nasty things in JFFS2.

One obvious thing to fix this JFFS2 problem is to acquire the iprune_sem
semaphore in JFFS2 GC, but for this we need to export it. So, please,
consider the following VFS patch (against Linux 2.6.11.5):

-------------------------------------------------------
diff -auNrp linux-2.6.11.5/fs/inode.c linux-2.6.11.5_vfs_fix/fs/inode.c
--- linux-2.6.11.5/fs/inode.c   2005-03-19 09:35:04.000000000 +0300
+++ linux-2.6.11.5_vfs_fix/fs/inode.c   2005-04-18 12:09:43.000000000
+0400
@@ -92,6 +92,8 @@ DEFINE_SPINLOCK(inode_lock);
  */
 DECLARE_MUTEX(iprune_sem);

+EXPORT_SYMBOL(iprune_sem);
+
 /*
  * Statistics gathering..
  */
-------------------------------------------------------

P.S. Probably we may fix this without VFS changes (albeit I'm not sure),
but it will be more difficult and much uglier.

The following is the correspondent patch for JFFS2 (against MTD CVS
Head):

-------------------------------------------------------
diff -auNrp --exclude=CVS mtd-pristine/fs/jffs2/gc.c mtd/fs/jffs2/gc.c
--- mtd-pristine/fs/jffs2/gc.c  2005-04-11 13:13:29.000000000 +0400
+++ mtd/fs/jffs2/gc.c   2005-04-18 12:20:40.390920376 +0400
@@ -126,15 +126,17 @@ int jffs2_garbage_collect_pass(struct jf
        struct jffs2_eraseblock *jeb;
        struct jffs2_raw_node_ref *raw;
        int ret = 0, inum, nlink;
+       int iprune_sem_up = 0;

        if (down_interruptible(&c->alloc_sem))
                return -EINTR;

        for (;;) {
-               spin_lock(&c->erase_completion_lock);
                if (!c->unchecked_size)
                        break;

+               spin_lock(&c->erase_completion_lock);
+
                /* We can't start doing GC yet. We haven't finished
checking
                   the node CRCs etc. Do it now. */

@@ -206,6 +208,17 @@ int jffs2_garbage_collect_pass(struct jf
                return ret;
        }

+       /*
+        * To be sure the ic->state's value stays consistent, we need to
+        * forbid kswapd to prune our inode. Otherwise, we may end up
+        * with the situation where the ic->state = INO_STATE_PRESENT
+        * while it isn't actually in the inode cache (since it was just
+        * pruned by kswapd, but clear_inode() wasn't yet called).
+        */
+       down(&iprune_sem);
+
+       spin_lock(&c->erase_completion_lock);
+
        /* First, work out which block we're garbage-collecting */
        jeb = c->gcblock;

@@ -215,6 +228,7 @@ int jffs2_garbage_collect_pass(struct jf
        if (!jeb) {
                D1 (printk(KERN_NOTICE "jffs2: Couldn't find erase block
to garbage collect!\n"));
                spin_unlock(&c->erase_completion_lock);
+               up(&iprune_sem);
                up(&c->alloc_sem);
                return -EIO;
        }
@@ -224,6 +238,7 @@ int jffs2_garbage_collect_pass(struct jf
           printk(KERN_DEBUG "Nextblock at  %08x, used_size %08x,
dirty_size %08x, wasted_size %08x, free_size %08x\n", c->n
extblock->offset, c->nextblock->used_size, c->nextblock->dirty_size, c-
>nextblock->wasted_size, c->nextblock->free_size));

        if (!jeb->used_size) {
+               up(&iprune_sem);
                up(&c->alloc_sem);
                goto eraseit;
        }
@@ -239,6 +254,7 @@ int jffs2_garbage_collect_pass(struct jf
                               jeb->offset, jeb->free_size, jeb-
>dirty_size, jeb->used_size);
                        jeb->gc_node = raw;
                        spin_unlock(&c->erase_completion_lock);
+                       up(&iprune_sem);
                        up(&c->alloc_sem);
                        BUG();
                }
@@ -253,6 +269,7 @@ int jffs2_garbage_collect_pass(struct jf
                   we don't grok that has JFFS2_NODETYPE_RWCOMPAT_COPY,
we should do so */
                spin_unlock(&c->erase_completion_lock);
                jffs2_mark_node_obsolete(c, raw);
+               up(&iprune_sem);
                up(&c->alloc_sem);
                goto eraseit_lock;
      @@ -283,6 +300,8 @@ int jffs2_garbage_collect_pass(struct jf
                   We can just copy any pristine nodes, but have
                   to prevent anyone else from doing read_inode() while
                   we're at it, so we set the state accordingly */
+               iprune_sem_up += 1;
+               up(&iprune_sem);
                if (ref_flags(raw) == REF_PRISTINE)
                        ic->state = INO_STATE_GC;
                else {
@@ -305,6 +324,7 @@ int jffs2_garbage_collect_pass(struct jf
                */
                printk(KERN_CRIT "Inode #%u already in state %d in
jffs2_garbage_collect_pass()!\n",
                       ic->ino, ic->state);
+               up(&iprune_sem);
                up(&c->alloc_sem);
                spin_unlock(&c->inocache_lock);
                BUG();
@@ -316,6 +336,7 @@ int jffs2_garbage_collect_pass(struct jf
                   the alloc_sem() (for marking nodes invalid) so we
must
                   drop the alloc_sem before sleeping. */

+               up(&iprune_sem);
                up(&c->alloc_sem);
                D1(printk(KERN_DEBUG "jffs2_garbage_collect_pass()
waiting for ino #%u in state %d\n",
                          ic->ino, ic->state));
@@ -367,6 +388,8 @@ int jffs2_garbage_collect_pass(struct jf
        spin_unlock(&c->inocache_lock);

        f = jffs2_gc_fetch_inode(c, inum, nlink);
+       if (!iprune_sem_up)
+               up(&iprune_sem);
        if (IS_ERR(f)) {
                ret = PTR_ERR(f);
                goto release_sem;
  }
-------------------------------------------------------

Comments?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

