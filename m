Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWJRNRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWJRNRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJRNRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:17:55 -0400
Received: from www.swissdisk.com ([216.66.254.197]:63196 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932136AbWJRNRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:17:54 -0400
Subject: [PATCHES] Sync trivial Ubuntu patches
From: Ben Collins <ben.collins@ubuntu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 09:17:46 -0400
Message-Id: <1161177466.5203.328.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull the following changes (log, diffstat and patch
attached) from:

rsync.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6#ubuntu-updates

These are mostly changes to add a MODULE_DEVICE_TABLE so modules can be
autoloaded. This doesn't really give them hotplug functionality, but it
does make it easier for users and distros to leave these as modules that
only get loaded when they're needed.

The rest is just random trivial stuff that I've collected in the Ubuntu
kernel. I'll be working on syncing the more difficult patches
individually.

Ben Collins:
      [alim7101] Add pci dev table for auto module loading.
      [mv643xx] Add pci device table for auto module loading.
      [BusLogic] Add pci dev table for auto module loading.
      [fdomain] Add pci dev table for module auto loading.
      [initio] Add pci dev table for module auto loading.
      [ixj] Add pci dev table for module auto loading.
      [hid-core] TurboX Keyboard needs NOGET quirk.
      [controlfb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [igafb] Add pci dev table for module auto loading.
      [platinumfb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [valkyriefb] Ifdef for when CONFIG_NVRAM isn't enabled.
      [pci_ids] Add Quicknet XJ vendor/device ID's.

 drivers/char/watchdog/alim7101_wdt.c |   13 ++++++++++++-
 drivers/net/mv643xx_eth.c            |    6 ++++++
 drivers/scsi/BusLogic.c              |   11 +++++++++++
 drivers/scsi/fdomain.c               |    9 +++++++++
 drivers/scsi/initio.c                |   19 ++++++++++---------
 drivers/telephony/ixj.c              |   11 ++++++++++-
 drivers/usb/input/hid-core.c         |    5 +++++
 drivers/video/controlfb.c            |    8 ++++++--
 drivers/video/igafb.c                |    7 +++++++
 drivers/video/platinumfb.c           |    5 ++++-
 drivers/video/valkyriefb.c           |    4 ++--
 include/linux/pci_ids.h              |    2 ++
 12 files changed, 84 insertions(+), 16 deletions(-)

diff --git a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
index 5948863..bf25d0a 100644
--- a/drivers/char/watchdog/alim7101_wdt.c
+++ b/drivers/char/watchdog/alim7101_wdt.c
@@ -77,7 +77,8 @@ static struct pci_dev *alim7101_pmu;
 
 static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __stringify(CONFIG_WATCHDOG_NOWAYOUT) ")");
 
 /*
  *	Whack the dog
@@ -415,6 +416,16 @@ err_out:
 module_init(alim7101_wdt_init);
 module_exit(alim7101_wdt_unload);
 
+static struct pci_device_id alim7101_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, alim7101_pci_tbl);
+
 MODULE_AUTHOR("Steve Hill");
 MODULE_DESCRIPTION("ALi M7101 PMU Computer Watchdog Timer driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 9997081..a4f861b 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -1557,6 +1557,12 @@ static void __exit mv643xx_cleanup_modul
 module_init(mv643xx_init_module);
 module_exit(mv643xx_cleanup_module);
 
+static struct pci_device_id pci_marvell_mv64360[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, pci_marvell_mv64360);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR(	"Rabeeh Khoury, Assaf Hoffman, Matthew Dharm, Manish Lachwani"
 		" and Dale Farnsworth");
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 7c59bba..cdd0337 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3600,5 +3600,16 @@ static void __exit BusLogic_exit(void)
 
 __setup("BusLogic=", BusLogic_Setup);
 
+static struct pci_device_id BusLogic_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER_NC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, BusLogic_pci_tbl);
+
 module_init(BusLogic_init);
 module_exit(BusLogic_exit);
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 72794a7..65e6e7b 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -1736,6 +1736,15 @@ struct scsi_host_template fdomain_driver
 };
 
 #ifndef PCMCIA
+
+static struct pci_device_id fdomain_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_FD, PCI_DEVICE_ID_FD_36C70,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, fdomain_pci_tbl);
+
 #define driver_template fdomain_driver_template
 #include "scsi_module.c"
+
 #endif
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 911f2ff..afed293 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -142,8 +142,6 @@ #define SENSE_SIZE		14
 #define i91u_MAXQUEUE		2
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.04a"
 
-#define INI_VENDOR_ID   0x1101	/* Initio's PCI vendor ID       */
-#define DMX_VENDOR_ID	0x134a	/* Domex's PCI vendor ID	*/
 #define I950_DEVICE_ID	0x9500	/* Initio's inic-950 product ID   */
 #define I940_DEVICE_ID	0x9400	/* Initio's inic-940 product ID   */
 #define I935_DEVICE_ID	0x9401	/* Initio's inic-935 product ID   */
@@ -171,13 +169,16 @@ #endif
 
 static void i91uSCBPost(BYTE * pHcb, BYTE * pScb);
 
-static const PCI_ID i91u_pci_devices[] = {
-	{ INI_VENDOR_ID, I950_DEVICE_ID },
-	{ INI_VENDOR_ID, I940_DEVICE_ID },
-	{ INI_VENDOR_ID, I935_DEVICE_ID },
-	{ INI_VENDOR_ID, I920_DEVICE_ID },
-	{ DMX_VENDOR_ID, I920_DEVICE_ID },
+/* PCI Devices supported by this driver */
+static struct pci_device_id i91u_pci_devices[] __devinitdata = {
+	{ PCI_VENDOR_ID_INIT,  I950_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_INIT,  I940_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_INIT,  I935_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_INIT,  I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_DOMEX, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
 };
+MODULE_DEVICE_TABLE(pci, i91u_pci_devices);
 
 #define DEBUG_INTERRUPT 0
 #define DEBUG_QUEUE     0
@@ -2771,7 +2772,7 @@ static int tul_NewReturnNumberOfAdapters
 
 	for (i = 0; i < ARRAY_SIZE(i91u_pci_devices); i++)
 	{
-		while ((pDev = pci_find_device(i91u_pci_devices[i].vendor_id, i91u_pci_devices[i].device_id, pDev)) != NULL) {
+		while ((pDev = pci_find_device(i91u_pci_devices[i].vendor, i91u_pci_devices[i].device, pDev)) != NULL) {
 			if (pci_enable_device(pDev))
 				continue;
 			pci_read_config_dword(pDev, 0x44, (u32 *) & dRegValue);
diff --git a/drivers/telephony/ixj.c b/drivers/telephony/ixj.c
index f6b2948..1b601b6 100644
--- a/drivers/telephony/ixj.c
+++ b/drivers/telephony/ixj.c
@@ -284,6 +284,14 @@ static int samplerate = 100;
 
 module_param(ixjdebug, int, 0);
 
+static struct pci_device_id ixj_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_QUICKNET, PCI_DEVICE_ID_QUICKNET_XJ,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, ixj_pci_tbl);
+
 /************************************************************************
 *
 * ixjdebug meanings are now bit mapped instead of level based
@@ -7683,7 +7691,8 @@ static int __init ixj_probe_pci(int *cnt
 	IXJ *j = NULL;
 
 	for (i = 0; i < IXJMAX - *cnt; i++) {
-		pci = pci_find_device(0x15E2, 0x0500, pci);
+		pci = pci_find_device(PCI_VENDOR_ID_QUICKNET,
+				      PCI_DEVICE_ID_QUICKNET_XJ, pci);
 		if (!pci)
 			break;
 
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index feabda7..45f44fe 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1391,6 +1391,9 @@ void hid_close(struct hid_device *hid)
 
 #define USB_VENDOR_ID_PANJIT		0x134c
 
+#define USB_VENDOR_ID_TURBOX		0x062a
+#define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
+
 /*
  * Initialize all reports
  */
@@ -1778,6 +1781,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PANJIT, 0x0003, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0004, HID_QUIRK_IGNORE },
 
+	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
+	
 	{ 0, 0 }
 };
 
diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index 8cc6c0e..04c6d92 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -415,13 +415,15 @@ static int __init init_control(struct fb
 	full = p->total_vram == 0x400000;
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
+#ifdef CONFIG_NVRAM
 	if (default_cmode == CMODE_NVRAM){
 		cmode = nvram_read_byte(NV_CMODE);
 		if(cmode < CMODE_8 || cmode > CMODE_32)
 			cmode = CMODE_8;
 	} else
+#endif
 		cmode=default_cmode;
-
+#ifdef CONFIG_NVRAM
 	if (default_vmode == VMODE_NVRAM) {
 		vmode = nvram_read_byte(NV_VMODE);
 		if (vmode < 1 || vmode > VMODE_MAX ||
@@ -432,7 +434,9 @@ static int __init init_control(struct fb
 			if (control_mac_modes[vmode - 1].m[full] < cmode)
 				vmode = VMODE_640_480_60;
 		}
-	} else {
+	} else
+#endif
+	{
 		vmode=default_vmode;
 		if (control_mac_modes[vmode - 1].m[full] < cmode) {
 			if (cmode > CMODE_8)
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index 67f384f..e6df492 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -573,3 +573,10 @@ int __init igafb_setup(char *options)
 
 module_init(igafb_init);
 MODULE_LICENSE("GPL");
+static struct pci_device_id igafb_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, igafb_pci_tbl);
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 983be3e..fdb33cd 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -339,11 +339,12 @@ static int __devinit platinum_init_fb(st
 
 	sense = read_platinum_sense(pinfo);
 	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
-
 	if (default_vmode == VMODE_NVRAM) {
+#ifdef CONFIG_NVRAM
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
 		    !platinum_reg_init[default_vmode-1])
+#endif
 			default_vmode = VMODE_CHOOSE;
 	}
 	if (default_vmode == VMODE_CHOOSE) {
@@ -351,8 +352,10 @@ static int __devinit platinum_init_fb(st
 	}
 	if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 		default_vmode = VMODE_640_480_60;
+#ifdef CONFIG_NVRAM
 	if (default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
+#endif
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode = CMODE_8;
 	/*
diff --git a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
index 47f2792..06fc19a 100644
--- a/drivers/video/valkyriefb.c
+++ b/drivers/video/valkyriefb.c
@@ -284,7 +284,7 @@ static void __init valkyrie_choose_mode(
 	printk(KERN_INFO "Monitor sense value = 0x%x\n", p->sense);
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
-#ifndef CONFIG_MAC
+#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0
@@ -297,7 +297,7 @@ #endif
 		default_vmode = mac_map_monitor_sense(p->sense);
 	if (!valkyrie_reg_init[default_vmode - 1])
 		default_vmode = VMODE_640_480_67;
-#ifndef CONFIG_MAC
+#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
 	if (default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f069df2..f3a168f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2351,3 +2351,5 @@ #define PCI_DEVICE_ID_RME_DIGI32	0x9896
 #define PCI_DEVICE_ID_RME_DIGI32_PRO	0x9897
 #define PCI_DEVICE_ID_RME_DIGI32_8	0x9898
 
+#define PCI_VENDOR_ID_QUICKNET		0x15E2
+#define PCI_DEVICE_ID_QUICKNET_XJ	0x0500

