Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJYVoM>; Fri, 25 Oct 2002 17:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJYVoM>; Fri, 25 Oct 2002 17:44:12 -0400
Received: from fmr02.intel.com ([192.55.52.25]:15563 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261614AbSJYVoK>; Fri, 25 Oct 2002 17:44:10 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Robert Love <rml@tech9.net>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 14:50:17 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
is already doing it:

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
Sent: Friday, October 25, 2002 2:40 PM
To: Robert Love
Cc: Nakajima, Jun; Alan Cox; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo


On Fri, 2002-10-25 at 17:30, Robert Love wrote:

> 	- wrap print in "if (cpu_has_ht) { ... }"   (Dave Jones)
> 	- remove initdata from phys_proc_id         (Jun Nakajima)
> 	- match field names in latest 2.4-ac        (Alan Cox)

missing this last bit, sorry..

	Robert Love

 cpu/proc.c |    7 +++++++
 smpboot.c  |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "siblings\t: %d\n", smp_num_siblings);
+	}
+#endif
 	
 	/* We use exception 16 if we have hardware math and we've either
seen it or the CPU claims it is internal */
 	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
diff -urN linux-2.5.44/arch/i386/kernel/smpboot.c
linux/arch/i386/kernel/smpboot.c
--- linux-2.5.44/arch/i386/kernel/smpboot.c	2002-10-19
00:01:53.000000000 -0400
+++ linux/arch/i386/kernel/smpboot.c	2002-10-25 17:24:26.000000000 -0400
@@ -58,7 +58,7 @@
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
+int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
