Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSE3Sx7>; Thu, 30 May 2002 14:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSE3Sx6>; Thu, 30 May 2002 14:53:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39110 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316826AbSE3Sx4>; Thu, 30 May 2002 14:53:56 -0400
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022712736.9255.289.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-3KdFA1+HbfLsCMDO+wTf"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 11:50:15 -0700
Message-Id: <1022784616.1963.106.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3KdFA1+HbfLsCMDO+wTf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Add CONFIG_X86_TSC_NOT_SYNCHRONOUS or similar and then check
> 
> #if defined(CONFIG_X86_TSC) && !defined(CONFIG_X86_NOT_SYNCHRONOUS))

Attached is the patch implemented as suggested above. It seems a bit
uglier, but perhaps I'm missing exactly what you meant. 

thanks
-john


--=-3KdFA1+HbfLsCMDO+wTf
Content-Disposition: attachment; filename=tsc-disable_A4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tsc-disable_A4.patch; charset=ISO-8859-1

Index: linux24/arch/i386/config.in
diff -u linux24/arch/i386/config.in:1.1.1.3 linux24/arch/i386/config.in:1.1=
.1.3.14.4
--- linux24/arch/i386/config.in:1.1.1.3	Wed Feb 13 14:53:47 2002
+++ linux24/arch/i386/config.in	Thu May 30 11:28:18 2002
@@ -198,6 +198,11 @@
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
=20
+# Multiquad NUMA boxes can't keep their TSCs in sync
+if [ "$CONFIG_MULTIQUAD" =3D "y" ]; then
+		define_bool CONFIG_TSC_DISABLE y
+fi
+
 if [ "$CONFIG_SMP" =3D "y" -a "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
 fi
Index: linux24/arch/i386/kernel/setup.c
diff -u linux24/arch/i386/kernel/setup.c:1.1.1.3.14.1 linux24/arch/i386/ker=
nel/setup.c:1.1.1.3.14.6
--- linux24/arch/i386/kernel/setup.c:1.1.1.3.14.1	Tue May 28 17:30:29 2002
+++ linux24/arch/i386/kernel/setup.c	Thu May 30 11:28:18 2002
@@ -1053,8 +1053,12 @@
 __setup("cachesize=3D", cachesize_setup);
=20
=20
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
+#ifdef CONFIG_TSC_DISABLE
+static int tsc_disable __initdata =3D 1;=09
+#else /*CONFIG_TSC_DISABLE*/
 static int tsc_disable __initdata =3D 0;
+#endif /*CONFIG_TSC_DISABLE*/
=20
 static int __init tsc_setup(char *str)
 {
@@ -2650,7 +2654,7 @@
 	 */
=20
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif
@@ -2888,7 +2892,7 @@
=20
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
 	if (tsc_disable && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
Index: linux24/arch/i386/kernel/time.c
diff -u linux24/arch/i386/kernel/time.c:1.1.1.2 linux24/arch/i386/kernel/ti=
me.c:1.1.1.2.14.2
--- linux24/arch/i386/kernel/time.c:1.1.1.2	Wed Feb 13 14:53:48 2002
+++ linux24/arch/i386/kernel/time.c	Thu May 30 11:28:18 2002
@@ -118,7 +118,7 @@
=20
 extern spinlock_t i8259A_lock;
=20
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
=20
 /* This function must be called with interrupts disabled=20
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
Index: linux24/include/asm-i386/bugs.h
diff -u linux24/include/asm-i386/bugs.h:1.1.1.1 linux24/include/asm-i386/bu=
gs.h:1.1.1.1.40.2
--- linux24/include/asm-i386/bugs.h:1.1.1.1	Tue Dec 18 15:49:01 2001
+++ linux24/include/asm-i386/bugs.h	Thu May 30 11:28:18 2002
@@ -173,7 +173,7 @@
 /*
  * If we configured ourselves for a TSC, we'd better have one!
  */
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
 	if (!cpu_has_tsc)
 		panic("Kernel compiled for Pentium+, requires TSC feature!");
 #endif
Index: linux24/include/asm-i386/timex.h
diff -u linux24/include/asm-i386/timex.h:1.1.1.2 linux24/include/asm-i386/t=
imex.h:1.1.1.2.14.2
--- linux24/include/asm-i386/timex.h:1.1.1.2	Wed Feb 13 14:52:42 2002
+++ linux24/include/asm-i386/timex.h	Thu May 30 11:28:18 2002
@@ -40,7 +40,7 @@
=20
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC) || defined(CONFIG_TSC_DISABLE)
 	return 0;
 #else
 	unsigned long long ret;
Index: linux24/include/net/pkt_sched.h
diff -u linux24/include/net/pkt_sched.h:1.1.1.1 linux24/include/net/pkt_sch=
ed.h:1.1.1.1.40.2
--- linux24/include/net/pkt_sched.h:1.1.1.1	Tue Dec 18 15:49:02 2001
+++ linux24/include/net/pkt_sched.h	Thu May 30 11:28:18 2002
@@ -11,7 +11,7 @@
 #include <linux/pkt_sched.h>
 #include <net/pkt_cls.h>
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
 #include <asm/msr.h>
 #endif
=20
@@ -252,7 +252,7 @@
=20
 #define PSCHED_US2JIFFIE(delay) (((delay)+psched_clock_per_hz-1)/psched_cl=
ock_per_hz)
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
=20
 #define PSCHED_GET_TIME(stamp) \
 ({ u64 __cur; \
Index: linux24/include/net/profile.h
diff -u linux24/include/net/profile.h:1.1.1.1 linux24/include/net/profile.h=
:1.1.1.1.40.2
--- linux24/include/net/profile.h:1.1.1.1	Tue Dec 18 15:49:02 2001
+++ linux24/include/net/profile.h	Thu May 30 11:28:18 2002
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <asm/system.h>
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC) && !defined(CONFIG_TSC_DISABLE)
 #include <asm/msr.h>
 #endif
=20
@@ -29,7 +29,7 @@
 extern struct timeval net_profile_adjust;
 extern void net_profile_irq_adjust(struct timeval *entered, struct timeval=
* leaved);
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
=20
 static inline void  net_profile_stamp(struct timeval *pstamp)
 {

--=-3KdFA1+HbfLsCMDO+wTf--

