Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWJQSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWJQSSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWJQSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:18:23 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:8760 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750854AbWJQSSW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:18:22 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 irq: Use irq_domain in ioapic_retrigger_irq
Date: Tue, 17 Oct 2006 11:09:28 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6F8@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: Use irq_domain in ioapic_retrigger_irq
Thread-Index: AcbyFv7Vz8rHcoOmQXGHGNrhOZF2twAAD4Yg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Linus Torvalds" <torvalds@osdl.org>
cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>
X-OriginalArrivalTime: 17 Oct 2006 18:09:29.0181 (UTC)
 FILETIME=[635C70D0:01C6F217]
X-WSS-ID: 692BC3E20CK4518154-14-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you change "unsigned vector" to "int vector" like other function?

YH

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Tuesday, October 17, 2006 11:03 AM
To: Linus Torvalds
Cc: Andrew Morton; Andi Kleen; linux-kernel@vger.kernel.org; Natalie
Protasevich; Lu, Yinghai
Subject: [PATCH] x86_64 irq: Use irq_domain in ioapic_retrigger_irq


Thanks to YH Lu for spotting this.  It appears I missed
this function when I refactored allocate_irq_vector and
introduced irq_domain, with the result that all retriggered
irqs would go to cpu 0 even if we were not prepared to
receive them there.

While reviewing YH's patch I also noticed that this function was
missing locking, and since I am now reading two values from
two diffrent arrays that looks like a race we might be able
to hit in the real world.

Cc: Yinghai Lu <yinghai.lu@amd.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 49e94f7..2207d4a 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1255,12 +1255,15 @@ static int ioapic_retrigger_irq(unsigned
 {
 	cpumask_t mask;
 	unsigned vector;
+	unsigned long flags;
 
+	spin_lock_irqsave(&vector_lock, flags);
 	vector = irq_vector[irq];
 	cpus_clear(mask);
-	cpu_set(vector >> 8, mask);
+	cpu_set(first_cpu(irq_domain[irq]), mask);
 
-	send_IPI_mask(mask, vector & 0xff);
+	send_IPI_mask(mask, vector);
+	spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
 }
-- 
1.4.2.rc3.g7e18e-dirty





