Return-Path: <linux-kernel-owner+w=401wt.eu-S1763005AbWLKSdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763005AbWLKSdd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763007AbWLKSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:33:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53195 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763005AbWLKSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:33:32 -0500
Date: Mon, 11 Dec 2006 10:33:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, ak@muc.de
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, shai@scalex86.org,
       Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       kiran@scalex86.org
Subject: Re: [stable] [patch 31/32] x86_64: fix boot hang due to nmi watchdog init code
Message-ID: <20061211183323.GC1397@sequoia.sous-sol.org>
References: <20061208235751.890503000@sous-sol.org> <20061209000328.188464000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209000328.188464000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------

replaced with upstream version, which is slightly changed by Andi.
--

From: Ravikiran G Thirumalai <kiran@scalex86.org>

2.6.19  stopped booting (or booted based on build/config) on our x86_64
systems due to a bug introduced in 2.6.19.  check_nmi_watchdog schedules an
IPI on all cpus to  busy wait on a flag, but fails to set the busywait
flag if NMI functionality is disabled.  This causes the secondary cpus
to spin in an endless loop, causing the kernel bootup to hang.
Depending upon the build, the  busywait flag got overwritten (stack variable)
and caused  the kernel to bootup on certain builds.  Following patch fixes
the bug by setting the busywait flag before returning from check_nmi_watchdog.
I guess using a stack variable is not good here as the calling function could
potentially return while the busy wait loop is still spinning on the flag.

AK: I redid the patch significantly to be cleaner

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/nmi.c   |    8 ++++----
 arch/x86_64/kernel/nmi.c |    9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

--- linux-2.6.19.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.19/arch/i386/kernel/nmi.c
@@ -192,6 +192,8 @@ static __cpuinit inline int nmi_known_cp
 	return 0;
 }
 
+static int endflag __initdata = 0;
+
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -199,7 +201,6 @@ static __cpuinit inline int nmi_known_cp
  */
 static __init void nmi_cpu_busy(void *data)
 {
-	volatile int *endflag = data;
 	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
@@ -207,14 +208,13 @@ static __init void nmi_cpu_busy(void *da
 	   pause instruction. On a real HT machine this is fine because
 	   all other CPUs are busy with "useless" delay loops and don't
 	   care if they get somewhat less cycles. */
-	while (*endflag == 0)
-		barrier();
+	while (endflag == 0)
+		mb();
 }
 #endif
 
 static int __init check_nmi_watchdog(void)
 {
-	volatile int endflag = 0;
 	unsigned int *prev_nmi_count;
 	int cpu;
 
--- linux-2.6.19.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.19/arch/x86_64/kernel/nmi.c
@@ -190,6 +190,8 @@ void nmi_watchdog_default(void)
 		nmi_watchdog = NMI_IO_APIC;
 }
 
+static int endflag __initdata = 0;
+
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -197,7 +199,6 @@ void nmi_watchdog_default(void)
  */
 static __init void nmi_cpu_busy(void *data)
 {
-	volatile int *endflag = data;
 	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
@@ -205,14 +206,13 @@ static __init void nmi_cpu_busy(void *da
 	   pause instruction. On a real HT machine this is fine because
 	   all other CPUs are busy with "useless" delay loops and don't
 	   care if they get somewhat less cycles. */
-	while (*endflag == 0)
-		barrier();
+	while (endflag == 0)
+		mb();
 }
 #endif
 
 int __init check_nmi_watchdog (void)
 {
-	volatile int endflag = 0;
 	int *counts;
 	int cpu;
 
@@ -253,6 +253,7 @@ int __init check_nmi_watchdog (void)
 	if (!atomic_read(&nmi_active)) {
 		kfree(counts);
 		atomic_set(&nmi_active, -1);
+		endflag = 1;
 		return -1;
 	}
 	endflag = 1;
