Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTDHXMo (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDHXMo (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:12:44 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:37366 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262563AbTDHXMh (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:12:37 -0400
Date: Tue, 8 Apr 2003 16:21:14 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com, hch@infradead.org
Subject: [RFC][PATCH] Early init for security modules
Message-ID: <20030408162114.A32564@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com, hch@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed before, here is a simple (x86 only) patch to allow for
early initialization of security modules when compiled statically into
the kernel.  The standard do_initcalls is too late for complete coverage
of all filesystems and threads for example.  If this looks alright, I
can polish it off with complete arch support and submit to Linus.  Patch
is against 2.5.67-bk.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== arch/i386/vmlinux.lds.S 1.26 vs edited =====
--- 1.26/arch/i386/vmlinux.lds.S	Sun Feb 16 15:55:23 2003
+++ edited/arch/i386/vmlinux.lds.S	Tue Apr  8 16:12:28 2003
@@ -77,6 +77,9 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  __security_initcall_start = .;
+  .security_initcall.init : { *(.security_initcall.init) }
+  __security_initcall_end = .;
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
===== include/linux/init.h 1.25 vs edited =====
--- 1.25/include/linux/init.h	Mon Mar  3 13:05:26 2003
+++ edited/include/linux/init.h	Tue Apr  8 16:12:29 2003
@@ -64,6 +64,7 @@
 typedef void (*exitcall_t)(void);
 
 extern initcall_t __con_initcall_start, __con_initcall_end;
+extern initcall_t __security_initcall_start, __security_initcall_end;
 #endif
   
 #ifndef MODULE
@@ -96,6 +97,9 @@
 #define console_initcall(fn) \
 	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
 
+#define security_initcall(fn) \
+	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".security_initcall.init"))) = fn
+
 struct obs_kernel_param {
 	const char *str;
 	int (*setup_func)(char *);
@@ -142,6 +146,8 @@
 #define fs_initcall(fn)			module_init(fn)
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
+
+#define security_initcall(fn)		module_init(fn)
 
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions
===== init/main.c 1.96 vs edited =====
--- 1.96/init/main.c	Thu Mar 27 21:13:34 2003
+++ edited/init/main.c	Tue Apr  8 16:12:29 2003
@@ -435,8 +435,8 @@
 	pte_chain_init();
 	fork_init(num_physpages);
 	proc_caches_init();
-	security_scaffolding_startup();
 	buffer_init();
+	security_scaffolding_startup();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
===== security/capability.c 1.15 vs edited =====
--- 1.15/security/capability.c	Mon Feb 17 12:08:10 2003
+++ edited/security/capability.c	Tue Apr  8 16:12:29 2003
@@ -348,7 +348,7 @@
 	}
 }
 
-module_init (capability_init);
+security_initcall (capability_init);
 module_exit (capability_exit);
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
===== security/root_plug.c 1.2 vs edited =====
--- 1.2/security/root_plug.c	Wed Dec 18 15:09:26 2002
+++ edited/security/root_plug.c	Tue Apr  8 16:20:25 2003
@@ -184,7 +184,7 @@
 	printk (KERN_INFO "Root Plug module removed\n");
 }
 
-module_init (rootplug_init);
+security_initcall (rootplug_init);
 module_exit (rootplug_exit);
 
 MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");
===== security/security.c 1.7 vs edited =====
--- 1.7/security/security.c	Wed Dec 18 15:10:17 2002
+++ edited/security/security.c	Tue Apr  8 16:20:07 2003
@@ -38,12 +38,22 @@
 	return 0;
 }
 
+static void __init do_security_initcalls(void)
+{
+	initcall_t *call;
+	call = &__security_initcall_start;
+	while (call < &__security_initcall_end) {
+		(*call)();
+		call++;
+	}
+}
+
 /**
  * security_scaffolding_startup - initialzes the security scaffolding framework
  *
  * This should be called early in the kernel initialization sequence.
  */
-int security_scaffolding_startup (void)
+int __init security_scaffolding_startup (void)
 {
 	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
 		" initialized\n");
@@ -55,6 +65,7 @@
 	}
 
 	security_ops = &dummy_security_ops;
+	do_security_initcalls();
 
 	return 0;
 }
