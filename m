Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWDMSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWDMSgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWDMSgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:36:23 -0400
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:26299 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964953AbWDMSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:36:22 -0400
Date: Thu, 13 Apr 2006 20:36:17 +0200
From: <tyler@agat.net>
To: Greg KH <gregkh@suse.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060413183617.GB10910@Starbuck>
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413182401.GA26885@suse.de>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:24:01AM -0700, Greg KH wrote:
> On Thu, Apr 13, 2006 at 08:03:45PM +0200, tyler@agat.net wrote:
> > Hi,
> > 
> > the request_mod functions try to load automatically a module by running
> > a user mode process helper (modprobe).
> > 
> > The user process is launched even if the module is already loaded. I
> > think it would be better to test if the module is already loaded.
> 
> Does this cause a problem somehow?  request_mod is called _very_
> infrequently from a normal kernel these days, so I really don't think
> this is necessary.

Yes I agree it _should_ be very infrequently called but it _will_ be very
infrequently called just if the user space configuration is done properly.

I personnaly think we shouldn't trust the configuration and the way the
different modules are loaded.

Well anyway, I've corrected the patch regarding the advices of randy.

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
+		return 1;
+
+	return 0;
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
