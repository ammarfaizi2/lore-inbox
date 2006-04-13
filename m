Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDMTRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDMTRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDMTRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:17:07 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:46726 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751027AbWDMTRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:17:06 -0400
Date: Thu, 13 Apr 2006 21:17:02 +0200
From: <tyler@agat.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>, rusty@rustcorp.com.au
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060413191702.GB30541@Starbuck>
Mail-Followup-To: tyler@agat.net, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>, rusty@rustcorp.com.au
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck> <443EA22B.2090105@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443EA22B.2090105@grupopie.com>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:10:35PM +0100, Paulo Marques wrote:
> tyler@agat.net wrote:
> >
> >+/* Test if a module is loaded : must hold module_mutex */
> >+inline int is_loaded(const char *module_name)
> >+{
> >+	struct module *mod = find_module(module_name);
> >+
> >+	if (!mod)
> >+		return 1;

For sure it is. Sorry, my mistake :)

diff -uprN -X linux-2.6.16.5/Documentation/dontdiff linux-2.6.16.5/include/linux/module.h linux-2.6.16.5-tyler/include/linux/module.h
--- linux-2.6.16.5/include/linux/module.h	2006-04-13 20:03:16.000000000 +0200
+++ linux-2.6.16.5-tyler/include/linux/module.h	2006-04-13 20:24:39.000000000 +0200
@@ -339,6 +339,19 @@ unsigned long module_kallsyms_lookup_nam
 
 int is_exported(const char *name, const struct module *mod);
 
+/* Test if a module is loaded : must hold module_mutex */
+inline int is_loaded(const char *module_name)
+{
+	struct module *mod = find_module(module_name);
+
+	if (!mod)
+		return 0;
+
+	return 1;
+}
+
+
+
 extern void __module_put_and_exit(struct module *mod, long code)
 	__attribute__((noreturn));
 #define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code);
diff -uprN -X linux-2.6.16.5/Documentation/dontdiff linux-2.6.16.5/kernel/kmod.c linux-2.6.16.5-tyler/kernel/kmod.c
--- linux-2.6.16.5/kernel/kmod.c	2006-04-13 20:03:16.000000000 +0200
+++ linux-2.6.16.5-tyler/kernel/kmod.c	2006-04-13 20:22:28.000000000 +0200
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
@@ -84,6 +87,16 @@ int request_module(const char *fmt, ...)
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
+	/* We don't to load the module if it's already loaded */
+	spin_lock_irqsave(&modlist_lock, flags);
+	if (is_loaded(module_name)) {
+		spin_unlock_irqrestore(&modlist_lock, flags);
+		return -EEXIST;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+
+
+
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
 	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
