Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSJYVdn>; Fri, 25 Oct 2002 17:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSJYVdn>; Fri, 25 Oct 2002 17:33:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:5133
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261612AbSJYVdl>; Fri, 25 Oct 2002 17:33:41 -0400
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <1035581420.734.3873.camel@phantasy>
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com> 
	<1035581420.734.3873.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 17:39:55 -0400
Message-Id: <1035581995.1501.3906.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 17:30, Robert Love wrote:

> 	- wrap print in "if (cpu_has_ht) { ... }"   (Dave Jones)
> 	- remove initdata from phys_proc_id         (Jun Nakajima)
> 	- match field names in latest 2.4-ac        (Alan Cox)

missing this last bit, sorry..

	Robert Love

 cpu/proc.c |    7 +++++++
 smpboot.c  |    2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -urN linux-2.5.44/arch/i386/kernel/cpu/proc.c linux/arch/i386/kernel/cpu/proc.c
--- linux-2.5.44/arch/i386/kernel/cpu/proc.c	2002-10-19 00:02:29.000000000 -0400
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
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
 	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
diff -urN linux-2.5.44/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.44/arch/i386/kernel/smpboot.c	2002-10-19 00:01:53.000000000 -0400
+++ linux/arch/i386/kernel/smpboot.c	2002-10-25 17:24:26.000000000 -0400
@@ -58,7 +58,7 @@
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
+int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;

