Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUJYPKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUJYPKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUJYPKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:10:01 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:64680 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261867AbUJYOsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:48:54 -0400
Cc: raven@themaw.net
Subject: [PATCH 20/28] HOTPLUG: call_usermodehelper callback support
In-Reply-To: <10987156903663@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:48:40 -0400
Message-Id: <10987157204162@sun.com>
References: <10987156903663@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the call_usermodehelper api by adding a callback variant.
The callback is made right when the system is about to call execve into the
new process.  This allows for the caller to provide changes to the default
environment right before the exec takes place.  Note: the context of the
callback will be _from within another process_.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 include/linux/kmod.h |    2 +
 kernel/kmod.c        |   80 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 63 insertions(+), 19 deletions(-)

Index: linux-2.6.9-quilt/kernel/kmod.c
===================================================================
--- linux-2.6.9-quilt.orig/kernel/kmod.c	2004-08-14 01:36:44.000000000 -0400
+++ linux-2.6.9-quilt/kernel/kmod.c	2004-10-22 17:17:44.279732600 -0400
@@ -140,17 +140,22 @@ EXPORT_SYMBOL(hotplug_path);
 
 struct subprocess_info {
 	struct completion *complete;
+	call_usermodehelper_cb_t cb;
+	void *cbdata;
+	int wait;
+	int retval;
+};
+
+struct simple_usermodehelper_info {
 	char *path;
 	char **argv;
 	char **envp;
-	int wait;
-	int retval;
 };
 
 /*
  * This is the task which runs the usermode application
  */
-static int ____call_usermodehelper(void *data)
+static int ____call_usermodehelper_cb(void *data)
 {
 	struct subprocess_info *sub_info = data;
 	int retval;
@@ -168,7 +173,7 @@ static int ____call_usermodehelper(void 
 
 	retval = -EPERM;
 	if (current->fs->root)
-		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
+		retval = (*sub_info->cb)(sub_info->cbdata);
 
 	/* Exec failed? */
 	sub_info->retval = retval;
@@ -190,7 +195,7 @@ static int wait_for_helper(void *data)
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 	allow_signal(SIGCHLD);
 
-	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
+	pid = kernel_thread(____call_usermodehelper_cb, sub_info, SIGCHLD);
 	if (pid < 0) {
 		sub_info->retval = pid;
 	} else {
@@ -211,7 +216,7 @@ static int wait_for_helper(void *data)
 }
 
 /* This is run by khelper thread  */
-static void __call_usermodehelper(void *data)
+static void __call_usermodehelper_cb(void *data)
 {
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
@@ -223,7 +228,7 @@ static void __call_usermodehelper(void *
 		pid = kernel_thread(wait_for_helper, sub_info,
 				    CLONE_FS | CLONE_FILES | SIGCHLD);
 	else
-		pid = kernel_thread(____call_usermodehelper, sub_info,
+		pid = kernel_thread(____call_usermodehelper_cb, sub_info,
 				    CLONE_VFORK | SIGCHLD);
 
 	if (pid < 0) {
@@ -234,12 +239,16 @@ static void __call_usermodehelper(void *
 }
 
 /**
- * call_usermodehelper - start a usermode application
- * @path: pathname for the application
- * @argv: null-terminated argument list
- * @envp: null-terminated environment list
+ * call_usermodehelper_cb - start a usermode application with a callback
+ * @cb: A user provided callback that will eventually execve.
+ * @cbdata: User supplied information that will be passed back to the callback.
  * @wait: wait for the application to finish and return status.
  *
+ * This call will do all the work required for setting up a usermode helper
+ * except perform the actual exec.  It is the caller's responsibility to
+ * provide a callback that will eventually exec.  This allows last minute
+ * changes to current.
+ *
  * Runs a user-space application.  The application is started
  * asynchronously if wait is not set, and runs as a child of keventd.
  * (ie. it runs with full root capabilities).
@@ -247,29 +256,62 @@ static void __call_usermodehelper(void *
  * Must be called from process context.  Returns a negative error code
  * if program was not execed successfully, or 0.
  */
-int call_usermodehelper(char *path, char **argv, char **envp, int wait)
+int call_usermodehelper_cb(call_usermodehelper_cb_t cb, void *cbdata, int wait)
 {
 	DECLARE_COMPLETION(done);
 	struct subprocess_info sub_info = {
 		.complete	= &done,
-		.path		= path,
-		.argv		= argv,
-		.envp		= envp,
+		.cb		= cb,
+		.cbdata		= cbdata,
 		.wait		= wait,
 		.retval		= 0,
 	};
-	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
+	DECLARE_WORK(work, __call_usermodehelper_cb, &sub_info);
 
+	BUG_ON(!cb || !cbdata);
 	if (!khelper_wq)
 		return -EBUSY;
 
-	if (path[0] == '\0')
-		return 0;
-
 	queue_work(khelper_wq, &work);
 	wait_for_completion(&done);
 	return sub_info.retval;
 }
+EXPORT_SYMBOL(call_usermodehelper_cb);
+
+static int call_usermodehelper_simple(void *cbdata)
+{
+	struct simple_usermodehelper_info *info = cbdata;
+	return execve(info->path, info->argv, info->envp);
+}
+
+/**
+ * call_usermodehelper - start a usermode application
+ * @path: pathname for the application
+ * @argv: null-terminated argument list
+ * @envp: null-terminated environment list
+ * @wait: wait for the application to finish and return status.
+ *
+ * Runs a user-space application.  The application is started
+ * asynchronously if wait is not set, and runs as a child of keventd.
+ * (ie. it runs with full root capabilities).
+ *
+ * Must be called from process context.  Returns a negative error code
+ * if program was not execed successfully, or 0.
+ */
+
+int call_usermodehelper(char *path, char **argv, char **envp, int wait)
+{
+	struct simple_usermodehelper_info info = {
+		.path = path,
+		.argv = argv,
+		.envp = envp,
+	};
+	
+	if (path[0] == '\0')
+		return 0;
+
+	return call_usermodehelper_cb(call_usermodehelper_simple, &info, wait);
+}
 EXPORT_SYMBOL(call_usermodehelper);
 
 static __init int usermodehelper_init(void)
Index: linux-2.6.9-quilt/include/linux/kmod.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/kmod.h	2004-08-14 01:36:32.000000000 -0400
+++ linux-2.6.9-quilt/include/linux/kmod.h	2004-10-22 17:17:44.279732600 -0400
@@ -34,6 +34,8 @@ static inline int request_module(const c
 #endif
 
 #define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
+typedef int (*call_usermodehelper_cb_t)(void *cbdata);
+extern int call_usermodehelper_cb(call_usermodehelper_cb_t cb, void *cbdata, int wait);
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG

