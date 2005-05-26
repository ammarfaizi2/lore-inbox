Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVEZGsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVEZGsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEZGsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:48:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:49059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261226AbVEZGsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:48:16 -0400
Date: Wed, 25 May 2005 23:47:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.12-rc5-mm1
Message-Id: <20050525234717.261beb48.akpm@osdl.org>
In-Reply-To: <175590000.1117089446@[10.10.2.4]>
References: <175590000.1117089446@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Build failure on numaq:
>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
> 
>  In file included from include/linux/sched.h:12,
>                   from arch/i386/kernel/asm-offsets.c:7:
>  include/linux/jiffies.h:42:3: #error You lose.

You lost!  CONFIG_HZ didn't get set.

Something obviously went wrong in the magic in kernel/Kconfig.hz.  Wanna do
`grep HZ .config' and see if you can work out why it broke?

Roman, is there a better way of doing the below?


From: Christoph Lameter <christoph@lameter.com>

Make the timer frequency selectable. The timer interrupt may cause bus
and memory contention in large NUMA systems since the interrupt occurs
on each processor HZ times per second.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/Kconfig          |    2 +
 arch/x86_64/Kconfig        |    2 +
 include/asm-i386/param.h   |    4 ++-
 include/asm-x86_64/param.h |    6 +++--
 kernel/Kconfig.hz          |   46 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 3 deletions(-)

diff -puN arch/i386/Kconfig~i386-selectable-frequency-of-the-timer-interrupt arch/i386/Kconfig
--- 25/arch/i386/Kconfig~i386-selectable-frequency-of-the-timer-interrupt	2005-05-23 19:41:04.000000000 -0700
+++ 25-akpm/arch/i386/Kconfig	2005-05-23 19:41:04.000000000 -0700
@@ -1116,6 +1116,8 @@ config APM_REAL_MODE_POWER_OFF
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
+source kernel/Kconfig.hz
+
 endmenu
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
diff -puN arch/x86_64/Kconfig~i386-selectable-frequency-of-the-timer-interrupt arch/x86_64/Kconfig
--- 25/arch/x86_64/Kconfig~i386-selectable-frequency-of-the-timer-interrupt	2005-05-23 19:41:04.000000000 -0700
+++ 25-akpm/arch/x86_64/Kconfig	2005-05-23 19:41:04.000000000 -0700
@@ -401,6 +401,8 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+source kernel/Kconfig.hz
+
 endmenu
 
 #
diff -puN include/asm-i386/param.h~i386-selectable-frequency-of-the-timer-interrupt include/asm-i386/param.h
--- 25/include/asm-i386/param.h~i386-selectable-frequency-of-the-timer-interrupt	2005-05-23 19:41:04.000000000 -0700
+++ 25-akpm/include/asm-i386/param.h	2005-05-23 19:41:04.000000000 -0700
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
diff -puN include/asm-x86_64/param.h~i386-selectable-frequency-of-the-timer-interrupt include/asm-x86_64/param.h
--- 25/include/asm-x86_64/param.h~i386-selectable-frequency-of-the-timer-interrupt	2005-05-23 19:41:04.000000000 -0700
+++ 25-akpm/include/asm-x86_64/param.h	2005-05-23 19:41:04.000000000 -0700
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
 
diff -puN /dev/null kernel/Kconfig.hz
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/kernel/Kconfig.hz	2005-05-23 19:41:04.000000000 -0700
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
_

