Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVERXBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVERXBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVERXBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:01:52 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:3057 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262385AbVERXB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:01:29 -0400
Date: Thu, 19 May 2005 01:00:47 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] __request_module: fixed argument request_module with waitflag
Message-ID: <20050518230046.GB3011@tsiryulnik>
Mail-Followup-To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following extracts the code in request_module which is responsible
for executing modprobe into a new helper function called __request_module.
This new function takes the wait flag which gets passed down to
call_usermodeheper as an argument, allowing async execution of modprobe.

During the writing of this I've had a bit of a mental struggle about
whether or not maybe call_modprobe is a better name for this and thus
I'm fine with either one if anyone else has a preference.

Signed-off-by: Per Svennerbrandt <per.svennerbrandt@lbi.se>

--- linux-2.6.12-rc2/kernel/kmod.c.orig	2005-04-16 19:08:22.000000000 +0200
+++ linux-2.6.12-rc2/kernel/kmod.c	2005-05-12 23:50:00.000000000 +0200
@@ -49,6 +49,49 @@
 */
 char modprobe_path[KMOD_PATH_LEN] = "/sbin/modprobe";
 
+int __request_module(char *name, int wait)
+{
+	int ret;
+	unsigned int max_modprobes;
+	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
+#define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
+	static int kmod_loop_msg;
+	
+	char *argv[] = { modprobe_path, "-q", "--", name, NULL };
+	static char *envp[] = { "HOME=/",
+				"TERM=linux",
+				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+				NULL };
+				
+	/* If modprobe needs a service that is in a module, we get a recursive
+	 * loop.  Limit the number of running kmod threads to max_threads/2 or
+	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
+	 * would be to run the parents of this process, counting how many times
+	 * kmod was invoked.  That would mean accessing the internals of the
+	 * process tables to get the command line, proc_pid_cmdline is static
+	 * and it is not worth changing the proc code just to handle this case. 
+	 * KAO.
+	 *
+	 * "trace the ppid" is simple, but will fail if someone's
+	 * parent exits.  I think this is as good as it gets. --RR
+	 */
+	max_modprobes = min(max_threads/2, MAX_KMOD_CONCURRENT);
+	atomic_inc(&kmod_concurrent);
+	if (atomic_read(&kmod_concurrent) > max_modprobes) {
+		/* We may be blaming an innocent here, but unlikely */
+		if (kmod_loop_msg++ < 5)
+			printk(KERN_ERR
+			       "request_module: runaway loop modprobe %s\n",
+			       name);
+		atomic_dec(&kmod_concurrent);
+		return -ENOMEM;
+	}
+	ret = call_usermodehelper(modprobe_path, argv, envp, wait);
+	atomic_dec(&kmod_concurrent);
+	return ret;
+}
+EXPORT_SYMBOL(__request_module);
+
 /**
  * request_module - try to load a kernel module
  * @fmt:     printf style format string for the name of the module
@@ -67,50 +110,15 @@ int request_module(const char *fmt, ...)
 {
 	va_list args;
 	char module_name[MODULE_NAME_LEN];
-	unsigned int max_modprobes;
 	int ret;
-	char *argv[] = { modprobe_path, "-q", "--", module_name, NULL };
-	static char *envp[] = { "HOME=/",
-				"TERM=linux",
-				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
-				NULL };
-	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
-#define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
-	static int kmod_loop_msg;
 
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
-	/* If modprobe needs a service that is in a module, we get a recursive
-	 * loop.  Limit the number of running kmod threads to max_threads/2 or
-	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
-	 * would be to run the parents of this process, counting how many times
-	 * kmod was invoked.  That would mean accessing the internals of the
-	 * process tables to get the command line, proc_pid_cmdline is static
-	 * and it is not worth changing the proc code just to handle this case. 
-	 * KAO.
-	 *
-	 * "trace the ppid" is simple, but will fail if someone's
-	 * parent exits.  I think this is as good as it gets. --RR
-	 */
-	max_modprobes = min(max_threads/2, MAX_KMOD_CONCURRENT);
-	atomic_inc(&kmod_concurrent);
-	if (atomic_read(&kmod_concurrent) > max_modprobes) {
-		/* We may be blaming an innocent here, but unlikely */
-		if (kmod_loop_msg++ < 5)
-			printk(KERN_ERR
-			       "request_module: runaway loop modprobe %s\n",
-			       module_name);
-		atomic_dec(&kmod_concurrent);
-		return -ENOMEM;
-	}
-
-	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
-	atomic_dec(&kmod_concurrent);
-	return ret;
+	return __request_module(module_name, 1);
 }
 EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
--- linux-2.6.12-rc2/include/linux/kmod.h.orig	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc2/include/linux/kmod.h	2005-05-12 23:53:22.000000000 +0200
@@ -28,8 +28,10 @@
 #ifdef CONFIG_KMOD
 /* modprobe exit status on success, -ve on error.  Return value
  * usually useless though. */
+extern int __request_module(char *name, int wait);
 extern int request_module(const char * name, ...) __attribute__ ((format (printf, 1, 2)));
 #else
+static inline int __request_module(char *name, int wait) { return -ENOSYS; }
 static inline int request_module(const char * name, ...) { return -ENOSYS; }
 #endif
 
