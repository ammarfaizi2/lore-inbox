Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTFMG5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTFMG5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:57:21 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:64499 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265181AbTFMG5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:57:00 -0400
Date: Fri, 13 Jun 2003 00:10:21 -0700
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Message-ID: <20030613001021.D31636@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, akpm@digeo.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: chris@wirex.com
Subject: Re: [PATCH][LSM] Early init for security modules 1/4
Reply-To: 
In-Reply-To: <20030613000409.B31636@figure1.int.wirex.com>; from chris@wirex.com on Fri, Jun 13, 2003 at 12:04:09AM -0700

[LSM] early init for security modules.  As discussed before, this allows
for early initialization of security modules when compiled statically
into the kernel.  The standard do_initcalls is too late for complete
coverage of all filesystems and threads, for example.

--- linus-2.5/arch/alpha/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/alpha/vmlinux.lds.S	Thu Jun 12 00:40:04 2003
@@ -74,6 +74,9 @@
 	__con_initcall_end = .;
   }
 
+  . = ALIGN(8);
+  SECURITY_INIT
+
   . = ALIGN(64);
   __per_cpu_start = .;
   .data.percpu : { *(.data.percpu) }
--- linus-2.5/arch/arm/vmlinux-armo.lds.in.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/arm/vmlinux-armo.lds.in	Thu Jun 12 00:40:04 2003
@@ -43,6 +43,7 @@
 		__con_initcall_start = .;
 			*(.con_initcall.init)
 		__con_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(32768);
 		__init_end = .;
 	}
--- linus-2.5/arch/arm/vmlinux-armv.lds.in.early_init	Sun Apr 27 08:35:24 2003
+++ linus-2.5/arch/arm/vmlinux-armv.lds.in	Thu Jun 12 00:40:04 2003
@@ -53,6 +53,7 @@
 		__con_initcall_start = .;
 			*(.con_initcall.init)
 		__con_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(32);
 		__initramfs_start = .;
 			usr/built-in.o(.init.ramfs)
--- linus-2.5/arch/cris/vmlinux.lds.S.early_init	Fri Feb 14 14:37:05 2003
+++ linus-2.5/arch/cris/vmlinux.lds.S	Thu Jun 12 22:41:51 2003
@@ -74,7 +74,12 @@
 		__con_initcall_start = .;
 		*(.con_initcall.init)
 		__con_initcall_end = .;
-	
+	}
+	.security_initcall.init : {
+		__security_initcall_start = .;
+		*(.security_initcall.init)
+		__security_initcall_end = .;
+
 		/* We fill to the next page, so we can discard all init
 		   pages without needing to consider what payload might be
 		   appended to the kernel image.  */
--- linus-2.5/arch/h8300/platform/h8300h/generic/rom.ld.early_init	Thu Apr 17 12:30:45 2003
+++ linus-2.5/arch/h8300/platform/h8300h/generic/rom.ld	Thu Jun 12 00:40:05 2003
@@ -83,6 +83,7 @@
 	___con_initcall_start = .;
 		*(.con_initcall.init)
 	___con_initcall_end = .;
+	SECURITY_INIT
 		. = ALIGN(4);
 	___initramfs_start = .;
   		*(.init.ramfs)
--- linus-2.5/arch/i386/vmlinux.lds.S.early_init	Tue May  6 06:54:06 2003
+++ linus-2.5/arch/i386/vmlinux.lds.S	Thu Jun 12 00:40:05 2003
@@ -81,6 +81,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4);
   __alt_instructions = .;
   .altinstructions : { *(.altinstructions) } 
--- linus-2.5/arch/ia64/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/ia64/vmlinux.lds.S	Thu Jun 12 00:40:05 2003
@@ -141,6 +141,10 @@
   .con_initcall.init : AT(ADDR(.con_initcall.init) - PAGE_OFFSET)
 	{ *(.con_initcall.init) }
   __con_initcall_end = .;
+  __security_initcall_start = .;
+  .security_initcall.init : AT(ADDR(.security_initcall.init) - PAGE_OFFSET)
+	{ *(.security_initcall.init) }
+  __security_initcall_end = .;
   . = ALIGN(PAGE_SIZE);
   __init_end = .;
 
--- linus-2.5/arch/m68k/vmlinux-std.lds.early_init Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/m68k/vmlinux-std.lds	Thu Jun 12 00:40:05 2003
@@ -67,6 +67,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(8192);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/m68k/vmlinux-sun3.lds.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/m68k/vmlinux-sun3.lds	Thu Jun 12 00:40:05 2003
@@ -61,6 +61,7 @@
 	__con_initcall_start = .;
 	.con_initcall.init : { *(.con_initcall.init) }
 	__con_initcall_end = .;
+	SECURITY_INIT
 	. = ALIGN(8192);
 	__initramfs_start = .;
 	.init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/m68knommu/vmlinux.lds.S.early_init	Tue May 27 20:13:11 2003
+++ linus-2.5/arch/m68knommu/vmlinux.lds.S	Thu Jun 12 00:40:05 2003
@@ -277,9 +277,7 @@
 		__con_initcall_start = .;
 		*(.con_initcall.init)
 		__con_initcall_end = .;
