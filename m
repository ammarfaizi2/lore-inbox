Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWKCUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWKCUnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbWKCUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:43:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41677 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753508AbWKCUnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:43:45 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: [PATCH 1/2] htirq: Refactor so we only have one function that writes to the chip.
References: <454A7B0F.7060701@pathscale.com>
	<m1odrpymqc.fsf@ebiederm.dsl.xmission.com>
	<454B7B70.9060104@pathscale.com>
	<m1d584xutk.fsf@ebiederm.dsl.xmission.com>
	<454B880A.1010802@pathscale.com>
	<m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>
	<454B8E19.90300@pathscale.com>
	<m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com>
cc: olson@pathscale.com, <linux-kernel@vger.kernel.org>
Date: Fri, 03 Nov 2006 13:43:23 -0700
In-Reply-To: <m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Fri, 03 Nov 2006 13:40:42 -0700")
Message-ID: <m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This refactoring actually optimizes the code a little by caching
the value that we think the device is programmed with instead of
reading it back from the hardware.  Which simplifies the code a
little and should speed things up a bit.

This patch introduces the concept of a ht_irq_msg and modifies
the architecture read/write routines to update this code.

There is a minor consistency fix here as well as x86_64 forgot
to initialize the htirq as masked.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/io_apic.c   |   26 +++++++--------
 arch/x86_64/kernel/io_apic.c |   31 +++++++++---------
 drivers/pci/htirq.c          |   72 ++++++++++++++----------------------------
 include/linux/htirq.h        |   11 ++++--
 4 files changed, 58 insertions(+), 82 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 507983c..798d812 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2624,18 +2624,16 @@ #ifdef CONFIG_SMP
 
 static void target_ht_irq(unsigned int irq, unsigned int dest)
 {
-	u32 low, high;
-	low  = read_ht_irq_low(irq);
-	high = read_ht_irq_high(irq);
+	struct ht_irq_msg msg;
+	fetch_ht_irq_msg(irq, &msg);
 
-	low  &= ~(HT_IRQ_LOW_DEST_ID_MASK);
-	high &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
+	msg.address_lo &= ~(HT_IRQ_LOW_DEST_ID_MASK);
+	msg.address_hi &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
 
-	low  |= HT_IRQ_LOW_DEST_ID(dest);
-	high |= HT_IRQ_HIGH_DEST_ID(dest);
+	msg.address_lo |= HT_IRQ_LOW_DEST_ID(dest);
+	msg.address_hi |= HT_IRQ_HIGH_DEST_ID(dest);
 
-	write_ht_irq_low(irq, low);
-	write_ht_irq_high(irq, high);
+	write_ht_irq_msg(irq, &msg);
 }
 
 static void set_ht_irq_affinity(unsigned int irq, cpumask_t mask)
