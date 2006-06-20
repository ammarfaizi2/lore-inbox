Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWFTWhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWFTWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFTWfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:35:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59364 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751361AbWFTW3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:02 -0400
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
Subject: [PATCH 15/25] i386 irq: Move msi message composition into io_apic.c
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:28 -0600
Message-Id: <11508425231168-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842523493-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the hardcoded assumption that irq == vector in the
msi composition code, and it allows the msi message composition
to setup logical mode, or lowest priorirty delivery mode as we
do for other apic interrupts, and with the same selection criteria.

Basically this moves the problem of what is in the msi message into
the architecture irq management code where it belongs.  Not in
a generic layer that doesn't have enough information to compose
msi messages properly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/io_apic.c |   70 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/msi.h     |    7 +---
 include/asm-i386/msidef.h  |   47 ++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 04f78ff..68af125 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -32,6 +32,7 @@ #include <linux/compiler.h>
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -39,6 +40,7 @@ #include <asm/desc.h>
 #include <asm/timer.h>
 #include <asm/i8259.h>
 #include <asm/nmi.h>
+#include <asm/msidef.h>
 
 #include <mach_apic.h>
 #include <mach_apicdef.h>
@@ -2545,6 +2547,74 @@ void destroy_irq(unsigned int irq)
 }
 #endif /* CONFIG_PCI_MSI */
 
+/*
+ * MSI mesage composition
+ */
+#ifdef CONFIG_PCI_MSI
+static int msi_msg_setup(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
+{
+	/* For now always this code always uses physical delivery
+	 * mode.
+	 */
+	int vector;
+	unsigned dest;
+
+	vector = assign_irq_vector(irq);
+	if (vector >= 0) {
+		dest = cpu_mask_to_apicid(TARGET_CPUS);
+
+		msg->address_hi = MSI_ADDR_BASE_HI;
+		msg->address_lo =
+			MSI_ADDR_BASE_LO |
+			((INT_DEST_MODE == 0) ?
+				MSI_ADDR_DEST_MODE_PHYSICAL:
+				MSI_ADDR_DEST_MODE_LOGICAL) |
+			((INT_DELIVERY_MODE != dest_LowestPrio) ?
+				MSI_ADDR_REDIRECTION_CPU:
+				MSI_ADDR_REDIRECTION_LOWPRI) |
+			MSI_ADDR_DEST_ID(dest);
+
+		msg->data = 
+			MSI_DATA_TRIGGER_EDGE |	
+			MSI_DATA_LEVEL_ASSERT |
+			((INT_DELIVERY_MODE != dest_LowestPrio) ?
+				MSI_DATA_DELIVERY_FIXED:
+				MSI_DATA_DELIVERY_LOWPRI) |
+			MSI_DATA_VECTOR(vector); 
+	}
+	return vector;
+}
+
+static void msi_msg_teardown(unsigned int irq)
+{
+	return;
+}
+
+static void msi_msg_set_affinity(unsigned int irq, cpumask_t mask, struct msi_msg *msg)
+{
+	int vector;
+	unsigned dest;
+
+	vector = assign_irq_vector(irq);
+	if (vector > 0) {
+		dest = cpu_mask_to_apicid(mask);
+
+		msg->data &= ~MSI_DATA_VECTOR_MASK;
+		msg->data |= MSI_DATA_VECTOR(vector);
+		msg->address_lo &= ~MSI_ADDR_DEST_ID_MASK;
+		msg->address_lo |= MSI_ADDR_DEST_ID(dest);
+	}
+}
+
+struct msi_ops arch_msi_ops = {
+	.needs_64bit_address = 0,
+	.setup = msi_msg_setup,
+	.teardown = msi_msg_teardown,
+	.target = msi_msg_set_affinity,
+};
+
+#endif /* CONFIG_PCI_MSI */
+
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
diff --git a/include/asm-i386/msi.h b/include/asm-i386/msi.h
index b11c4b7..7368a89 100644
--- a/include/asm-i386/msi.h
+++ b/include/asm-i386/msi.h
@@ -9,14 +9,11 @@ #define ASM_MSI_H
 #include <asm/desc.h>
 #include <mach_apic.h>
 
-#define LAST_DEVICE_VECTOR	(FIRST_SYSTEM_VECTOR - 1)
-#define MSI_TARGET_CPU_SHIFT	12
-
-extern struct msi_ops msi_apic_ops;
+extern struct msi_ops arch_msi_ops;
 
 static inline int msi_arch_init(void)
 {
-	msi_register(&msi_apic_ops);
+	msi_register(&arch_msi_ops);
 	return 0;
 }
 
diff --git a/include/asm-i386/msidef.h b/include/asm-i386/msidef.h
new file mode 100644
index 0000000..4667f1a
--- /dev/null
+++ b/include/asm-i386/msidef.h
@@ -0,0 +1,47 @@
+#ifndef ASM_MSIDEF_H
+#define ASM_MSIDEF_H
+
+/*
+ * Constants for Intel APIC based MSI messages.
+ */
+
+/*
+ * Shifts for MSI data
+ */
+
+#define MSI_DATA_VECTOR_SHIFT		0
+#define  MSI_DATA_VECTOR_MASK		0x000000ff
+#define	 MSI_DATA_VECTOR(v)		(((v) << MSI_DATA_VECTOR_SHIFT) & MSI_DATA_VECTOR_MASK)
+
+#define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
+#define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
+
+#define MSI_DATA_LEVEL_SHIFT		14
+#define	 MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
+#define	 MSI_DATA_LEVEL_ASSERT		(1 << MSI_DATA_LEVEL_SHIFT)
+
+#define MSI_DATA_TRIGGER_SHIFT		15
+#define  MSI_DATA_TRIGGER_EDGE		(0 << MSI_DATA_TRIGGER_SHIFT)
+#define  MSI_DATA_TRIGGER_LEVEL		(1 << MSI_DATA_TRIGGER_SHIFT)
+
+/*
+ * Shift/mask fields for msi address
+ */
+
+#define MSI_ADDR_BASE_HI		0
+#define MSI_ADDR_BASE_LO		0xfee00000
+
+#define MSI_ADDR_DEST_MODE_SHIFT	2
+#define  MSI_ADDR_DEST_MODE_PHYSICAL	(0 << MSI_ADDR_DEST_MODE_SHIFT)
+#define	 MSI_ADDR_DEST_MODE_LOGICAL	(1 << MSI_ADDR_DEST_MODE_SHIFT)
+	
+#define MSI_ADDR_REDIRECTION_SHIFT	3
+#define  MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT) /* dedicated cpu */
+#define  MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT) /* lowest priority */
+
+#define MSI_ADDR_DEST_ID_SHIFT		12
+#define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0
+#define  MSI_ADDR_DEST_ID(dest)		(((dest) << MSI_ADDR_DEST_ID_SHIFT) & MSI_ADDR_DEST_ID_MASK)
+
+#endif /* ASM_MSIDEF_H */
-- 
1.4.0.gc07e

