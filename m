Return-Path: <linux-kernel-owner+w=401wt.eu-S1750854AbXAHPyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbXAHPyU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbXAHPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:54:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59592 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbXAHPyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:54:19 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2/4] x86_64 io_apic: Implement irq_from_pin
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
	<86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
	<20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
	<m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
Date: Mon, 08 Jan 2007 08:53:52 -0700
In-Reply-To: <m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 08 Jan 2007 08:49:36 -0700")
Message-ID: <m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another helper needed for guessing the routing of the timer
irq.

irq_from_pin looks at the irq_2_pin mapping and figures
out which irq is connected to a given apic and pin combination.

We need to know this to avoid guessing an apic pin that is already
in use by another irq.

Despite the nested loops this is O(N) walk through the irq_2_pin
data structure.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 7365f5f..5ad210f 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -262,6 +262,20 @@ static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
 }
 #endif
 
+static int irq_from_pin(int apic, int pin)
+{
+	int irq;
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		struct irq_pin_list *entry = irq_2_pin + irq;
+		while (entry->next && ((entry->apic != apic) || (entry->pin != pin)))
+			entry = irq_2_pin + entry->next;
+
+		if ((entry->pin == pin) && (entry->apic == apic))
+			return irq;
+	}
+	return -1;
+}
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
-- 
1.4.4.1.g278f

