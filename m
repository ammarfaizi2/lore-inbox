Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbSKAD7Z>; Thu, 31 Oct 2002 22:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSKAD7Z>; Thu, 31 Oct 2002 22:59:25 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:55306 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265575AbSKAD7W>; Thu, 31 Oct 2002 22:59:22 -0500
Date: Fri, 1 Nov 2002 04:05:44 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, oprofile-list@lists.sf.net
Subject: [PATCH] fix sys_lookup_dcookie prototype
Message-ID: <20021101040544.GA5269@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to use u64 because the future 64-bit ports can theoretically
return the same value for two different dentries, as pointed out by
Ulrich Weigand.

The patch also changes return value of the syscall to give length of
data copied, needed for valgrind support (this bit is by Philippe Elie).

Note this is not a complete fix for mixed 32/64: userspace needs to
figure out the kernel pointer size when reading from the buffer. But
that's another fix...

please apply

thanks
john

p.s. any oprofile users will need to upgrade after this goes in, and the
user-space equivalent is checked into CVS. Sorry for the inconvenience


diff -Naur -X dontdiff linux-linus/drivers/oprofile/buffer_sync.c linux/drivers/oprofile/buffer_sync.c
--- linux-linus/drivers/oprofile/buffer_sync.c	Wed Oct 16 19:08:46 2002
+++ linux/drivers/oprofile/buffer_sync.c	Thu Oct 17 01:42:47 2002
@@ -118,13 +118,13 @@
  * because we cannot reach this code without at least one
  * dcookie user still being registered (namely, the reader
  * of the event buffer). */
