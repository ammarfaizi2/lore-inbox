Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLQGIn>; Tue, 17 Dec 2002 01:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLQGIn>; Tue, 17 Dec 2002 01:08:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264702AbSLQGI3>;
	Tue, 17 Dec 2002 01:08:29 -0500
Date: Mon, 16 Dec 2002 22:11:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] move LOG_BUF_SIZE to header file
In-Reply-To: <3DF64369.81F288FE@digeo.com>
Message-ID: <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Andrew Morton wrote:

| "Randy.Dunlap" wrote:
| >
| > I'd like to see LOG_BUF_LEN from kernel/printk.c moved to a header file
| > so that some non-kernel (kernel-mode) tools can know the value being
| > used (tools like kmsgdump or lkcd etc.).
| >
| > This patch moves LOG_BUF_LEN to include/linux/kernel.h .
| > Or it could go to a separate (new) header file...
| >
| > ...
| > -#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
| > -#define LOG_BUF_LEN    (65536)
| > -#elif defined(CONFIG_ARCH_S390)
| > -#define LOG_BUF_LEN    (131072)
| > -#elif defined(CONFIG_SMP)
| > -#define LOG_BUF_LEN    (32768)
| > -#else
| > -#define LOG_BUF_LEN    (16384)                 /* This must be a power of two */
| > -#endif
| > -
| > -#define LOG_BUF_MASK   (LOG_BUF_LEN-1)
|
| It's probably better to move all this gunk into the config
| system.  Then your app can use CONFIG_LOG_BUF_LEN, too.

Hi,  [after some delay]

I did think of that and agree that it makes some sense.
I don't really mind how it's done, so if that will help move along
the change, I'm for it.

I want to thank Roman Zippel for helping me thru this and with
enabling Kconfig with code to support this (that was already
in progress).  This patch requires Kconfig changes in 2.5.52.

Here's what I have, tested with
  make ARCH=<all 20 of them in succession> menuconfig
This puts the 'Kernel log buffer size' under Kernel hacking.
General Setup was too early for it since this needs processor
type/SMP info.

One other thing that I considered doing was using a common
Kconfig file for all 20 arch'es by adding a
  source "kernel/Kconfig"
at the end of each <arch>/Kconfig file.  This would provide
a common "General setup (more)" that could be used after most
config options are set instead of near the top of the menu.
Does that make sense to anybody?

More comments, feedback?

Thanks,
~Randy


patch_name:	logbuf-2552b.patch
patch_version:	2002.12.16
author:		Randy Dunlap <rddunlap@osdl.org>
description:	change LOG_BUF_SIZE to a config option
product:	linux
product_versions: 2.5.52
changelog:
URL:
requires:	kconfig in 2.5.52
conflicts:
diffstat:
 arch/alpha/Kconfig     |   37 +++++++++++++++++++++++++++++++++++++
 arch/arm/Kconfig       |   37 +++++++++++++++++++++++++++++++++++++
 arch/cris/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/i386/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/ia64/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/m68k/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/m68knommu/Kconfig |   37 +++++++++++++++++++++++++++++++++++++
 arch/mips/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/mips64/Kconfig    |   37 +++++++++++++++++++++++++++++++++++++
 arch/parisc/Kconfig    |   37 +++++++++++++++++++++++++++++++++++++
 arch/ppc/Kconfig       |   37 +++++++++++++++++++++++++++++++++++++
 arch/ppc64/Kconfig     |   37 +++++++++++++++++++++++++++++++++++++
 arch/s390/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/s390x/Kconfig     |   37 +++++++++++++++++++++++++++++++++++++
 arch/sh/Kconfig        |   37 +++++++++++++++++++++++++++++++++++++
 arch/sparc/Kconfig     |   37 +++++++++++++++++++++++++++++++++++++
 arch/sparc64/Kconfig   |   37 +++++++++++++++++++++++++++++++++++++
 arch/um/Kconfig        |   37 +++++++++++++++++++++++++++++++++++++
 arch/v850/Kconfig      |   37 +++++++++++++++++++++++++++++++++++++
 arch/x86_64/Kconfig    |   37 +++++++++++++++++++++++++++++++++++++
 kernel/printk.c        |   34 ++++++++++++----------------------
 21 files changed, 752 insertions(+), 22 deletions(-)

--- ./arch/i386/Kconfig%LOGBUF	Sun Dec 15 18:07:47 2002
+++ ./arch/i386/Kconfig	Sun Dec 15 20:45:09 2002
@@ -1573,6 +1573,43 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC
--- ./kernel/printk.c%LOGBUF	Sun Dec 15 18:08:24 2002
+++ ./kernel/printk.c	Sun Dec 15 20:49:49 2002
@@ -30,17 +30,7 @@

 #include <asm/uaccess.h>

