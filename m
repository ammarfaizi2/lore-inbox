Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbTLSDKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 22:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTLSDKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 22:10:38 -0500
Received: from dp.samba.org ([66.70.73.150]:45768 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265434AbTLSDKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 22:10:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module Alias back compat code
Date: Fri, 19 Dec 2003 14:08:47 +1100
Message-Id: <20031219031034.A38502C06C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The provides backwards compat for old char and block aliases.

MODULE_ALIAS_BLOCK() and MODULE_ALIAS_CHAR() define aliases of form
"XXX-<major>-<minor>", so we should probe for modules using this
form.  Unfortunately in 2.4, block aliases were "XXX-<major>" and
char aliases were of both forms.

Ideally, all modules would now be using MODULE_ALIAS() macros to
define their aliases, and the old configuration files wouldn't
matter as much.  Unfortunately, this hasn't happened, so we make
request_module() return the exit status of modprobe, and then
do fallback when probing for char and block devices.

Please apply.
Rusty.

Name: Backwards Compatibility For Old block and char Aliases
Author: Rusty Russell
Status: Tested on 2.6.0

D: MODULE_ALIAS_BLOCK() and MODULE_ALIAS_CHAR() define aliases of form
D: "XXX-<major>-<minor>", so we should probe for modules using this
D: form.  Unfortunately in 2.4, block aliases were "XXX-<major>" and
D: char aliases were of both forms.
D: 
D: Ideally, all modules would now be using MODULE_ALIAS() macros to
D: define their aliases, and the old configuration files wouldn't
D: matter as much.  Unfortunately, this hasn't happened, so we make
D: request_module() return the exit status of modprobe, and then
D: do fallback when probing for char and block devices.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1494-linux-2.6.0/drivers/block/genhd.c .1494-linux-2.6.0.updated/drivers/block/genhd.c
--- .1494-linux-2.6.0/drivers/block/genhd.c	2003-10-09 18:02:51.000000000 +1000
+++ .1494-linux-2.6.0.updated/drivers/block/genhd.c	2003-12-19 13:40:15.000000000 +1100
@@ -296,7 +296,9 @@ extern int blk_dev_init(void);
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("block-major-%d", MAJOR(dev));
+	if (request_module("block-major-%d-%d", MAJOR(dev), MINOR(dev)) > 0)
+		/* Make old-style 2.4 aliases work */
+		request_module("block-major-%d", MAJOR(dev));
 	return NULL;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1494-linux-2.6.0/fs/char_dev.c .1494-linux-2.6.0.updated/fs/char_dev.c
--- .1494-linux-2.6.0/fs/char_dev.c	2003-11-24 15:42:32.000000000 +1100
+++ .1494-linux-2.6.0.updated/fs/char_dev.c	2003-12-19 13:40:23.000000000 +1100
@@ -434,7 +434,9 @@ void cdev_init(struct cdev *cdev, struct
 
 static struct kobject *base_probe(dev_t dev, int *part, void *data)
 {
-	request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev));
+	if (request_module("char-major-%d-%d", MAJOR(dev), MINOR(dev)) > 0)
+		/* Make old-style 2.4 aliases work */
+		request_module("char-major-%d", MAJOR(dev));
 	return NULL;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1494-linux-2.6.0/include/linux/kmod.h .1494-linux-2.6.0.updated/include/linux/kmod.h
--- .1494-linux-2.6.0/include/linux/kmod.h	2003-09-22 10:28:12.000000000 +1000
+++ .1494-linux-2.6.0.updated/include/linux/kmod.h	2003-12-19 13:26:50.000000000 +1100
@@ -24,6 +24,8 @@
 #include <linux/compiler.h>
 
 #ifdef CONFIG_KMOD
+/* modprobe exit status on success, -ve on error.  Return value
+ * usually useless though. */
 extern int request_module(const char * name, ...) __attribute__ ((format (printf, 1, 2)));
 #else
 static inline int request_module(const char * name, ...) { return -ENOSYS; }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1494-linux-2.6.0/kernel/kmod.c .1494-linux-2.6.0.updated/kernel/kmod.c
--- .1494-linux-2.6.0/kernel/kmod.c	2003-10-26 14:52:50.000000000 +1100
+++ .1494-linux-2.6.0.updated/kernel/kmod.c	2003-12-19 13:25:48.000000000 +1100
@@ -182,16 +182,21 @@ static int wait_for_helper(void *data)
 {
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
+	struct k_sigaction sa;
+
+	/* Install a handler: if SIGCLD isn't handled sys_wait4 won't
+	 * populate the status, but will return -ECHILD. */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	allow_signal(SIGCHLD);
 
-	sub_info->retval = 0;
 	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
 	if (pid < 0)
 		sub_info->retval = pid;
 	else
-		/* We don't have a SIGCHLD signal handler, so this
-		 * always returns -ECHILD, but the important thing is
-		 * that it blocks. */
-		sys_wait4(pid, NULL, 0, NULL);
+		sys_wait4(pid, &sub_info->retval, 0, NULL);
 
 	complete(sub_info->complete);
 	return 0;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
