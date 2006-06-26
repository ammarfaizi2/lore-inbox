Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933087AbWFZWQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087AbWFZWQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933090AbWFZWQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:16:03 -0400
Received: from web50115.mail.yahoo.com ([206.190.39.163]:16538 "HELO
	web50115.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933087AbWFZWQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:16:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UHu+Go0joymyCa7dM3Dl2WnfksQV8Zm+JSiv+B2a3JjkkkiAatvgTb6Ics0d2jXAlUrmSKhXMHjGr8CvPyndUL+hpKkhT+a0Wn3AlqKB2XawzN1BQ2yb0nFX7V+zcgoPo5ppwx54Z+S8/YP8K2tsrganSStblIvMtgoVjegP218=  ;
Message-ID: <20060626221558.11917.qmail@web50115.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:15:58 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 1/6]  EDAC PCI device to DEVICE cleanup
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

Change MC drivers from using CVS revision strings for their version number,
Now each driver has its own local string.

Remove some PCI dependencies from the core EDAC module.  
Made the code 'struct device' centric instead of 'struct pci_dev'
Most of the code changes here are from a patch by Dave Jiang.
It may be best to eventually move the PCI-specific code into a separate source file.

Signed-off-by:  Doug Thompson <norsk5@xmission.com>
---

 amd76x_edac.c  |   23 +-
 e752x_edac.c   |   23 +-
 e7xxx_edac.c   |   16 -
 edac_mc.c      |  538 +++++++++++++++++++++++++++++----------------------------
 edac_mc.h      |   16 +
 i82860_edac.c  |   30 +--
 i82875p_edac.c |   30 +--
 r82600_edac.c  |   21 +-
 8 files changed, 374 insertions(+), 323 deletions(-)


Index: linux-2.6.17-rc6/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/edac_mc.h	2006-06-12 18:17:17.000000000 -0600
+++ linux-2.6.17-rc6/drivers/edac/edac_mc.h	2006-06-12 18:17:29.000000000 -0600
@@ -88,6 +88,12 @@
 #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
 	PCI_DEVICE_ID_ ## vend ## _ ## dev
 
+#if defined(CONFIG_X86) && defined(CONFIG_PCI)
+#define dev_name(dev) pci_name(to_pci_dev(dev))
+#else
+#define dev_name(dev) to_platform_device(dev)->name
+#endif
+
 /* memory devices */
 enum dev_type {
 	DEV_UNKNOWN = 0,
@@ -327,10 +333,10 @@
 	struct csrow_info *csrows;
 	/*
 	 * FIXME - what about controllers on other busses? - IDs must be
-	 * unique.  pdev pointer should be sufficiently unique, but
+	 * unique.  dev pointer should be sufficiently unique, but
 	 * BUS:SLOT.FUNC numbers may not be unique.
 	 */
-	struct pci_dev *pdev;
+	struct device *dev;
 	const char *mod_name;
 	const char *mod_ver;
 	const char *ctl_name;
@@ -353,6 +359,8 @@
 	struct completion kobj_complete;
 };
 
+#ifdef CONFIG_PCI
+
 /* write all or some bits in a byte-register*/
 static inline void pci_write_bits8(struct pci_dev *pdev, int offset, u8 value,
 		u8 mask)
@@ -401,6 +409,8 @@
 	pci_write_config_dword(pdev, offset, value);
 }
 
+#endif /* CONFIG_PCI */
+
 #ifdef CONFIG_EDAC_DEBUG
 void edac_mc_dump_channel(struct channel_info *chan);
 void edac_mc_dump_mci(struct mem_ctl_info *mci);
@@ -408,7 +418,7 @@
 #endif  /* CONFIG_EDAC_DEBUG */
 
 extern int edac_mc_add_mc(struct mem_ctl_info *mci);
