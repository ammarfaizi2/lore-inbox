Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSKGTDJ>; Thu, 7 Nov 2002 14:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSKGTDJ>; Thu, 7 Nov 2002 14:03:09 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:55484 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261490AbSKGTCf>; Thu, 7 Nov 2002 14:02:35 -0500
Date: Thu, 7 Nov 2002 12:09:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Templates and tweaks (for size performance and more)
Message-ID: <20021107190910.GC6164@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the first cut at the Template things Matt Porter mentioned
originally and I've been talking about too.

The basic idea is that yes, you should not ask about $(large number) of
things to tweak the kernel to some specific application but by that same
token you shouldn't have to change the code directly (as when the next
update happens, it will conflict and maybe you'll miss the new place
that value is used, etc).

So what this does is try and provide a happy medium.  If something is
tweakable, say so when you write the code, provide a default and let
people tune it if they need to.  And while we're at it, lets make it
easy to change any number of these for a specific use and let the user
pick a new profile.

The following is vs current 2.5 BK and has been lightly tested on PPC
(and compiled on i386).  This creates the default files for all current
arches, and adapts ARM and ia64 as well to show how to override a
generic param with an arch-specific one (and removes
CONFIG_FORCE_MAX_ZONEORDER).

It also doesn't currently modify every arch/$(ARCH)/Kconfig right now.
I fully except that there would be additional arch-specific profiles
added, so I don't think this should be asked in a more common file like
lib/Kconfig or something.

I don't yet do CFLAG changes as that will require a bit more work
(CONFIG_xxx works now since we can directly include .config.  For
TWEAK_XXX to work some sed'ing will be required to generate a new file
for scripts/Makefile.build to include), and there's no doubt many other
things which can / could be tweaked.

Comments?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/arm/Kconfig 1.3 vs edited =====
--- 1.3/arch/arm/Kconfig	Sat Nov  2 11:35:13 2002
+++ edited/arch/arm/Kconfig	Thu Nov  7 09:42:32 2002
@@ -220,11 +220,6 @@
 	depends on ASSABET_NEPONSET || SA1100_ADSBITSY || SA1100_BADGE4 || SA1100_CONSUS || SA1100_GRAPHICSMASTER || SA1100_JORNADA720 || ARCH_LUBBOCK || SA1100_PFS168 || SA1100_PT_SYSTEM3 || SA1100_XP860
 	default y
 
-config FORCE_MAX_ZONEORDER
-	int
-	depends on ASSABET_NEPONSET || SA1100_ADSBITSY || SA1100_BADGE4 || SA1100_CONSUS || SA1100_GRAPHICSMASTER || SA1100_JORNADA720 || ARCH_LUBBOCK || SA1100_PFS168 || SA1100_PT_SYSTEM3 || SA1100_XP860
-	default "9"
-
 comment "Processor Type"
 
 # Figure out whether this system uses 26-bit or 32-bit CPUs.
===== arch/i386/Kconfig 1.5 vs edited =====
--- 1.5/arch/i386/Kconfig	Mon Nov  4 12:24:42 2002
+++ edited/arch/i386/Kconfig	Thu Nov  7 09:42:32 2002
@@ -720,6 +720,38 @@
 	  low memory.  Setting this option will put user-space page table
 	  entries in high memory.
 
+config TWEAK_PROFILES
+	bool "Pick a different set of defaults"
+	default n
+	help
+	  In the kernel, it is possible to easily change a number of
+	  parameters in the kernel.  Normally, defaults are picked which
+	  are the best for most machines.  There are times where one would
+	  want to change these values.  If you select this option, you can
+	  then pick a new set of defaults, and then further tweak that.
+
+	  For more details see <file:Documentation/tweak.txt>
+
+	  If in doubt, say N.
+
+choice
+	prompt "Type of kernel"
+	default TINY
+	depends on TWEAK_PROFILES
+	help
+	  It is possible to choose different sets of default values for
+	  different parts of the kernel, and to change these to better
+	  fit specific situations.
+
+config TINY
+	bool "Tiny"
+	help
+	  This option will select values for all parts of the kernel
+	  which allow parts of the subsystem to be tweaked which will
+	  result in a smaller kernel image.
+
+endchoice
+
 config MATH_EMULATION
 	bool "Math emulation"
 	---help---
