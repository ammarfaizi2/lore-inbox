Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVEXKmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVEXKmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVEXKkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:40:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35546 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261961AbVEXKbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:31:10 -0400
Date: Tue, 24 May 2005 12:30:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [patch] consolidate PREEMPT options into kernel/Kconfig.preempt
Message-ID: <20050524103047.GA26586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


any objections? This is against the tail of the scheduler-patchset in 
-mm. For now i only included architectures that support the full range 
of preemption features - other architectures can still cherry-pick them 
if they want to. (I did not do a Kconfig.sched, because other scheduler 
features are much more hardware-dependent.)

--

this patch consolidates the CONFIG_PREEMPT and CONFIG_PREEMPT_BKL 
preemption options into kernel/Kconfig.preempt. This, besides reducing 
source-code, also enables more centralized tweaking of preemption 
related options.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/Kconfig      |   23 +----------------------
 arch/ppc64/Kconfig     |   21 +--------------------
 arch/x86_64/Kconfig    |   29 ++---------------------------
 kernel/Kconfig.preempt |   24 ++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 69 deletions(-)

--- linux/kernel/Kconfig.preempt.orig
+++ linux/kernel/Kconfig.preempt
@@ -0,0 +1,24 @@
+
+config PREEMPT
+	bool "Preemptible Kernel"
+	help
+	  This option reduces the latency of the kernel when reacting to
+	  real-time or interactive events by allowing a low priority process to
+	  be preempted even if it is in kernel mode executing a system call.
+	  This allows applications to run more reliably even when the system is
+	  under load.
+
+	  Say Y here if you are building a kernel for a desktop, embedded
+	  or real-time system.  Say N if you are unsure.
+
+config PREEMPT_BKL
+	bool "Preempt The Big Kernel Lock"
+	depends on PREEMPT
+	default y
+	help
+	  This option reduces the latency of the kernel by making the
+	  big kernel lock preemptible.
+
+	  Say Y here if you are building a kernel for a desktop system.
+	  Say N if you are unsure.
+
--- linux/arch/x86_64/Kconfig.orig
+++ linux/arch/x86_64/Kconfig
@@ -207,33 +207,6 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	---help---
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load. On contrary it may also break your drivers and add
-	  priority inheritance problems to your system. Don't select it if
-	  you rely on a stable system or have slightly obscure hardware.
-	  It's also not very well tested on x86-64 currently.
-	  You have been warned.
-
-	  Say Y here if you are feeling brave and building a kernel for a
-	  desktop, embedded or real-time system.  Say N if you are unsure.
-
-config PREEMPT_BKL
-	bool "Preempt The Big Kernel Lock"
-	depends on PREEMPT
-	default y
-	help
-	  This option reduces the latency of the kernel by making the
-	  big kernel lock preemptible.
-
-	  Say Y here if you are building a kernel for a desktop system.
-	  Say N if you are unsure.
-
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
@@ -244,6 +217,8 @@ config SCHED_SMT
 	  cost of slightly increased overhead in some places. If unsure say
 	  N here.
 
+ource "kernel/Kconfig.preempt"
+
 config K8_NUMA
        bool "K8 NUMA support"
        select NUMA
--- linux/arch/ppc64/Kconfig.orig
+++ linux/arch/ppc64/Kconfig
@@ -268,26 +268,7 @@ config SCHED_SMT
 	  when dealing with POWER5 cpus at a cost of slightly increased
 	  overhead in some places. If unsure say N here.
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
-
-config PREEMPT_BKL
-	bool "Preempt The Big Kernel Lock"
-	depends on PREEMPT
-	default y
-	help
-	  This option reduces the latency of the kernel by making the
-	  big kernel lock preemptible.
-
-	  Say Y here if you are building a kernel for a desktop system.
-	  Say N if you are unsure.
+source "kernel/Kconfig.preempt"
 
 config EEH
 	bool "PCI Extended Error Handling (EEH)" if EMBEDDED
--- linux/arch/i386/Kconfig.orig
+++ linux/arch/i386/Kconfig
@@ -510,28 +510,7 @@ config SCHED_SMT
 	  cost of slightly increased overhead in some places. If unsure say
 	  N here.
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
-
-	  Say Y here if you are building a kernel for a desktop, embedded
-	  or real-time system.  Say N if you are unsure.
-
-config PREEMPT_BKL
-	bool "Preempt The Big Kernel Lock"
-	depends on PREEMPT
-	default y
-	help
-	  This option reduces the latency of the kernel by making the
-	  big kernel lock preemptible.
-
-	  Say Y here if you are building a kernel for a desktop system.
-	  Say N if you are unsure.
+source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
