Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWFTWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWFTWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFTW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40669 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751378AbWFTW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:21 -0400
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
Subject: [PATCH 12/25] x86_64 irq:  Dynamic irq support
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:25 -0600
Message-Id: <11508425221394-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425222427-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of create_irq() is a hack
but it is the current hack that msi.c uses, and unfortunately
the ``generic'' apic msi ops depend on this hack.  Thus
we are this hack of assuming irq == vector until the depencencies
in the generic irq code are removed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/io_apic.c |   48 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index f50be45..ae64a63 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -2013,6 +2013,54 @@ static int __init ioapic_init_sysfs(void
 
 device_initcall(ioapic_init_sysfs);
 
+#ifdef CONFIG_PCI_MSI
+/*
+ * Dynamic irq allocate and deallocation for MSI
+ */
+int create_irq(void)
+{
+	/* Hack of the day: irq == vector.
+	 *
+	 * Ultimately this will be be more general,
+	 * and not depend on the irq to vector identity mapping.
+	 * But this version is needed until msi.c can cope with
+	 * the more general form.
+	 */
+	int irq, vector;
+	unsigned long flags;
+	vector = assign_irq_vector(AUTO_ASSIGN);
+	irq = vector;
+
+	if (vector >= 0) {
+		struct irq_desc *desc;
+
+		spin_lock_irqsave(&vector_lock, flags);
+		vector_irq[vector] = irq;
+		irq_vector[irq] = vector;
+		spin_unlock_irqrestore(&vector_lock, flags);
+		
+		set_intr_gate(vector, interrupt[irq]);
+
+		dynamic_irq_init(irq);
+	}
+	return irq;
+}
+
+void destroy_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int vector;
+
+	dynamic_irq_cleanup(irq);
+
+	spin_lock_irqsave(&vector_lock, flags);
+	vector = irq_vector[irq];
+	vector_irq[vector] = -1;
+	irq_vector[irq] = 0;
+	spin_unlock_irqrestore(&vector_lock, flags);
+}
+#endif
+
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
-- 
1.4.0.gc07e

