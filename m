Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTEKNCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTEKNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:02:54 -0400
Received: from holomorphy.com ([66.224.33.161]:63146 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261323AbTEKNCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:02:51 -0400
Date: Sun, 11 May 2003 06:15:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Jos Hulzink <josh@stack.nl>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
Message-ID: <20030511131521.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Jos Hulzink <josh@stack.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]> <200305111200.31242.josh@stack.nl> <Pine.LNX.4.50.0305110813140.15337-100000@montezuma.mastecende.com> <20030511125438.GJ8978@holomorphy.com> <Pine.LNX.4.50.0305110855120.15337-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305110855120.15337-100000@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, William Lee Irwin III wrote:
>> I vaguely like this notion because it removes a #ifdef and cleans up
>> a tiny bit of its surroundings. But it's not quite a one-liner.

On Sun, May 11, 2003 at 08:58:57AM -0400, Zwane Mwaikambo wrote:
> Nice, it's during init too so there really is no need for any sort of 
> optimisation, the inline can also go and make it __init.

Very good point. The static variable in an inline function is very fishy
also. Here it is:

-- wli


Un-#idef target_cpus() and also shove it into arch/i386/kernel/io_apic.c
as both static and __init.

 arch/i386/kernel/io_apic.c |   19 +++++++++++++++++++
 include/asm-i386/smpboot.h |   20 --------------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff -prauN linux-2.4.21-pre7-1/include/asm-i386/smpboot.h zwane-2.4.21-pre7-1/include/asm-i386/smpboot.h
--- linux-2.4.21-pre7-1/include/asm-i386/smpboot.h	Thu Feb  6 07:39:52 2003
+++ zwane-2.4.21-pre7-1/include/asm-i386/smpboot.h	Sun May 11 06:09:47 2003
@@ -98,24 +98,4 @@
 #define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
 #define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
 #endif /* CONFIG_MULTIQUAD */
-
-#ifdef CONFIG_X86_CLUSTERED_APIC
-static inline int target_cpus(void)
-{
-	static int cpu;
-	switch(clustered_apic_mode){
-		case CLUSTERED_APIC_NUMAQ:
-			/* Broadcast intrs to local quad only. */
-			return APIC_BROADCAST_ID_APIC;
-		case CLUSTERED_APIC_XAPIC:
-			/*round robin the interrupts*/
-			cpu = (cpu+1)%smp_num_cpus;
-			return cpu_to_physical_apicid(cpu);
-		default:
-	}
-	return cpu_online_map;
-}
-#else
-#define target_cpus() (cpu_online_map)
-#endif
 #endif
diff -prauN linux-2.4.21-pre7-1/arch/i386/kernel/io_apic.c zwane-2.4.21-pre7-1/arch/i386/kernel/io_apic.c
--- linux-2.4.21-pre7-1/arch/i386/kernel/io_apic.c	Wed Apr 16 14:32:46 2003
+++ zwane-2.4.21-pre7-1/arch/i386/kernel/io_apic.c	Sun May 11 06:10:22 2003
@@ -614,6 +614,25 @@
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
+static int __init target_cpus(void)
+{
+	switch (clustered_apic_mode) {
+		/* physical broadcast, routed only to local APIC bus */
+		case CLUSTERED_APIC_NUMAQ:
+			return APIC_BROADCAST_ID_APIC;
+		/* round robin the interrupts (physical unicast) */
+		case CLUSTERED_APIC_XAPIC: {
+			static int cpu;
+			cpu = (cpu + 1) % smp_num_cpus;
+			return cpu_to_physical_apicid(cpu);
+		}
+		/* flat logical broadcast */
+		case CLUSTERED_APIC_NONE:
+		default:
+			return 0xFF;
+	}
+}
+
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