-#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
-#elif defined(CONFIG_ARCH_S390)
-#define LOG_BUF_LEN	(131072)
-#elif defined(CONFIG_SMP)
-#define LOG_BUF_LEN	(32768)
-#else
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
-#endif
-
-#define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+#define LOG_BUF_MASK	(CONFIG_LOG_BUF_LEN-1)

 #ifndef arch_consoles_callable
 #define arch_consoles_callable() (1)
@@ -79,11 +69,11 @@
  */
 static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;

-static char log_buf[LOG_BUF_LEN];
+static char log_buf[CONFIG_LOG_BUF_LEN];
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])

 /*
- * The indices into log_buf are not constrained to LOG_BUF_LEN - they
+ * The indices into log_buf are not constrained to CONFIG_LOG_BUF_LEN - they
  * must be masked before subscripting
  */
 static unsigned long log_start;			/* Index into log_buf: next char to be read by syslog() */
@@ -219,8 +209,8 @@
 		if (error)
 			goto out;
 		count = len;
-		if (count > LOG_BUF_LEN)
-			count = LOG_BUF_LEN;
+		if (count > CONFIG_LOG_BUF_LEN)
+			count = CONFIG_LOG_BUF_LEN;
 		spin_lock_irq(&logbuf_lock);
 		if (count > logged_chars)
 			count = logged_chars;
