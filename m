Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTHUWRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbTHUWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:17:23 -0400
Received: from holomorphy.com ([66.224.33.161]:49808 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262910AbTHUWRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:17:13 -0400
Date: Thu, 21 Aug 2003 15:17:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Theurer <habanero@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Message-ID: <20030821221744.GK4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211056.29876.habanero@us.ibm.com> <1061482159.19036.1716.camel@nighthawk> <200308211202.02871.habanero@us.ibm.com> <20030821213350.GJ4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821213350.GJ4306@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 12:02:02PM -0500, Andrew Theurer wrote:
>> smp_boot_cpus() bit: 80
>> Booting processor 16/114 eip 2000
>> Not responding.
>> Unmapping cpu 16 from all nodes
>> CPU #114 not responding - cannot use it.

On Thu, Aug 21, 2003 at 02:33:50PM -0700, William Lee Irwin III wrote:
> cpu_present_to_apicid() needs a similar treatment to dhansen's prior
> bits. diff incoming shortly.

Could one of you two try this out on a Summit machine in addition to
Dave's prior patch (or hook me up to one)?

Thanks.


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
===== include/asm-i386/mach-default/mach_apic.h 1.27 vs edited =====
--- 1.27/include/asm-i386/mach-default/mach_apic.h	Mon Aug 18 19:46:23 2003
+++ edited/include/asm-i386/mach-default/mach_apic.h	Thu Aug 21 15:08:15 2003
@@ -83,7 +83,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return  mps_cpu;
+	if (mps_cpu < NR_CPUS)
+		return mps_cpu;
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
===== include/asm-i386/mach-visws/mach_apic.h 1.7 vs edited =====
--- 1.7/include/asm-i386/mach-visws/mach_apic.h	Wed Aug 20 22:30:10 2003
+++ edited/include/asm-i386/mach-visws/mach_apic.h	Thu Aug 21 15:11:16 2003
@@ -59,7 +59,10 @@
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return mps_cpu;
+	if (mps_cpu < NR_CPUS)
+		return mps_cpu;
+	else
+		return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int apicid)
