Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbQKSPfA>; Sun, 19 Nov 2000 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbQKSPeu>; Sun, 19 Nov 2000 10:34:50 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:23180 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S132484AbQKSPer>; Sun, 19 Nov 2000 10:34:47 -0500
Message-ID: <3A17EBA1.EB966392@didntduck.org>
Date: Sun, 19 Nov 2000 10:02:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Module cleanups
Content-Type: multipart/mixed;
 boundary="------------A69234E697CB6017A3699C15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A69234E697CB6017A3699C15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Three small patches against test11-pre7

1) creates arch_init_modules(), removes alpha specific code from
module.c
2) makes non-modular try_inc_use_count() an inline for better
optimization.
3) Creates __modinfo define.

-- 

						Brian Gerst
--------------A69234E697CB6017A3699C15
Content-Type: text/plain; charset=us-ascii;
 name="module-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-1.diff"

diff -urN linux-2.4.0t11p7/include/asm-alpha/module.h linux/include/asm-alpha/module.h
--- linux-2.4.0t11p7/include/asm-alpha/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-alpha/module.h	Sat Nov 18 12:11:04 2000
@@ -8,4 +8,9 @@
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
 
+static inline void arch_init_modules(void)
+{
+	__asm__("stq $29,%0" : "=m"(kernel_module.gp));
+}
+
 #endif /* _ASM_ALPHA_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-arm/module.h linux/include/asm-arm/module.h
--- linux-2.4.0t11p7/include/asm-arm/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-arm/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_ARM_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-i386/module.h linux/include/asm-i386/module.h
--- linux-2.4.0t11p7/include/asm-i386/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-i386/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_I386_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-ia64/module.h linux/include/asm-ia64/module.h
--- linux-2.4.0t11p7/include/asm-ia64/module.h	Mon Oct  9 20:54:59 2000
+++ linux/include/asm-ia64/module.h	Sat Nov 18 12:11:04 2000
@@ -15,6 +15,7 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		ia64_module_unmap(x)
 #define module_arch_init(x)	ia64_module_init(x)
+#define arch_init_modules()	do { } while (0)
 
 /*
  * This must match in size and layout the data created by
diff -urN linux-2.4.0t11p7/include/asm-m68k/module.h linux/include/asm-m68k/module.h
--- linux-2.4.0t11p7/include/asm-m68k/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-m68k/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_M68K_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-mips/module.h linux/include/asm-mips/module.h
--- linux-2.4.0t11p7/include/asm-mips/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-mips/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_MIPS_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-mips64/module.h linux/include/asm-mips64/module.h
--- linux-2.4.0t11p7/include/asm-mips64/module.h	Fri Nov 17 20:26:22 2000
+++ linux/include/asm-mips64/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_MIPS64_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-ppc/module.h linux/include/asm-ppc/module.h
--- linux-2.4.0t11p7/include/asm-ppc/module.h	Fri Nov 17 20:26:23 2000
+++ linux/include/asm-ppc/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_PPC_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-s390/module.h linux/include/asm-s390/module.h
--- linux-2.4.0t11p7/include/asm-s390/module.h	Fri Nov 17 20:26:24 2000
+++ linux/include/asm-s390/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_S390_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-sh/module.h linux/include/asm-sh/module.h
--- linux-2.4.0t11p7/include/asm-sh/module.h	Fri Nov 17 20:26:24 2000
+++ linux/include/asm-sh/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_SH_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-sparc/module.h linux/include/asm-sparc/module.h
--- linux-2.4.0t11p7/include/asm-sparc/module.h	Fri Nov 17 20:26:24 2000
+++ linux/include/asm-sparc/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_SPARC_MODULE_H */
diff -urN linux-2.4.0t11p7/include/asm-sparc64/module.h linux/include/asm-sparc64/module.h
--- linux-2.4.0t11p7/include/asm-sparc64/module.h	Fri Nov 17 20:26:24 2000
+++ linux/include/asm-sparc64/module.h	Sat Nov 18 12:11:04 2000
@@ -7,5 +7,6 @@
 extern void * module_map (unsigned long size);
 extern void module_unmap (void *addr);
 #define module_arch_init(x)	(0)
+#define arch_init_modules()	do { } while (0)
 
 #endif /* _ASM_SPARC64_MODULE_H */
