Return-Path: <linux-kernel-owner+w=401wt.eu-S1750883AbXAHP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbXAHP4w (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXAHP4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:56:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59600 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbXAHP4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:56:51 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] x86_64 io_apic: Implment update_irq0_entry
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
	<86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
	<20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
	<m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com>
Date: Mon, 08 Jan 2007 08:56:23 -0700
In-Reply-To: <m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 08 Jan 2007 08:53:52 -0700")
Message-ID: <m1d55pikbc.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To guess different irq routing strategies for irq 0 we
need the ability to update our data structures to reflect
our guess.

update_irq0_entry updates the mp routing table information
to reflect our current guess as to the routing of the timer
irq.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 5ad210f..1e68377 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -446,6 +446,37 @@ static int __init find_isa_irq_apic(int irq, int type)
 	return -1;
 }
 
+static int update_irq0_entry(int apic, int pin)
+{
+	int irq = 0;
+	int idx;
+	int isa_bus;
+
+	/* Figure out the isa bus, by convention it is bus 0,
+	 * but be prepared for someone being creative.
+	 */
+	for (isa_bus = 0; isa_bus < MAX_MP_BUSSES; isa_bus++)
+		if (test_bit(isa_bus, mp_bus_not_pci))
+			break;
+	if (isa_bus >= MAX_MP_BUSSES)
+		isa_bus = 0;
+
+	idx = find_irq_entry(apic, pin, mp_INT);
+	if (idx == -1) {
+		idx = mp_irq_entries;
+		if (++mp_irq_entries >= MAX_IRQ_SOURCES)
+			panic("MAX # of irq sources exceeded!!!\n");
+	}
+	mp_irqs[idx].mpc_type = MP_INTSRC;
+	mp_irqs[idx].mpc_irqtype = mp_INT;
+	mp_irqs[idx].mpc_irqflag = 0;	/* Use bus defaults */
+	mp_irqs[idx].mpc_srcbus = isa_bus;
+	mp_irqs[idx].mpc_srcbusirq = irq;
+	mp_irqs[idx].mpc_dstapic = mp_ioapics[apic].mpc_apicid;
+	mp_irqs[idx].mpc_dstirq = pin;
+	return idx;
+}
+
 /*
  * Find a specific PCI IRQ entry.
  * Not an __init, possibly needed by modules
-- 
1.4.4.1.g278f