-static inline u32 fast_get_dcookie(struct dentry * dentry,
+static inline unsigned long fast_get_dcookie(struct dentry * dentry,
 	struct vfsmount * vfsmnt)
 {
-	u32 cookie;
+	unsigned long cookie;
  
 	if (dentry->d_cookie)
-		return (u32)dentry;
+		return (unsigned long)dentry;
 	get_dcookie(dentry, vfsmnt, &cookie);
 	return cookie;
 }
@@ -135,9 +135,9 @@
  * not strictly necessary but allows oprofile to associate
  * shared-library samples with particular applications
  */
-static u32 get_exec_dcookie(struct mm_struct * mm)
+static unsigned long get_exec_dcookie(struct mm_struct * mm)
 {
-	u32 cookie = 0;
+	unsigned long cookie = 0;
 	struct vm_area_struct * vma;
  
 	if (!mm)
@@ -163,9 +163,9 @@
  * sure to do this lookup before a mm->mmap modification happens so
  * we don't lose track.
  */
-static u32 lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
+static unsigned long lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
 {
-	u32 cookie = 0;
+	unsigned long cookie = 0;
 	struct vm_area_struct * vma;
 
 	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
@@ -188,7 +188,7 @@
 }
 
 
-static u32 last_cookie = ~0UL;
+static unsigned long last_cookie = ~0UL;
  
 static void add_cpu_switch(int i)
 {
@@ -199,7 +199,7 @@
 }
 
  
-static void add_ctx_switch(pid_t pid, u32 cookie)
+static void add_ctx_switch(pid_t pid, unsigned long cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_SWITCH_CODE); 
@@ -208,7 +208,7 @@
 }
 
  
-static void add_cookie_switch(u32 cookie)
+static void add_cookie_switch(unsigned long cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(COOKIE_SWITCH_CODE);
@@ -225,7 +225,7 @@
 
 static void add_us_sample(struct mm_struct * mm, struct op_sample * s)
 {
-	u32 cookie;
+	unsigned long cookie;
 	off_t offset;
  
  	cookie = lookup_dcookie(mm, s->eip, &offset);
@@ -317,7 +317,7 @@
 {
 	struct mm_struct * mm = 0;
 	struct task_struct * new;
-	u32 cookie;
+	unsigned long cookie;
 	int i;
  
 	for (i=0; i < cpu_buf->pos; ++i) {
diff -Naur -X dontdiff linux-linus/fs/dcookies.c linux/fs/dcookies.c
--- linux-linus/fs/dcookies.c	Wed Oct 16 19:08:50 2002
+++ linux/fs/dcookies.c	Fri Nov  1 03:38:53 2002
@@ -8,7 +8,7 @@
  * non-transitory that can be processed at a later date.
  * This is done by locking the dentry/vfsmnt pair in the
  * kernel until released by the tasks needing the persistent
- * objects. The tag is simply an u32 that refers
+ * objects. The tag is simply an unsigned long that refers
  * to the pair and can be looked up from userspace.
  */
 
@@ -46,19 +46,19 @@
 
 
 /* The dentry is locked, its address will do for the cookie */
-static inline u32 dcookie_value(struct dcookie_struct * dcs)
+static inline unsigned long dcookie_value(struct dcookie_struct * dcs)
 {
-	return (u32)dcs->dentry;
+	return (unsigned long)dcs->dentry;
 }
 
 
-static size_t dcookie_hash(u32 dcookie)
+static size_t dcookie_hash(unsigned long dcookie)
 {
-	return (dcookie >> 2) & (hash_size - 1);
+	return (dcookie >> L1_CACHE_SHIFT) & (hash_size - 1);
 }
 
 
-static struct dcookie_struct * find_dcookie(u32 dcookie)
+static struct dcookie_struct * find_dcookie(unsigned long dcookie)
 {
 	struct dcookie_struct * found = 0;
 	struct dcookie_struct * dcs;
@@ -109,7 +110,7 @@
  * value for a dentry/vfsmnt pair.
  */
 int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
-	u32 * cookie)
+	unsigned long * cookie)
 {
 	int err = 0;
 	struct dcookie_struct * dcs;
@@ -142,11 +143,12 @@
 /* And here is where the userspace process can look up the cookie value
  * to retrieve the path.
  */
-asmlinkage int sys_lookup_dcookie(u32 cookie, char * buf, size_t len)
+asmlinkage int sys_lookup_dcookie(u64 cookie64, char * buf, size_t len)
 {
+	unsigned long cookie = (unsigned long)cookie64;
+	int err = -EINVAL;
 	char * kbuf;
 	char * path;
-	int err = -EINVAL;
 	size_t pathlen;
 	struct dcookie_struct * dcs;
 
@@ -170,19 +172,18 @@
 	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!kbuf)
 		goto out;
-	memset(kbuf, 0, PAGE_SIZE);
 
 	/* FIXME: (deleted) ? */
 	path = d_path(dcs->dentry, dcs->vfsmnt, kbuf, PAGE_SIZE);
 
-	err = 0;
-
+	err = -ERANGE;
+ 
 	pathlen = kbuf + PAGE_SIZE - path;
-	if (len > pathlen)
-		len = pathlen;
-
-	if (copy_to_user(buf, path, len))
-		err = -EFAULT;
+	if (pathlen <= len) {
+		err = pathlen;
+		if (copy_to_user(buf, path, pathlen))
+			err = -EFAULT;
+	}
 
 	kfree(kbuf);
 out:
diff -Naur -X dontdiff linux-linus/include/linux/dcookies.h linux/include/linux/dcookies.h
--- linux-linus/include/linux/dcookies.h	Wed Oct 16 19:08:53 2002
+++ linux/include/linux/dcookies.h	Sat Oct 19 01:58:16 2002
@@ -44,7 +44,7 @@
  * Returns 0 on success, with *cookie filled in
  */
 int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
-	u32 * cookie);
+	unsigned long * cookie);
 
 #else
 
@@ -59,7 +59,7 @@
 }
  
 static inline int get_dcookie(struct dentry * dentry,
-	struct vfsmount * vfsmnt, u32 * cookie)
+	struct vfsmount * vfsmnt, unsigned long * cookie)
 {
 	return -ENOSYS;
 } 
