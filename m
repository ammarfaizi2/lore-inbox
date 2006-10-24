Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWJXVd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWJXVd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWJXVd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:33:27 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:23527 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161234AbWJXVd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:33:26 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] x86_64 irq: reset more to default when clear irq_vector
 for destroy_irq
Date: Tue, 24 Oct 2006 14:33:08 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reset more to default when clear
 irq_vector for destroy_irq
Thread-Index: Acb29PZqiQrjMhYqRXOk2C3vtxTWVwApoRYQAAVpBDA=
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Muli Ben-Yehuda" <muli@il.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2006 21:33:09.0946 (UTC)
 FILETIME=[006571A0:01C6F7B4]
X-WSS-ID: 6920591F1AO236771-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Clear the irq releated entries in irq_vector, irq_domain and vector_irq 
instead of clearing irq_vector only. So when new irq is created, it 
could get that vector.

Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>

--- linux-2.6/arch/x86_64/kernel/io_apic.c	2006-10-24
13:40:48.000000000 -0700
+++ linux-2.6.xx/arch/x86_64/kernel/io_apic.c	2006-10-24
14:03:08.000000000 -0700
@@ -716,6 +716,22 @@
 	return vector;
 }
 
+static void __clear_irq_vector(int irq)
+{
+	int old_vector = -1;
+	if (irq_vector[irq] > 0)
+		old_vector = irq_vector[irq];
+	if (old_vector >= 0) {
+		cpumask_t old_mask;
+		int old_cpu;
+		cpus_and(old_mask, irq_domain[irq], cpu_online_map);
+		for_each_cpu_mask(old_cpu, old_mask)
+			per_cpu(vector_irq, old_cpu)[old_vector] = -1;
+	}
+	irq_vector[irq] = 0;
+	irq_domain[irq] = CPU_MASK_NONE;
+}
+
 void __setup_vector_irq(int cpu)
 {
 	/* Initialize vector_irq on a new cpu */
@@ -1803,7 +1819,7 @@
 	dynamic_irq_cleanup(irq);
 
 	spin_lock_irqsave(&vector_lock, flags);
-	irq_vector[irq] = 0;
+	__clear_irq_vector(irq);
 	spin_unlock_irqrestore(&vector_lock, flags);
 }
 


