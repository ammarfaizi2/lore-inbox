Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOPYi>; Wed, 15 Nov 2000 10:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKOPY2>; Wed, 15 Nov 2000 10:24:28 -0500
Received: from 213-1-124-214.btconnect.com ([213.1.124.214]:6018 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129045AbQKOPYS>;
	Wed, 15 Nov 2000 10:24:18 -0500
Date: Wed, 15 Nov 2000 14:56:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Keith Owens <kaos@melbourne.sgi.com>
cc: linux-kernel@vger.kernel.org, George <greerga@entropy.muc.muohio.edu>
Subject: Re: [patch] fixes for kdb on 2.4.0-test11-pre5
In-Reply-To: <Pine.GSO.4.21.0011150337390.19024-100000@megami.veritas.com>
Message-ID: <Pine.LNX.4.21.0011151455190.1567-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Tigran Aivazian wrote:

> Hi Keith,
> 
> Here is some fixes related to x86 capabilities changes in test11-pre5.
> Against your latest patch (test11-pre5) from oss.sgi. Tested under
> test11-pre5 on SMP.
> 

small (but important!) typo fixed, thanks to George
<greerga@entropy.muc.muohio.edu>. Here is updated patch:

--- arch/i386/kernel/traps.c.0	Wed Nov 15 11:20:34 2000
+++ arch/i386/kernel/traps.c	Wed Nov 15 11:28:20 2000
@@ -1213,8 +1213,8 @@
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
 #if defined(CONFIG_KDB)
-	if ((boot_cpu_data.x86_capability & X86_FEATURE_MCE) &&
-	    (boot_cpu_data.x86_capability & X86_FEATURE_MCA)) {
+	if (test_bit(X86_FEATURE_MCE, &boot_cpu_data.x86_capability) &&
+	    test_bit(X86_FEATURE_MCA, &boot_cpu_data.x86_capability)) {
 		set_trap_gate(14,&page_fault_mca);
 	}
 	else {
--- arch/i386/kernel/apic.c.0	Wed Nov 15 11:26:27 2000
+++ arch/i386/kernel/apic.c	Wed Nov 15 11:28:12 2000
@@ -210,7 +210,8 @@
 int set_nmi_counter_local(void)
 {
 	extern unsigned long cpu_khz;
-	if (!(boot_cpu_data.x86_capability & X86_FEATURE_APIC))
+
+	if (test_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability))
 		return(-EIO);
 	if (nmi_watchdog_source && nmi_watchdog_source != 1)
 		return(0);	/* Not using local APIC */
@@ -224,7 +225,8 @@
 int setup_apic_nmi_watchdog(int value)
 {
 	int ret, eax;
-	if (!(boot_cpu_data.x86_capability & X86_FEATURE_APIC))
+
+	if (!test_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability))
 		return(-EIO);
 	if (nmi_watchdog_source && nmi_watchdog_source != 1)
 		return(0);	/* Not using local APIC */
--- arch/i386/kdb/kdbasupport.c.0	Wed Nov 15 11:29:16 2000
+++ arch/i386/kdb/kdbasupport.c	Wed Nov 15 11:33:37 2000
@@ -1081,11 +1081,8 @@
 	/*
 	 * Enable Machine Check Exceptions
 	 */
-	u32 x86_capability;
-
-	x86_capability = boot_cpu_data.x86_capability;
-	if ((x86_capability & X86_FEATURE_MCE) &&
-	    (x86_capability & X86_FEATURE_MCA)) {
+	if (test_bit(X86_FEATURE_MCE, &boot_cpu_data.x86_capability) &&
+	    test_bit(X86_FEATURE_MCA, &boot_cpu_data.x86_capability)) {
 		u32 i, lv, hv, count;
 		rdmsr(MCG_CAP, lv, hv);
 		count = lv&0xff;
@@ -1141,7 +1138,7 @@
 {
 	u32  lv, hv;
 
-	if (!(boot_cpu_data.x86_capability & X86_FEATURE_MCA)) {
+	if (!test_bit(X86_FEATURE_MCA, &boot_cpu_data.x86_capability)) {
 		if (lbr_warned) {
 			kdb_printf("kdb: machine does not support last branch recording\n");
 			lbr_warned = 1;
@@ -1173,7 +1170,7 @@
 {
 	u32  lv, hv;
 
-	if (!(boot_cpu_data.x86_capability & X86_FEATURE_MCA)) {
+	if (!test_bit(X86_FEATURE_MCA, &boot_cpu_data.x86_capability)) {
 		if (lbr_warned) {
 			kdb_printf("kdb: machine does not support last branch recording\n");
 			lbr_warned = 1;
@@ -1205,9 +1202,8 @@
 {
 	u32  from, to, dummy;
 
-	if (!(boot_cpu_data.x86_capability & X86_FEATURE_MCA)) {
+	if (!test_bit(X86_FEATURE_MCA, &boot_cpu_data.x86_capability))
 		return;
-	}
 
 	rdmsr(LASTBRANCHFROMIP, from, dummy);
 	rdmsr(LASTBRANCHTOIP, to, dummy);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
