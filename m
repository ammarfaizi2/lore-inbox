Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWDMSDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWDMSDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDMSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:03:48 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:33130 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932355AbWDMSDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:03:48 -0400
Date: Thu, 13 Apr 2006 20:03:45 +0200
From: <tyler@agat.net>
To: rusty@rustcorp.com.au, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kmod optimization
Message-ID: <20060413180345.GA10910@Starbuck>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the request_mod functions try to load automatically a module by running
a user mode process helper (modprobe).

The user process is launched even if the module is already loaded. I
think it would be better to test if the module is already loaded.

-- 
tyler
tyler@agat.net

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch_kmod_2.6.16.5"

diff -uprN -X linux-2.6.16.5/Documentation/dontdiff linux-2.6.16.5/include/linux/module.h linux-2.6.16.5-tyler/include/linux/module.h
--- linux-2.6.16.5/include/linux/module.h	2006-04-13 19:53:01.000000000 +0200
+++ linux-2.6.16.5-tyler/include/linux/module.h	2006-04-13 19:17:21.000000000 +0200
@@ -338,6 +338,7 @@ struct module *module_get_kallsym(unsign
 unsigned long module_kallsyms_lookup_name(const char *name);
 
 int is_exported(const char *name, const struct module *mod);
+int is_loaded(const char *module_name);
 
 extern void __module_put_and_exit(struct module *mod, long code)
 	__attribute__((noreturn));
diff -uprN -X linux-2.6.16.5/Documentation/dontdiff linux-2.6.16.5/kernel/kmod.c linux-2.6.16.5-tyler/kernel/kmod.c
--- linux-2.6.16.5/kernel/kmod.c	2006-04-13 19:53:02.000000000 +0200
+++ linux-2.6.16.5-tyler/kernel/kmod.c	2006-04-13 19:19:32.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <linux/spinlock.h>
 
 extern int max_threads;
 
@@ -48,6 +49,7 @@ static struct workqueue_struct *khelper_
 	modprobe_path is set via /proc/sys.
 */
 char modprobe_path[KMOD_PATH_LEN] = "/sbin/modprobe";
+extern spinlock_t modlist_lock;
 
 /**
  * request_module - try to load a kernel module
@@ -77,6 +79,7 @@ int request_module(const char *fmt, ...)
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
+	unsigned long flags;
 
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
@@ -84,6 +87,15 @@ int request_module(const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
+	/* We don't to load the module if it's already loaded */
+	spin_lock_irqsave(&modlist_lock, flags);
+	if (is_loaded(module_name)) {
+		return -EEXIST;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+
+
+
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
 	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
diff -uprN -X linux-2.6.16.5/Documentation/dontdiff linux-2.6.16.5/kernel/module.c linux-2.6.16.5-tyler/kernel/module.c
--- linux-2.6.16.5/kernel/module.c	2006-04-13 19:54:37.000000000 +0200
+++ linux-2.6.16.5-tyler/kernel/module.c	2006-04-13 19:21:11.000000000 +0200
@@ -212,6 +212,19 @@ static struct module *find_module(const 
 	return NULL;
 }
 
+/* Test if a module is loaded : must hold module_mutex */
+int is_loaded(const char *module_name);
+{
+	struct module *mod = find_module(module_name);
+
+	if (!mod) {
+		return 1;
+	}
+
+	return 0;
+}
+
+
 #ifdef CONFIG_SMP
 /* Number of blocks used and allocated. */
 static unsigned int pcpu_num_used, pcpu_num_allocated;

--+QahgC5+KEYLbs62--


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services prifiris : virifiez vos nouveaux mails, lancez vos recherches et suivez l'actualiti en temps riel. 
Rendez-vous sur http://fr.yahoo.com/set
