Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTAGDYW>; Mon, 6 Jan 2003 22:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTAGDYW>; Mon, 6 Jan 2003 22:24:22 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:59339 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267278AbTAGDYS>; Mon, 6 Jan 2003 22:24:18 -0500
To: marcelo@conectiva.com.br
Subject: [PATCH-2.4] Add wait flag to call_usermodehelper()
Cc: linux-kernel@vger.kernel.org
Message-Id: <E18VkTN-000445-00@pegasus.local>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Tue, 07 Jan 2003 04:32:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this patch adds a wait flag to call_usermodehelper(), so it can also
block, if some drivers wants it. Currently the following two drivers
get advantages from it and will save some lines of code:

	drivers/net/hamradio/baycom_epp.c
	drivers/bluetooth/bt3c_cs.c

Regards

Marcel

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.926.2.1, 2003-01-06 07:50:59+01:00, marcel@holtmann.org
  [PATCH] Add wait flag to call_usermodehelper()
  
  This change is based on a patch from Rusty Russell and adds a wait
  flag to call_usermodehelper() for blocking operation.


 drivers/ieee1394/nodemgr.c |    2 -
 drivers/pci/pci.c          |    2 -
 drivers/usb/usb.c          |    2 -
 include/linux/kmod.h       |    2 -
 kernel/kmod.c              |   66 +++++++++++++++++++++++++++++++++------------
 net/bluetooth/hci_core.c   |    2 -
 net/core/dev.c             |    2 -
 7 files changed, 55 insertions(+), 23 deletions(-)


diff -Nru a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
--- a/drivers/ieee1394/nodemgr.c	Tue Jan  7 04:20:51 2003
+++ b/drivers/ieee1394/nodemgr.c	Tue Jan  7 04:20:51 2003
@@ -741,7 +741,7 @@
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 	HPSB_DEBUG("NodeMgr: %s %s %016Lx", argv[0], verb, (long long unsigned)ud->ne->guid);
 #endif
-	value = call_usermodehelper(argv[0], argv, envp);
+	value = call_usermodehelper(argv[0], argv, envp, 0);
 	kfree(buf);
 	kfree(envp);
 	if (value != 0)
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Tue Jan  7 04:20:51 2003
+++ b/drivers/pci/pci.c	Tue Jan  7 04:20:51 2003
@@ -741,7 +741,7 @@
 		envp[i++] = "ACTION=remove";
 	envp[i] = 0;
 
-	call_usermodehelper (argv [0], argv, envp);
+	call_usermodehelper (argv [0], argv, envp, 0);
 }
 
 /**
diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Tue Jan  7 04:20:51 2003
+++ b/drivers/usb/usb.c	Tue Jan  7 04:20:51 2003
@@ -882,7 +882,7 @@
 	/* NOTE: user mode daemons can call the agents too */
 
 	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum);
-	value = call_usermodehelper (argv [0], argv, envp);
+	value = call_usermodehelper (argv [0], argv, envp, 0);
 	kfree (buf);
 	kfree (envp);
 	if (value != 0)
diff -Nru a/include/linux/kmod.h b/include/linux/kmod.h
--- a/include/linux/kmod.h	Tue Jan  7 04:20:51 2003
+++ b/include/linux/kmod.h	Tue Jan  7 04:20:51 2003
@@ -29,7 +29,7 @@
 #endif
 
 extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
-extern int call_usermodehelper(char *path, char *argv[], char *envp[]);
+extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path [];
diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Tue Jan  7 04:20:51 2003
+++ b/kernel/kmod.c	Tue Jan  7 04:20:51 2003
@@ -14,6 +14,9 @@
 
 	Unblock all signals when we exec a usermode process.
 	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
+
+	Add wait flag to call_usermodehelper. Based on a patch from Rusty Russell.
+	Marcel Holtmann <marcel@holtmann.org> Jan 2003
 */
 
 #define __KERNEL_SYSCALLS__
@@ -178,7 +181,7 @@
  * If module auto-loading support is disabled then this function
  * becomes a no-operation.
  */
-int request_module(const char * module_name)
+int request_module(const char *module_name)
 {
 	pid_t pid;
 	int waitpid_result;
@@ -276,7 +279,8 @@
 	char *path;
 	char **argv;
 	char **envp;
-	pid_t retval;
+	int wait;
+	int retval;
 };
 
 /*
@@ -292,10 +296,29 @@
 		retval = exec_usermodehelper(sub_info->path, sub_info->argv, sub_info->envp);
 
 	/* Exec failed? */