@@ -235,7 +225,7 @@
 		 */
 		for(i=0;i < count;i++) {
 			j = limit-1-i;
-			if (j+LOG_BUF_LEN < log_end)
+			if (j+CONFIG_LOG_BUF_LEN < log_end)
 				break;
 			c = LOG_BUF(j);
 			spin_unlock_irq(&logbuf_lock);
@@ -321,7 +311,7 @@
 	if (msg_log_level < console_loglevel && console_drivers && start != end) {
 		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
 			/* wrapped write */
-			__call_console_drivers(start & LOG_BUF_MASK, LOG_BUF_LEN);
+			__call_console_drivers(start & LOG_BUF_MASK, CONFIG_LOG_BUF_LEN);
 			__call_console_drivers(0, end & LOG_BUF_MASK);
 		} else {
 			__call_console_drivers(start, end);
@@ -384,11 +374,11 @@
 {
 	LOG_BUF(log_end) = c;
 	log_end++;
-	if (log_end - log_start > LOG_BUF_LEN)
-		log_start = log_end - LOG_BUF_LEN;
-	if (log_end - con_start > LOG_BUF_LEN)
-		con_start = log_end - LOG_BUF_LEN;
-	if (logged_chars < LOG_BUF_LEN)
+	if (log_end - log_start > CONFIG_LOG_BUF_LEN)
+		log_start = log_end - CONFIG_LOG_BUF_LEN;
+	if (log_end - con_start > CONFIG_LOG_BUF_LEN)
+		con_start = log_end - CONFIG_LOG_BUF_LEN;
+	if (logged_chars < CONFIG_LOG_BUF_LEN)
 		logged_chars++;
 }

--- ./arch/m68k/Kconfig%LOGBUF	Sun Dec 15 18:08:11 2002
+++ ./arch/m68k/Kconfig	Mon Dec 16 21:07:31 2002
@@ -2338,6 +2338,43 @@
 	bool "Verbose BUG() reporting"
 	depends on DEBUG_KERNEL

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/sparc/Kconfig%LOGBUF	Sun Dec 15 18:07:42 2002
+++ ./arch/sparc/Kconfig	Mon Dec 16 21:17:40 2002
@@ -1414,6 +1414,43 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/sparc64/Kconfig%LOGBUF	Sun Dec 15 18:08:16 2002
+++ ./arch/sparc64/Kconfig	Mon Dec 16 21:18:14 2002
@@ -1702,6 +1702,43 @@
 	depends on STACK_DEBUG
 	default y

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/ppc/Kconfig%LOGBUF	Sun Dec 15 18:08:23 2002
+++ ./arch/ppc/Kconfig	Mon Dec 16 21:10:24 2002
@@ -1866,6 +1866,43 @@
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || GT64260 || LOPEC || MCPN765 || PPLUS || PRPMC800 || SANDPOINT || ZX4500

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/m68knommu/Kconfig%LOGBUF	Sun Dec 15 18:08:13 2002
+++ ./arch/m68knommu/Kconfig	Mon Dec 16 21:07:56 2002
@@ -751,6 +751,43 @@
 	help
 	  Disable the CPU's BDM signals.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/alpha/Kconfig%LOGBUF	Sun Dec 15 18:08:14 2002
+++ ./arch/alpha/Kconfig	Mon Dec 16 21:00:23 2002
@@ -1022,6 +1022,43 @@
 	  verbose debugging messages.  If you suspect a semaphore problem or a
 	  kernel hacker asks for this option then say Y.  Otherwise say N.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/cris/Kconfig%LOGBUF	Sun Dec 15 18:08:19 2002
+++ ./arch/cris/Kconfig	Mon Dec 16 21:06:09 2002
@@ -751,6 +751,43 @@
 	depends on PROFILE
 	default "2"

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/mips/Kconfig%LOGBUF	Sun Dec 15 18:07:56 2002
+++ ./arch/mips/Kconfig	Mon Dec 16 21:08:44 2002
@@ -1276,6 +1276,43 @@
 	depends on SMP
 	default "32"

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/x86_64/Kconfig%LOGBUF	Sun Dec 15 18:08:14 2002
+++ ./arch/x86_64/Kconfig	Mon Dec 16 21:20:19 2002
@@ -692,6 +692,43 @@
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/ppc64/Kconfig%LOGBUF	Sun Dec 15 18:08:09 2002
+++ ./arch/ppc64/Kconfig	Mon Dec 16 21:10:33 2002
@@ -551,6 +551,43 @@
 	bool "Include PPCDBG realtime debugging"
 	depends on DEBUG_KERNEL

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/um/Kconfig%LOGBUF	Sun Dec 15 18:07:57 2002
+++ ./arch/um/Kconfig	Mon Dec 16 21:18:35 2002
@@ -169,5 +169,42 @@
 	bool "Enable gcov support"
 	depends on DEBUGSYM

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

--- ./arch/arm/Kconfig%LOGBUF	Sun Dec 15 18:08:09 2002
+++ ./arch/arm/Kconfig	Mon Dec 16 21:05:34 2002
@@ -1220,6 +1220,43 @@
 	  output to the second serial port on these devices.  Saying N will
 	  cause the debug messages to appear on the first serial port.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/parisc/Kconfig%LOGBUF	Sun Dec 15 18:08:11 2002
+++ ./arch/parisc/Kconfig	Mon Dec 16 21:09:21 2002
@@ -415,6 +415,43 @@
 	  symbolic stack backtraces. This increases the size of the kernel
 	  somewhat, as all symbols have to be loaded into the kernel image.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/ia64/Kconfig%LOGBUF	Sun Dec 15 18:08:21 2002
+++ ./arch/ia64/Kconfig	Mon Dec 16 21:07:20 2002
@@ -886,6 +886,43 @@
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/mips64/Kconfig%LOGBUF	Sun Dec 15 18:07:52 2002
+++ ./arch/mips64/Kconfig	Mon Dec 16 21:09:00 2002
@@ -719,6 +719,43 @@
 	depends on SMP
 	default "64"

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/s390x/Kconfig%LOGBUF	Sun Dec 15 18:07:59 2002
+++ ./arch/s390x/Kconfig	Mon Dec 16 21:10:59 2002
@@ -338,6 +338,43 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/v850/Kconfig%LOGBUF	Sun Dec 15 18:07:56 2002
+++ ./arch/v850/Kconfig	Mon Dec 16 21:19:06 2002
@@ -444,6 +444,43 @@
 	help
 	  Disable the CPU's BDM signals.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/sh/Kconfig%LOGBUF	Sun Dec 15 18:08:23 2002
+++ ./arch/sh/Kconfig	Mon Dec 16 21:17:31 2002
@@ -1268,6 +1268,43 @@
 	  when the kernel may crash or hang before the serial console is
 	  initialised. If unsure, say N.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"
--- ./arch/s390/Kconfig%LOGBUF	Sun Dec 15 18:07:54 2002
+++ ./arch/s390/Kconfig	Mon Dec 16 21:10:49 2002
@@ -329,6 +329,43 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_128KB if ARCH_S390
+	default LOG_BUF_64KB if X86_NUMAQ || IA64
+	default LOG_BUF_32KB if SMP
+	default LOG_BUF_16KB
+	help
+	  Select kernel log buffer size from this list.
+	  Defaults:  16 KB for uniprocessor
+	             32 KB for SMP
+		     64 KB for x86 NUMAQ or IA-64
+		     128 KB for S/390
+
+config LOG_BUF_128KB
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_64KB
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_32KB
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_16KB
+	bool "16 KB"
+
+endchoice
+
+config LOG_BUF_LEN
+	int
+	default 131072 if LOG_BUF_128KB
+	default 65536 if LOG_BUF_64KB
+	default 32768 if LOG_BUF_32KB
+	default 16384 if LOG_BUF_16KB
+
 endmenu

 source "security/Kconfig"