===== arch/ia64/Kconfig 1.3 vs edited =====
--- 1.3/arch/ia64/Kconfig	Sat Nov  2 11:35:28 2002
+++ edited/arch/ia64/Kconfig	Thu Nov  7 09:42:32 2002
@@ -333,10 +333,6 @@
 	  don't understand what this means or are not a kernel hacker, just
 	  leave it at its default value ELF.
 
-config FORCE_MAX_ZONEORDER
-	int
-	default "18"
-
 config HUGETLB_PAGE
 	bool "IA-64 Huge TLB Page Support"
 
===== arch/ppc/Kconfig 1.7 vs edited =====
--- 1.7/arch/ppc/Kconfig	Thu Nov  7 09:32:09 2002
+++ edited/arch/ppc/Kconfig	Thu Nov  7 09:42:33 2002
@@ -656,6 +656,38 @@
 
 	  If in doubt, say N here.
 
+config TWEAK_PROFILES
+	bool "Pick a different set of defaults"
+	default n
+	help
+	  In the kernel, it is possible to easily change a number of
+	  parameters in the kernel.  Normally, defaults are picked which
+	  are the best for most machines.  There are times where one would
+	  want to change these values.  If you select this option, you can
+	  then pick a new set of defaults, and then further tweak that.
+
+	  For more details see <file:Documentation/tweak.txt>
+
+	  If in doubt, say N.
+
+choice
+	prompt "Type of kernel"
+	default TINY
+	depends on TWEAK_PROFILES
+	help
+	  It is possible to choose different sets of default values for
+	  different parts of the kernel, and to change these to better
+	  fit specific situations.
+
+config TINY
+	bool "Tiny"
+	help
+	  This option will select values for all parts of the kernel
+	  which allow parts of the subsystem to be tweaked which will
+	  result in a smaller kernel image.
+
+endchoice
+
 config MATH_EMULATION
 	bool "Math emulation"
 	depends on 4xx || 8xx
===== include/linux/mmzone.h 1.31 vs edited =====
--- 1.31/include/linux/mmzone.h	Thu Oct 31 15:48:19 2002
+++ edited/include/linux/mmzone.h	Thu Nov  7 09:42:33 2002
@@ -10,6 +10,7 @@
 #include <linux/wait.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
+#include <asm/tweaks.h>
 #include <asm/atomic.h>
 #ifdef CONFIG_DISCONTIGMEM
 #include <asm/numnodes.h>
@@ -19,11 +20,7 @@
 #endif
 
 /* Free memory management - zoned buddy allocator.  */
