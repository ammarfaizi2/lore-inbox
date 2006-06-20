Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWFTWcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWFTWcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWFTWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:31:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42973 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751397AbWFTW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:23 -0400
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
Subject: [PATCH 14/25] x86_64 irq: Move msi message composition into io_apic.c
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:27 -0600
Message-Id: <1150842523493-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425223015-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com>
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
 arch/x86_64/kernel/io_apic.c |   73 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/msi.h     |    7 +---
 include/asm-x86_64/msidef.h  |   47 +++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index ae64a63..7ad0980 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -42,6 +42,7 @@ #include <asm/mach_apic.h>
 #include <asm/acpi.h>
 #include <asm/dma.h>
 #include <asm/nmi.h>
+#include <asm/msidef.h>
 
 #define __apicdebuginit  __init
 
@@ -2061,6 +2062,78 @@ void destroy_irq(unsigned int irq)
 }
 #endif
 
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
+		cpumask_t tmp;
+
+		cpus_clear(tmp);
+		cpu_set(first_cpu(cpu_online_map), tmp);
+		dest = cpu_mask_to_apicid(tmp);
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
+#endif
+
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
    -------------------------------------------------------------------------- */
diff --git a/include/asm-x86_64/msi.h b/include/asm-x86_64/msi.h
index 3ad2346..1876fda 100644
--- a/include/asm-x86_64/msi.h
+++ b/include/asm-x86_64/msi.h
@@ -10,14 +10,11 @@ #include <asm/desc.h>
 #include <asm/mach_apic.h>
 #include <asm/smp.h>
 
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
 
diff --git a/include/asm-x86_64/msidef.h b/include/asm-x86_64/msidef.h
new file mode 100644
index 0000000..4667f1a
--- /dev/null
+++ b/include/asm-x86_64/msidef.h
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

