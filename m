Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWJWVhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWJWVhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWJWVhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:37:03 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:28978 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1752021AbWJWVhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:37:00 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Date: Mon, 23 Oct 2006 14:07:38 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D74E@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity
 in phys flat mode
Thread-Index: Acb2z6yh7kkkVcL9RS2Pl+w1VN4u7AADThVwAAJejwA=
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
X-OriginalArrivalTime: 23 Oct 2006 21:07:38.0591 (UTC)
 FILETIME=[453976F0:01C6F6E7]
X-WSS-ID: 6923F0901AO126429-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

resend


>From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 

>Beyond that I have a few nits to pick with the patch.
>- We duplicate the code that claims a new vector which makes
>  maintenance a pain.
>- The comments are specific to phys_flat but the code is not.
>- The test for being able to use the old_vector in the new domain
>  should be: ...[old_vector] == vector || ...[old_vector] == -1

Please attached one. This one need Eric's patch about irq global vector.

YH


--- linux-2.6/arch/x86_64/kernel/io_apic_eric.c	2006-10-23
11:56:36.000000000 -0700
+++ linux-2.6/arch/x86_64/kernel/io_apic.c	2006-10-23
13:59:36.000000000 -0700
@@ -613,8 +613,9 @@
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
 	static int current_vector = FIRST_DEVICE_VECTOR, current_offset
= 0;
-	int old_vector = -1;
-	int cpu;
+	int vector = -1, old_vector = -1;
+	cpumask_t domain, new_mask;
+	int cpu, new_cpu;
 
 	BUG_ON((unsigned)irq >= NR_IRQ_VECTORS);
 
@@ -628,12 +629,30 @@
 		if (!cpus_empty(*result))
 			return old_vector;
 
+		/* try to reuse vector */
+		for_each_cpu_mask(cpu, mask) {
+			int can_resue = 1;
+			domain = vector_allocation_domain(cpu);
+			cpus_and(new_mask, domain, cpu_online_map);
+			for_each_cpu_mask(new_cpu, new_mask) {
+				int old_irq;
+				old_irq = per_cpu(vector_irq,
new_cpu)[old_vector];
+				if ( (old_irq != irq) && (old_irq !=
-1)) {
+					can_resue = 0;
+					break;
+				}
+			}
+
+			if(!can_resue) continue;
+
+			vector = old_vector;
+			goto found_one;	
+		}
+
 	}
 
 	for_each_cpu_mask(cpu, mask) {
-		cpumask_t domain, new_mask;
-		int new_cpu;
-		int vector, offset;
+		int offset;
 
 		domain = vector_allocation_domain(cpu);
 		cpus_and(new_mask, domain, cpu_online_map);
@@ -657,21 +676,27 @@
 		/* Found one! */
 		current_vector = vector;
 		current_offset = offset;
-		if (old_vector >= 0) {
-			cpumask_t old_mask;
-			int old_cpu;
-			cpus_and(old_mask, irq_domain[irq],
cpu_online_map);
-			for_each_cpu_mask(old_cpu, old_mask)
-				per_cpu(vector_irq, old_cpu)[old_vector]
= -1;
-		}
-		for_each_cpu_mask(new_cpu, new_mask)
-			per_cpu(vector_irq, new_cpu)[vector] = irq;
-		irq_vector[irq] = vector;
-		irq_domain[irq] = domain;
-		cpus_and(*result, domain, mask);
-		return vector;
+		
+		goto found_one;
 	}
+
 	return -ENOSPC;
+
+found_one:
+	if (old_vector >= 0) {
+		cpumask_t old_mask;
+		int old_cpu;
+		cpus_and(old_mask, irq_domain[irq], cpu_online_map);
+		for_each_cpu_mask(old_cpu, old_mask)
+			per_cpu(vector_irq, old_cpu)[old_vector] = -1;
+	}
+	for_each_cpu_mask(new_cpu, new_mask)
+		per_cpu(vector_irq, new_cpu)[vector] = irq;
+	irq_vector[irq] = vector;
+	irq_domain[irq] = domain;
+	cpus_and(*result, domain, mask);
+	return vector;
+
 }
 
 static int assign_irq_vector(int irq, cpumask_t mask, cpumask_t
*result)


