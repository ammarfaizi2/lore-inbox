Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272007AbTG2SPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271970AbTG2SPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:15:31 -0400
Received: from fmr01.intel.com ([192.55.52.18]:64214 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S272037AbTG2SPT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:15:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] [RESEND] Use of Performance Monitoring Counters based on Model number
Date: Tue, 29 Jul 2003 11:15:10 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D157@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] Use of Performance Monitoring Counters based on Model number
Thread-Index: AcNV/VeTZon0D9G9Sf6INTirCqSVzw==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 29 Jul 2003 18:15:10.0954 (UTC) FILETIME=[5948DCA0:01C355FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Attaching a modified version of this patch, based on the feedback that I
got for my previous post.

Feedback and Resolution:
1) If you're going to do this you should fix up arch/i386/oprofile/ to
error out similarly at least
-  Done. Made a similar change in oprofile code. Infact it already had a
check for 0xf, 0x3. Added one for 0x6, 0xd.

2) How about some macros for those magic numbers?  
#define INTEL_MODEL_THINGABABOBBERPERON 0xd
-  Not sure whether I need to add macros for family and models. We don't
seem to have macros for them anywhere else in kernel code.

3) It'd also be nice to let the user know why things aren't working
instead of silent failure.
-  Done. Added a message while in nmi_init. 

Let me know if you have any questions. Please Apply.

Thanks,
-Venkatesh

> -----Original Message-----
> From: Pallipadi, Venkatesh 
> Sent: Wednesday, July 16, 2003 10:08 AM
> To: 'torvalds@osdl.org'
> Cc: 'linux-kernel@vger.kernel.org'; Mallick, Asit K
> Subject: [PATCH] Use of Performance Monitoring Counters based 
> on Model number
> 
> 
> 
> 
> Attached is a small patch to make Linux kernel use of 
> performance monitoring MSRs based on known processor models. 
> Future processor implementation models may not support the 
> same MSR layout.
> 
> Please apply.
> 
> Thanks,
> -Venkatesh




--- linux-2.6.0-test1/arch/i386/kernel/nmi.c.orig	2003-07-13
20:34:40.000000000 -0700
+++ linux-2.6.0-test1/arch/i386/kernel/nmi.c	2003-07-17
17:26:45.000000000 -0700
@@ -162,9 +162,15 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				break;
+
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				break;
+
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
 			break;
@@ -348,9 +354,19 @@
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd) {
+				printk (KERN_INFO "Performance Counter
support for this CPU model not yet added.\n");
+				return;
+			}
+
 			setup_p6_watchdog();
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3) {
+				printk (KERN_INFO "Performance Counter
support for this CPU model not yet added.\n");
+				return;
+			}
+
 			if (!setup_p4_watchdog())
 				return;
 			break;
--- linux-2.6.0-test1/arch/i386/oprofile/nmi_int.c.orig	2003-07-17
17:20:30.000000000 -0700
+++ linux-2.6.0-test1/arch/i386/oprofile/nmi_int.c	2003-07-17
17:21:06.000000000 -0700
@@ -285,6 +285,9 @@
 {
 	__u8 cpu_model = current_cpu_data.x86_model;
 
+	if (cpu_model > 0xd)
+		return 0;
+
 	if (cpu_model > 5) {
 		nmi_ops.cpu_type = "i386/piii";
 	} else if (cpu_model > 2) {


