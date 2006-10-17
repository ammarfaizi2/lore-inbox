Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWJQOvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWJQOvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWJQOvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:51:48 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:19844 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751105AbWJQOvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:51:47 -0400
Date: Tue, 17 Oct 2006 08:51:46 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Adam Belay <abelay@MIT.EDU>
Subject: [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061017145146.GJ22289@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The existing implementation of pci_block_user_cfg_access() was recently
criticised for providing out of date information and for returning errors
on write, which applications won't be expecting.

This reimplementation uses an rw semaphore to block accesses.  I examined
a couple of other alternatives (a mutex, which would unnecessarily
serialise kernel BIST users; a per-device mutex, which would take another
16 bytes per pci device; a custom queue), I felt the rwsem provided the
best tradeoffs.

I'll post the patch I used to test blocking device accesses separately.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ea16805..29581a2 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,6 +1,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/rwsem.h>
 
 #include "pci.h"
 
@@ -12,6 +13,18 @@ #include "pci.h"
 static DEFINE_SPINLOCK(pci_lock);
 
 /*
+ * Prevent the user from accessing PCI config space when it's unsafe to do
+ * so.  Some devices require this during BIST and we're required to prevent
+ * it during D-state transitions.  It could be made per-device, but it doesn't
+ * seem worthwhile for such a rare occurrence.
+ *
+ * User accesses are the 'writer' as only one is allowed at a time.  Kernel
+ * blocking the user is the 'reader' as multiple devices can be blocked at
+ * the same time.
+ */
+static DECLARE_RWSEM(pci_user_sem);
+
+/*
  *  Wrappers for all PCI configuration access functions.  They just check
  *  alignment, do locking and call the low-level functions pointed to
  *  by pci_dev->ops.
@@ -63,15 +76,6 @@ EXPORT_SYMBOL(pci_bus_write_config_byte)
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
-static u32 pci_user_cached_config(struct pci_dev *dev, int pos)
-{
-	u32 data;
-
-	data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])];
-	data >>= (pos % sizeof(dev->saved_config_space[0])) * 8;
-	return data;
-}
-
 #define PCI_USER_READ_CONFIG(size,type)					\
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
@@ -80,13 +84,12 @@ int pci_user_read_config_##size						\
 	int ret = 0;							\
 	u32 data = -1;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	down_write(&pci_user_sem);					\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	if (likely(!dev->block_ucfg_access))				\
-		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
-	else if (pos < sizeof(dev->saved_config_space))			\
-		data = pci_user_cached_config(dev, pos); 		\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
+	up_write(&pci_user_sem);					\
 	*val = (type)data;						\
 	return ret;							\
 }
@@ -98,11 +101,12 @@ int pci_user_write_config_##size					\
 	unsigned long flags;						\
 	int ret = -EIO;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
+	down_write(&pci_user_sem);					\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	if (likely(!dev->block_ucfg_access))				\
-		ret = dev->bus->ops->write(dev->bus, dev->devfn,	\
+	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
 					pos, sizeof(type), val);	\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
+	up_write(&pci_user_sem);					\
 	return ret;							\
 }
 
@@ -117,21 +121,12 @@ PCI_USER_WRITE_CONFIG(dword, u32)
  * pci_block_user_cfg_access - Block userspace PCI config reads/writes
  * @dev:	pci device struct
  *
- * This function blocks any userspace PCI config accesses from occurring.
- * When blocked, any writes will be bit bucketed and reads will return the
- * data saved using pci_save_state for the first 64 bytes of config
- * space and return 0xff for all other config reads.
- **/
+ * When user access is blocked, any reads or writes to config space will
+ * sleep until access is unblocked again.
+ */
 void pci_block_user_cfg_access(struct pci_dev *dev)
 {
-	unsigned long flags;
-
-	pci_save_state(dev);
-
-	/* spinlock to synchronize with anyone reading config space now */
-	spin_lock_irqsave(&pci_lock, flags);
-	dev->block_ucfg_access = 1;
-	spin_unlock_irqrestore(&pci_lock, flags);
+	down_read(&pci_user_sem);
 }
 EXPORT_SYMBOL_GPL(pci_block_user_cfg_access);
 
@@ -140,14 +135,9 @@ EXPORT_SYMBOL_GPL(pci_block_user_cfg_acc
  * @dev:	pci device struct
  *
  * This function allows userspace PCI config accesses to resume.
- **/
+ */
 void pci_unblock_user_cfg_access(struct pci_dev *dev)
 {
-	unsigned long flags;
-
-	/* spinlock to synchronize with anyone reading saved config space */
-	spin_lock_irqsave(&pci_lock, flags);
-	dev->block_ucfg_access = 0;
-	spin_unlock_irqrestore(&pci_lock, flags);
+	up_read(&pci_user_sem);
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
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3632282..4dbcbbd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -174,7 +174,6 @@ struct pci_dev {
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	no_d1d2:1;   /* only allow d0 or d3 */
-	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int 	msi_enabled:1;
 	unsigned int	msix_enabled:1;
