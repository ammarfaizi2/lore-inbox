Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJYTmq>; Fri, 25 Oct 2002 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJYTmq>; Fri, 25 Oct 2002 15:42:46 -0400
Received: from fmr06.intel.com ([134.134.136.7]:19653 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261412AbSJYTmp>; Fri, 25 Oct 2002 15:42:45 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000EA17130@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Robert Love <rml@tech9.net>, Dave Jones <davej@codemonkey.org.uk>,
       akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       chrisl@vmware.com, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: RE: [PATCH] How to get number of physical CPU in linux from user 
	space?
Date: Fri, 25 Oct 2002 12:48:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more request :-)

Actually "processor" keyword was not good in "physical processor ID"
(someone may be grepping it to find out the number of processors), and it
was one of the reasons it was changed/fixed in the AC tree. 

Since (H/W) threads (rather than "siblings") in a CPU is generic (i.e. not
just an Intel thing), I would like to propose this ("physical id" is from
AC). Alan also simplified "number of simblings" to  "siblings". 

+#ifdef CONFIG_SMP
+	if (cpu_has_ht) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "threads\t\t: %d\n", smp_num_siblings);
+	}
+#endif

Thanks,
Jun

-----Original Message-----
From: Robert Love [mailto:rml@tech9.net]
Sent: Friday, October 25, 2002 12:21 PM
To: Dave Jones; akpm@digeo.com
Cc: linux-kernel@vger.kernel.org; Nakajima, Jun; chrisl@vmware.com;
Martin J. Bligh
Subject: Re: [PATCH] How to get number of physical CPU in linux from
user space?


On Fri, 2002-10-25 at 15:13, Dave Jones wrote:

> Should this be wrapped in a if (cpu_has_ht(c)) { }  ?
> Seems silly to be displaying HT information on non-HT CPUs.

I am neutral, but is fine with me. It is just "cpu_has_ht", btw.

Take two...

This displays the physical processor id and number of siblings of each
processor in /proc/cpuinfo.

	Robert Love

 .proc.c.swp |binary
 proc.c      |    7 +++++++
 2 files changed, 7 insertions(+)

diff -urN linux-2.5.44/arch/i386/kernel/cpu/proc.c
linux/arch/i386/kernel/cpu/proc.c
--- linux-2.5.44/arch/i386/kernel/cpu/proc.c	2002-10-19
00:02:29.000000000 -0400
+++ linux/arch/i386/kernel/cpu/proc.c	2002-10-25 15:18:03.000000000 -0400
@@ -17,6 +17,7 @@
 	 * applications want to get the raw CPUID data, they should access
 	 * /dev/cpu/<cpu_nr>/cpuid instead.
 	 */
+	extern int phys_proc_id[NR_CPUS];
 	static char *x86_cap_flags[] = {
 		/* Intel-defined */
 	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",
@@ -74,6 +75,12 @@
 	/* Cache size */
 	if (c->x86_cache_size >= 0)
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+#ifdef CONFIG_SMP
+	if (cpu_has_ht) {
+		seq_printf(m, "physical processor ID\t: %d\n",
phys_proc_id[n]);
+		seq_printf(m, "number of siblings\t: %d\n",
smp_num_siblings);
+	}
+#endif
 	
 	/* We use exception 16 if we have hardware math and we've either
seen it or the CPU claims it is internal */
 	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
