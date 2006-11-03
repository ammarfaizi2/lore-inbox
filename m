Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWKCVqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWKCVqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWKCVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:46:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55250 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932160AbWKCVqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:46:51 -0500
Date: Fri, 3 Nov 2006 14:46:30 -0700
Message-Id: <200611032146.kA3LkUe9031799@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: [RFC][PATCH 2/2] htirq:  Allow buggy drivers of buggy hardware to write the registers.
In-Reply-To: <m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Fri, 03 Nov 2006 13:43:23 -0700")
References: <454A7B0F.7060701@pathscale.com>
	<m1odrpymqc.fsf@ebiederm.dsl.xmission.com>
	<454B7B70.9060104@pathscale.com>
	<m1d584xutk.fsf@ebiederm.dsl.xmission.com>
	<454B880A.1010802@pathscale.com>
	<m1zmb8wexd.fsf@ebiederm.dsl.xmission.com>
	<454B8E19.90300@pathscale.com>
	<m1irhww9f9.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ejskw9as.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
cc: olson@pathscale.com, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc olson@pathscale.com,  <linux-kernel@vger.kernel.org>
Date: Fri, 03 Nov 2006 14:46:30 -0700
Message-ID: <m1ejskurt5.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


This patch adds a variant of ht_create_irq __ht_create_irq that
takes an aditional parameter update that is a function that is
called whenever we want to write to a drivers htirq configuration
registers.

This is needed to support the ipath_iba6110 because it's registers
in the proper location are not actually conected to the hardware
that controlls interrupt delivery.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/htirq.c   |   46 +++++++++++++++++++++++++++++++++-------------
 include/linux/htirq.h |    4 ++++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/htirq.c b/drivers/pci/htirq.c
index e346fe3..6ed53c5 100644
--- a/drivers/pci/htirq.c
+++ b/drivers/pci/htirq.c
@@ -25,6 +25,8 @@ static DEFINE_SPINLOCK(ht_irq_lock);
 
 struct ht_irq_cfg {
 	struct pci_dev *dev;
+	 /* Update callback used to cope with buggy hardware */
+	ht_irq_update_t *update;
 	unsigned pos;
 	unsigned idx;
 	struct ht_irq_msg msg;
@@ -36,14 +38,17 @@ void write_ht_irq_msg(unsigned int irq, 
 	struct ht_irq_cfg *cfg = get_irq_data(irq);
 	unsigned long flags;
 	spin_lock_irqsave(&ht_irq_lock, flags);
-	if (cfg->msg.address_lo != msg->address_lo) {
-		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
-		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_lo);
-	}
-	if (cfg->msg.address_hi != msg->address_hi) {
-		pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
-		pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_hi);
-	}
+	if (!likely(cfg->update)) {
+		if (cfg->msg.address_lo != msg->address_lo) {
+			pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx);
+			pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_lo);
+		}
+		if (cfg->msg.address_hi != msg->address_hi) {
+			pci_write_config_byte(cfg->dev, cfg->pos + 2, cfg->idx + 1);
+			pci_write_config_dword(cfg->dev, cfg->pos + 4, msg->address_hi);
+		}
+	} else
+		cfg->update(irq, msg);
 	spin_unlock_irqrestore(&ht_irq_lock, flags);
 	cfg->msg = *msg;
 }
@@ -79,16 +84,14 @@ void unmask_ht_irq(unsigned int irq)
 }
 
 /**
- * ht_create_irq - create an irq and attach it to a device.
+ * __ht_create_irq - create an irq and attach it to a device.
  * @dev: The hypertransport device to find the irq capability on.
  * @idx: Which of the possible irqs to attach to.
- *
- * ht_create_irq is needs to be called for all hypertransport devices
- * that generate irqs.
+ * @update: Function to be called when changing the htirq message
  *
  * The irq number of the new irq or a negative error value is returned.
  */
-int ht_create_irq(struct pci_dev *dev, int idx)
+int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update)
 {
 	struct ht_irq_cfg *cfg;
 	unsigned long flags;
@@ -123,6 +126,7 @@ int ht_create_irq(struct pci_dev *dev, i
 		return -ENOMEM;
 
 	cfg->dev = dev;
+	cfg->update = update;
 	cfg->pos = pos;
 	cfg->idx = 0x10 + (idx * 2);
 	/* Initialize msg to a value that will never match the first write. */
@@ -145,6 +149,21 @@ int ht_create_irq(struct pci_dev *dev, i
 }
 
 /**
+ * ht_create_irq - create an irq and attach it to a device.
+ * @dev: The hypertransport device to find the irq capability on.
+ * @idx: Which of the possible irqs to attach to.
+ *
+ * ht_create_irq needs to be called for all hypertransport devices
+ * that generate irqs.
+ *
+ * The irq number of the new irq or a negative error value is returned.
+ */
+int ht_create_irq(struct pci_dev *dev, int idx)
+{
+	return __ht_create_irq(dev, idx, NULL);
+}
+
+/**
  * ht_destroy_irq - destroy an irq created with ht_create_irq
  *
  * This reverses ht_create_irq removing the specified irq from
@@ -162,5 +181,6 @@ void ht_destroy_irq(unsigned int irq)
 	kfree(cfg);
 }
 
+EXPORT_SYMBOL(__ht_create_irq);
 EXPORT_SYMBOL(ht_create_irq);
 EXPORT_SYMBOL(ht_destroy_irq);
diff --git a/include/linux/htirq.h b/include/linux/htirq.h
index 108f0d9..8adacc2 100644
--- a/include/linux/htirq.h
+++ b/include/linux/htirq.h
@@ -15,4 +15,8 @@ void unmask_ht_irq(unsigned int irq);
 /* The arch hook for getting things started */
 int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev);
 
+/* For drivers of buggy hardware */
+typedef void (ht_irq_update_t)(int irq, struct ht_irq_msg *);
+int __ht_create_irq(struct pci_dev *dev, int idx, ht_irq_update_t *update);
+
 #endif /* LINUX_HTIRQ_H */
-- 
1.4.2.rc3.g7e18e-dirty