diff -urN linux-2.4.0t11p7/kernel/module.c linux/kernel/module.c
--- linux-2.4.0t11p7/kernel/module.c	Fri Nov 17 20:26:24 2000
+++ linux/kernel/module.c	Sat Nov 18 12:11:04 2000
@@ -230,10 +230,7 @@
 void __init init_modules(void)
 {
 	kernel_module.nsyms = __stop___ksymtab - __start___ksymtab;
-
-#ifdef __alpha__
-	__asm__("stq $29,%0" : "=m"(kernel_module.gp));
-#endif
+	arch_init_modules();
 }
 
 /*

--------------A69234E697CB6017A3699C15
Content-Type: text/plain; charset=us-ascii;
 name="module-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-2.diff"

diff -urN linux-2.4.0t11p7/include/linux/module.h linux/include/linux/module.h
--- linux-2.4.0t11p7/include/linux/module.h	Sat Nov 18 12:14:43 2000
+++ linux/include/linux/module.h	Sat Nov 18 12:32:00 2000
@@ -182,8 +182,6 @@
 	const void *userdata;
 };
 
-extern int try_inc_mod_count(struct module *mod);
-
 #if defined(MODULE) && !defined(__GENKSYMS__)
 
 /* Embedded module documentation macros.  */
@@ -345,8 +343,10 @@
 #endif /* MODULE */
 
 #ifdef CONFIG_MODULES
+extern int try_inc_mod_count(struct module *mod);
 #define SET_MODULE_OWNER(some_struct) do { some_struct->owner = THIS_MODULE; } while (0)
 #else
+static inline int try_inc_mod_count(struct module *mod) { return 1; }
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
diff -urN linux-2.4.0t11p7/kernel/module.c linux/kernel/module.c
--- linux-2.4.0t11p7/kernel/module.c	Fri Nov 17 20:26:24 2000
+++ linux/kernel/module.c	Sat Nov 18 12:32:28 2000
@@ -1222,9 +1222,4 @@
 	return -ENOSYS;
 }
 
-int try_inc_mod_count(struct module *mod)
-{
-	return 1;
-}
-
 #endif	/* CONFIG_MODULES */

--------------A69234E697CB6017A3699C15
Content-Type: text/plain; charset=us-ascii;
 name="module-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-3.diff"

diff -urN linux-2.4.0t11p7/include/linux/module.h linux/include/linux/module.h
--- linux-2.4.0t11p7/include/linux/module.h	Sat Nov 18 12:14:43 2000
+++ linux/include/linux/module.h	Sat Nov 18 12:38:16 2000
@@ -190,19 +190,18 @@
 
 /* For documentation purposes only.  */
 
+#define __modinfo __attribute__((section(".modinfo")))
+
 #define MODULE_AUTHOR(name)						   \
-const char __module_author[] __attribute__((section(".modinfo"))) = 	   \
-"author=" name
+const char __module_author[] __modinfo = "author=" name
 
 #define MODULE_DESCRIPTION(desc)					   \
-const char __module_description[] __attribute__((section(".modinfo"))) =   \
-"description=" desc
+const char __module_description[] __modinfo = "description=" desc
 
 /* Could potentially be used by kmod...  */
 
 #define MODULE_SUPPORTED_DEVICE(dev)					   \
-const char __module_device[] __attribute__((section(".modinfo"))) = 	   \
-"device=" dev
+const char __module_device[] __modinfo = "device=" dev
 
 /* Used to verify parameters given to the module.  The TYPE arg should
    be a string in the following format:
@@ -219,13 +218,11 @@
 
 #define MODULE_PARM(var,type)			\
 const char __module_parm_##var[]		\
-__attribute__((section(".modinfo"))) =		\
-"parm_" __MODULE_STRING(var) "=" type
+__modinfo = "parm_" __MODULE_STRING(var) "=" type
 
 #define MODULE_PARM_DESC(var,desc)		\
 const char __module_parm_desc_##var[]		\
-__attribute__((section(".modinfo"))) =		\
-"parm_desc_" __MODULE_STRING(var) "=" desc
+__modinfo = "parm_desc_" __MODULE_STRING(var) "=" desc
 
 /*
  * MODULE_DEVICE_TABLE exports information about devices
@@ -263,11 +260,9 @@
 #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
 
 #include <linux/version.h>
-static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
-"kernel_version=" UTS_RELEASE;
+static const char __module_kernel_version[] __modinfo = "kernel_version=" UTS_RELEASE;
 #ifdef MODVERSIONS
-static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
-"using_checksums=1";
+static const char __module_using_checksums[] __modinfo = "using_checksums=1";
 #endif
 
 #else /* MODULE */

--------------A69234E697CB6017A3699C15--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
