Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUBLCW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 21:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUBLCWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 21:22:45 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:28363 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261799AbUBLCWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 21:22:36 -0500
Date: Wed, 11 Feb 2004 18:22:06 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040212022205.GQ9155@sun.com>
Reply-To: thockin@sun.com
References: <20040211210930.GJ9155@sun.com> <20040211135325.7b4b5020.akpm@osdl.org> <20040211222849.GL9155@sun.com> <20040211144844.0e4a2888.akpm@osdl.org> <20040211233852.GN9155@sun.com> <20040211155754.5068332c.akpm@osdl.org> <20040212003840.GO9155@sun.com> <20040211164233.5f233595.akpm@osdl.org> <20040212010822.GP9155@sun.com> <20040211172046.37e18a2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <20040211172046.37e18a2f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2004 at 05:20:46PM -0800, Andrew Morton wrote:
> > Offer repeated. :)
> 
> Please.

Patch attached.  I somehow blew up my box when I overran the 800 port limit
in nfs, now.  More fun.

never happened before, but I don't know how itr could be this patch's
fault..

RPC: can't bind to reserved port.
NFS: cannot retrieve file system info.
nfs_read_super: get root inode failed
------------[ cut here ]------------
kernel BUG at fs/inode.c:1090!
invalid operand: 0000 [#2]
CPU:    1
EIP:    0060:[<c0187fc4>]    Not tainted
EFLAGS: 00010246
EIP is at iput+0x72/0x7c
eax: c0455b20   ebx: f4537690   ecx: c01f6fbc   edx: 00000001
esi: f4a24000   edi: f4537690   ebp: f4a25e2c   esp: f4a25e20
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 3029, threadinfo=f4a24000 task=f729b940)
Stack: f4654480 f4a24000 f4654480 f4a25e4c c01835a2 f4537690 f4537690 f4654488
       f4654480 f4a99200 c0455b20 f4a25e6c c016fbb6 f4654480 c03c6398 f4eab000
       f4a24000 0000019c f4a24000 f4a25e84 c0170da7 f4a99200 f46844ea f44aad80
Call Trace:
 [<c01835a2>] dput+0x183/0x3ea
 [<c016fbb6>] generic_shutdown_super+0x3f/0x26b
 [<c03c6398>] xprt_shutdown+0x48/0x7a
 [<c0170da7>] kill_anon_super+0x1d/0xad
 [<c01fc6a5>] nfs_kill_super+0x1a/0x28
 [<c016f892>] deactivate_super+0xa4/0x15a
 [<c01fc61a>] nfs_get_sb+0x1e7/0x258
 [<c01711db>] do_kern_mount+0x56/0xc5
 [<c018b980>] do_add_mount+0x8a/0x19a
 [<c018bcec>] do_mount+0x151/0x194

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="max_anon_raise-2.6.2-2.diff"

===== include/linux/idr.h 1.3 vs edited =====
--- 1.3/include/linux/idr.h	Thu Mar 27 21:13:36 2003
+++ edited/include/linux/idr.h	Wed Feb 11 16:25:20 2004
@@ -58,7 +58,7 @@
  */
 
 void *idr_find(struct idr *idp, int id);
-int idr_pre_get(struct idr *idp);
+int idr_pre_get(struct idr *idp, unsigned gfp_mask);
 int idr_get_new(struct idr *idp, void *ptr);
 void idr_remove(struct idr *idp, int id);
 void idr_init(struct idr *idp);
===== lib/idr.c 1.3 vs edited =====
--- 1.3/lib/idr.c	Thu Mar 27 21:13:36 2003
+++ edited/lib/idr.c	Wed Feb 11 16:24:57 2004
@@ -62,13 +62,13 @@
  *   to the rest of the functions.  The structure is defined in the
  *   header.
 
- * int idr_pre_get(struct idr *idp)
+ * int idr_pre_get(struct idr *idp, unsigned gfp_mask)
 
  *   This function should be called prior to locking and calling the
  *   following function.  It pre allocates enough memory to satisfy the
- *   worst possible allocation.  It can sleep, so must not be called
- *   with any spinlocks held.  If the system is REALLY out of memory
- *   this function returns 0, other wise 1.
+ *   worst possible allocation.  Unless gfp_mask is GFP_ATOMIC, it can
+ *   sleep, so must not be called with any spinlocks held.  If the system is
+ *   REALLY out of memory this function returns 0, other wise 1.
 
  * int idr_get_new(struct idr *idp, void *ptr);
  
