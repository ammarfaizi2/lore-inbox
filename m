Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWJQSE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWJQSE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJQSE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:04:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24516 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750816AbWJQSE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:04:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Yinghai Lu <yinghai.lu@amd.com>
Subject: [PATCH] x86_64 irq: Use irq_domain in ioapic_retrigger_irq
Date: Tue, 17 Oct 2006 12:02:38 -0600
Message-ID: <m13b9makht.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

