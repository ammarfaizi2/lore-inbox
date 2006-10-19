Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946125AbWJSPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946125AbWJSPla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946126AbWJSPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:41:30 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:59792 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1946125AbWJSPl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:41:29 -0400
Date: Thu, 19 Oct 2006 09:41:28 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
Subject: [PATCH] Block on access to temporarily unavailable pci device [version 3]
Message-ID: <20061019154128.GD2602@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017145146.GJ22289@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The existing implementation of pci_block_user_cfg_access() was recently
criticised for providing out of date information and for returning errors
on write, which applications won't be expecting.

This reimplementation uses a global wait queue and a bit per device.
I've open-coded prepare_to_wait() / finish_wait() as I could optimise
it significantly by knowing that the pci_lock protected us at all points.

It looked a bit funny to be doing a spin_unlock_irqsave(); schedule(),
so I used spin_lock_irq() for the _user versions of pci_read_config and
pci_write_config.  Not carrying a flags pointer around made the code
much less nasty.

Attempts to block an already blocked device hit a BUG() and attempts to
unblock an already unblocked device hit a WARN().  If we need to block
access to a device from userspace, it's because it's unsafe for even
another bit of the kernel to access the device.  An attempt to block
a device for a second time means we're about to access the device to
perform some other operation, which could provoke undefined behaviour
from the device.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ea16805..73a58c7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,6 +1,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/wait.h>
 
 #include "pci.h"
 
@@ -63,30 +64,42 @@ EXPORT_SYMBOL(pci_bus_write_config_byte)
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
-static u32 pci_user_cached_config(struct pci_dev *dev, int pos)
-{
-	u32 data;
+/*
+ * The following routines are to prevent the user from accessing PCI config
+ * space when it's unsafe to do so.  Some devices require this during BIST and
+ * we're required to prevent it during D-state transitions.
+ *
+ * We have a bit per device to indicate it's blocked and a global wait queue
+ * for callers to sleep on until devices are unblocked.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(pci_ucfg_wait);
 
-	data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])];
-	data >>= (pos % sizeof(dev->saved_config_space[0])) * 8;
-	return data;
+static noinline void pci_wait_ucfg(struct pci_dev *dev)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	__add_wait_queue(&pci_ucfg_wait, &wait);
+	do {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&pci_lock);
+		schedule();
+		spin_lock_irq(&pci_lock);
+	} while (dev->block_ucfg_access);
+	__remove_wait_queue(&pci_ucfg_wait, &wait);
 }
 
 #define PCI_USER_READ_CONFIG(size,type)					\
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
-	unsigned long flags;						\
 	int ret = 0;							\
 	u32 data = -1;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
-	spin_lock_irqsave(&pci_lock, flags);				\
-	if (likely(!dev->block_ucfg_access))				\
-		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+	spin_lock_irq(&pci_lock);					\
+	if (unlikely(dev->block_ucfg_access)) pci_wait_ucfg(dev);	\
+	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
-	else if (pos < sizeof(dev->saved_config_space))			\
-		data = pci_user_cached_config(dev, pos); 		\
-	spin_unlock_irqrestore(&pci_lock, flags);			\
+	spin_unlock_irq(&pci_lock);					\
 	*val = (type)data;						\
 	return ret;							\
 }
@@ -95,14 +108,13 @@ #define PCI_USER_WRITE_CONFIG(size,type)
 int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
-	unsigned long flags;						\
 	int ret = -EIO;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
-	spin_lock_irqsave(&pci_lock, flags);				\
-	if (likely(!dev->block_ucfg_access))				\
-		ret = dev->bus->ops->write(dev->bus, dev->devfn,	\
+	spin_lock_irq(&pci_lock);					\
+	if (unlikely(dev->block_ucfg_access)) pci_wait_ucfg(dev);	\
+	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
 					pos, sizeof(type), val);	\
-	spin_unlock_irqrestore(&pci_lock, flags);			\
+	spin_unlock_irq(&pci_lock);					\
 	return ret;							\
 }
 
@@ -117,21 +129,23 @@ PCI_USER_WRITE_CONFIG(dword, u32)
  * pci_block_user_cfg_access - Block userspace PCI config reads/writes
  * @dev:	pci device struct
  *
- * This function blocks any userspace PCI config accesses from occurring.
- * When blocked, any writes will be bit bucketed and reads will return the
- * data saved using pci_save_state for the first 64 bytes of config
- * space and return 0xff for all other config reads.
- **/
+ * When user access is blocked, any reads or writes to config space will
+ * sleep until access is unblocked again.  We don't allow nesting of
+ * block/unblock calls.
+ */
 void pci_block_user_cfg_access(struct pci_dev *dev)
 {
 	unsigned long flags;
+	int was_blocked;
 
-	pci_save_state(dev);
-
-	/* spinlock to synchronize with anyone reading config space now */
 	spin_lock_irqsave(&pci_lock, flags);
+	was_blocked = dev->block_ucfg_access;
 	dev->block_ucfg_access = 1;
 	spin_unlock_irqrestore(&pci_lock, flags);
+
+	/* If we BUG() inside the pci_lock, we're guaranteed to hose
+	 * the machine */
+	BUG_ON(was_blocked);
 }
 EXPORT_SYMBOL_GPL(pci_block_user_cfg_access);
 
@@ -140,14 +154,19 @@ EXPORT_SYMBOL_GPL(pci_block_user_cfg_acc
  * @dev:	pci device struct
  *
  * This function allows userspace PCI config accesses to resume.
- **/
+ */
 void pci_unblock_user_cfg_access(struct pci_dev *dev)
 {
 	unsigned long flags;
 
-	/* spinlock to synchronize with anyone reading saved config space */
 	spin_lock_irqsave(&pci_lock, flags);
+
+	/* This indicates a problem in the caller, but we don't need
+	 * to kill them, unlike a double-block above. */
+	WARN_ON(!dev->block_ucfg_access);
+
 	dev->block_ucfg_access = 0;
+	wake_up_all(&pci_ucfg_wait);
 	spin_unlock_irqrestore(&pci_lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_unblock_user_cfg_access);
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 2dde821..5d06837 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6174,6 +6174,7 @@ static int ipr_reset_start_bist(struct i
 	int rc;
 
 	ENTER;
+	pci_save_state(ioa_cfg->pdev);
 	pci_block_user_cfg_access(ioa_cfg->pdev);
 	rc = pci_write_config_byte(ioa_cfg->pdev, PCI_BIST, PCI_BIST_START);
 
