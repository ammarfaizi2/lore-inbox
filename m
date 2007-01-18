Return-Path: <linux-kernel-owner+w=401wt.eu-S932281AbXARTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbXARTNn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXARTNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:13:43 -0500
Received: from usea-naimss3.unisys.com ([192.61.61.105]:3326 "EHLO
	usea-naimss3.unisys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbXARTNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:13:43 -0500
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field  
	(X86_64)
From: Benjamin Romer <benjamin.romer@unisys.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <m14pqo6w3d.fsf@ebiederm.dsl.xmission.com>
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	 <m1tz yp8o8v.fsf@ebiederm.dsl.xmission.com>
	 <20070118034153.GA5406@in.ibm.com>  <20070118043639.GA12459@in.ibm.com>
	 <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.co m>
	 <20070118080003.GC31860@in.ibm.com>
	 <1169141034.6665.6.camel@ustr-romerbm- 2.na.uis.unisys.com>
	 <m14pqo6w3d.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Unisys Corporation
Date: Thu, 18 Jan 2007 14:13:39 -0500
Message-Id: <1169147619.6665.11.camel@ustr-romerbm-2.na.uis.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2007 19:13:40.0224 (UTC) FILETIME=[C32DB800:01C73B34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 11:14 -0700, Eric W. Biederman wrote:
> Benjamin Romer <benjamin.romer@unisys.com> writes:
> 
> > On Thu, 2007-01-18 at 13:30 +0530, Vivek Goyal wrote:
> >> On Thu, Jan 18, 2007 at 12:10:55AM -0700, Eric W. Biederman wrote:
> >> > Vivek Goyal <vgoyal@in.ibm.com> writes:
> >> > >
> >> > > Or how about making physical_dest field also 8bit like logical_dest field.
> >> > > This will work both for 4bit and 8bit physical apic ids at the same time
> >> > > code becomes more intutive and it is easier to know whether IOAPIC is
> > being
> >> > > put in physical or destination logical mode.
> >> > 
> >> > Exactly what I was trying to suggest.
> >> > 
> >> > Looking closer at the code I think it makes sense to just kill the union and
> >> > stop the discrimination between physical and logical modes and just have a
> >> > dest field in the structure.  Roughly as you were suggesting at first.
> >> > 
> >> > The reason we aren't bitten by this on a regular basis is the normal code
> >> > path uses logical.logical_dest in both logical and physical modes.
> >> > Which is a little confusing.
> >> > 
> >> > Since there really isn't a distinction to be made we should just stop
> >> > trying, which will make maintenance easier :)
> >> > 
> >> > Currently there are several non-common case users of physical_dest
> >> > that are probably bitten by this problem under the right
> >> > circumstances.
> >> > 
> >> > So I think we should just make the structure:
> >> > 
> >> > struct IO_APIC_route_entry {
> >> > 	__u32	vector		:  8,
> >> > 		delivery_mode	:  3,	/* 000: FIXED
> >> > 					 * 001: lowest prio
> >> > 					 * 111: ExtINT
> >> > 					 */
> >> > 		dest_mode	:  1,	/* 0: physical, 1: logical */
> >> > 		delivery_status	:  1,
> >> > 		polarity	:  1,
> >> > 		irr		:  1,
> >> > 		trigger		:  1,	/* 0: edge, 1: level */
> >> > 		mask		:  1,	/* 0: enabled, 1: disabled */
> >> > 		__reserved_2	: 15;
> >> > 
> >> > 	__u32	__reserved_3	: 24,
> >> > 		__dest		:  8;
> >> > } __attribute__ ((packed));
> >> > 
> >> > And fixup the users.  This should keep us from getting bit by this bug
> >> > in the future.  Like when people start introducing support for more
> >> > than 256 cores and the low 24bits start getting used.
> >> > 
> >> > Or when someone new starts working on the code and thinks the fact
> >> > the field name says logical we are actually using the apic in logical
> >> > mode.
> >> 
> >> This makes perfect sense to me. Ben, interested in providing a patch 
> >> for this?
> >> 
> >> Thanks
> >> Vivek
> >
> > OK, here's the updated patch that uses the new definition and fixes up
> > the other places that use it. I built and tested this on the ES7000/ONE
> > and it works well. :)
> 
> Cool.
> 
> I hate to pick nits by why the double underscore on dest?
> 

It was defined that way in the updated structure definition you sent in
a previous mail, so I figured you wanted it that way. Here's another
revision with the double underscores removed. :)

-- Ben

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


