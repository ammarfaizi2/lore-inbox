Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUIQEQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUIQEQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268351AbUIQENs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:48 -0400
Received: from [12.177.129.25] ([12.177.129.25]:6084 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268353AbUIQENF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:05 -0400
Message-Id: <200409170517.i8H5HZ2J005407@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another batch of "obviously harmless" changes:
	comments
	unsigned long -> __u32 changes for some data that needs to be 32 bits
	cleanups
	removal of an unused declaration
	rearrangement of includes

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/drivers/chan_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/chan_kern.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/chan_kern.c	2004-09-16 23:44:37.000000000 -0400
@@ -106,6 +106,8 @@
 	return(n);
 }
 
+/* XXX Trivial wrapper around os_write_file */
+
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
 	return(os_write_file(fd, buf, n));
Index: 2.6.9-rc2/arch/um/drivers/cow_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/cow_user.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/cow_user.c	2004-09-16 23:44:37.000000000 -0400
@@ -27,8 +27,8 @@
 #define PATH_LEN_V2 MAXPATHLEN
 
 struct cow_header_v2 {
-	unsigned long magic;
-	unsigned long version;
+	__u32 magic;
+	__u32 version;
 	char backing_file[PATH_LEN_V2];
 	time_t mtime;
 	__u64 size;
Index: 2.6.9-rc2/arch/um/drivers/hostaudio_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/hostaudio_kern.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/hostaudio_kern.c	2004-09-16 23:44:37.000000000 -0400
@@ -35,7 +35,7 @@
 "    The default is \"" HOSTAUDIO_DEV_DSP "\".\n\n"
 
 #define MIXER_HELP \
-"    This is used to specify the host mixer device to the hostaudio driver.\n" \
+"    This is used to specify the host mixer device to the hostaudio driver.\n"\
 "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
 
 #ifndef MODULE
@@ -72,7 +72,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	void *kbuf;
-	int ret;
+	int err;
 
 #ifdef DEBUG
         printk("hostaudio: read called, count = %d\n", count);
@@ -82,16 +82,16 @@
 	if(kbuf == NULL)
 		return(-ENOMEM);
 
-	ret = os_read_file(state->fd, kbuf, count);
-	if(ret < 0)
+	err = os_read_file(state->fd, kbuf, count);
+	if(err < 0)
 		goto out;
 
-	if(copy_to_user(buffer, kbuf, ret))
-		ret = -EFAULT;
+	if(copy_to_user(buffer, kbuf, err))
+		err = -EFAULT;
 
  out:
 	kfree(kbuf);
-	return(ret);
+	return(err);
 }
 
 static ssize_t hostaudio_write(struct file *file, const char *buffer, 
@@ -99,7 +99,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	void *kbuf;
-	int ret;
+	int err;
 
 #ifdef DEBUG
         printk("hostaudio: write called, count = %d\n", count);
@@ -109,17 +109,18 @@
 	if(kbuf == NULL)
 		return(-ENOMEM);
 
-	ret = -EFAULT;
+	err = -EFAULT;
 	if(copy_from_user(kbuf, buffer, count))
 		goto out;
 
-	ret = os_write_file(state->fd, kbuf, count);
-	if(ret < 0)
+	err = os_write_file(state->fd, kbuf, count);
+	if(err < 0)
 		goto out;
+	*ppos += err;
 
  out:
 	kfree(kbuf);
-	return(ret);
+	return(err);
 }
 
 static unsigned int hostaudio_poll(struct file *file, 
@@ -139,7 +140,7 @@
 {
         struct hostaudio_state *state = file->private_data;
 	unsigned long data = 0;
-	int ret;
+	int err;
 
 #ifdef DEBUG
         printk("hostaudio: ioctl called, cmd = %u\n", cmd);
@@ -158,7 +159,7 @@
 		break;
 	}
 
-	ret = os_ioctl_generic(state->fd, cmd, (unsigned long) &data);
+	err = os_ioctl_generic(state->fd, cmd, (unsigned long) &data);
 
 	switch(cmd){
 	case SNDCTL_DSP_SPEED:
@@ -174,7 +175,7 @@
 		break;
 	}
 
-	return(ret);
+	return(err);
 }
 
 static int hostaudio_open(struct inode *inode, struct file *file)
@@ -188,22 +189,19 @@
 #endif
 
         state = kmalloc(sizeof(struct hostaudio_state), GFP_KERNEL);
-        if(state == NULL) return(-ENOMEM);
+        if(state == NULL) 
+		return(-ENOMEM);
 
         if(file->f_mode & FMODE_READ) r = 1;
         if(file->f_mode & FMODE_WRITE) w = 1;
 
 	ret = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
-
         if(ret < 0){
-		printk("hostaudio_open failed to open '%s', err = %d\n",
-		       dsp, -ret);
 		kfree(state);
 		return(ret);
         }
 
 	state->fd = ret;
-
         file->private_data = state;
         return(0);
 }
@@ -216,11 +214,7 @@
         printk("hostaudio: release called\n");
 #endif
 
-	if(state->fd >= 0){
 		os_close_file(state->fd);
-		state->fd = -1;
-	}
-
         kfree(state);
 
 	return(0);
@@ -265,8 +259,6 @@
 		return(ret);
         }
 
-	state->fd = ret;
-
         file->private_data = state;
         return(0);
 }
@@ -279,10 +271,7 @@
         printk("hostmixer: release called\n");
 #endif
 
-	if(state->fd >= 0){
 		os_close_file(state->fd);
-		state->fd = -1;
-	}
         kfree(state);
 
 	return(0);
Index: 2.6.9-rc2/arch/um/include/user_util.h
===================================================================
--- 2.6.9-rc2.orig/arch/um/include/user_util.h	2004-09-16 23:14:18.000000000 -0400
+++ 2.6.9-rc2/arch/um/include/user_util.h	2004-09-16 23:44:37.000000000 -0400
@@ -74,7 +74,6 @@
 extern void tracer_panic(char *msg, ...);
 extern char *get_umid(int only_if_set);
 extern void do_longjmp(void *p, int val);
-extern void suspend_new_thread(int fd);
 extern int detach(int pid, int sig);
 extern int attach(int pid);
 extern void kill_child_dead(int pid);
Index: 2.6.9-rc2/arch/um/kernel/uaccess_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/uaccess_user.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/uaccess_user.c	2004-09-16 23:44:37.000000000 -0400
@@ -17,8 +17,8 @@
 					int n), int *faulted_out)
 {
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
-	sigjmp_buf jbuf;
 
+	sigjmp_buf jbuf;
 	*fault_catcher = &jbuf;
 	if(sigsetjmp(jbuf, 1) == 0){
 		(*op)(to, from, n);
Index: 2.6.9-rc2/arch/um/kernel/um_arch.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/um_arch.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/um_arch.c	2004-09-16 23:44:37.000000000 -0400
@@ -27,7 +27,6 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
-#include "mprot.h"
 #include "mem_user.h"
 #include "mem.h"
 #include "umid.h"
Index: 2.6.9-rc2/arch/um/kernel/user_util.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/user_util.c	2004-09-16 23:14:18.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/user_util.c	2004-09-16 23:44:38.000000000 -0400
@@ -7,8 +7,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
-#include <sys/mman.h> 
 #include <setjmp.h>
+#include <sys/mman.h> 
 #include <sys/stat.h>
 #include <sys/ptrace.h>
 #include <sys/utsname.h>

