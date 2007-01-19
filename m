Return-Path: <linux-kernel-owner+w=401wt.eu-S932792AbXASRMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbXASRMd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXASRMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:12:33 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:2951 "EHLO
	usea-naimss1.unisys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792AbXASRMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:12:32 -0500
Subject: [PATCH 2.6.19.2 1/1] kexec: update IO-APIC dest field to 8-bit for
	xAPIC
From: Benjamin Romer <benjamin.romer@unisys.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>
Content-Type: text/plain
Organization: Unisys Corporation
Date: Fri, 19 Jan 2007 12:12:28 -0500
Message-Id: <1169226749.6467.14.camel@ustr-romerbm-2.na.uis.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2007 17:12:29.0845 (UTC) FILETIME=[001BAC50:01C73BED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the Unisys ES7000/ONE system, we encountered a problem where
performing a kexec reboot or dump on any cell other than cell 0 causes
the system timer to stop working, resulting in a hang during timer
calibration in the new kernel. 

We traced the problem to one line of code in disable_IO_APIC(), which
needs to restore the timer's IO-APIC configuration before rebooting. The
code is currently using the 4-bit physical destination field, rather
than using the 8-bit logical destination field, and it cuts off the
upper 4 bits of the timer's APIC ID. If we change this to use the
logical destination field, the timer works and we can kexec on the upper
cells. This was tested on two different cells (0 and 2) in an ES7000/ONE
system.

For reference, the relevant Intel xAPIC spec is kept at
ftp://download.intel.com/design/chipsets/e8501/datashts/30962001.pdf,
specifically on page 334.

Signed-off-by: Benjamin M Romer <benjamin.romer@unisys.com>

---
 arch/x86_64/kernel/io_apic.c |   24 +++++++++++-------------
 include/asm-x86_64/io_apic.h |   38
++++++++++++++------------------------
 2 files changed, 25 insertions(+), 37 deletions(-)

diff -ru linux-2.6.19.2-orig/arch/x86_64/kernel/io_apic.c
linux-2.6.19.2/arch/x86_64/kernel/io_apic.c
--- linux-2.6.19.2-orig/arch/x86_64/kernel/io_apic.c	2007-03-18
12:29:52.000000000 -0400
+++ linux-2.6.19.2/arch/x86_64/kernel/io_apic.c	2007-03-18
13:15:26.000000000 -0400
@@ -814,7 +814,7 @@
 		entry.delivery_mode = INT_DELIVERY_MODE;
 		entry.dest_mode = INT_DEST_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
+		entry.dest = cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -832,7 +832,7 @@
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
+			entry.dest = cpu_mask_to_apicid(TARGET_CPUS);
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -847,7 +847,7 @@
 			if (vector < 0)
 				continue;
 
-			entry.dest.logical.logical_dest = cpu_mask_to_apicid(mask);
+			entry.dest = cpu_mask_to_apicid(mask);
 			entry.vector = vector;
 
 			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
@@ -888,7 +888,7 @@
 	 */
 	entry.dest_mode = INT_DEST_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
+	entry.dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -988,18 +988,17 @@
 
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");
 
-	printk(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
-			  " Stat Dest Deli Vect:   \n");
+	printk(KERN_DEBUG " NR Dst Mask Trig IRR Pol"
+			  " Stat Dmod Deli Vect:   \n");
 
 	for (i = 0; i <= reg_01.bits.entries; i++) {
 		struct IO_APIC_route_entry entry;
 
 		entry = ioapic_read_entry(apic, i);
 
-		printk(KERN_DEBUG " %02x %03X %02X  ",
+		printk(KERN_DEBUG " %02x %03X ",
 			i,
-			entry.dest.logical.logical_dest,
-			entry.dest.physical.physical_dest
+			entry.dest
 		);
 
 		printk("%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
@@ -1261,8 +1260,7 @@
 		entry.dest_mode       = 0; /* Physical */
 		entry.delivery_mode   = dest_ExtINT; /* ExtInt */
 		entry.vector          = 0;
-		entry.dest.logical.logical_dest =
-					GET_APIC_ID(apic_read(APIC_ID));
+		entry.dest          = GET_APIC_ID(apic_read(APIC_ID));
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
@@ -1524,7 +1522,7 @@
 
 	entry1.dest_mode = 0;			/* physical delivery */
 	entry1.mask = 0;			/* unmask IRQ now */
-	entry1.dest.physical.physical_dest = hard_smp_processor_id();
+	entry1.dest = hard_smp_processor_id();
 	entry1.delivery_mode = dest_ExtINT;
 	entry1.polarity = entry0.polarity;
 	entry1.trigger = 0;
@@ -2092,7 +2090,7 @@
 
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(mask);
+	entry.dest = cpu_mask_to_apicid(mask);
 	entry.trigger = triggering;
 	entry.polarity = polarity;
 	entry.mask = 1;					 /* Disabled (masked) */
diff -ru linux-2.6.19.2-orig/include/asm-x86_64/io_apic.h
linux-2.6.19.2/include/asm-x86_64/io_apic.h
--- linux-2.6.19.2-orig/include/asm-x86_64/io_apic.h	2007-03-18
12:30:07.000000000 -0400
+++ linux-2.6.19.2/include/asm-x86_64/io_apic.h	2007-03-18
12:58:37.000000000 -0400
@@ -72,31 +72,21 @@
 };
 
 struct IO_APIC_route_entry {
-	__u32	vector		:  8,
-		delivery_mode	:  3,	/* 000: FIXED
-					 * 001: lowest prio
-					 * 111: ExtINT
-					 */
-		dest_mode	:  1,	/* 0: physical, 1: logical */
-		delivery_status	:  1,
-		polarity	:  1,
-		irr		:  1,
-		trigger		:  1,	/* 0: edge, 1: level */
-		mask		:  1,	/* 0: enabled, 1: disabled */
-		__reserved_2	: 15;
-
-	union {		struct { __u32
-					__reserved_1	: 24,
-					physical_dest	:  4,
-					__reserved_2	:  4;
-			} physical;
-
-			struct { __u32
-					__reserved_1	: 24,
-					logical_dest	:  8;
-			} logical;
-	} dest;
+        __u32   vector          :  8,
+                delivery_mode   :  3,   /* 000: FIXED
+                                         * 001: lowest prio
+                                         * 111: ExtINT
+                                         */
+                dest_mode       :  1,   /* 0: physical, 1: logical */
+                delivery_status :  1,
+                polarity        :  1,
+                irr             :  1,
+                trigger         :  1,   /* 0: edge, 1: level */
+                mask            :  1,   /* 0: enabled, 1: disabled */
+                __reserved_2    : 15;
 
+        __u32   __reserved_3    : 24,
+                dest          :  8;
 } __attribute__ ((packed));
 
 /*


