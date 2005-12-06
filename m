Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVLFQ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVLFQ6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLFQ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:58:08 -0500
Received: from fmr24.intel.com ([143.183.121.16]:28569 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932355AbVLFQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:58:06 -0500
Date: Tue, 6 Dec 2005 08:58:00 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Reading /proc/stat is slooow
Message-ID: <20051206165800.GA6277@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05204A1E@scsmsx401.amr.corp.intel.com> <894E37DECA393E4D9374E0ACBBE7427003BC9642@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427003BC9642@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 05:24:16PM +0800, Zou, Nanhai wrote:
>   I think the reason of second loop much slower than the first one is page coloring.
>   For the first loop, at least cache line is hot in the inner loop.
> For the second loop, things will be much worse because percpu data offset is 64k....

Two possible fixes:
1) Compute the per irq sums during the first (cache-friendly) loop.  This has
the downside that we need to allocate NR_IRQS*sizeof(int) to save the sums
until we need them.  This might not be popular for other architectures who
don't have a big problem here as they don't allow such large values for NR_CPUS.

2) The problem loop is already #ifdef'd out for PPC64 and ALPHA.  We could add
IA64 to that exclusive club and just not include the per irq sums.  Since kstat_irqs()
computes the sums in an "int", they will wrap frequently on a large system
(512 cpus * default 250Hz = 128000 ... which wraps a 32-bit unsigned in 9 hours
and 19 minutes) ... so their usefulness is questionable.  Does xosview use
the per-irq values?

>  But I have no idea of why 2.6.13 is much faster here.
Andreas didn't have CPU_HOTPLUG turned on in his 2.6.13 build.  Which means that
the "for_each_cpu" loop inside kstat_cpus() only touched the percpu area for the
cpus on his system (with CPU_HOTPLUG=n cpu_possible map is equal to cpu_present).

proof of concept patch for option #1 (drops time from 52ms to 3ms with NR_CPUS=1024):

--- a/fs/proc/proc_misc.c	2005-12-05 17:09:25.000000000 -0800
+++ b/fs/proc/proc_misc.c	2005-12-06 08:47:43.000000000 -0800
@@ -343,6 +343,7 @@
 	unsigned long jif;
 	cputime64_t user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 sum = 0;
+	int *perirqsums;
 
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = cputime64_zero;
@@ -350,6 +351,7 @@
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
+	perirqsums = kcalloc(NR_IRQS, sizeof (*perirqsums), GFP_KERNEL);
 	for_each_cpu(i) {
 		int j;
 
@@ -361,8 +363,10 @@
 		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
 		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
 		steal = cputime64_add(steal, kstat_cpu(i).cpustat.steal);
-		for (j = 0 ; j < NR_IRQS ; j++)
+		for (j = 0 ; j < NR_IRQS ; j++) {
 			sum += kstat_cpu(i).irqs[j];
+			perirqsums[j] += kstat_cpu(i).irqs[j];
+		}
 	}
 
 	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu\n",
@@ -400,8 +404,9 @@
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
 	for (i = 0; i < NR_IRQS; i++)
-		seq_printf(p, " %u", kstat_irqs(i));
+		seq_printf(p, " %u", perirqsums[i]);
 #endif
+	kfree(perirqsums);
 
 	seq_printf(p,
 		"\nctxt %llu\n"
