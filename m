Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSJPAAb>; Tue, 15 Oct 2002 20:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265119AbSJPAAa>; Tue, 15 Oct 2002 20:00:30 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:46343 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264785AbSJPAA2>; Tue, 15 Oct 2002 20:00:28 -0400
Date: Wed, 16 Oct 2002 01:06:23 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021016000623.GA45945@compsoc.man.ac.uk>
References: <20021015223255.GB41906@compsoc.man.ac.uk> <20021015.163749.38782953.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015.163749.38782953.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:37:49PM -0700, David S. Miller wrote:

> Can you make the dcookie a fixed sized type such

Look OK ? Applies after the previous 7 patches.

Briefly tested

thanks
john


diff -Naur -X dontdiff linux-linus2/drivers/oprofile/buffer_sync.c linux/drivers/oprofile/buffer_sync.c
--- linux-linus2/drivers/oprofile/buffer_sync.c	Tue Oct 15 23:00:30 2002
+++ linux/drivers/oprofile/buffer_sync.c	Wed Oct 16 00:49:43 2002
@@ -118,13 +118,13 @@
  * because we cannot reach this code without at least one
  * dcookie user still being registered (namely, the reader
  * of the event buffer). */
-static inline unsigned long fast_get_dcookie(struct dentry * dentry,
+static inline u32 fast_get_dcookie(struct dentry * dentry,
 	struct vfsmount * vfsmnt)
 {
-	unsigned long cookie;
+	u32 cookie;
  
 	if (dentry->d_cookie)
-		return (unsigned long)dentry;
+		return (u32)dentry;
 	get_dcookie(dentry, vfsmnt, &cookie);
 	return cookie;
 }
@@ -135,9 +135,9 @@
  * not strictly necessary but allows oprofile to associate
  * shared-library samples with particular applications
  */
-static unsigned long get_exec_dcookie(struct mm_struct * mm)
+static u32 get_exec_dcookie(struct mm_struct * mm)
 {
-	unsigned long cookie = 0;
+	u32 cookie = 0;
 	struct vm_area_struct * vma;
  
 	if (!mm)
@@ -163,9 +163,9 @@
  * sure to do this lookup before a mm->mmap modification happens so
  * we don't lose track.
  */
-static unsigned long lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
+static u32 lookup_dcookie(struct mm_struct * mm, unsigned long addr, off_t * offset)
 {
-	unsigned long cookie = 0;
+	u32 cookie = 0;
 	struct vm_area_struct * vma;
 
 	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
@@ -188,7 +188,7 @@
 }
 
 
-static unsigned long last_cookie = ~0UL;
+static u32 last_cookie = ~0UL;
  
 static void add_cpu_switch(int i)
 {
@@ -199,7 +199,7 @@
 }
 
  
-static void add_ctx_switch(pid_t pid, unsigned long cookie)
+static void add_ctx_switch(pid_t pid, u32 cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_SWITCH_CODE); 
@@ -208,7 +208,7 @@
 }
 
  
-static void add_cookie_switch(unsigned long cookie)
+static void add_cookie_switch(u32 cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(COOKIE_SWITCH_CODE);
@@ -225,7 +225,7 @@
 
 static void add_us_sample(struct mm_struct * mm, struct op_sample * s)
 {
-	unsigned long cookie;
+	u32 cookie;
 	off_t offset;
  
  	cookie = lookup_dcookie(mm, s->eip, &offset);
@@ -317,7 +317,7 @@
 {
 	struct mm_struct * mm = 0;
 	struct task_struct * new;
-	unsigned long cookie;
+	u32 cookie;
 	int i;
  
 	for (i=0; i < cpu_buf->pos; ++i) {
diff -Naur -X dontdiff linux-linus2/drivers/oprofile/oprof.c linux/drivers/oprofile/oprof.c
--- linux-linus2/drivers/oprofile/oprof.c	Tue Oct 15 23:00:30 2002
+++ linux/drivers/oprofile/oprof.c	Wed Oct 16 00:48:50 2002
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/sched.h>
-#include <linux/dcookies.h>
 #include <linux/notifier.h>
 #include <linux/profile.h>
 #include <linux/oprofile.h>
diff -Naur -X dontdiff linux-linus2/fs/dcookies.c linux/fs/dcookies.c
--- linux-linus2/fs/dcookies.c	Tue Oct 15 22:23:29 2002
+++ linux/fs/dcookies.c	Wed Oct 16 00:51:10 2002
@@ -8,7 +8,7 @@
  * non-transitory that can be processed at a later date.
  * This is done by locking the dentry/vfsmnt pair in the
  * kernel until released by the tasks needing the persistent
- * objects. The tag is simply an unsigned long that refers
+ * objects. The tag is simply an u32 that refers
  * to the pair and can be looked up from userspace.
  */
 
@@ -46,19 +46,19 @@
 
 
 /* The dentry is locked, its address will do for the cookie */
-static inline unsigned long dcookie_value(struct dcookie_struct * dcs)
+static inline u32 dcookie_value(struct dcookie_struct * dcs)
 {
-	return (unsigned long)dcs->dentry;
+	return (u32)dcs->dentry;
 }
 
 
-static size_t dcookie_hash(unsigned long dcookie)
+static size_t dcookie_hash(u32 dcookie)
 {
 	return (dcookie >> 2) & (hash_size - 1);
 }
 
 
-static struct dcookie_struct * find_dcookie(unsigned long dcookie)
+static struct dcookie_struct * find_dcookie(u32 dcookie)
 {
 	struct dcookie_struct * found = 0;
 	struct dcookie_struct * dcs;
@@ -109,7 +109,7 @@
  * value for a dentry/vfsmnt pair.
  */
 int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
-	unsigned long * cookie)
+	u32 * cookie)
 {
 	int err = 0;
 	struct dcookie_struct * dcs;
@@ -142,7 +142,7 @@
 /* And here is where the userspace process can look up the cookie value
  * to retrieve the path.
  */
-asmlinkage int sys_lookup_dcookie(unsigned long cookie, char * buf, size_t len)
+asmlinkage int sys_lookup_dcookie(u32 cookie, char * buf, size_t len)
 {
 	char * kbuf;
 	char * path;
diff -Naur -X dontdiff linux-linus2/include/linux/dcookies.h linux/include/linux/dcookies.h
--- linux-linus2/include/linux/dcookies.h	Tue Oct 15 22:23:29 2002
+++ linux/include/linux/dcookies.h	Wed Oct 16 00:48:25 2002
@@ -44,7 +44,7 @@
  * Returns 0 on success, with *cookie filled in
  */
 int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
-	unsigned long * cookie);
+	u32 * cookie);
 
 #else
 
@@ -59,7 +59,7 @@
 }
  
 static inline int get_dcookie(struct dentry * dentry,
-	struct vfsmount * vfsmnt, unsigned long * cookie)
+	struct vfsmount * vfsmnt, u32 * cookie)
 {
 	return -ENOSYS;
 } 
