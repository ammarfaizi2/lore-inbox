Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRLMChV>; Wed, 12 Dec 2001 21:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283052AbRLMChM>; Wed, 12 Dec 2001 21:37:12 -0500
Received: from [203.51.30.71] ([203.51.30.71]:25744 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S283016AbRLMChD>; Wed, 12 Dec 2001 21:37:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, kaos@ocs.com.au
Subject: [PATCH] 2.5.1-pre10 #ifdef CONFIG_KMOD Cleanup Part II.
Date: Thu, 13 Dec 2001 13:18:31 +1100
Message-Id: <E16ELSB-0005Xt-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does three things to remove the requirement for #ifdef
CONFIG_KMOD in code:

1) Makes request_module() take args like sprintf. eg.

	request_module("proto-%u", protonum);

2) Adds request_module_start()/request_module_end() macros, eg.

	struct protocol protoptr;

	request_module_start("proto-%u", protonum) {
		/* search for protocol, set protoptr. */

	} request_module_end(protoptr != NULL);

   This loops once if !CONFIG_KMOD or protoptr != NULL after first
   iteration, otherwise calls request_module and loops a second time.

3) Adds a request_module_unless() macro, eg:

	protoptr = request_module_unless(protoptrs[proto],
					 "proto-%u", protonum);

   The evaluates the condition (protoptrs[proto]), if true, returns
   it, otherwise calls request_module and returns the (re-evaluated)
   condition.

This patch doesn't actually convert any code,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Enhanced kmod macros
Author: Rusty Russell
Status: Simple
Class: New Infrastructure
Section: Kmod

D: This patch makes request_module() take args like snprintf, and adds
D: three new support macros: request_module_start(), request_module_end()
D: and request_module_unless().  Now there should be no reason to have
D: gratuitous code or #ifdef CONFIG_KMOD throughout the kernel.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.14-params/include/linux/kmod.h working-2.4.14-kmod-used/include/linux/kmod.h
--- working-2.4.14-params/include/linux/kmod.h	Wed Nov 14 17:56:18 2001
+++ working-2.4.14-kmod-used/include/linux/kmod.h	Mon Nov 19 13:14:23 2001
@@ -23,9 +23,39 @@
 #include <linux/errno.h>
 
 #ifdef CONFIG_KMOD
-extern int request_module(const char * name);
-#else
-static inline int request_module(const char * name) { return -ENOSYS; }
+/* ISO C99 would allow a request_module_once() macro like
+   list_for_each, by declaring the var in the for().  Soon, soon... --RR */
+
+/* Start a request module loop: module will be requested the *second* time */
+#define request_module_start(format, arg...)				   \
+do {									   \
+	int __r;							   \
+	for (__r = 0; __r < 2; __r++ ?: request_module(format , ## arg)) {
+
+/* Stop first time (ie. don't request) if this condition is true. */
+#define request_module_end(cond) if (cond) break; } } while(0)
+
+/* Request module if this is false, then re-evaluate */
+#define request_module_unless(cond, format, arg...)		\
+({ if (!cond) request_module(format , ## arg); (cond); })
+
+/* Request a module (returns 0 on success, -errno otherwise).  Keep
+   name << a page please! */
+int request_module(const char *format, ...) 
+__attribute__ ((format (printf, 1, 2)));
+
+#else /* !CONFIG_KMOD */
+
+#define request_module_start(format, arg...) do {
+#define request_module_end(cond) while(0)
+
+/* Request a module (returns 0 on success, -errno otherwise) */
+static inline int request_module(const char *format, ...) 
+__attribute__ ((format (printf, 1, 2)));
+
+static inline int request_module(const char * name, ...) { return -ENOSYS; }
+
+#define request_module_unless(cond, format, arg...) (cond)
 #endif
 
 extern int exec_usermodehelper(char *program_path, char *argv[], char *envp[]);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.14-params/kernel/kmod.c working-2.4.14-kmod-used/kernel/kmod.c
--- working-2.4.14-params/kernel/kmod.c	Thu Nov 15 22:20:10 2001
+++ working-2.4.14-kmod-used/kernel/kmod.c	Mon Nov 19 13:13:29 2001
@@ -14,6 +14,9 @@
 
 	Unblock all signals when we exec a usermode process.
 	Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
+
+	Reworked to be varargs.
+	Rusty Russell <rusty@rustcorp.com.au> 2001
 */
 
 #define __KERNEL_SYSCALLS__
@@ -151,26 +154,13 @@
 	ret = exec_usermodehelper(modprobe_path, argv, envp);
 	if (ret) {
 		printk(KERN_ERR
-		       "kmod: failed to exec %s -s -k %s, errno = %d\n",
+		       "kmod: failed to exec %s %s, errno = %d\n",
 		       modprobe_path, (char*) module_name, errno);
 	}
 	return ret;
 }
 
-/**
- * request_module - try to load a kernel module
- * @module_name: Name of module
- *
- * Load a module using the user mode module loader. The function returns
- * zero on success or a negative errno code on failure. Note that a
- * successful module load does not mean the module did not then unload
- * and exit on an error of its own. Callers must check that the service
- * they requested is now available not blindly invoke it.
- *
- * If module auto-loading support is disabled then this function
- * becomes a no-operation.
- */
-int request_module(const char * module_name)
+static int __request_module(const char *module_name)
 {
 	pid_t pid;
 	int waitpid_result;
@@ -237,6 +227,47 @@
 	}
 	return 0;
 }
+
+/**
+ * request_module - try to load a kernel module
+ * @format: sprintf-style format of module
+ *
+ * Load a module using the user mode module loader. The function
+ * returns zero on success or a negative errno code on failure. Note
+ * that a successful module load does not mean the module did not then
+ * unload and exit on an error of its own. Callers must check that the
+ * service they requested is now available not blindly invoke it; see
+ * request_module_start and request_module_end macros.  Names longer
+ * than 256 characters will always fail.
+ *
+ * If module auto-loading support is disabled then this function
+ * becomes a no-operation.  */
+int request_module(const char *format, ...)
+{
+	va_list args;
+	int namelen, ret;
+
+	/* Don't allow request_module() before the root fs is mounted!  */
+	if (!current->fs->root) 
+		return -ENOENT; /* FIXME: BUG(), but this happens... */
+
+	va_start(args, format);
+	/* get length we need */
+	namelen = vsnprintf(NULL, 0, format, args);
+	if (namelen > 256)
+		return -ENOENT;
+
+	{
+		char module[namelen + 1];
+		vsprintf(module, format, args);
+
+		ret = __request_module(module);
+	}
+	va_end(args);
+
+	return ret;
+}
+
 #endif /* CONFIG_KMOD */
 
 