@@ -2673,7 +2671,7 @@ int arch_setup_ht_irq(unsigned int irq, 
 
 	vector = assign_irq_vector(irq);
 	if (vector >= 0) {
-		u32 low, high;
+		struct ht_irq_msg msg;
 		unsigned dest;
 		cpumask_t tmp;
 
@@ -2681,9 +2679,10 @@ int arch_setup_ht_irq(unsigned int irq, 
 		cpu_set(vector >> 8, tmp);
 		dest = cpu_mask_to_apicid(tmp);
 
-		high = 	HT_IRQ_HIGH_DEST_ID(dest);
+		msg.address_hi = HT_IRQ_HIGH_DEST_ID(dest);
 
-		low =	HT_IRQ_LOW_BASE |
+		msg.address_lo = 
+			HT_IRQ_LOW_BASE |
 			HT_IRQ_LOW_DEST_ID(dest) |
 			HT_IRQ_LOW_VECTOR(vector) |
 			((INT_DEST_MODE == 0) ?
@@ -2695,8 +2694,7 @@ int arch_setup_ht_irq(unsigned int irq, 
 				HT_IRQ_LOW_MT_ARBITRATED) |
 			HT_IRQ_LOW_IRQ_MASKED;
 
-		write_ht_irq_low(irq, low);
-		write_ht_irq_high(irq, high);
+		write_ht_irq_msg(irq, &msg);
 
 		set_irq_chip_and_handler_name(irq, &ht_irq_chip,
 					      handle_edge_irq, "edge");
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index fe429e5..6524516 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -1889,18 +1889,16 @@ #ifdef CONFIG_SMP
 
 static void target_ht_irq(unsigned int irq, unsigned int dest, u8 vector)
 {
-	u32 low, high;
-	low  = read_ht_irq_low(irq);
-	high = read_ht_irq_high(irq);
+	struct ht_irq_msg msg;
+	fetch_ht_irq_msg(irq, &msg);
 
-	low  &= ~(HT_IRQ_LOW_VECTOR_MASK | HT_IRQ_LOW_DEST_ID_MASK);
-	high &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
+	msg.address_lo &= ~(HT_IRQ_LOW_VECTOR_MASK | HT_IRQ_LOW_DEST_ID_MASK);
+	msg.address_hi &= ~(HT_IRQ_HIGH_DEST_ID_MASK);
 
-	low  |= HT_IRQ_LOW_VECTOR(vector) | HT_IRQ_LOW_DEST_ID(dest);
-	high |= HT_IRQ_HIGH_DEST_ID(dest);
+	msg.address_lo |= HT_IRQ_LOW_VECTOR(vector) | HT_IRQ_LOW_DEST_ID(dest);
+	msg.address_hi |= HT_IRQ_HIGH_DEST_ID(dest);
 
-	write_ht_irq_low(irq, low);
-	write_ht_irq_high(irq, high);
+	write_ht_irq_msg(irq, &msg);
 }
 
 static void set_ht_irq_affinity(unsigned int irq, cpumask_t mask)
@@ -1921,7 +1919,7 @@ static void set_ht_irq_affinity(unsigned
 
 	dest = cpu_mask_to_apicid(tmp);
 
-	target_ht_irq(irq, dest, vector & 0xff);
+	target_ht_irq(irq, dest, vector);
 	set_native_irq_info(irq, mask);
 }
 #endif
@@ -1944,14 +1942,15 @@ int arch_setup_ht_irq(unsigned int irq, 
 
 	vector = assign_irq_vector(irq, TARGET_CPUS, &tmp);
 	if (vector >= 0) {
-		u32 low, high;
+		struct ht_irq_msg msg;
 		unsigned dest;
 
 		dest = cpu_mask_to_apicid(tmp);
 
-		high = 	HT_IRQ_HIGH_DEST_ID(dest);
+		msg.address_hi = HT_IRQ_HIGH_DEST_ID(dest);
 
-		low =	HT_IRQ_LOW_BASE |
+		msg.address_lo = 
+			HT_IRQ_LOW_BASE |
 			HT_IRQ_LOW_DEST_ID(dest) |
 			HT_IRQ_LOW_VECTOR(vector) |
 			((INT_DEST_MODE == 0) ?
@@ -1960,10 +1959,10 @@ int arch_setup_ht_irq(unsigned int irq, 
 			HT_IRQ_LOW_RQEOI_EDGE |
 			((INT_DELIVERY_MODE != dest_LowestPrio) ?
 				HT_IRQ_LOW_MT_FIXED :
-				HT_IRQ_LOW_MT_ARBITRATED);
+				HT_IRQ_LOW_MT_ARBITRATED) |
+			HT_IRQ_LOW_IRQ_MASKED;
 
-		write_ht_irq_low(irq, low);
-		write_ht_irq_high(irq, high);
+		write_ht_irq_msg(irq, &msg);
 
 		set_irq_chip_and_handler_name(irq, &ht_irq_chip,
 					      handle_edge_irq, "edge");
diff --git a/drivers/pci/htirq.c b/drivers/pci/htirq.c
index 0e27f24..e346fe3 100644
--- a/drivers/pci/htirq.c
+++ b/drivers/pci/htirq.c
@@ -27,82 +27,55 @@ struct ht_irq_cfg {
 	struct pci_dev *dev;
 	unsigned pos;
 	unsigned idx;
+	struct ht_irq_msg msg;
 };
 
-void write_ht_irq_low(unsigned int irq, u32 data)
-{
-	struct ht_irq_cfg *cfg = get_irq_data(irq);
-	unsigned long flags;
-	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
-	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
-	spin_unlock_irqrestore(&ht_irq_lock, flags);
-}
-
-void write_ht_irq_high(unsigned int irq, u32 data)
-{
-	struct ht_irq_cfg *cfg = get_irq_data(irq);
-	unsigned long flags;
-	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
-	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
-	spin_unlock_irqrestore(&ht_irq_lock, flags);
-}
 
-u32 read_ht_irq_low(unsigned int irq)
+void write_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg)
 {
 	struct ht_irq_cfg *cfg = get_irq_data(irq);
 	unsigned long flags;
-	u32 data;
 	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
-	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
+	if (cfg->msg.address_lo != msg->address_lo) {
+		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_lo);
+	}
+	if (cfg->msg.address_hi != msg->address_hi) {
+		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
+		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_hi);
+	}
 	spin_unlock_irqrestore(&ht_irq_lock, flags);
-	return data;
+	cfg->msg = *msg;
 }
 
-u32 read_ht_irq_high(unsigned int irq)
+void fetch_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg)
 {
 	struct ht_irq_cfg *cfg = get_irq_data(irq);
-	unsigned long flags;
-	u32 data;
-	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
-	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
-	spin_unlock_irqrestore(&ht_irq_lock, flags);
-	return data;
+	*msg = cfg->msg;
 }
 
 void mask_ht_irq(unsigned int irq)
 {
 	struct ht_irq_cfg *cfg;
-	unsigned long flags;
-	u32 data;
+	struct ht_irq_msg msg;
 
 	cfg = get_irq_data(irq);
 
-	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
-	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
-	data |= 1;
-	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
-	spin_unlock_irqrestore(&ht_irq_lock, flags);
+	msg = cfg->msg;
+	msg.address_lo |= 1;
+	write_ht_irq_msg(irq, &msg);
 }
 
 void unmask_ht_irq(unsigned int irq)
 {
 	struct ht_irq_cfg *cfg;
-	unsigned long flags;
-	u32 data;
+	struct ht_irq_msg msg;
 
 	cfg = get_irq_data(irq);
 
-	spin_lock_irqsave(&ht_irq_lock, flags);
-	pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
-	pci_read_config_dword(cfg->dev, cfg->pos + 4, &data);
-	data &= ~1;
-	pci_write_config_dword(cfg->dev, cfg->pos + 4, data);
-	spin_unlock_irqrestore(&ht_irq_lock, flags);
+	msg = cfg->msg;
+	msg.address_lo &= ~1;
+	write_ht_irq_msg(irq, &msg);
 }
 
 /**
@@ -152,6 +125,9 @@ int ht_create_irq(struct pci_dev *dev, i
 	cfg->dev = dev;
 	cfg->pos = pos;
 	cfg->idx = 0x10 + (idx * 2);
+	/* Initialize msg to a value that will never match the first write. */
+	cfg->msg.address_lo = 0xffffffff;
+	cfg->msg.address_hi = 0xffffffff;
 
 	irq = create_irq();
 	if (irq < 0) {
diff --git a/include/linux/htirq.h b/include/linux/htirq.h
index 1f15ce2..108f0d9 100644
--- a/include/linux/htirq.h
+++ b/include/linux/htirq.h
@@ -1,11 +1,14 @@
 #ifndef LINUX_HTIRQ_H
 #define LINUX_HTIRQ_H
 
+struct ht_irq_msg {
+	u32	address_lo;	/* low 32 bits of the ht irq message */
+	u32	address_hi;	/* high 32 bits of the it irq message */
+};
+
 /* Helper functions.. */
-void write_ht_irq_low(unsigned int irq, u32 data);
-void write_ht_irq_high(unsigned int irq, u32 data);
-u32  read_ht_irq_low(unsigned int irq);
-u32  read_ht_irq_high(unsigned int irq);
+void fetch_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg);
+void write_ht_irq_msg(unsigned int irq, struct ht_irq_msg *msg);
 void mask_ht_irq(unsigned int irq);
 void unmask_ht_irq(unsigned int irq);
 
-- 
1.4.2.rc3.g7e18e-dirty

