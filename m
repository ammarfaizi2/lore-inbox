Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSFNSlQ>; Fri, 14 Jun 2002 14:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFNSlP>; Fri, 14 Jun 2002 14:41:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32176 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312601AbSFNSlN>;
	Fri, 14 Jun 2002 14:41:13 -0400
Subject: [Patch] tsc-disable_A5
From: john stultz <johnstul@us.ibm.com>
To: marcelo@conectiva.com.br
Cc: lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-B/HhAsgr8RS/49rK+w/1"
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jun 2002 11:35:26 -0700
Message-Id: <1024079726.29929.131.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B/HhAsgr8RS/49rK+w/1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Marcelo,
	I know its probably poor form to send this out so close to -rc, but I
figured I might as well give it a shot. I'll happily resubmit this for
the .20pre series later if you'd prefer.

This patch disables the TSCs when compiled for Multiquad NUMA hardware.
Due to the slower interconnect, the TSCs aren't being synced properly at
boot time. Even if they were synced, since the different nodes are
driven by different crystals, the TSCs still drift. 

This results in sequential calls to gettimeofday to return
non-sequential time values. By disabling the TSCs on these boxes, it
forces gettimeofday to use the PIC clock instead, fixing the problem. 

Let me know if you have any comments. 

Thanks
-john

--=-B/HhAsgr8RS/49rK+w/1
Content-Disposition: attachment; filename=linux-2.4.19-pre10_tsc-disable_A5.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.19-pre10_tsc-disable_A5.patch;
	charset=ISO-8859-1

diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Thu Jun 13 20:01:09 2002
+++ b/arch/i386/config.in	Thu Jun 13 20:01:09 2002
@@ -198,7 +198,17 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+	bool 'Multiquad NUMA support' CONFIG_X86_NUMA
+	if [ "$CONFIG_X86_NUMA" =3D "y" ]; then
+		choice 'NUMA Hardware Selection' \
+		"NUMAQ					CONFIG_X86_NUMAQ \
+		 x440					CONFIG_X86_X440" NUMAQ
+		if [ "$CONFIG_X86_NUMAQ" =3D "y" ]; then
+			define_bool CONFIG_MULTIQUAD y
+		fi
+		# Multiquad NUMA boxes can't keep their TSCs in sync
+		define_bool CONFIG_TSC_DISABLE y
+	fi
 fi
=20
 if [ "$CONFIG_SMP" =3D "y" -a "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Jun 13 20:01:09 2002
+++ b/arch/i386/kernel/setup.c	Thu Jun 13 20:01:09 2002
@@ -1127,8 +1127,12 @@
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
@@ -2733,7 +2737,7 @@
 	 */
=20
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif
@@ -2978,7 +2982,7 @@
=20
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
 	if (tsc_disable && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Jun 13 20:01:09 2002
+++ b/arch/i386/kernel/time.c	Thu Jun 13 20:01:09 2002
@@ -118,7 +118,7 @@
=20
 extern spinlock_t i8259A_lock;
=20
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
=20
 /* This function must be called with interrupts disabled=20
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
diff -Nru a/include/asm-i386/bugs.h b/include/asm-i386/bugs.h
--- a/include/asm-i386/bugs.h	Thu Jun 13 20:01:09 2002
+++ b/include/asm-i386/bugs.h	Thu Jun 13 20:01:09 2002
@@ -173,7 +173,7 @@
 /*
  * If we configured ourselves for a TSC, we'd better have one!
  */
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
 	if (!cpu_has_tsc)
 		panic("Kernel compiled for Pentium+, requires TSC feature!");
 #endif
diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Thu Jun 13 20:01:09 2002
+++ b/include/asm-i386/timex.h	Thu Jun 13 20:01:09 2002
@@ -40,7 +40,7 @@
=20
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC) || defined(CONFIG_TSC_DISABLE)
 	return 0;
 #else
 	unsigned long long ret;
diff -Nru a/include/net/pkt_sched.h b/include/net/pkt_sched.h
--- a/include/net/pkt_sched.h	Thu Jun 13 20:01:09 2002
+++ b/include/net/pkt_sched.h	Thu Jun 13 20:01:09 2002
@@ -12,7 +12,7 @@
 #include <linux/pkt_sched.h>
 #include <net/pkt_cls.h>
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
 #include <asm/msr.h>
 #endif
=20
@@ -253,7 +253,7 @@
=20
 #define PSCHED_US2JIFFIE(delay) (((delay)+psched_clock_per_hz-1)/psched_cl=
ock_per_hz)
=20
-#ifdef CONFIG_X86_TSC
+#if defined(CONFIG_X86_TSC)&&!defined(CONFIG_TSC_DISABLE)
=20
 #define PSCHED_GET_TIME(stamp) \
 ({ u64 __cur; \
diff -Nru a/include/net/profile.h b/include/net/profile.h
--- a/include/net/profile.h	Thu Jun 13 20:01:09 2002
+++ b/include/net/profile.h	Thu Jun 13 20:01:09 2002
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

--=-B/HhAsgr8RS/49rK+w/1--

