Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTAZCy2>; Sat, 25 Jan 2003 21:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTAZCy2>; Sat, 25 Jan 2003 21:54:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:19842 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266615AbTAZCyX>;
	Sat, 25 Jan 2003 21:54:23 -0500
Date: Sat, 25 Jan 2003 19:04:10 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz, mason@suse.com,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030125190410.7c91e640.akpm@digeo.com>
In-Reply-To: <20030125153607.A10590@namesys.com>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
	<20030124225320.5d387993.akpm@digeo.com>
	<20030125153607.A10590@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2003 03:03:32.0247 (UTC) FILETIME=[824E8A70:01C2C4E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Looking through 2.5.54, I found that changeset named "[PATCH] quota locking update" forwarded by you
> is the cause for the problem.

OK, it's writepage-versus-writepage and/or writepage-versus-truncate. 
There's no locking between the updaters and i_blocks goes negative.
This is good ;)  We have done well.

I went for the new frlocks which I dragged into -mm to fix up the xtime_lock
problems.  It's not 100% appropriate, but it'll do just fine.

Stephen, we can use that frlock in the inode to protect access to the 64-bit
i_size on 32-bit platforms as well.  However in the case of i_size, the
updaters do not need to take the frlock's spinlock, because writers are
serialised inode->i_sem.

So could you please take a look at adding new writer-side primitives to
frlocks to cover this requirement?  See i_size_read/i_size_write from the -aa
kernel:

+static inline void i_size_write(struct inode * inode, loff_t i_size)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#ifdef __ARCH_HAS_GET_SET_64BIT
+	set_64bit((unsigned long long *) &inode->i_size, (unsigned long long) i_size);
+#else
+	inode->i_size_version2++;
+	wmb();
+	inode->i_size = i_size;
+	wmb();
+	inode->i_size_version1++;
+	wmb(); /* make it visible ASAP */
+#endif
+#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
+	inode->i_size = i_size;
+#endif
+}


Something like this might suffice:

diff -puN include/linux/frlock.h~frlock_write_begin include/linux/frlock.h
--- 25/include/linux/frlock.h~frlock_write_begin	2003-01-25 18:59:27.000000000 -0800
+++ 25-akpm/include/linux/frlock.h	2003-01-25 19:01:27.000000000 -0800
@@ -80,6 +80,22 @@ static inline unsigned fr_read_end(frloc
 	return rw->pre_sequence;
 }
 
+static inline unsigned fr_write_begin(frlock_t *rw)
+{
+	unsigned ret = rw->pre_sequence++;
+	wmb();
+	return ret;
+}	
+
+static inline unsigned fr_write_end(frlock_t *rw) 
+{
+	unsgned ret;
+	wmb();
+	ret = ++(rw->post_sequence);
+	wmb();
+	return ret;
+}
+
 /*
  * Possible sw/hw IRQ protected versions of the interfaces.
  */

Thanks.




Since Jan removed the lock_kernel()s in inode_add_bytes() and
inode_sub_bytes(), these functions have been racy.

One problematic workload has been discovered in which concurrent writepage
and truncate on SMP quickly causes i_blocks to go negative.  writepage() does
not take i_sem, and it seems that for ext2, there are no other locks in
force when inode_add_bytes() is called.

Putting the BKL back in there is not acceptable.  To fix this race I have
used the new frlocks.

This is actually fairly pointless, because these fields are write-mostly and
read-rarely.  But we need a spinlock anyway because of the concurrent
modifiers problem.

And we need this frlock in the inode to solve the problem of the nonatomicity
of i_size.  (But some aditional frlock work is needed first: in the case of
i_size we do not need to take the spinlock because of i_sem protection).

The splitting of the used disk space into i_blocks and i_bytes is silly - we
should nuke all that and just have a bare loff_t i_usedbytes.   Later.


 inode.c    |    1 +
 stat.c     |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 linux/fs.h |   52 +++++++++++++++++-----------------------------------
 ksyms.c    |    4 ++++
 4 files changed, 68 insertions(+), 35 deletions(-)

diff -puN include/linux/fs.h~inode-accounting-race-fix include/linux/fs.h
--- linux-hype/include/linux/fs.h~inode-accounting-race-fix	2003-01-25 18:36:25.000000000 -0800
+++ linux-hype-akpm/include/linux/fs.h	2003-01-25 18:36:25.000000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
+#include <linux/frlock.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -371,9 +372,19 @@ struct inode {
 	struct timespec		i_ctime;
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
-	unsigned long		i_blocks;
 	unsigned long		i_version;
+
+	/*
+	 * i_bytes and i_blocks represent the amount of allocated disk space:
+	 * (i_blocks * 512 + i_bytes) (FIXME: just use an loff_t here).  They
+	 * are protected by i_frlock.
+	 */
+	unsigned long		i_blocks;
 	unsigned short          i_bytes;
+
+	/* Protects i_blocks, i_bytes and, later, i_size */
+	frlock_t		i_frlock;
+
 	struct semaphore	i_sem;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
@@ -400,7 +411,7 @@ struct inode {
 	void			*i_security;
 	__u32			i_generation;
 	union {
-		void				*generic_ip;
+		void		*generic_ip;
 	} u;
 };
 
@@ -412,39 +423,6 @@ struct fown_struct {
 	void *security;
 };
 
