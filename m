Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbTHUXJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTHUXJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:09:54 -0400
Received: from holomorphy.com ([66.224.33.161]:6801 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262949AbTHUXJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:09:46 -0400
Date: Thu, 21 Aug 2003 16:10:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: torvalds@osdl.org
Cc: Andrew Theurer <habanero@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Message-ID: <20030821231020.GW3170@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	torvalds@osdl.org, Andrew Theurer <habanero@us.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211056.29876.habanero@us.ibm.com> <1061482159.19036.1716.camel@nighthawk> <200308211202.02871.habanero@us.ibm.com> <20030821213350.GJ4306@holomorphy.com> <20030821221744.GK4306@holomorphy.com> <20030821224543.GL4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821224543.GL4306@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 03:45:43PM -0700, William Lee Irwin III wrote:
> That broke sparse APIC ID's on several subarches. This is a bit less
> indiscriminate about who it updates (and should replace the prior patch
> wrt. sending anything upstream):

This must go in regardless; in the bios_cpu_apicid[] case, it would
walk off the end of bios_cpu_apicid[] and attempt to send APIC INIT
messages to garbage without this patch, and in the NUMA-Q case, it
would attempt to send NMI wakeups to destinations in the broadcast
cluster (which is harmless, but very poor form) without this patch.

vs. current bk as of 4:01PM PDT.

Linus, please apply.


-- wli


===== include/asm-i386/mach-bigsmp/mach_apic.h 1.16 vs edited =====
--- 1.16/include/asm-i386/mach-bigsmp/mach_apic.h	Wed Aug 20 22:32:06 2003
+++ edited/include/asm-i386/mach-bigsmp/mach_apic.h	Thu Aug 21 15:07:42 2003
@@ -86,7 +86,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return (int) bios_cpu_apicid[mps_cpu];
+	if (mps_cpu < NR_CPUS)
+		return (int)bios_cpu_apicid[mps_cpu];
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
===== include/asm-i386/mach-es7000/mach_apic.h 1.3 vs edited =====
--- 1.3/include/asm-i386/mach-es7000/mach_apic.h	Wed Aug 20 22:32:06 2003
+++ edited/include/asm-i386/mach-es7000/mach_apic.h	Thu Aug 21 15:08:41 2003
@@ -106,8 +106,10 @@
 {
 	if (!mps_cpu)
 		return boot_cpu_physical_apicid;
-	else
+	else if (mps_cpu < NR_CPUS)
 		return (int) bios_cpu_apicid[mps_cpu];
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
===== include/asm-i386/mach-numaq/mach_apic.h 1.22 vs edited =====
--- 1.22/include/asm-i386/mach-numaq/mach_apic.h	Wed Aug 20 22:32:06 2003
+++ edited/include/asm-i386/mach-numaq/mach_apic.h	Thu Aug 21 15:10:31 2003
@@ -65,9 +65,17 @@
 	return (int)cpu_2_logical_apicid[cpu];
 }
 
+/*
+ * Supporting over 60 cpus on NUMA-Q requires a locality-dependent
+ * cpu to APIC ID relation to properly interact with the intelligent
+ * mode of the cluster controller.
+ */
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return ((mps_cpu >> 2) << 4) | (1 << (mps_cpu & 0x3));
+	if (mps_cpu < 60)
+		return ((mps_cpu >> 2) << 4) | (1 << (mps_cpu & 0x3));
+	else
+		return BAD_APICID;
 }
 
 static inline int generate_logical_apicid(int quad, int phys_apicid)
===== include/asm-i386/mach-summit/mach_apic.h 1.31 vs edited =====
--- 1.31/include/asm-i386/mach-summit/mach_apic.h	Wed Aug 20 22:32:06 2003
+++ edited/include/asm-i386/mach-summit/mach_apic.h	Thu Aug 21 15:10:57 2003
@@ -87,7 +87,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return (int) bios_cpu_apicid[mps_cpu];
+	if (mps_cpu < NR_CPUS)
+		return (int)bios_cpu_apicid[mps_cpu];
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_id_map)
