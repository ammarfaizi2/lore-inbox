Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTEKMmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTEKMmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:42:08 -0400
Received: from holomorphy.com ([66.224.33.161]:56746 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261335AbTEKMmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:42:06 -0400
Date: Sun, 11 May 2003 05:54:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Jos Hulzink <josh@stack.nl>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
Message-ID: <20030511125438.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, Jos Hulzink <josh@stack.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]> <200305111200.31242.josh@stack.nl> <Pine.LNX.4.50.0305110813140.15337-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305110813140.15337-100000@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 08:17:53AM -0400, Zwane Mwaikambo wrote:
> It was a bug in 2.4, fixed in Alan's tree by setting target_cpus to 0xff 
> (previously cpu_online_map). There is no noirqbalance option in 2.4 
> because there is no in kernel irq balancer.

I vaguely like this notion because it removes a #ifdef and cleans up
a tiny bit of its surroundings. But it's not quite a one-liner.


-- wli

 smpboot.h |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff -prauN linux-2.4.21-pre7-1/include/asm-i386/smpboot.h zwane-2.4.21-pre7-1/include/asm-i386/smpboot.h
--- linux-2.4.21-pre7-1/include/asm-i386/smpboot.h	Thu Feb  6 07:39:52 2003
+++ zwane-2.4.21-pre7-1/include/asm-i386/smpboot.h	Sun May 11 05:49:41 2003
@@ -99,23 +99,22 @@
 #define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
 #endif /* CONFIG_MULTIQUAD */
 
-#ifdef CONFIG_X86_CLUSTERED_APIC
 static inline int target_cpus(void)
 {
-	static int cpu;
-	switch(clustered_apic_mode){
+	switch (clustered_apic_mode) {
+		/* physical broadcast, routed only to local APIC bus */
 		case CLUSTERED_APIC_NUMAQ:
-			/* Broadcast intrs to local quad only. */
 			return APIC_BROADCAST_ID_APIC;
-		case CLUSTERED_APIC_XAPIC:
-			/*round robin the interrupts*/
-			cpu = (cpu+1)%smp_num_cpus;
+		/* round robin the interrupts (physical unicast) */
+		case CLUSTERED_APIC_XAPIC: {
+			static int cpu;
+			cpu = (cpu + 1) % smp_num_cpus;
 			return cpu_to_physical_apicid(cpu);
+		}
+		/* flat logical broadcast */
+		case CLUSTERED_APIC_NONE:
 		default:
+			return 0xFF;
 	}
-	return cpu_online_map;
 }
-#else
-#define target_cpus() (cpu_online_map)
-#endif
 #endif