-static inline void inode_add_bytes(struct inode *inode, loff_t bytes)
-{
-	inode->i_blocks += bytes >> 9;
-	bytes &= 511;
-	inode->i_bytes += bytes;
-	if (inode->i_bytes >= 512) {
-		inode->i_blocks++;
-		inode->i_bytes -= 512;
-	}
-}
-
-static inline void inode_sub_bytes(struct inode *inode, loff_t bytes)
-{
-	inode->i_blocks -= bytes >> 9;
-	bytes &= 511;
-	if (inode->i_bytes < bytes) {
-		inode->i_blocks--;
-		inode->i_bytes += 512;
-	}
-	inode->i_bytes -= bytes;
-}
-
-static inline loff_t inode_get_bytes(struct inode *inode)
-{
-	return (((loff_t)inode->i_blocks) << 9) + inode->i_bytes;
-}
-
-static inline void inode_set_bytes(struct inode *inode, loff_t bytes)
-{
-	inode->i_blocks = bytes >> 9;
-	inode->i_bytes = bytes & 511;
-}
-
 /*
  * Track a single file's readahead state
  */
@@ -1277,6 +1255,10 @@ extern int page_symlink(struct inode *in
 extern struct inode_operations page_symlink_inode_operations;
 extern void generic_fillattr(struct inode *, struct kstat *);
 extern int vfs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
+void inode_add_bytes(struct inode *inode, loff_t bytes);
+void inode_sub_bytes(struct inode *inode, loff_t bytes);
+loff_t inode_get_bytes(struct inode *inode);
+void inode_set_bytes(struct inode *inode, loff_t bytes);
 
 extern int vfs_readdir(struct file *, filldir_t, void *);
 
diff -puN fs/stat.c~inode-accounting-race-fix fs/stat.c
--- linux-hype/fs/stat.c~inode-accounting-race-fix	2003-01-25 18:36:25.000000000 -0800
+++ linux-hype-akpm/fs/stat.c	2003-01-25 18:36:25.000000000 -0800
@@ -316,3 +316,49 @@ asmlinkage long sys_fstat64(unsigned lon
 }
 
 #endif /* LFS-64 */
+
+void inode_add_bytes(struct inode *inode, loff_t bytes)
+{
+	fr_write_lock(&inode->i_frlock);
+	inode->i_blocks += bytes >> 9;
+	bytes &= 511;
+	inode->i_bytes += bytes;
+	if (inode->i_bytes >= 512) {
+		inode->i_blocks++;
+		inode->i_bytes -= 512;
+	}
+	fr_write_unlock(&inode->i_frlock);
+}
+
+void inode_sub_bytes(struct inode *inode, loff_t bytes)
+{
+	fr_write_lock(&inode->i_frlock);
+	inode->i_blocks -= bytes >> 9;
+	bytes &= 511;
+	if (inode->i_bytes < bytes) {
+		inode->i_blocks--;
+		inode->i_bytes += 512;
+	}
+	inode->i_bytes -= bytes;
+	fr_write_unlock(&inode->i_frlock);
+}
+
+loff_t inode_get_bytes(struct inode *inode)
+{
+	unsigned seq;
+	loff_t ret;
+
+	do {
+		seq = fr_read_begin(&inode->i_frlock);
+		ret = (((loff_t)inode->i_blocks) << 9) + inode->i_bytes;
+	} while (seq != fr_read_end(&inode->i_frlock));
+	return ret;
+}
+
+void inode_set_bytes(struct inode *inode, loff_t bytes)
+{
+	fr_write_lock(&inode->i_frlock);
+	inode->i_blocks = bytes >> 9;
+	inode->i_bytes = bytes & 511;
+	fr_write_unlock(&inode->i_frlock);
+}
diff -puN kernel/ksyms.c~inode-accounting-race-fix kernel/ksyms.c
--- linux-hype/kernel/ksyms.c~inode-accounting-race-fix	2003-01-25 18:36:25.000000000 -0800
+++ linux-hype-akpm/kernel/ksyms.c	2003-01-25 18:36:25.000000000 -0800
@@ -272,6 +272,10 @@ EXPORT_SYMBOL(vfs_fstat);
 EXPORT_SYMBOL(vfs_stat);
 EXPORT_SYMBOL(vfs_lstat);
 EXPORT_SYMBOL(vfs_getattr);
+EXPORT_SYMBOL(inode_add_bytes);
+EXPORT_SYMBOL(inode_sub_bytes);
+EXPORT_SYMBOL(inode_get_bytes);
+EXPORT_SYMBOL(inode_set_bytes);
 EXPORT_SYMBOL(lock_rename);
 EXPORT_SYMBOL(unlock_rename);
 EXPORT_SYMBOL(generic_read_dir);
diff -puN fs/inode.c~inode-accounting-race-fix fs/inode.c
--- linux-hype/fs/inode.c~inode-accounting-race-fix	2003-01-25 18:36:25.000000000 -0800
+++ linux-hype-akpm/fs/inode.c	2003-01-25 18:36:25.000000000 -0800
@@ -176,6 +176,7 @@ void inode_init_once(struct inode *inode
 	spin_lock_init(&inode->i_data.private_lock);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	frlock_init(&inode->i_frlock);
 }
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)

_