-#ifndef CONFIG_FORCE_MAX_ZONEORDER
-#define MAX_ORDER 11
-#else
-#define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
-#endif
+#define MAX_ORDER TWEAK_MAX_ORDER
 
 struct free_area {
 	struct list_head	free_list;
===== include/net/af_unix.h 1.2 vs edited =====
--- 1.2/include/net/af_unix.h	Mon Feb 11 00:06:52 2002
+++ edited/include/net/af_unix.h	Thu Nov  7 09:42:33 2002
@@ -1,12 +1,15 @@
 #ifndef __LINUX_NET_AFUNIX_H
 #define __LINUX_NET_AFUNIX_H
+
+#include <asm/tweaks.h>
+
 extern void unix_proto_init(struct net_proto *pro);
 extern void unix_inflight(struct file *fp);
 extern void unix_notinflight(struct file *fp);
 typedef struct sock unix_socket;
 extern void unix_gc(void);
 
-#define UNIX_HASH_SIZE	256
+#define UNIX_HASH_SIZE	TWEAK_UNIX_HASH_SIZE
 
 extern unix_socket *unix_socket_table[UNIX_HASH_SIZE+1];
 extern rwlock_t unix_table_lock;
===== include/net/udp.h 1.7 vs edited =====
--- 1.7/include/net/udp.h	Sun Oct 20 09:15:38 2002
+++ edited/include/net/udp.h	Thu Nov  7 09:42:33 2002
@@ -25,8 +25,9 @@
 #include <linux/udp.h>
 #include <linux/ip.h>
 #include <net/sock.h>
+#include <asm/tweaks.h>
 
-#define UDP_HTABLE_SIZE		128
+#define UDP_HTABLE_SIZE		TWEAK_UDP_HTABLE_SIZE
 
 /* udp.c: This needs to be shared by v4 and v6 because the lookup
  *        and hashing code needs to work with different AF's yet
===== init/main.c 1.77 vs edited =====
--- 1.77/init/main.c	Tue Nov  5 08:34:37 2002
+++ edited/init/main.c	Thu Nov  7 09:42:33 2002
@@ -34,6 +34,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 
+#include <asm/tweaks.h>
 #include <asm/io.h>
 #include <asm/bugs.h>
 
@@ -431,7 +432,7 @@
 	proc_caches_init();
 	security_scaffolding_startup();
 	buffer_init();
-	vfs_caches_init(num_physpages);
+	vfs_caches_init(TWEAK_VFS_CACHE_AVAILMEM);
 	radix_tree_init();
 	signals_init();
 	populate_rootfs();
===== net/ipv4/route.c 1.29 vs edited =====
--- 1.29/net/ipv4/route.c	Tue Nov  5 14:56:09 2002
+++ edited/net/ipv4/route.c	Thu Nov  7 09:42:33 2002
@@ -94,6 +94,7 @@
 #include <net/arp.h>
 #include <net/tcp.h>
 #include <net/icmp.h>
+#include <asm/tweaks.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
@@ -2499,7 +2500,7 @@
 	if (!ipv4_dst_ops.kmem_cachep)
 		panic("IP: failed to allocate ip_dst_cache\n");
 
-	goal = num_physpages >> (26 - PAGE_SHIFT);
+	goal = num_physpages >> ((26 + TWEAK_IPV4_NETHASH_MOD) - PAGE_SHIFT);
 
 	for (order = 0; (1UL << order) < goal; order++)
 		/* NOTHING */;
===== net/ipv4/tcp.c 1.31 vs edited =====
--- 1.31/net/ipv4/tcp.c	Fri Nov  1 05:15:17 2002
+++ edited/net/ipv4/tcp.c	Thu Nov  7 09:42:33 2002
@@ -260,6 +260,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
+#include <asm/tweaks.h>
 
 int sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
 
@@ -2611,9 +2612,11 @@
 	 * The methodology is similar to that of the buffer cache.
 	 */
 	if (num_physpages >= (128 * 1024))
-		goal = num_physpages >> (21 - PAGE_SHIFT);
+		goal = num_physpages >> ((21 + TWEAK_IPV4_NETHASH_MOD)
+				- PAGE_SHIFT);
 	else
-		goal = num_physpages >> (23 - PAGE_SHIFT);
+		goal = num_physpages >> ((23 + TWEAK_IPV4_NETHASH_MOD)
+				- PAGE_SHIFT);
 
 	for (order = 0; (1UL << order) < goal; order++)
 		;
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-alpha/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-alpha/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-alpha/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-alpha/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-arm/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-arm/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,18 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-arm/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-arm/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,39 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+
+/* This is the number of free areas per zone to manage, but the max
+ * number determines the maximum order of a page allocation request
+ * as well. */
+/* Default: 11 */
+#if defined(ASSABET_NEPONSET0) || defined(SA1100_ADSBITSY) || 		\
+	defined(SA1100_BADGE4) || defined(SA1100_CONSUS) || 		\
+	defined(SA1100_GRAPHICSMASTER) || defined(SA1100_JORNADA720) ||	\
+	defined(ARCH_LUBBOCK) || defined(SA1100_PFS168) ||		\
+	defined(SA1100_PT_SYSTEM3) || defined(SA1100_XP860)
+#undef TWEAK_MAX_ORDER
+#define TWEAK_MAX_ORDER		9
+#endif
+
+#include <asm/custom_tweaks.h>
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-cris/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-cris/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-cris/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-cris/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-generic/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-generic/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,31 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This files provides 'tweaked' values for various parts of the kernel
+ * which represent the default values for that particular section of code.
+ *
+ * < minimal GPL v2 notice here >
+ */
+
+/* The size the each of the VFS hash tables. */
+/* Default: num_physpages */
+#define TWEAK_VFS_CACHE_AVAILMEM	num_physpages
+
+/* The size of the UNIX socket hash table. */
+/* Default: 256 */
+#define TWEAK_UNIX_HASH_SIZE		256
+
+/* The size of the UDP socket hash table. */
+/* Default: 128 */
+#define TWEAK_UDP_HTABLE_SIZE		128
+
+/* Various parts of the IPv4 code allocate hash tables of a various sizes.
+ * We do not want to tweak their size in any way. */
+/* Default: 0 */
+#define TWEAK_IPV4_NETHASH_MOD		0
+
+/* This is the number of free areas per zone to manage, but the max
+ * number determines the maximum order of a page allocation request
+ * as well. */
+/* Default: 11 */
+#define TWEAK_MAX_ORDER			11
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-generic/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,30 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This files provides 'tweaked' values for various parts of the kernel
+ * which represent values which would produce a smaller kernel image.
+ *
+ * < minimal GPL v2 notice here >
+ */
+
+/* The size the each of the VFS hash tables. */
+/* Default: num_physpages */
+#undef TWEAK_VFS_CACHE_AVAILMEM
+#define TWEAK_VFS_CACHE_AVAILMEM	1
+
+/* The size of the UNIX socket hash table. */
+/* Default: 256 */
+#undef TWEAK_UNIX_HASH_SIZE
+#define TWEAK_UNIX_HASH_SIZE		16
+
+/* The size of the UDP socket hash table. */
+/* Default: 128 */
+#undef TWEAK_UDP_HTABLE_SIZE
+#define TWEAK_UDP_HTABLE_SIZE		8
+
+/* Various parts of the IPv4 code allocate hash tables of a various sizes.
+ * This value is always used with a shift, and we want to reduce the size
+ * by 16. */
+/* Default: 0 */
+#undef TWEAK_IPV4_NETHASH_MOD
+#define TWEAK_IPV4_NETHASH_MOD		4
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-i386/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-i386/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-i386/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-i386/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ia64/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ia64/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,18 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ia64/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ia64/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,33 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+
+/* This is the number of free areas per zone to manage, but the max
+ * number determines the maximum order of a page allocation request
+ * as well. */
+/* Default: 11 */
+#undef TWEAK_MAX_ORDER
+#define TWEAK_MAX_ORDER		18
+
+#include <asm/custom_tweaks.h>
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68k/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68k/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68k/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68k/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68knommu/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68knommu/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68knommu/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-m68knommu/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips64/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips64/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips64/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-mips64/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-parisc/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-parisc/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-parisc/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-parisc/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc64/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc64/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc64/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-ppc64/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390x/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390x/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390x/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-s390x/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sh/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sh/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sh/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sh/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc64/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc64/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc64/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-sparc64/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-um/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-um/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-um/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-um/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-v850/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-v850/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-v850/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-v850/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-x86_64/custom_tweaks.h	2002-11-07 09:44:49.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ *
+ * This file is the included last in <asm/tweaks.h> and contains the
+ * authorative value for any TWEAK value.  If you wish to change any
+ * TWEAK value, do so here.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_CUSTOM_TWEAKS_H__
+#define __ASM_CUSTOM_TWEAKS_H__
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-x86_64/default_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,17 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the default values for the various parts of
+ * the kernel which can be tweaked at compile time.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_DEFAULT_TWEAKS_H__
+#define __ASM_DEFAULT_TWEAKS_H__
+
+/* Get the generic defines. */
+#include <asm-generic/default_tweaks.h>
+
+/* Now define arch-specific defaults. */
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-x86_64/tiny_tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,19 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * This file represents the values for the various parts of
+ * the kernel which can be tweaked at compile time which result
+ * in a smaller kernel image.
+ *
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TINY_TWEAKS_H__
+#define __ASM_TINY_TWEAKS_H__
+
+/* Get the default values. */
+#include <asm-generic/tiny_tweaks.h>
+
+/* Now, redefine things as needed. */
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/include/asm-x86_64/tweaks.h	2002-11-07 09:42:33.000000000 -0700
@@ -0,0 +1,26 @@
+/*
+ * Tom Rini <trini@kernel.crashing.org>
+ *
+ * Inside the kernel, there are numerous values which can be tweaked
+ * at compile time to get a kernel which is smaller, performs better,
+ * or otherwise fits into a specific problem better.  Depending on what
+ * the user selects, we get a different set of values, which can be further
+ * tweaked as the user sees fit.
+ * 
+ * < minimal GPL v2 notice goes here >
+ */
+
+#ifndef __ASM_TWEAKS_H__
+#define __ASM_TWEAKS_H__
+
+/* By default, we pick the defines in the default_tweaks.h file.  We also
+ * always include custom_tweaks.h.  We conditionally pick other files as
+ * well to better make the kernel fit the situation.
+ */
+#include <asm/default_tweaks.h>
+#if defined(CONFIG_TINY)
+#include <asm/tiny_tweaks.h>
+#endif
+#include <asm/custom_tweaks.h>
+
+#endif
--- /dev/null	1969-12-31 17:00:00.000000000 -0700
+++ linuxppc-2.5/Documentation/tweak.txt	2002-11-07 08:26:18.000000000 -0700
@@ -0,0 +1,43 @@
+How to tweak the kernel, using the TWEAK infrastructure.
+		Tom Rini <trini@kernel.crashing.org>
+
+This document is divided into two sections.  The first section is for
+how users can use the TWEAK infrastructure to make the kernel better fit
+their custom application.  The second section is aimed at coders to
+suggest how to make use of this when writing new code, or reviewing
+existing code.
+
+	The TWEAK system was designed to be easy to use, and hopefully it is.
+There are two types of tweakable parameters, generic ones and arch-specific
+ones.  Everything which can be tweaked, and is in common code is initially
+defined in include/asm-generic/default_tweaks.h.  There is currently another
+file, include/asm-generic/tiny_tweaks.h which re-defines values found in 
+include/asm-generic/tiny_tweaks.h so that a smaller kernel image is produced.
+	It is possible that specific archs will provide additional,
+arch-specific configurations.  Which brings us to the arch specific portion.
+Every arch has an include/asm-$(ARCH)/tweaks.h, which includes
+<asm/default_tweaks.h>, possibly other arch-specific tweak headers, and 
+<asm/custom_tweaks.h>.  This file is also where arches can re-tweak
+common tweaks if needed.  For example, ARM and ia64 will redefine
+TWEAK_MAX_ORDER as they, on a platform or arch-specific basis need a different
+value.
+	The <asm/custom_tweaks.h> file is very important, as this is where
+the per-user tweaking happens.  This file is always included at the end of
+<asm/tweaks.h>, so regardless of what is in any other of the tweak headers
+included, any value can still be overridden by the user.
+
+	The TWEAK system should also be easy to use for the coders as well.
+If some subsystem is using a constant somewhere, ask yourself if you could
+see any reason that someone might have to want to change it.  If you can think
+of one, and this is common code, add something akin to the following to
+include/asm-generic/default_tweaks.h:
+/* In the foo subsystem, we use BAR to do baz. */
+/* Default: 16 */
+#define TWEAK_BAR	16
+/* Or even TWEAK_FOO_BAR, whichever makes sense */
+And that's it.  If you know that it could impact size, or one of the other
+existing set of generic templates, you can also change those templates:
+in include/asm-generic/tiny_tweaks.h:
+/* In the foo subsystem, we use BAR to do baz. */
+/* Default: 16 */
+#define TWEAK_BAR	4
