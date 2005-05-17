Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVEQFbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVEQFbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVEQFbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:31:42 -0400
Received: from graphe.net ([209.204.138.32]:62477 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261153AbVEQFbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:31:32 -0400
Date: Mon, 16 May 2005 22:31:25 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Linus Torvalds <torvalds@osdl.org>
cc: randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
In-Reply-To: <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.62.0505162225260.28022@graphe.net>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
 <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net>
 <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net>
 <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Linus Torvalds wrote:

> or something. You can even maje the Kconfig parts be a separate Kconfig.HZ
> file, and have both the x86 and x86-64 Kconfig files just include the
> common part (since it's a generic issue, not even PC-related: we might
> want to allow things like 60Hz frequencies for CONFIG_EMBEDDED etc, and
> these choices are really valid on any system that allows for the timer to
> be reprogrammed)

Ok. Here is the patch redone. The location for Kconfig.hz is in the
kernel directory since the other timer related stuff is there too:

---

Make the timer frequency selectable. The timer interrupt may cause bus
and memory contention in large NUMA systems since the interrupt occurs
on each processor HZ times per second.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.12-rc4/arch/i386/Kconfig
===================================================================
--- linux-2.6.12-rc4.orig/arch/i386/Kconfig	2005-05-17 02:19:55.000000000 +0000
+++ linux-2.6.12-rc4/arch/i386/Kconfig	2005-05-17 05:27:31.000000000 +0000
@@ -1133,6 +1133,8 @@
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
+source kernel/Kconfig.hz
+
 endmenu
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
Index: linux-2.6.12-rc4/include/asm-i386/param.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-i386/param.h	2005-05-17 05:08:56.000000000 +0000
+++ linux-2.6.12-rc4/include/asm-i386/param.h	2005-05-17 05:10:08.000000000 +0000
@@ -1,8 +1,10 @@
+#include <linux/config.h>
+
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif
Index: linux-2.6.12-rc4/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.12-rc4.orig/arch/x86_64/Kconfig	2005-05-17 02:19:54.000000000 +0000
+++ linux-2.6.12-rc4/arch/x86_64/Kconfig	2005-05-17 05:20:49.000000000 +0000
@@ -410,6 +410,8 @@
 
 	  If unsure, say Y. Only embedded should say N here.
 
+source kernel/Kconfig.hz
+
 endmenu
 
 #
Index: linux-2.6.12-rc4/include/asm-x86_64/param.h
===================================================================
--- linux-2.6.12-rc4.orig/include/asm-x86_64/param.h	2005-05-17 05:08:52.000000000 +0000
+++ linux-2.6.12-rc4/include/asm-x86_64/param.h	2005-05-17 05:09:42.000000000 +0000
@@ -1,9 +1,11 @@
+#include <linux/config.h>
+
 #ifndef _ASMx86_64_PARAM_H
 #define _ASMx86_64_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ            1000            /* Internal kernel timer frequency */
-# define USER_HZ       100          /* .. some user interfaces are in "ticks */
+# define HZ            CONFIG_HZ	/* Internal kernel timer frequency */
+# define USER_HZ       100		/* .. some user interfaces are in "ticks */
 #define CLOCKS_PER_SEC        (USER_HZ)       /* like times() */
 #endif
 
Index: linux-2.6.12-rc4/kernel/Kconfig.hz
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/kernel/Kconfig.hz	2005-05-17 05:24:01.000000000 +0000
@@ -0,0 +1,46 @@
+#
+# Timer Interrupt Frequency Configuration
+#
+
+choice
+	prompt "Timer frequency"
+	default HZ_250
+	help
+	 Allows the configuration of the timer frequency. It is customary
+	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
+	 beneficial for servers and NUMA systems that do not need to have
+	 a fast response for user interaction and that may experience bus
+	 contention and cacheline bounces as a result of timer interrupts.
+	 Note that the timer interrupt occurs on each processor in an SMP
+	 environment leading to NR_CPUS * HZ number of timer interrupts
+	 per second.
+
+
+	config HZ_100
+		bool "100 HZ"
+	help
+	  100 HZ is a typical choice for servers, SMP and NUMA systems
+	  with lots of processors that may show reduced performance if
+	  too many timer interrupts are occurring.
+
+	config HZ_250
+		bool "250 HZ"
+	help
+	 250 HZ is a good compromise choice allowing server performance
+	 while also showing good interactive responsiveness even
+	 on SMP and NUMA systems.
+
+	config HZ_1000
+		bool "1000 HZ"
+	help
+	 1000 HZ is the preferred choice for desktop systems and other
+	 systems requiring fast interactive responses to events.
+
+endchoice
+
+config HZ
+	int
+	default 100 if HZ_100
+	default 250 if HZ_250
+	default 1000 if HZ_1000
+