-	sub_info->retval = (pid_t)retval;
+	sub_info->retval = retval;
 	do_exit(0);
 }
 
+/* 
+ * Keventd can't block, but this (a child) can.
+ */
+static int wait_for_helper(void *data)
+{
+	struct subprocess_info *sub_info = data;
+	pid_t pid;
+
+	pid = kernel_thread(____call_usermodehelper, sub_info,
+			    CLONE_VFORK | SIGCHLD);
+	if (pid < 0)
+		sub_info->retval = pid;
+	else
+		sys_wait4(pid, (unsigned int *)&sub_info->retval, 0, NULL);
+
+	complete(sub_info->complete);
+	return 0;
+}
+
 /*
  * This is run by keventd.
  */
@@ -304,14 +327,21 @@
 	struct subprocess_info *sub_info = data;
 	pid_t pid;
 
-	/*
-	 * CLONE_VFORK: wait until the usermode helper has execve'd successfully
-	 * We need the data structures to stay around until that is done.
-	 */
-	pid = kernel_thread(____call_usermodehelper, sub_info, CLONE_VFORK | SIGCHLD);
-	if (pid < 0)
+	/* CLONE_VFORK: wait until the usermode helper has execve'd
+	 * successfully We need the data structures to stay around
+	 * until that is done.  */
+	if (sub_info->wait)
+		pid = kernel_thread(wait_for_helper, sub_info,
+				    CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
+	else
+		pid = kernel_thread(____call_usermodehelper, sub_info,
+				    CLONE_VFORK | SIGCHLD);
+
+	if (pid < 0) {
 		sub_info->retval = pid;
-	complete(sub_info->complete);
+		complete(sub_info->complete);
+	} else if (!sub_info->wait)
+		complete(sub_info->complete);
 }
 
 /**
@@ -319,15 +349,17 @@
  * @path: pathname for the application
  * @argv: null-terminated argument list
  * @envp: null-terminated environment list
+ * @wait: wait for the application to finish and return status.
  *
- * Runs a user-space application.  The application is started asynchronously.  It
- * runs as a child of keventd.  It runs with full root capabilities.  keventd silently
- * reaps the child when it exits.
+ * Runs a user-space application.  The application is started
+ * asynchronously if wait is not set, and runs as a child of keventd.
+ * (ie. it runs with full root capabilities).
  *
- * Must be called from process context.  Returns zero on success, else a negative
- * error code.
+ * Must be called from process context.  Returns a negative error code
+ * if program was not execed successfully, or (exitcode << 8 + signal)
+ * of the application (0 if wait is not set).
  */
-int call_usermodehelper(char *path, char **argv, char **envp)
+int call_usermodehelper(char *path, char **argv, char **envp, int wait)
 {
 	DECLARE_COMPLETION(work);
 	struct subprocess_info sub_info = {
@@ -335,6 +367,7 @@
 		path:		path,
 		argv:		argv,
 		envp:		envp,
+		wait:		wait,
 		retval:		0,
 	};
 	struct tq_struct tqs = {
@@ -378,4 +411,3 @@
 #ifdef CONFIG_KMOD
 EXPORT_SYMBOL(request_module);
 #endif
-
diff -Nru a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
--- a/net/bluetooth/hci_core.c	Tue Jan  7 04:20:51 2003
+++ b/net/bluetooth/hci_core.c	Tue Jan  7 04:20:51 2003
@@ -115,7 +115,7 @@
 	envp[3] = astr;
 	envp[4] = NULL;
 	
-	return call_usermodehelper(argv[0], argv, envp);
+	return call_usermodehelper(argv[0], argv, envp, 0);
 }
 #else
 #define hci_run_hotplug(A...)
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Tue Jan  7 04:20:51 2003
+++ b/net/core/dev.c	Tue Jan  7 04:20:51 2003
@@ -2834,6 +2834,6 @@
 	envp [i++] = action_str;
 	envp [i] = 0;
 	
-	return call_usermodehelper(argv [0], argv, envp);
+	return call_usermodehelper(argv [0], argv, envp, 0);
 }
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
1.926.2.1
## Wrapped with gzip_uu ##


begin 664 bkpatch15567
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
(4$:+B7(<````
`
end
