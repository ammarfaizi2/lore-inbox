Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSJ2TBT>; Tue, 29 Oct 2002 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJ2TBT>; Tue, 29 Oct 2002 14:01:19 -0500
Received: from verein.lst.de ([212.34.181.86]:54794 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262159AbSJ2TBR>;
	Tue, 29 Oct 2002 14:01:17 -0500
Date: Tue, 29 Oct 2002 20:07:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sanitize intel movsl selection
Message-ID: <20021029200732.A2671@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

umm, the ifdef <actual cpu selection> is very bad style, we usually
introduce feature CONFIG_ options in config.in instead.


--- 1.60/arch/i386/config.in	Thu Oct 24 12:58:07 2002
+++ edited/arch/i386/config.in	Tue Oct 29 18:44:36 2002
@@ -83,6 +83,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
+   define_bool CONFIG_X86_INTEL_USERCOPY y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -96,12 +97,14 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_INTEL_USERCOPY y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_INTEL_USERCOPY y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
--- 1.11/arch/i386/kernel/cpu/intel.c	Mon Oct 28 19:34:38 2002
+++ edited/arch/i386/kernel/cpu/intel.c	Tue Oct 29 18:43:08 2002
@@ -14,9 +14,11 @@
 static int disable_P4_HT __initdata = 0;
 extern int trap_init_f00f_bug(void);
 
-#ifdef INTEL_MOVSL
-struct movsl_mask movsl_mask;	/* alignment at which movsl is preferred for
-			   	   bulk memory copies */
+#ifdef CONFIG_X86_INTEL_USERCOPY
+/*
+ * Alignment at which movsl is preferred for bulk memory copies.
+ */
+struct movsl_mask movsl_mask;
 #endif
 
 /*
@@ -355,7 +357,7 @@
 	/* Work around errata */
 	Intel_errata_workarounds(c);
 
-#ifdef INTEL_MOVSL
+#ifdef CONFIG_X86_INTEL_USERCOPY
 	/*
 	 * Set up the preferred alignment for movsl bulk memory moves
 	 */
@@ -372,7 +374,6 @@
 		break;
 	}
 #endif
-
 }
 
 
--- 1.6/arch/i386/lib/usercopy.c	Mon Oct 28 19:34:41 2002
+++ edited/arch/i386/lib/usercopy.c	Tue Oct 29 18:42:59 2002
@@ -9,21 +9,14 @@
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
-#ifdef INTEL_MOVSL
-static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
-{
-	if (n < 64)
-		return 1;
-	if ((((const long)a1 ^ (const long)a2) & movsl_mask.mask) == 0)
-		return 1;
-	return 0;
-}
-#else
 static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
 {
+#ifdef CONFIG_X86_INTEL_USERCOPY
+	if (n >= 64 || (((const long)a1 ^ (const long)a2) & movsl_mask.mask))
+		return 0;
+#endif
 	return 1;
 }
-#endif
 
 /*
  * Copy a null terminated string from userspace.
@@ -151,8 +144,7 @@
 	return res & mask;
 }
 
-#ifdef INTEL_MOVSL
-
+#ifdef CONFIG_X86_INTEL_USERCOPY
 static unsigned long
 __copy_user_intel(void *to, const void *from,unsigned long size)
 {
@@ -334,8 +326,7 @@
 		       : "eax", "edx", "memory");
 	return size;
 }
-#else	/* INTEL_MOVSL */
-
+#else
 /*
  * Leave these declared but undefined.  They should not be any references to
  * them
@@ -344,8 +335,7 @@
 __copy_user_zeroing_intel(void *to, const void *from, unsigned long size);
 unsigned long
 __copy_user_intel(void *to, const void *from,unsigned long size);
-
-#endif	/* INTEL_MOVSL */
+#endif /* CONFIG_X86_INTEL_USERCOPY */
 
 /* Generic arbitrary sized copy.  */
 #define __copy_user(to,from,size)					\
--- 1.10/include/asm-i386/uaccess.h	Mon Oct 28 19:34:41 2002
+++ edited/include/asm-i386/uaccess.h	Tue Oct 29 18:43:21 2002
@@ -36,12 +36,7 @@
 /*
  * movsl can be slow when source and dest are not both 8-byte aligned
  */
-#if defined(CONFIG_M586MMX) || defined(CONFIG_M686) || \
-	defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
-#define INTEL_MOVSL
-#endif
-
-#ifdef INTEL_MOVSL
+#ifdef CONFIG_X86_INTEL_USERCOPY
 extern struct movsl_mask {
 	int mask;
 } ____cacheline_aligned_in_smp movsl_mask;
