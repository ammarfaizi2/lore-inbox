Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSHDUTy>; Sun, 4 Aug 2002 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSHDUTy>; Sun, 4 Aug 2002 16:19:54 -0400
Received: from ppp-217-133-220-178.dialup.tiscali.it ([217.133.220.178]:11723
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318203AbSHDUTv>; Sun, 4 Aug 2002 16:19:51 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020804185952.GC1670@junk>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-qKaEGyWWuS724CXg2gM2"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Aug 2002 22:23:16 +0200
Message-Id: <1028492596.1293.535.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qKaEGyWWuS724CXg2gM2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Added, with the exception that sfence is only used if CONFIG_X86_OOSTORE
is not defined (currently never).

This patch, to be applied after the previous two ones, does:
- s/dep_bool/bool/ in config.in for CONFIG_X86_PPRO_FENCE
- Works around make xconfig brokenness in config.in
- Adds an option in config.in to select the processor to optimize for,
that determines the -mcpu flags
- Supports lfence, mfence and sfence


diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/Config.help b/arch/i386/Config.help
--- a/arch/i386/Config.help	2002-08-04 21:54:59.000000000 +0200
+++ b/arch/i386/Config.help	2002-08-04 21:52:41.000000000 +0200
@@ -527,6 +527,38 @@
   kernels also enable out of order memory stores for this CPU, which
   can increase performance of some operations.
 
+CONFIG_MCPU_386
+  This is the processor type the kernel will be optimized for. The
+  kernel will run on the processor you selected in the previous
+  question and processors compatible with it, but it will run faster
+  on the CPUs selected here and slower on others.
+
+  The following settings are available:
+   - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
+     486DLC/DLC2, UMC 486SX-S and NexGen Nx586.
+   - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
+     SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
+   - "586" for Pentium/K5/5x86/6x86.
+   - "586+MMX" for Pentium-6x86MX/CyrixIII/C3/Winchip. Currently this
+     is the same as "586".
+   - "686" for Pentium-Pro and other 686 processors.
+   - "Pentium-II" for Pentium-II. Currently this is the same as "686".
+   - "Pentium-III" for Pentium-III. Currently this is the same as "686".
+   - "Pentium-4" for the Intel Pentium 4.
+   - "K6" for the AMD K6.
+   - "K6-II/K6-III" for the AMD K6-II/K6-III processors. Currently
+     this is the same as "K6".
+   - "Athlon" for the AMD Athlon
+   - "Athlon-ThunderBird" for the AMD Athlon ThunderBird. Currently
+     this is the same as "Athlon".
+   - "Athlon-4/XP/MP" for AMD Athlon 4/XP/MP processors. Currently
+     this is the same as "Athlon".
+   - "Crusoe" for the Transmeta Crusoe.
+
+  If you don't know what to do, choose the same processor that you
+  chose in the previous question. If you still don't know what to do,
+  choose "686".
+
 CONFIG_X86_PPRO_FENCE
   Allows the kernel to run on Pentium Pro systems by supporting a
   workaround for the store ordering bug present on them.
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	2002-08-04 21:54:59.000000000 +0200
+++ b/arch/i386/config.in	2002-08-04 22:09:05.000000000 +0200
@@ -14,7 +14,7 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-choice 'Processor family' \
+choice 'Required processor family' \
 	"386					CONFIG_M386 \
 	 486					CONFIG_M486 \
 	 586/K5/5x86/6x86			CONFIG_M586 \
@@ -35,10 +35,33 @@
 	 Winchip+TSC...Winchip-2			CONFIG_MWINCHIP2 \
 	 Winchip+TSC+3DNow...Winchip-2A/Winchip-3	CONFIG_MWINCHIP3D \
 	 CyrixIII/C3				CONFIG_MCYRIXIII" Pentium-III
+
+choice 'Optimized for processor family' \
+	"386					CONFIG_MCPU_386 \
+	 486...486/Elan				CONFIG_MCPU_486 \
+	 586...Pentium/K5/etc			CONFIG_MCPU_586 \
+	 586+MMX...Pentium-MMX/6x86MX/etc	CONFIG_MCPU_586MMX \
+	 686...Pentium-Pro			CONFIG_MCPU_686 \
+	 Pentium-II				CONFIG_MCPU_PENTIUMII \
+	 Pentium-III				CONFIG_MCPU_PENTIUMIII \
+	 Pentium-4				CONFIG_MCPU_PENTIUM4 \
+	 K6					CONFIG_MCPU_K6 \
+	 K6-II/K6-III				CONFIG_MCPU_K6II \
+	 Athlon					CONFIG_MCPU_ATHLON \
+	 Athlon-ThunderBird			CONFIG_MCPU_ATHLON_TBIRD \
+	 Athlon-4/XP/MP				CONFIG_MCPU_ATHLON_XP \
+	 Crusoe					CONFIG_MCPU_CRUSOE" 686
+
 #
 # Define implied options from the CPU selection here
 #
 
+# Workaround make xconfig brokenness
+define_bool CONFIG_X86_USE_SSE_PREFETCH n
+define_bool CONFIG_X86_USE_3DNOW n
+define_bool CONFIG_X86_OOSTORE n
+define_bool CONFIG_X86_686 n
+
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
@@ -214,7 +237,7 @@
    define_bool CONFIG_X86_F00F_BUG y
 fi
 if [ "$CONFIG_X86_USE_SSE_PREFETCH" != "y" -a "$CONFIG_X86_USE_3DNOW" != "y" -a "$CONFIG_X86_OOSTORE" != "y" ]; then
-   dep_bool 'Support Pentium Pro and slow down all processors' CONFIG_X86_PPRO_FENCE
+   bool 'Support Pentium Pro and slow down all processors' CONFIG_X86_PPRO_FENCE
 fi
 
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2002-08-04 16:39:51.000000000 +0200
+++ b/arch/i386/Makefile	2002-08-04 21:57:21.000000000 +0200
@@ -23,9 +23,8 @@
 __cc_test = if $(CC) $(1) -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "$(1)"; $(2)fi
 cc_test = $(call __cc_test,$(1),)
 cc_test_ = $(call __cc_test,$(1),else $(2); )
-cc_test_march = $(call cc_test_,-march=$(1),echo "-march=$(2)")
-cc_test_march3 = $(call cc_test_,-march=$(1),$(call cc_test_march,$(2),$(3)))
-
+cc_test_o = $(call cc_test_,-$(1)=$(2),echo "-$(1)=$(3)")
+cc_test_o3 = $(call cc_test_,-$(1)=$(2),$(call cc_test_o,$(1),$(3),$(4)))
 CFLAGS += -pipe
 
 # prevent gcc from keeping the stack 16 byte aligned
@@ -56,11 +55,11 @@
 endif
 
 ifdef CONFIG_M586MX
-CFLAGS += $(shell $(call cc_test_march,pentium-mmx,i586))
+CFLAGS += $(shell $(call cc_test_o,march,pentium-mmx,i586))
 endif
 
 ifdef CONFIG_M586MMX
-CFLAGS += $(shell $(call cc_test_march,pentium-mmx,i586))
+CFLAGS += $(shell $(call cc_test_o,march,pentium-mmx,i586))
 endif
 
 ifdef CONFIG_M686
@@ -68,35 +67,35 @@
 endif
 
 ifdef CONFIG_MPENTIUMII
-CFLAGS += $(shell $(call cc_test_march,pentium2,i686))
+CFLAGS += $(shell $(call cc_test_o,march,pentium2,i686))
 endif
 
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += $(shell $(call cc_test_march,pentium3,i686))
+CFLAGS += $(shell $(call cc_test_o,march,pentium3,i686))
 endif
 
 ifdef CONFIG_MPENTIUM4
-CFLAGS += $(shell $(call cc_test_march,pentium4,i686))
+CFLAGS += $(shell $(call cc_test_o,march,pentium4,i686))
 endif
 
 ifdef CONFIG_MK6
-CFLAGS += $(shell $(call cc_test_march,k6,i586 -mcpu=i686))
+CFLAGS += $(shell $(call cc_test_o,march,k6,i586))
 endif
 
 ifdef CONFIG_MK6II
-CFLAGS += $(shell $(call cc_test_march3,k6-2,k6,i586 -mcpu=i686))
+CFLAGS += $(shell $(call cc_test_o3,march,k6-2,k6,i586))
 endif
 
 ifdef CONFIG_MK7
-CFLAGS += $(shell $(call cc_test_march,athlon,i686))
+CFLAGS += $(shell $(call cc_test_o,march,athlon,i686))
 endif
 
 ifdef CONFIG_MK7SSE
-CFLAGS += $(shell $(call cc_test_march3,athlon-xp,athlon,i686))
+CFLAGS += $(shell $(call cc_test_o3,march,athlon-xp,athlon,i686))
 endif
 
 ifdef CONFIG_MCRUSOE
-CFLAGS += $(shell $(call cc_test_march,crusoe,i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0))
+CFLAGS += $(shell $(call cc_test_o,march,crusoe,i686))
 endif
 
 ifdef CONFIG_MWINCHIPC6
@@ -115,6 +114,62 @@
 CFLAGS += -march=i586
 endif
 
+ifdef CONFIG_MCPU_386
+CFLAGS += -march=i386
+endif
+
+ifdef CONFIG_MCPU_486
+CFLAGS += -march=i486
+endif
+
+ifdef CONFIG_MCPU_586
+CFLAGS += -march=i586
+endif
+
+ifdef CONFIG_MCPU_586MMX
+CFLAGS += $(shell $(call cc_test_o,mcpu,pentium-mmx,i586))
+endif
+
+ifdef CONFIG_MCPU_686
+CFLAGS += -march=i686
+endif
+
+ifdef CONFIG_MCPU_PENTIUMII
+CFLAGS += $(shell $(call cc_test_o,mcpu,pentium2,i686))
+endif
+
+ifdef CONFIG_MCPU_PENTIUMIII
+CFLAGS += $(shell $(call cc_test_o,mcpu,pentium3,i686))
+endif
+
+ifdef CONFIG_MCPU_PENTIUM4
+CFLAGS += $(shell $(call cc_test_o,mcpu,pentium4,i686))
+endif
+
+ifdef CONFIG_MCPU_K6
+CFLAGS += $(shell $(call cc_test_o,mcpu,k6,i686))
+endif
+
+ifdef CONFIG_MCPU_K6II
+CFLAGS += $(shell $(call cc_test_o3,mcpu,k6-2,k6,i686))
+endif
+
+ifdef CONFIG_MCPU_ATHLON
+CFLAGS += $(shell $(call cc_test_o,mcpu,athlon,i686))
+endif
+
+ifdef CONFIG_MCPU_ATHLON_TBIRD
+CFLAGS += $(shell $(call cc_test_o3,mcpu,athlon-tbird,athlon,i686))
+endif
+
+ifdef CONFIG_MCPU_ATHLON_XP
+CFLAGS += $(shell $(call cc_test_o3,mcpu,athlon-xp,athlon,i686))
+endif
+
+ifdef CONFIG_MCPU_CRUSOE
+CFLAGS += $(shell $(call cc_test_o,mcpu,crusoe,i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0))
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/bugs.h b/include/asm-i386/bugs.h
--- a/include/asm-i386/bugs.h	2002-08-04 21:54:59.000000000 +0200
+++ b/include/asm-i386/bugs.h	2002-08-04 22:17:22.000000000 +0200
@@ -212,10 +212,15 @@
 		panic("Kernel requires 3DNow support (K6-2/3, Athlon)");
 #endif
 
-#if defined(CONFIG_X86_USE_SSE_PREFETCH)
+#if defined(CONFIG_X86_USE_SSE_PREFETCH) || (defined(CONFIG_X86_MMXEXT) && defined(CONFIG_X86_OOSTORE))
 	if(!boot_cpu_has(X86_FEATURE_MMXEXT))
 		panic("Kernel requires extended MMX support (Pentium3/4, Athlon)");
 #endif
+
+#if defined(CONFIG_X86_SSE2)
+	if(!boot_cpu_has(X86_FEATURE_XMM2))
+		panic("Kernel requires SSE2 (Pentium4)");
+#endif
 }
 
 static void __init check_bugs(void)
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/system.h b/include/asm-i386/system.h
--- a/include/asm-i386/system.h	2002-07-29 04:17:20.000000000 +0200
+++ b/include/asm-i386/system.h	2002-08-04 21:56:34.000000000 +0200
@@ -282,12 +282,21 @@
  * Some non intel clones support out of order store. wmb() ceases to be a
  * nop for these.
  */
- 
+
+#ifdef CONFIG_X86_SSE2
+#define mb()	__asm__ __volatile__ ("mfence": : :"memory")
+#define rmb()	__asm__ __volatile__ ("lfence": : :"memory")
+#else
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #define rmb()	mb()
+#endif
 
 #ifdef CONFIG_X86_OOSTORE
+#ifdef CONFIG_X86_MMXEXT /* never happens right now */
+#define wmb() 	__asm__ __volatile__ ("sfence": : :"memory")
+#else
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#endif
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif

--=-qKaEGyWWuS724CXg2gM2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TY00djkty3ft5+cRAjSqAKCm2QFrBgP6/C15A0chY9teh/W7/ACfQdtO
eZPzf9InJ4GvU7P7Dej3poo=
=1yRj
-----END PGP SIGNATURE-----

--=-qKaEGyWWuS724CXg2gM2--