@@ -135,11 +135,11 @@
 	spin_unlock(&idp->lock);
 }
 
-int idr_pre_get(struct idr *idp)
+int idr_pre_get(struct idr *idp, unsigned gfp_mask)
 {
 	while (idp->id_free_cnt < idp->layers + 1) {
 		struct idr_layer *new;
-		new = kmem_cache_alloc(idr_layer_cache, GFP_KERNEL);
+		new = kmem_cache_alloc(idr_layer_cache, gfp_mask);
 		if(new == NULL)
 			return (0);
 		free_layer(idp, new);
===== fs/super.c 1.110 vs edited =====
--- 1.110/fs/super.c	Sun Oct  5 01:07:55 2003
+++ edited/fs/super.c	Wed Feb 11 17:08:07 2004
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/acct.h>
 #include <linux/blkdev.h>
@@ -33,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
+#include <linux/idr.h>
 #include <asm/uaccess.h>
 
 
@@ -535,22 +537,26 @@
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
+static struct idr unnamed_dev_idr;
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
+
 	spin_lock(&unnamed_dev_lock);
-	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
-	if (dev == Max_anon) {
+	if (idr_pre_get(&unnamed_dev_idr, GFP_ATOMIC) == 0) {
 		spin_unlock(&unnamed_dev_lock);
-		return -EMFILE;
+		return -ENOMEM;
 	}
-	set_bit(dev, unnamed_dev_in_use);
+	dev = idr_get_new(&unnamed_dev_idr, NULL);
 	spin_unlock(&unnamed_dev_lock);
-	s->s_dev = MKDEV(0, dev);
+
+	if ((dev & MAX_ID_MASK) == (1 << MINORBITS)) {
+		idr_remove(&unnamed_dev_idr, dev);
+		return -EMFILE;
+	}
+	s->s_dev = MKDEV(0, dev & MINORMASK);
 	return 0;
 }
 
@@ -559,13 +565,19 @@
 void kill_anon_super(struct super_block *sb)
 {
 	int slot = MINOR(sb->s_dev);
+
 	generic_shutdown_super(sb);
 	spin_lock(&unnamed_dev_lock);
-	clear_bit(slot, unnamed_dev_in_use);
+	idr_remove(&unnamed_dev_idr, slot);
 	spin_unlock(&unnamed_dev_lock);
 }
 
 EXPORT_SYMBOL(kill_anon_super);
+
+void __init unnamed_dev_init(void)
+{
+	idr_init(&unnamed_dev_idr);
+}
 
 void kill_litter_super(struct super_block *sb)
 {
===== include/linux/fs.h 1.283 vs edited =====
--- 1.283/include/linux/fs.h	Mon Jan 19 15:38:10 2004
+++ edited/include/linux/fs.h	Wed Feb 11 13:43:31 2004
@@ -1045,6 +1045,7 @@
 			void *data);
 struct super_block *get_sb_pseudo(struct file_system_type *, char *,
 			struct super_operations *ops, unsigned long);
+void unnamed_dev_init(void);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
===== init/main.c 1.119 vs edited =====
--- 1.119/init/main.c	Tue Feb  3 21:28:11 2004
+++ edited/init/main.c	Wed Feb 11 13:43:31 2004
@@ -450,6 +450,7 @@
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
+	unnamed_dev_init();
 	security_scaffolding_startup();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
===== kernel/posix-timers.c 1.26 vs edited =====
--- 1.26/kernel/posix-timers.c	Tue Feb  3 21:35:50 2004
+++ edited/kernel/posix-timers.c	Wed Feb 11 16:26:41 2004
@@ -426,7 +426,7 @@
 
 	spin_lock_init(&new_timer->it_lock);
 	do {
-		if (unlikely(!idr_pre_get(&posix_timers_id))) {
+		if (unlikely(!idr_pre_get(&posix_timers_id, GFP_KERNEL))) {
 			error = -EAGAIN;
 			new_timer->it_id = (timer_t)-1;
 			goto out;

--pP0ycGQONqsnqIMP--