-		__security_initcall_start = .;
-		*(.security_initcall.init)
-		__security_initcall_end = .;
+		SECURITY_INIT
 		. = ALIGN(4);
 		__initramfs_start = .;
 		*(.init.ramfs)
--- linus-2.5/arch/mips/vmlinux.lds.S.early_init	Fri Feb 14 15:09:55 2003
+++ linus-2.5/arch/mips/vmlinux.lds.S	Thu Jun 12 00:40:06 2003
@@ -54,6 +54,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
--- linus-2.5/arch/mips64/vmlinux.lds.S.early_init	Fri Feb 14 15:10:00 2003
+++ linus-2.5/arch/mips64/vmlinux.lds.S	Thu Jun 12 00:40:06 2003
@@ -53,6 +53,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);	/* Align double page for init_task_union */
   __init_end = .;
 
--- linus-2.5/arch/parisc/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/parisc/vmlinux.lds.S	Thu Jun 12 00:40:06 2003
@@ -80,6 +80,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/ppc/vmlinux.lds.S.early_init	Mon May 26 04:58:49 2003
+++ linus-2.5/arch/ppc/vmlinux.lds.S	Thu Jun 12 00:40:06 2003
@@ -119,6 +119,8 @@
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
 
+  SECURITY_INIT
+
   __start___ftr_fixup = .;
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup = .;
--- linus-2.5/arch/ppc64/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/ppc64/vmlinux.lds.S	Thu Jun 12 00:40:07 2003
@@ -104,6 +104,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/s390/vmlinux.lds.S.early_init	Mon May 26 12:20:42 2003
+++ linus-2.5/arch/s390/vmlinux.lds.S	Thu Jun 12 00:40:07 2003
@@ -94,6 +94,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
--- linus-2.5/arch/sh/vmlinux.lds.S.early_init	Fri Feb 14 15:11:24 2003
+++ linus-2.5/arch/sh/vmlinux.lds.S	Thu Jun 12 00:40:08 2003
@@ -71,6 +71,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   __machvec_start = .;
   .machvec.init : { *(.machvec.init) }
   __machvec_end = .;
--- linus-2.5/arch/sparc/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/sparc/vmlinux.lds.S	Thu Jun 12 00:40:09 2003
@@ -62,6 +62,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/sparc64/vmlinux.lds.S.early_init	Wed Apr  2 00:42:56 2003
+++ linus-2.5/arch/sparc64/vmlinux.lds.S	Thu Jun 12 00:40:09 2003
@@ -68,6 +68,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(8192); 
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/arch/x86_64/vmlinux.lds.S.early_init	Fri May 23 03:56:33 2003
+++ linus-2.5/arch/x86_64/vmlinux.lds.S	Thu Jun 12 00:40:10 2003
@@ -105,6 +105,7 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  SECURITY_INIT
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
--- linus-2.5/include/asm-generic/vmlinux.lds.h.early_init	Mon Feb  3 13:00:30 2003
+++ linus-2.5/include/asm-generic/vmlinux.lds.h	Thu Jun 12 00:40:10 2003
@@ -45,3 +45,9 @@
 		*(__ksymtab_strings)					\
 	}
 
+#define SECURITY_INIT							\
+	.security_initcall.init : {					\
+		__security_initcall_start = .;				\
+		*(.security_initcall.init) 				\
+		__security_initcall_end = .;				\
+	}
--- linus-2.5/include/linux/init.h.early_init	Mon Mar  3 13:05:26 2003
+++ linus-2.5/include/linux/init.h	Thu Jun 12 00:40:10 2003
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
--- linus-2.5/init/main.c.early_init	Fri Jun  6 17:30:07 2003
+++ linus-2.5/init/main.c	Thu Jun 12 00:40:11 2003
@@ -439,8 +439,8 @@
 	pte_chain_init();
 	fork_init(num_physpages);
 	proc_caches_init();
-	security_scaffolding_startup();
 	buffer_init();
+	security_scaffolding_startup();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
--- linus-2.5/security/capability.c.early_init	Mon Feb 17 12:08:10 2003
+++ linus-2.5/security/capability.c	Thu Jun 12 00:40:11 2003
@@ -348,7 +348,7 @@
 	}
 }
 
-module_init (capability_init);
+security_initcall (capability_init);
 module_exit (capability_exit);
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
--- linus-2.5/security/root_plug.c.early_init	Mon Jun  2 03:37:38 2003
+++ linus-2.5/security/root_plug.c	Thu Jun 12 00:40:12 2003
@@ -135,7 +135,7 @@
 	printk (KERN_INFO "Root Plug module removed\n");
 }
 
-module_init (rootplug_init);
+security_initcall (rootplug_init);
 module_exit (rootplug_exit);
 
 MODULE_DESCRIPTION("Root Plug sample LSM module, written for Linux Journal article");
--- linus-2.5/security/security.c.early_init	Wed Dec 18 15:10:17 2002
+++ linus-2.5/security/security.c	Thu Jun 12 00:40:12 2003
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
