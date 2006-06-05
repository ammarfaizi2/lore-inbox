Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750770AbWFEIfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWFEIfs (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFEIfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:35:31 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23438 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750772AbWFEIfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:35:20 -0400
Subject: [PATCH 4/9] PCI PM: save and restore configuration state correctly
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:05 -0400
Message-Id: <1149497166.7831.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates pci_save_state() and pci_restore_state() to be more
in line with the PCI PM specification.  Specifically, read-only
registers are no longer saved, BIST is never touched, and the command
register is handled more carefully.  A new data structure "struct
pci_dev_config" is created to store any context that might need to be
saved before entering a higher power state.

The configuration space cache is now obsolete and no longer needed for
PCI PM.  However, this patch does not remove it as it is still
referenced by the PCI configuration space access restriction code.  As
an unexpected bonus, this patch also fixes a possible memory leak;
drivers/pci/access.c wasn't expecting the MSI code in pci_save_state().

Signed-off-by: Adam Belay <abelay@novell.com>

---
 drivers/pci/access.c |   17 ++++++++++-------
 drivers/pci/pm.c     |   29 +++++++++++++++++++++++------
 include/linux/pci.h  |   12 +++++++++++-
 3 files changed, 44 insertions(+), 14 deletions(-)

diff -urN a/drivers/pci/access.c b/drivers/pci/access.c
--- a/drivers/pci/access.c	2006-06-03 16:21:16.000000000 -0400
+++ b/drivers/pci/access.c	2006-06-02 00:40:28.000000000 -0400
@@ -67,8 +67,8 @@
 {
 	u32 data;
 
-	data = dev->saved_config_space[pos/sizeof(dev->saved_config_space[0])];
-	data >>= (pos % sizeof(dev->saved_config_space[0])) * 8;
+	data = dev->cached_config_space[pos/sizeof(dev->cached_config_space[0])];
+	data >>= (pos % sizeof(dev->cached_config_space[0])) * 8;
 	return data;
 }
 
@@ -84,7 +84,7 @@
 	if (likely(!dev->block_ucfg_access))				\
 		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
 					pos, sizeof(type), &data);	\
-	else if (pos < sizeof(dev->saved_config_space))			\
+	else if (pos < sizeof(dev->cached_config_space))		\
 		data = pci_user_cached_config(dev, pos); 		\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	*val = (type)data;						\
@@ -118,15 +118,18 @@
  * @dev:	pci device struct
  *
  * This function blocks any userspace PCI config accesses from occurring.
- * When blocked, any writes will be bit bucketed and reads will return the
- * data saved using pci_save_state for the first 64 bytes of config
- * space and return 0xff for all other config reads.
+ * When blocked, any writes will be bit bucketed and reads will return cached
+ * data for the first 64 bytes of config space and return 0xff for all other
+ * config reads.
  **/
 void pci_block_user_cfg_access(struct pci_dev *dev)
 {
 	unsigned long flags;
+	int i;
 
-	pci_save_state(dev);
+	/* NOTE: 100% dword access ok here? */
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4, &dev->cached_config_space[i]);
 
 	/* spinlock to synchronize with anyone reading config space now */
 	spin_lock_irqsave(&pci_lock, flags);
diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-03 16:21:16.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-03 16:46:08.000000000 -0400
@@ -58,13 +58,19 @@
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
-	/* XXX: 100% dword access ok here? */
-	for (i = 0; i < 16; i++)
-		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
+	struct pci_dev_config * conf = &dev->saved_config;
+
+	pci_read_config_word(dev, PCI_COMMAND, &conf->command);
+	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &conf->cacheline_size);
+	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &conf->latency_timer);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &conf->interrupt_pin);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &conf->interrupt_line);
+
 	if ((i = pci_save_msi_state(dev)) != 0)
 		return i;
 	if ((i = pci_save_msix_state(dev)) != 0)
 		return i;
+
 	return 0;
 }
 
@@ -76,12 +82,23 @@
  */
 int pci_restore_state(struct pci_dev *dev)
 {
-	int i;
+	u16 command;
+	struct pci_dev_config * conf = &dev->saved_config;
+
+	command = conf->command & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+				    PCI_COMMAND_MASTER);
+
+	pci_write_config_word(dev, PCI_COMMAND, command);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, conf->cacheline_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, conf->latency_timer);
+	pci_write_config_byte(dev, PCI_INTERRUPT_PIN, conf->interrupt_pin);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, conf->interrupt_line);
+
+	pci_restore_bars(dev);
 
-	for (i = 0; i < 16; i++)
-		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
 	pci_restore_msi_state(dev);
 	pci_restore_msix_state(dev);
+
 	return 0;
 }
 
diff -urN a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2006-06-03 16:21:16.000000000 -0400
+++ b/include/linux/pci.h	2006-06-03 16:27:45.000000000 -0400
@@ -68,6 +68,14 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+struct pci_dev_config {
+	unsigned short	command;
+	unsigned char	cacheline_size;
+	unsigned char	latency_timer;
+	unsigned char	interrupt_pin;
+	unsigned char	interrupt_line;
+};
+
 struct pci_dev_pm {
 	unsigned int	pm_offset;	/* the PCI PM capability offset */
 
@@ -183,7 +191,9 @@
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
 
-	u32		saved_config_space[16]; /* config space saved at suspend time */
+	u32		cached_config_space[16]; /* config space saved at suspend time */
+	struct pci_dev_config saved_config; /* config space saved for power management */
+
 	struct hlist_head saved_cap_space;
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */


