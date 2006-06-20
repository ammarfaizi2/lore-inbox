Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWFTWfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWFTWfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFTW26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:28:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51940 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751329AbWFTW2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:52 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/25] x86_64 irq: Reenable migrating irqs to other cpus.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:16 -0600
Message-Id: <11508425192220-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425191381-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest changes the code for migrating x86_64 irqs was dropped.
This reads it in a fashion that will work even if we change the
vector on level triggered irqs when we migrate them.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 2e9f1cf..f50be45 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1572,18 +1572,43 @@ static int ioapic_retrigger_vector(unsig
  * races.
  */
 
-static void ack_apic(unsigned int vector)
+static void ack_apic(unsigned int irq)
 {
 	ack_APIC_irq();
 }
 
+static void ack_apic_edge(unsigned int irq)
+{
+	move_native_irq(irq);
+	ack_APIC_irq();
+}
+
+static void ack_apic_level(unsigned int irq)
+{
+	int do_unmask_irq = 0;
+	/* If we are moving the irq we need to mask it */
+	if (unlikely(irq_desc[irq].status & IRQ_MOVE_PENDING)) {
+		do_unmask_irq = 1;
+		mask_IO_APIC_irq(irq);
+	}
+	/* We must acknowledge the irq before we move it
+	 * or the acknowledge will not propogate properly.
+	 */
+	ack_APIC_irq();
+
+	/* Now we can move and renable the irq */
+	move_masked_irq(irq);
+	if (unlikely(do_unmask_irq))
+		unmask_IO_APIC_irq(irq);
+}
+
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name 		= "IO-APIC",
 	.startup 	= startup_ioapic_vector,
 	.mask	 	= mask_ioapic_vector,
 	.unmask	 	= unmask_ioapic_vector,
-	.ack 		= ack_apic,
-	.eoi 		= ack_apic,
+	.ack 		= ack_apic_edge,
+	.eoi 		= ack_apic_level,
 #ifdef CONFIG_SMP
 	.set_affinity 	= set_ioapic_affinity_vector,
 #endif
-- 
1.4.0.gc07e