-extern struct mem_ctl_info * edac_mc_del_mc(struct pci_dev *pdev);
+extern struct mem_ctl_info * edac_mc_del_mc(struct device *dev);
 extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
 					unsigned long page);
 extern void edac_mc_scrub_block(unsigned long page, unsigned long offset,
Index: linux-2.6.17-rc6/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/amd76x_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/amd76x_edac.c	2006-06-12 18:17:29.000000000 -0600
@@ -20,6 +20,9 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define AMD76X_REVISION	" Ver: 2.0.0 "  __DATE__
+
+
 #define amd76x_printk(level, fmt, arg...) \
 	edac_printk(level, "amd76x", fmt, ##arg)
 
@@ -102,15 +105,18 @@
 static void amd76x_get_error_info(struct mem_ctl_info *mci,
 		struct amd76x_error_info *info)
 {
-	pci_read_config_dword(mci->pdev, AMD76X_ECC_MODE_STATUS,
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(mci->dev);
+	pci_read_config_dword(pdev, AMD76X_ECC_MODE_STATUS,
 				&info->ecc_mode_status);
 
 	if (info->ecc_mode_status & BIT(8))
-		pci_write_bits32(mci->pdev, AMD76X_ECC_MODE_STATUS,
+		pci_write_bits32(pdev, AMD76X_ECC_MODE_STATUS,
 				(u32) BIT(8), (u32) BIT(8));
 
 	if (info->ecc_mode_status & BIT(9))
-		pci_write_bits32(mci->pdev, AMD76X_ECC_MODE_STATUS,
+		pci_write_bits32(pdev, AMD76X_ECC_MODE_STATUS,
 				(u32) BIT(9), (u32) BIT(9));
 }
 
@@ -211,13 +217,13 @@
 	}
 
 	debugf0("%s(): mci = %p\n", __func__, mci);
-	mci->pdev = pdev;
+	mci->dev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_RDDR;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
 	mci->edac_cap = ems_mode ?
 			(EDAC_FLAG_EC | EDAC_FLAG_SECDED) : EDAC_FLAG_NONE;
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.4.2.5 $";
+	mci->mod_ver = AMD76X_REVISION;
 	mci->ctl_name = amd76x_devs[dev_idx].ctl_name;
 	mci->edac_check = amd76x_check;
 	mci->ctl_page_to_phys = NULL;
@@ -230,7 +236,7 @@
 		u32 dms;
 
 		/* find the DRAM Chip Select Base address and mask */
-		pci_read_config_dword(mci->pdev,
+		pci_read_config_dword(pdev,
 				AMD76X_MEM_BASE_ADDR + (index * 4), &mba);
 
 		if (!(mba & BIT(0)))
@@ -238,8 +244,7 @@
 
 		mba_base = mba & 0xff800000UL;
 		mba_mask = ((mba & 0xff80) << 16) | 0x7fffffUL;
-		pci_read_config_dword(mci->pdev, AMD76X_DRAM_MODE_STATUS,
-				&dms);
+		pci_read_config_dword(pdev, AMD76X_DRAM_MODE_STATUS, &dms);
 		csrow->first_page = mba_base >> PAGE_SHIFT;
 		csrow->nr_pages = (mba_mask + 1) >> PAGE_SHIFT;
 		csrow->last_page = csrow->first_page + csrow->nr_pages - 1;
@@ -291,7 +296,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	edac_mc_free(mci);
Index: linux-2.6.17-rc6/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/e752x_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/e752x_edac.c	2006-06-12 18:17:29.000000000 -0600
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define E752X_REVISION	" Ver: 2.0.0 " __DATE__
+
 static int force_function_unhide;
 
 #define e752x_printk(level, fmt, arg...) \
@@ -819,8 +821,8 @@
 	    EDAC_FLAG_S4ECD4ED;
 	/* FIXME - what if different memory types are in different csrows? */
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.5.2.11 $";
-	mci->pdev = pdev;
+	mci->mod_ver = E752X_REVISION;
+	mci->dev = &pdev->dev;
 
 	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e752x_pvt *) mci->pvt_info;
@@ -864,7 +866,7 @@
 		struct csrow_info *csrow = &mci->csrows[index];
 
 		mem_dev = (mem_dev == 2);
-		pci_read_config_byte(mci->pdev, E752X_DRB + index, &value);
+		pci_read_config_byte(pdev, E752X_DRB + index, &value);
 		/* convert a 128 or 64 MiB DRB to a page size. */
 		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
 		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
@@ -904,8 +906,7 @@
 		u8 row = 0;
 
 		for (index = 0; index < 8; index += 2) {
-			pci_read_config_byte(mci->pdev, E752X_DRB + index,
-					&value);
+			pci_read_config_byte(pdev, E752X_DRB + index, &value);
 
 			/* test if there is a dimm in this slot */
 			if (value == last) {
@@ -918,7 +919,7 @@
 				last = value;
 				/* test the next value to see if the dimm is
 				   double sided */
-				pci_read_config_byte(mci->pdev,
+				pci_read_config_byte(pdev,
 						E752X_DRB + index + 1,
 						&value);
 				pvt->map[index + 1] = (value == last) ?
@@ -935,18 +936,18 @@
 	}
 
 	/* set the map type.  1 = normal, 0 = reversed */
-	pci_read_config_byte(mci->pdev, E752X_DRM, &stat8);
+	pci_read_config_byte(pdev, E752X_DRM, &stat8);
 	pvt->map_type = ((stat8 & 0x0f) > ((stat8 >> 4) & 0x0f));
 
 	mci->edac_cap |= EDAC_FLAG_NONE;
 	debugf3("%s(): tolm, remapbase, remaplimit\n", __func__);
 
 	/* load the top of low memory, remap base, and remap limit vars */
-	pci_read_config_word(mci->pdev, E752X_TOLM, &pci_data);
+	pci_read_config_word(pdev, E752X_TOLM, &pci_data);
 	pvt->tolm = ((u32) pci_data) << 4;
-	pci_read_config_word(mci->pdev, E752X_REMAPBASE, &pci_data);
+	pci_read_config_word(pdev, E752X_REMAPBASE, &pci_data);
 	pvt->remapbase = ((u32) pci_data) << 14;
-	pci_read_config_word(mci->pdev, E752X_REMAPLIMIT, &pci_data);
+	pci_read_config_word(pdev, E752X_REMAPLIMIT, &pci_data);
 	pvt->remaplimit = ((u32) pci_data) << 14;
 	e752x_printk(KERN_INFO,
 		"tolm = %x, remapbase = %x, remaplimit = %x\n", pvt->tolm,
@@ -1015,7 +1016,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	pvt = (struct e752x_pvt *) mci->pvt_info;
Index: linux-2.6.17-rc6/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/e7xxx_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/e7xxx_edac.c	2006-06-12 18:17:29.000000000 -0600
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define	E7XXX_REVISION " Ver: 2.0.0 " __DATE__
+
 #define e7xxx_printk(level, fmt, arg...) \
 	edac_printk(level, "e7xxx", fmt, ##arg)
 
@@ -373,8 +375,8 @@
 			EDAC_FLAG_S4ECD4ED;
 	/* FIXME - what if different memory types are in different csrows? */
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.5.2.9 $";
-	mci->pdev = pdev;
+	mci->mod_ver = E7XXX_REVISION;
+	mci->dev = &pdev->dev;
 
 	debugf3("%s(): init pvt\n", __func__);
 	pvt = (struct e7xxx_pvt *) mci->pvt_info;
@@ -411,7 +413,7 @@
 		int mem_dev = (dra >> (index * 4 + 3)) & 0x1;
 		struct csrow_info *csrow = &mci->csrows[index];
 
-		pci_read_config_byte(mci->pdev, E7XXX_DRB + index, &value);
+		pci_read_config_byte(pdev, E7XXX_DRB + index, &value);
 		/* convert a 64 or 32 MiB DRB to a page size. */
 		cumul_size = value << (25 + drc_drbg - PAGE_SHIFT);
 		debugf3("%s(): (%d) cumul_size 0x%x\n", __func__, index,
@@ -448,11 +450,11 @@
 
 	debugf3("%s(): tolm, remapbase, remaplimit\n", __func__);
 	/* load the top of low memory, remap base, and remap limit vars */
-	pci_read_config_word(mci->pdev, E7XXX_TOLM, &pci_data);
+	pci_read_config_word(pdev, E7XXX_TOLM, &pci_data);
 	pvt->tolm = ((u32) pci_data) << 4;
-	pci_read_config_word(mci->pdev, E7XXX_REMAPBASE, &pci_data);
+	pci_read_config_word(pdev, E7XXX_REMAPBASE, &pci_data);
 	pvt->remapbase = ((u32) pci_data) << 14;
-	pci_read_config_word(mci->pdev, E7XXX_REMAPLIMIT, &pci_data);
+	pci_read_config_word(pdev, E7XXX_REMAPLIMIT, &pci_data);
 	pvt->remaplimit = ((u32) pci_data) << 14;
 	e7xxx_printk(KERN_INFO,
 		"tolm = %x, remapbase = %x, remaplimit = %x\n", pvt->tolm,
@@ -498,7 +500,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	pvt = (struct e7xxx_pvt *) mci->pvt_info;
Index: linux-2.6.17-rc6/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/edac_mc.c	2006-06-12 18:17:17.000000000 -0600
+++ linux-2.6.17-rc6/drivers/edac/edac_mc.c	2006-06-12 18:17:29.000000000 -0600
@@ -54,16 +54,17 @@
 static int panic_on_ue;
 static int poll_msec = 1000;
 
-static int check_pci_parity = 0;	/* default YES check PCI parity */
-static int panic_on_pci_parity;		/* default no panic on PCI Parity */
-static atomic_t pci_parity_count = ATOMIC_INIT(0);
-
 /* lock to memory controller's control array */
 static DECLARE_MUTEX(mem_ctls_mutex);
 static struct list_head mc_devices = LIST_HEAD_INIT(mc_devices);
 
 static struct task_struct *edac_thread;
 
+#ifdef CONFIG_PCI
+static int check_pci_parity = 0;	/* default YES check PCI parity */
+static int panic_on_pci_parity;		/* default no panic on PCI Parity */
+static atomic_t pci_parity_count = ATOMIC_INIT(0);
+
 /* Structure of the whitelist and blacklist arrays */
 struct edac_pci_device_list {
 	unsigned int  vendor;		/* Vendor ID */
@@ -80,6 +81,12 @@
 static struct edac_pci_device_list pci_whitelist[MAX_LISTED_PCI_DEVICES];
 static int pci_whitelist_count ;
 
+#ifndef DISABLE_EDAC_SYSFS
+static struct kobject edac_pci_kobj; /* /sys/devices/system/edac/pci */
+static struct completion edac_pci_kobj_complete;
+#endif	/* DISABLE_EDAC_SYSFS */
+#endif	/* CONFIG_PCI */
+
 /*  START sysfs data and methods */
 
 #ifndef DISABLE_EDAC_SYSFS
@@ -127,18 +134,15 @@
 	set_kset_name("edac"),
 };
 
-/* sysfs objects:
+/* sysfs object:
  *	/sys/devices/system/edac/mc
- *	/sys/devices/system/edac/pci
  */
 static struct kobject edac_memctrl_kobj;
-static struct kobject edac_pci_kobj;
 
 /* We use these to wait for the reference counts on edac_memctrl_kobj and
  * edac_pci_kobj to reach 0.
  */
 static struct completion edac_memctrl_kobj_complete;
-static struct completion edac_pci_kobj_complete;
 
 /*
  * /sys/devices/system/edac/mc;
@@ -324,6 +328,8 @@
 #endif  /* DISABLE_EDAC_SYSFS */
 }
 
+#ifdef CONFIG_PCI
+
 #ifndef DISABLE_EDAC_SYSFS
 
 /*
@@ -624,6 +630,252 @@
 #endif
 }
 
+
+static u16 get_pci_parity_status(struct pci_dev *dev, int secondary)
+{
+	int where;
+	u16 status;
+
+	where = secondary ? PCI_SEC_STATUS : PCI_STATUS;
+	pci_read_config_word(dev, where, &status);
+
+	/* If we get back 0xFFFF then we must suspect that the card has been
+	 * pulled but the Linux PCI layer has not yet finished cleaning up.
+	 * We don't want to report on such devices
+	 */
+
+	if (status == 0xFFFF) {
+		u32 sanity;
+
+		pci_read_config_dword(dev, 0, &sanity);
+
+		if (sanity == 0xFFFFFFFF)
+			return 0;
+	}
+
+	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
+		PCI_STATUS_PARITY;
+
+	if (status)
+		/* reset only the bits we are interested in */
+		pci_write_config_word(dev, where, status);
+
+	return status;
+}
+
+typedef void (*pci_parity_check_fn_t) (struct pci_dev *dev);
+
+/* Clear any PCI parity errors logged by this device. */
+static void edac_pci_dev_parity_clear(struct pci_dev *dev)
+{
+	u8 header_type;
+
+	get_pci_parity_status(dev, 0);
+
+	/* read the device TYPE, looking for bridges */
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE)
+		get_pci_parity_status(dev, 1);
+}
+
+/*
+ *  PCI Parity polling
+ *
+ */
+static void edac_pci_dev_parity_test(struct pci_dev *dev)
+{
+	u16 status;
+	u8  header_type;
+
+	/* read the STATUS register on this device
+	 */
+	status = get_pci_parity_status(dev, 0);
+
+	debugf2("PCI STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
+
+	/* check the status reg for errors */
+	if (status) {
+		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				"Signaled System Error on %s\n",
+				pci_name(dev));
+
+		if (status & (PCI_STATUS_PARITY)) {
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				"Master Data Parity Error on %s\n",
+				pci_name(dev));
+
+			atomic_inc(&pci_parity_count);
+		}
+
+		if (status & (PCI_STATUS_DETECTED_PARITY)) {
+			edac_printk(KERN_CRIT, EDAC_PCI,
+				"Detected Parity Error on %s\n",
+				pci_name(dev));
+
+			atomic_inc(&pci_parity_count);
+		}
+	}
+
+	/* read the device TYPE, looking for bridges */
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	debugf2("PCI HEADER TYPE= 0x%02x %s\n", header_type, dev->dev.bus_id );
+
+	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
+		/* On bridges, need to examine secondary status register  */
+		status = get_pci_parity_status(dev, 1);
+
+		debugf2("PCI SEC_STATUS= 0x%04x %s\n",
+				status, dev->dev.bus_id );
+
+		/* check the secondary status reg for errors */
+		if (status) {
+			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					"Signaled System Error on %s\n",
+					pci_name(dev));
+
+			if (status & (PCI_STATUS_PARITY)) {
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					"Master Data Parity Error on "
+					"%s\n", pci_name(dev));
+
+				atomic_inc(&pci_parity_count);
+			}
+
+			if (status & (PCI_STATUS_DETECTED_PARITY)) {
+				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
+					"Detected Parity Error on %s\n",
+					pci_name(dev));
+
+				atomic_inc(&pci_parity_count);
+			}
+		}
+	}
+}
+
+/*
+ * check_dev_on_list: Scan for a PCI device on a white/black list
+ * @list:	an EDAC  &edac_pci_device_list  white/black list pointer
+ * @free_index:	index of next free entry on the list
+ * @pci_dev:	PCI Device pointer
+ *
+ * see if list contains the device.
+ *
+ * Returns:  	0 not found
+ *		1 found on list
+ */
+static int check_dev_on_list(struct edac_pci_device_list *list,
+		int free_index, struct pci_dev *dev)
+{
+	int i;
+	int rc = 0;     /* Assume not found */
+	unsigned short vendor=dev->vendor;
+	unsigned short device=dev->device;
+
+	/* Scan the list, looking for a vendor/device match */
+	for (i = 0; i < free_index; i++, list++ ) {
+		if ((list->vendor == vendor ) && (list->device == device )) {
+			rc = 1;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+/*
+ * pci_dev parity list iterator
+ *	Scan the PCI device list for one iteration, looking for SERRORs
+ *	Master Parity ERRORS or Parity ERRORs on primary or secondary devices
+ */
+static inline void edac_pci_dev_parity_iterator(pci_parity_check_fn_t fn)
+{
+	struct pci_dev *dev = NULL;
+
+	/* request for kernel access to the next PCI device, if any,
+	 * and while we are looking at it have its reference count
+	 * bumped until we are done with it
+	 */
+	while((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		/* if whitelist exists then it has priority, so only scan
+		 * those devices on the whitelist
+		 */
+		if (pci_whitelist_count > 0 ) {
+			if (check_dev_on_list(pci_whitelist,
+					pci_whitelist_count, dev))
+				fn(dev);
+		} else {
+			/*
+			 * if no whitelist, then check if this devices is
+			 * blacklisted
+			 */
+			if (!check_dev_on_list(pci_blacklist,
+					pci_blacklist_count, dev))
+				fn(dev);
+		}
+	}
+}
+
+static void do_pci_parity_check(void)
+{
+	unsigned long flags;
+	int before_count;
+
+	debugf3("%s()\n", __func__);
+
+	if (!check_pci_parity)
+		return;
+
+	before_count = atomic_read(&pci_parity_count);
+
+	/* scan all PCI devices looking for a Parity Error on devices and
+	 * bridges
+	 */
+	local_irq_save(flags);
+	edac_pci_dev_parity_iterator(edac_pci_dev_parity_test);
+	local_irq_restore(flags);
+
+	/* Only if operator has selected panic on PCI Error */
+	if (panic_on_pci_parity) {
+		/* If the count is different 'after' from 'before' */
+		if (before_count != atomic_read(&pci_parity_count))
+			panic("EDAC: PCI Parity Error");
+	}
+}
+
+static inline void clear_pci_parity_errors(void)
+{
+	/* Clear any PCI bus parity errors that devices initially have logged
+	 * in their registers.
+	 */
+	edac_pci_dev_parity_iterator(edac_pci_dev_parity_clear);
+}
+
+#else	/* CONFIG_PCI */
+
+static inline void do_pci_parity_check(void)
+{
+	/* no-op */
+}
+
+static inline void clear_pci_parity_errors(void)
+{
+	/* no-op */
+}
+
+static void edac_sysfs_pci_teardown(void)
+{
+}
+
+static int edac_sysfs_pci_setup(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_PCI */
+
 #ifndef DISABLE_EDAC_SYSFS
 
 /* EDAC sysfs CSROW data structures and methods */
@@ -1132,7 +1384,7 @@
 		return err;
 
 	/* create a symlink for the device */
-	err = sysfs_create_link(edac_mci_kobj, &mci->pdev->dev.kobj,
+	err = sysfs_create_link(edac_mci_kobj, &mci->dev->kobj,
 				EDAC_DEVICE_SYMLINK);
 
 	if (err)
@@ -1238,7 +1490,7 @@
 	debugf4("\tmci->edac_check = %p\n", mci->edac_check);
 	debugf3("\tmci->nr_csrows = %d, csrows = %p\n",
 		mci->nr_csrows, mci->csrows);
-	debugf3("\tpdev = %p\n", mci->pdev);
+	debugf3("\tdev = %p\n", mci->dev);
 	debugf3("\tmod_name:ctl_name = %s:%s\n",
 		mci->mod_name, mci->ctl_name);
 	debugf3("\tpvt_info = %p\n\n", mci->pvt_info);
@@ -1363,7 +1615,7 @@
 }
 EXPORT_SYMBOL_GPL(edac_mc_free);
 
-static struct mem_ctl_info *find_mci_by_pdev(struct pci_dev *pdev)
+static struct mem_ctl_info *find_mci_by_dev(struct device *dev)
 {
 	struct mem_ctl_info *mci;
 	struct list_head *item;
@@ -1373,7 +1625,7 @@
 	list_for_each(item, &mc_devices) {
 		mci = list_entry(item, struct mem_ctl_info, link);
 
-		if (mci->pdev == pdev)
+		if (mci->dev == dev)
 			return mci;
 	}
 
@@ -1390,12 +1642,12 @@
 		mci->mc_idx = 0;
 		insert_before = &mc_devices;
 	} else {
-		if (find_mci_by_pdev(mci->pdev)) {
+		if (find_mci_by_dev(mci->dev)) {
 			edac_printk(KERN_WARNING, EDAC_MC,
 				"%s (%s) %s %s already assigned %d\n",
-				mci->pdev->dev.bus_id,
-				pci_name(mci->pdev), mci->mod_name,
-				mci->ctl_name, mci->mc_idx);
+				mci->dev->bus_id, dev_name(mci->dev),
+				mci->mod_name, mci->ctl_name,
+				mci->mc_idx);
 			return 1;
 		}
 
@@ -1486,8 +1738,8 @@
         }
 
 	/* Report action taken */
-	edac_mc_printk(mci, KERN_INFO, "Giving out device to %s %s: PCI %s\n",
-		mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
+	edac_mc_printk(mci, KERN_INFO, "Giving out device to %s %s: DEV %s\n",
+		mci->mod_name, mci->ctl_name, dev_name(mci->dev));
 
 	up(&mem_ctls_mutex);
 	return 0;
@@ -1504,18 +1756,18 @@
 /**
  * edac_mc_del_mc: Remove sysfs entries for specified mci structure and
  *                 remove mci structure from global list
- * @pdev: Pointer to 'struct pci_dev' representing mci structure to remove.
+ * @pdev: Pointer to 'struct device' representing mci structure to remove.
  *
  * Return pointer to removed mci structure, or NULL if device not found.
  */
-struct mem_ctl_info * edac_mc_del_mc(struct pci_dev *pdev)
+struct mem_ctl_info * edac_mc_del_mc(struct device *dev)
 {
 	struct mem_ctl_info *mci;
 
 	debugf0("MC: %s()\n", __func__);
 	down(&mem_ctls_mutex);
 
-	if ((mci = find_mci_by_pdev(pdev)) == NULL) {
+	if ((mci = find_mci_by_dev(dev)) == NULL) {
 		up(&mem_ctls_mutex);
 		return NULL;
 	}
@@ -1524,8 +1776,8 @@
 	del_mc_from_global_list(mci);
 	up(&mem_ctls_mutex);
 	edac_printk(KERN_INFO, EDAC_MC,
-		"Removed device %d for %s %s: PCI %s\n", mci->mc_idx,
-		mci->mod_name, mci->ctl_name, pci_name(mci->pdev));
+		"Removed device %d for %s %s: DEV %s\n", mci->mc_idx,
+		mci->mod_name, mci->ctl_name, dev_name(mci->dev));
 	return mci;
 }
 EXPORT_SYMBOL_GPL(edac_mc_del_mc);
@@ -1739,244 +1991,6 @@
 }
 EXPORT_SYMBOL_GPL(edac_mc_handle_ue_no_info);
 
-#ifdef CONFIG_PCI
-
-static u16 get_pci_parity_status(struct pci_dev *dev, int secondary)
-{
-	int where;
-	u16 status;
-
-	where = secondary ? PCI_SEC_STATUS : PCI_STATUS;
-	pci_read_config_word(dev, where, &status);
-
-	/* If we get back 0xFFFF then we must suspect that the card has been
-	 * pulled but the Linux PCI layer has not yet finished cleaning up.
-	 * We don't want to report on such devices
-	 */
-
-	if (status == 0xFFFF) {
-		u32 sanity;
-
-		pci_read_config_dword(dev, 0, &sanity);
-
-		if (sanity == 0xFFFFFFFF)
-			return 0;
-	}
-
-	status &= PCI_STATUS_DETECTED_PARITY | PCI_STATUS_SIG_SYSTEM_ERROR |
-		PCI_STATUS_PARITY;
-
-	if (status)
-		/* reset only the bits we are interested in */
-		pci_write_config_word(dev, where, status);
-
-	return status;
-}
-
-typedef void (*pci_parity_check_fn_t) (struct pci_dev *dev);
-
-/* Clear any PCI parity errors logged by this device. */
-static void edac_pci_dev_parity_clear(struct pci_dev *dev)
-{
-	u8 header_type;
-
-	get_pci_parity_status(dev, 0);
-
-	/* read the device TYPE, looking for bridges */
-	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
-
-	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE)
-		get_pci_parity_status(dev, 1);
-}
-
-/*
- *  PCI Parity polling
- *
- */
-static void edac_pci_dev_parity_test(struct pci_dev *dev)
-{
-	u16 status;
-	u8  header_type;
-
-	/* read the STATUS register on this device
-	 */
-	status = get_pci_parity_status(dev, 0);
-
-	debugf2("PCI STATUS= 0x%04x %s\n", status, dev->dev.bus_id );
-
-	/* check the status reg for errors */
-	if (status) {
-		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
-			edac_printk(KERN_CRIT, EDAC_PCI,
-				"Signaled System Error on %s\n",
-				pci_name(dev));
-
-		if (status & (PCI_STATUS_PARITY)) {
-			edac_printk(KERN_CRIT, EDAC_PCI,
-				"Master Data Parity Error on %s\n",
-				pci_name(dev));
-
-			atomic_inc(&pci_parity_count);
-		}
-
-		if (status & (PCI_STATUS_DETECTED_PARITY)) {
-			edac_printk(KERN_CRIT, EDAC_PCI,
-				"Detected Parity Error on %s\n",
-				pci_name(dev));
-
-			atomic_inc(&pci_parity_count);
-		}
-	}
-
-	/* read the device TYPE, looking for bridges */
-	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
-
-	debugf2("PCI HEADER TYPE= 0x%02x %s\n", header_type, dev->dev.bus_id );
-
-	if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
-		/* On bridges, need to examine secondary status register  */
-		status = get_pci_parity_status(dev, 1);
-
-		debugf2("PCI SEC_STATUS= 0x%04x %s\n",
-				status, dev->dev.bus_id );
-
-		/* check the secondary status reg for errors */
-		if (status) {
-			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
-				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
-					"Signaled System Error on %s\n",
-					pci_name(dev));
-
-			if (status & (PCI_STATUS_PARITY)) {
-				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
-					"Master Data Parity Error on "
-					"%s\n", pci_name(dev));
-
-				atomic_inc(&pci_parity_count);
-			}
-
-			if (status & (PCI_STATUS_DETECTED_PARITY)) {
-				edac_printk(KERN_CRIT, EDAC_PCI, "Bridge "
-					"Detected Parity Error on %s\n",
-					pci_name(dev));
-
-				atomic_inc(&pci_parity_count);
-			}
-		}
-	}
-}
-
-/*
- * check_dev_on_list: Scan for a PCI device on a white/black list
- * @list:	an EDAC  &edac_pci_device_list  white/black list pointer
- * @free_index:	index of next free entry on the list
- * @pci_dev:	PCI Device pointer
- *
- * see if list contains the device.
- *
- * Returns:  	0 not found
- *		1 found on list
- */
-static int check_dev_on_list(struct edac_pci_device_list *list,
-		int free_index, struct pci_dev *dev)
-{
-	int i;
-	int rc = 0;     /* Assume not found */
-	unsigned short vendor=dev->vendor;
-	unsigned short device=dev->device;
-
-	/* Scan the list, looking for a vendor/device match */
-	for (i = 0; i < free_index; i++, list++ ) {
-		if ((list->vendor == vendor ) && (list->device == device )) {
-			rc = 1;
-			break;
-		}
-	}
-
-	return rc;
-}
-
-/*
- * pci_dev parity list iterator
- *	Scan the PCI device list for one iteration, looking for SERRORs
- *	Master Parity ERRORS or Parity ERRORs on primary or secondary devices
- */
-static inline void edac_pci_dev_parity_iterator(pci_parity_check_fn_t fn)
-{
-	struct pci_dev *dev = NULL;
-
-	/* request for kernel access to the next PCI device, if any,
-	 * and while we are looking at it have its reference count
-	 * bumped until we are done with it
-	 */
-	while((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		/* if whitelist exists then it has priority, so only scan
-		 * those devices on the whitelist
-		 */
-		if (pci_whitelist_count > 0 ) {
-			if (check_dev_on_list(pci_whitelist,
-					pci_whitelist_count, dev))
-				fn(dev);
-		} else {
-			/*
-			 * if no whitelist, then check if this devices is
-			 * blacklisted
-			 */
-			if (!check_dev_on_list(pci_blacklist,
-					pci_blacklist_count, dev))
-				fn(dev);
-		}
-	}
-}
-
-static void do_pci_parity_check(void)
-{
-	unsigned long flags;
-	int before_count;
-
-	debugf3("%s()\n", __func__);
-
-	if (!check_pci_parity)
-		return;
-
-	before_count = atomic_read(&pci_parity_count);
-
-	/* scan all PCI devices looking for a Parity Error on devices and
-	 * bridges
-	 */
-	local_irq_save(flags);
-	edac_pci_dev_parity_iterator(edac_pci_dev_parity_test);
-	local_irq_restore(flags);
-
-	/* Only if operator has selected panic on PCI Error */
-	if (panic_on_pci_parity) {
-		/* If the count is different 'after' from 'before' */
-		if (before_count != atomic_read(&pci_parity_count))
-			panic("EDAC: PCI Parity Error");
-	}
-}
-
-static inline void clear_pci_parity_errors(void)
-{
-	/* Clear any PCI bus parity errors that devices initially have logged
-	 * in their registers.
-	 */
-	edac_pci_dev_parity_iterator(edac_pci_dev_parity_clear);
-}
-
-#else  /* CONFIG_PCI */
-
-static inline void do_pci_parity_check(void)
-{
-	/* no-op */
-}
-
-static inline void clear_pci_parity_errors(void)
-{
-	/* no-op */
-}
-
-#endif  /* CONFIG_PCI */
 
 /*
  * Iterate over all MC instances and check for ECC, et al, errors
@@ -2096,10 +2110,12 @@
 
 module_param(panic_on_ue, int, 0644);
 MODULE_PARM_DESC(panic_on_ue, "Panic on uncorrected error: 0=off 1=on");
+#ifdef CONFIG_PCI
 module_param(check_pci_parity, int, 0644);
 MODULE_PARM_DESC(check_pci_parity, "Check for PCI bus parity errors: 0=off 1=on");
 module_param(panic_on_pci_parity, int, 0644);
 MODULE_PARM_DESC(panic_on_pci_parity, "Panic on PCI Bus Parity error: 0=off 1=on");
+#endif
 module_param(log_ue, int, 0644);
 MODULE_PARM_DESC(log_ue, "Log uncorrectable error to console: 0=off 1=on");
 module_param(log_ce, int, 0644);
Index: linux-2.6.17-rc6/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/i82860_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/i82860_edac.c	2006-06-12 18:17:29.000000000 -0600
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define  I82860_REVISION " Ver: 2.0.0 " __DATE__
+
 #define i82860_printk(level, fmt, arg...) \
 	edac_printk(level, "i82860", fmt, ##arg)
 
@@ -63,17 +65,21 @@
 static void i82860_get_error_info(struct mem_ctl_info *mci,
 		struct i82860_error_info *info)
 {
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(mci->dev);
+
 	/*
 	 * This is a mess because there is no atomic way to read all the
 	 * registers at once and the registers can transition from CE being
 	 * overwritten by UE.
 	 */
-	pci_read_config_word(mci->pdev, I82860_ERRSTS, &info->errsts);
-	pci_read_config_dword(mci->pdev, I82860_EAP, &info->eap);
-	pci_read_config_word(mci->pdev, I82860_DERRCTL_STS, &info->derrsyn);
-	pci_read_config_word(mci->pdev, I82860_ERRSTS, &info->errsts2);
+	pci_read_config_word(pdev, I82860_ERRSTS, &info->errsts);
+	pci_read_config_dword(pdev, I82860_EAP, &info->eap);
+	pci_read_config_word(pdev, I82860_DERRCTL_STS, &info->derrsyn);
+	pci_read_config_word(pdev, I82860_ERRSTS, &info->errsts2);
 
-	pci_write_bits16(mci->pdev, I82860_ERRSTS, 0x0003, 0x0003);
+	pci_write_bits16(pdev, I82860_ERRSTS, 0x0003, 0x0003);
 
 	/*
 	 * If the error is the same for both reads then the first set of reads
@@ -84,8 +90,8 @@
 		return;
 
 	if ((info->errsts ^ info->errsts2) & 0x0003) {
-		pci_read_config_dword(mci->pdev, I82860_EAP, &info->eap);
-		pci_read_config_word(mci->pdev, I82860_DERRCTL_STS,
+		pci_read_config_dword(pdev, I82860_EAP, &info->eap);
+		pci_read_config_word(pdev, I82860_DERRCTL_STS,
 				&info->derrsyn);
 	}
 }
@@ -151,7 +157,7 @@
 		return -ENOMEM;
 
 	debugf3("%s(): init mci\n", __func__);
-	mci->pdev = pdev;
+	mci->dev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_DDR;
 
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
@@ -160,12 +166,12 @@
 	/* adjust FLAGS */
 
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.1.2.6 $";
+	mci->mod_ver = I82860_REVISION;
 	mci->ctl_name = i82860_devs[dev_idx].ctl_name;
 	mci->edac_check = i82860_check;
 	mci->ctl_page_to_phys = NULL;
 
-	pci_read_config_word(mci->pdev, I82860_MCHCFG, &mchcfg_ddim);
+	pci_read_config_word(pdev, I82860_MCHCFG, &mchcfg_ddim);
 	mchcfg_ddim = mchcfg_ddim & 0x180;
 
 	/*
@@ -179,7 +185,7 @@
 		u32 cumul_size;
 		struct csrow_info *csrow = &mci->csrows[index];
 
-		pci_read_config_word(mci->pdev, I82860_GBA + index * 2,
+		pci_read_config_word(pdev, I82860_GBA + index * 2,
 				&value);
 
 		cumul_size = (value & I82860_GBA_MASK) <<
@@ -240,7 +246,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	edac_mc_free(mci);
Index: linux-2.6.17-rc6/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/i82875p_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/i82875p_edac.c	2006-06-12 18:17:29.000000000 -0600
@@ -21,6 +21,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define I82875P_REVISION	" Ver: 2.0.0 " __DATE__
+
 #define i82875p_printk(level, fmt, arg...) \
 	edac_printk(level, "i82875p", fmt, ##arg)
 
@@ -185,18 +187,22 @@
 static void i82875p_get_error_info(struct mem_ctl_info *mci,
 		struct i82875p_error_info *info)
 {
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(mci->dev);
+
 	/*
 	 * This is a mess because there is no atomic way to read all the
 	 * registers at once and the registers can transition from CE being
 	 * overwritten by UE.
 	 */
-	pci_read_config_word(mci->pdev, I82875P_ERRSTS, &info->errsts);
-	pci_read_config_dword(mci->pdev, I82875P_EAP, &info->eap);
-	pci_read_config_byte(mci->pdev, I82875P_DES, &info->des);
-	pci_read_config_byte(mci->pdev, I82875P_DERRSYN, &info->derrsyn);
-	pci_read_config_word(mci->pdev, I82875P_ERRSTS, &info->errsts2);
+	pci_read_config_word(pdev, I82875P_ERRSTS, &info->errsts);
+	pci_read_config_dword(pdev, I82875P_EAP, &info->eap);
+	pci_read_config_byte(pdev, I82875P_DES, &info->des);
+	pci_read_config_byte(pdev, I82875P_DERRSYN, &info->derrsyn);
+	pci_read_config_word(pdev, I82875P_ERRSTS, &info->errsts2);
 
-	pci_write_bits16(mci->pdev, I82875P_ERRSTS, 0x0081, 0x0081);
+	pci_write_bits16(pdev, I82875P_ERRSTS, 0x0081, 0x0081);
 
 	/*
 	 * If the error is the same then we can for both reads then
@@ -208,9 +214,9 @@
 		return;
 
 	if ((info->errsts ^ info->errsts2) & 0x0081) {
-		pci_read_config_dword(mci->pdev, I82875P_EAP, &info->eap);
-		pci_read_config_byte(mci->pdev, I82875P_DES, &info->des);
-		pci_read_config_byte(mci->pdev, I82875P_DERRSYN,
+		pci_read_config_dword(pdev, I82875P_EAP, &info->eap);
+		pci_read_config_byte(pdev, I82875P_DES, &info->des);
+		pci_read_config_byte(pdev, I82875P_DERRSYN,
 				&info->derrsyn);
 	}
 }
@@ -337,14 +343,14 @@
 	}
 
 	debugf3("%s(): init mci\n", __func__);
-	mci->pdev = pdev;
+	mci->dev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_DDR;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_UNKNOWN;
 	/* adjust FLAGS */
 
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.5.2.11 $";
+	mci->mod_ver = I82875P_REVISION;
 	mci->ctl_name = i82875p_devs[dev_idx].ctl_name;
 	mci->edac_check = i82875p_check;
 	mci->ctl_page_to_phys = NULL;
@@ -437,7 +443,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	pvt = (struct i82875p_pvt *) mci->pvt_info;
Index: linux-2.6.17-rc6/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/edac/r82600_edac.c	2006-06-12 18:17:17.000000000
-0600
+++ linux-2.6.17-rc6/drivers/edac/r82600_edac.c	2006-06-12 18:17:44.000000000 -0600
@@ -23,6 +23,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+#define R82600_REVISION	" Ver: 2.0.0 " __DATE__
+
 #define r82600_printk(level, fmt, arg...) \
 	edac_printk(level, "r82600", fmt, ##arg)
 
@@ -134,17 +136,20 @@
 static void r82600_get_error_info (struct mem_ctl_info *mci,
 		struct r82600_error_info *info)
 {
-	pci_read_config_dword(mci->pdev, R82600_EAP, &info->eapr);
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(mci->dev);
+	pci_read_config_dword(pdev, R82600_EAP, &info->eapr);
 
 	if (info->eapr & BIT(0))
 		/* Clear error to allow next error to be reported [p.62] */
-		pci_write_bits32(mci->pdev, R82600_EAP,
+		pci_write_bits32(pdev, R82600_EAP,
 				((u32) BIT(0) & (u32) BIT(1)),
 				((u32) BIT(0) & (u32) BIT(1)));
 
 	if (info->eapr & BIT(1))
 		/* Clear error to allow next error to be reported [p.62] */
-		pci_write_bits32(mci->pdev, R82600_EAP,
+		pci_write_bits32(pdev, R82600_EAP,
 				((u32) BIT(0) & (u32) BIT(1)),
 				((u32) BIT(0) & (u32) BIT(1)));
 }
@@ -232,7 +237,7 @@
 	}
 
 	debugf0("%s(): mci = %p\n", __func__, mci);
-	mci->pdev = pdev;
+	mci->dev = &pdev->dev;
 	mci->mtype_cap = MEM_FLAG_RDDR | MEM_FLAG_DDR;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_EC | EDAC_FLAG_SECDED;
 	/* FIXME try to work out if the chip leads have been used for COM2
@@ -253,7 +258,7 @@
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	mci->mod_name = EDAC_MOD_STR;
-	mci->mod_ver = "$Revision: 1.1.2.6 $";
+	mci->mod_ver = R82600_REVISION;
 	mci->ctl_name = "R82600";
 	mci->edac_check = r82600_check;
 	mci->ctl_page_to_phys = NULL;
@@ -265,7 +270,7 @@
 		u32 row_base;
 
 		/* find the DRAM Chip Select Base address and mask */
-		pci_read_config_byte(mci->pdev, R82600_DRBA + index, &drbar);
+		pci_read_config_byte(pdev, R82600_DRBA + index, &drbar);
 
 		debugf1("MC%d: %s() Row=%d DRBA = %#0x\n", mci->mc_idx,
 			__func__, index, drbar);
@@ -309,7 +314,7 @@
 	if (disable_hardware_scrub) {
 		debugf3("%s(): Disabling Hardware Scrub (scrub on error)\n",
 			__func__);
-		pci_write_bits32(mci->pdev, R82600_EAP, BIT(31), BIT(31));
+		pci_write_bits32(pdev, R82600_EAP, BIT(31), BIT(31));
 	}
 
 	debugf3("%s(): success\n", __func__);
@@ -338,7 +343,7 @@
 
 	debugf0("%s()\n", __func__);
 
-	if ((mci = edac_mc_del_mc(pdev)) == NULL)
+	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
 		return;
 
 	edac_mc_free(mci);

