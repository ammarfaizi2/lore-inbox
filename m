Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSLJA2M>; Mon, 9 Dec 2002 19:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLJA2M>; Mon, 9 Dec 2002 19:28:12 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:44974 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266425AbSLJA1g>; Mon, 9 Dec 2002 19:27:36 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-BK] Add missing $somearches system.h bits from IDE -ac merge
Date: Tue, 10 Dec 2002 01:34:09 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212100132.59816.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_X8OV25MDQZ0IFHKQ2MOC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_X8OV25MDQZ0IFHKQ2MOC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

x86 missing system.h bits got fixed by Changeset 1.793 but this is also=20
missing for the following arches:

- ALPHA, ARM, CRIS, IA64, s390, s390x, sparc, sparc64.

ciao, Marc
--------------Boundary-00=_X8OV25MDQZ0IFHKQ2MOC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing-ide-otherarch-stuff-2.4.21.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="missing-ide-otherarch-stuff-2.4.21.patch"

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-alpha/system.h linux.20-ac1/include/asm-alpha/system.h
--- linux.vanilla/include/asm-alpha/system.h	2001-10-05 02:47:08.000000000 +0100
+++ linux.20-ac1/include/asm-alpha/system.h	2002-08-06 15:41:52.000000000 +0100
@@ -309,9 +309,11 @@
 #define __sti()			do { barrier(); setipl(IPL_MIN); } while(0)
 #define __save_flags(flags)	((flags) = rdps())
 #define __save_and_cli(flags)	do { (flags) = swpipl(IPL_MAX); barrier(); } while(0)
+#define __save_and_sti(flags)	do { (flags) = swpipl(IPL_MIN); barrier(); } while(0)
 #define __restore_flags(flags)	do { barrier(); setipl(flags); barrier(); } while(0)
 
 #define local_irq_save(flags)		__save_and_cli(flags)
+#define local_irq_set(flags)		__save_and_sti(flags)
 #define local_irq_restore(flags)	__restore_flags(flags)
 #define local_irq_disable()		__cli()
 #define local_irq_enable()		__sti()
@@ -320,8 +322,6 @@
 
 extern int global_irq_holder;
 
-#define save_and_cli(flags)     (save_flags(flags), cli())
-
 extern void __global_cli(void);
 extern void __global_sti(void);
 extern unsigned long __global_save_flags(void);
@@ -331,6 +331,8 @@
 #define sti()                   __global_sti()
 #define save_flags(flags)	((flags) = __global_save_flags())
 #define restore_flags(flags)    __global_restore_flags(flags)
+#define save_and_cli(flags)	(save_flags(flags), cli())
+#define save_and_sti(flags)	(save_flags(flags), sti())
 
 #else /* CONFIG_SMP */
 
@@ -338,6 +340,7 @@
 #define sti()			__sti()
 #define save_flags(flags)	__save_flags(flags)
 #define save_and_cli(flags)	__save_and_cli(flags)
+#define save_and_sti(flags)	__save_and_sti(flags)
 #define restore_flags(flags)	__restore_flags(flags)
 
 #endif /* CONFIG_SMP */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-arm/system.h linux.20-ac1/include/asm-arm/system.h
--- linux.vanilla/include/asm-arm/system.h	2000-11-28 01:07:59.000000000 +0000
+++ linux.20-ac1/include/asm-arm/system.h	2002-08-06 15:41:52.000000000 +0100
@@ -58,6 +58,7 @@
 
 /* For spinlocks etc */
 #define local_irq_save(x)	__save_flags_cli(x)
+#define local_irq_set(x)	__save_and_sti(x)
 #define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
@@ -82,6 +83,8 @@
 #define save_flags(x)		__save_flags(x)
 #define restore_flags(x)	__restore_flags(x)
 #define save_flags_cli(x)	__save_flags_cli(x)
+#define save_and_cli(x)		__save_flags_cli(x)
+#define save_and_sti(x)		__save_flags_sti(x)
 
 #endif /* CONFIG_SMP */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-cris/system.h linux.20-ac1/include/asm-cris/system.h
--- linux.vanilla/include/asm-cris/system.h	2002-08-03 16:08:30.000000000 +0100
+++ linux.20-ac1/include/asm-cris/system.h	2002-08-06 15:41:52.000000000 +0100
@@ -69,6 +69,7 @@
 
 /* For spinlocks etc */
 #define local_irq_save(x) __asm__ __volatile__ ("move $ccr,%0\n\tdi" : "=rm" (x) : : "memory"); 
+#define local_irq_set(x) __asm__ __volatile__ ("move $ccr,%0\n\tei" : "=rm" (x) : : "memory");
 #define local_irq_restore(x) restore_flags(x)
 
 #define local_irq_disable()  cli()
@@ -80,7 +81,8 @@
 #define sti() __sti()
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
-#define save_and_cli(x) do { __save_flags(x); cli(); } while(0)
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0)
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0)
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-ia64/system.h linux.20-ac1/include/asm-ia64/system.h
--- linux.vanilla/include/asm-ia64/system.h	2002-11-29 21:27:23.000000000 +0000
+++ linux.20-ac1/include/asm-ia64/system.h	2002-09-14 22:36:29.000000000 +0100
@@ -171,6 +171,15 @@
 						      : "p6", "p7", "memory")
 #endif /* !CONFIG_IA64_DEBUG_IRQ */
 
+#error andre hedrick screwed this up please help unscrew in order to clean up
+/*
+ * __save_and_sti(x) == __save_flags(x); ide__sti();
+ *                      __save_flags(x); __sti();
+ *
+ * local_irq_set(x) == __save_and_sti(x)
+ */
+
+
 #define local_irq_enable()	__asm__ __volatile__ (";; ssm psr.i;; srlz.d" ::: "memory")
 
 #define __cli()			local_irq_disable ()
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-s390/system.h linux.20-ac1/include/asm-s390/system.h
--- linux.vanilla/include/asm-s390/system.h	2002-11-29 21:27:24.000000000 +0000
+++ linux.20-ac1/include/asm-s390/system.h	2002-08-13 14:46:55.000000000 +0100
@@ -206,8 +206,12 @@
                 : "cc", "0", "1", "2"); \
         })
 
+#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
+#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
+
 /* For spinlocks etc */
 #define local_irq_save(x)	((x) = __cli())
+#define local_irq_set(x)	__save_and_sti(x)
 #define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
@@ -223,6 +227,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
 
 extern void smp_ctl_set_bit(int cr, int bit);
 extern void smp_ctl_clear_bit(int cr, int bit);
@@ -235,6 +241,8 @@
 #define sti() __sti()
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
+#define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 
 #define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
 #define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-s390x/system.h linux.20-ac1/include/asm-s390x/system.h
--- linux.vanilla/include/asm-s390x/system.h	2002-11-29 21:27:24.000000000 +0000
+++ linux.20-ac1/include/asm-s390x/system.h	2002-08-13 14:46:55.000000000 +0100
@@ -216,8 +216,13 @@
                 : "cc", "0", "1", "2"); \
         })
 
+
+#define __save_and_cli(x)       do { __save_flags(x); __cli(); } while(0);
+#define __save_and_sti(x)       do { __save_flags(x); __sti(); } while(0);
+
 /* For spinlocks etc */
 #define local_irq_save(x)	((x) = __cli())
+#define local_irq_set(x)	__save_and_sti(x)
 #define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
@@ -233,6 +238,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
 
 extern void smp_ctl_set_bit(int cr, int bit);
 extern void smp_ctl_clear_bit(int cr, int bit);
@@ -245,6 +252,8 @@
 #define sti() __sti()
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
+#define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 
 #define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
 #define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-sparc/system.h linux.20-ac1/include/asm-sparc/system.h
--- linux.vanilla/include/asm-sparc/system.h	2001-10-30 23:08:11.000000000 +0000
+++ linux.20-ac1/include/asm-sparc/system.h	2002-08-06 15:41:52.000000000 +0100
@@ -241,20 +241,21 @@
 	return retval;
 }
 
+#define __save_and_sti(flags)	do { __save_flags(flags); __sti(); } while(0);
+
 #define __save_flags(flags)	((flags) = getipl())
 #define __save_and_cli(flags)	((flags) = read_psr_and_cli())
 #define __restore_flags(flags)	setipl((flags))
 #define local_irq_disable()		__cli()
 #define local_irq_enable()		__sti()
 #define local_irq_save(flags)		__save_and_cli(flags)
+#define local_irq_set(flags)		__save_and_sti(flags)
 #define local_irq_restore(flags)	__restore_flags(flags)
 
 #ifdef CONFIG_SMP
 
 extern unsigned char global_irq_holder;
 
-#define save_and_cli(flags)   do { save_flags(flags); cli(); } while(0)
-
 extern void __global_cli(void);
 extern void __global_sti(void);
 extern unsigned long __global_save_flags(void);
@@ -263,6 +264,7 @@
 #define sti()			__global_sti()
 #define save_flags(flags)	((flags)=__global_save_flags())
 #define restore_flags(flags)	__global_restore_flags(flags)
+#define save_and_sti(flags)	do { save_flags(flags); sti(); } while(0);
 
 #else
 
@@ -271,6 +273,7 @@
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
 #define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 
 #endif
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/asm-sparc64/system.h linux.20-ac1/include/asm-sparc64/system.h
--- linux.vanilla/include/asm-sparc64/system.h	2002-08-03 16:08:32.000000000 +0100
+++ linux.20-ac1/include/asm-sparc64/system.h	2002-08-06 15:41:52.000000000 +0100
@@ -65,9 +65,13 @@
 #define __save_flags(flags)		((flags) = getipl())
 #define __save_and_cli(flags)		((flags) = read_pil_and_cli())
 #define __restore_flags(flags)		setipl((flags))
+
+#define __save_and_sti(flags)		({ __save_flags(flags); __sti(); })
+
 #define local_irq_disable()		__cli()
 #define local_irq_enable()		__sti()
 #define local_irq_save(flags)		__save_and_cli(flags)
+#define local_irq_set(flags)		__save_and_sti(flags)
 #define local_irq_restore(flags)	__restore_flags(flags)
 
 #ifndef CONFIG_SMP
@@ -76,6 +80,7 @@
 #define save_flags(x) __save_flags(x)
 #define restore_flags(x) __restore_flags(x)
 #define save_and_cli(x) __save_and_cli(x)
+#define save_and_sti(x) __save_and_sti(x)
 #else
 
 #ifndef __ASSEMBLY__
@@ -90,6 +95,7 @@
 #define save_flags(x)		((x) = __global_save_flags())
 #define restore_flags(flags)	__global_restore_flags(flags)
 #define save_and_cli(flags)	do { save_flags(flags); cli(); } while(0)
+#define save_and_sti(flags)	do { save_flags(flags); sti(); } while(0)
 
 #endif
 

--------------Boundary-00=_X8OV25MDQZ0IFHKQ2MOC--

