Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQKVNWP>; Wed, 22 Nov 2000 08:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbQKVNWF>; Wed, 22 Nov 2000 08:22:05 -0500
Received: from [209.249.10.20] ([209.249.10.20]:18345 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129682AbQKVNV4>; Wed, 22 Nov 2000 08:21:56 -0500
Date: Wed, 22 Nov 2000 04:51:54 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
Message-ID: <20001122045154.A13572@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	Here is my first pass at adding pci_device_id tables to all
PCI scsi drivers in linux-2.4.0-test11.  It implements a compromise
regarding named initializers for pci_device_id table entries: shorter
tables or tables that contain anonymous constants use the named fields,
but the few longer tables where the purpose of the constants are more
clearly labelled do not use named fields, because those tables would
be really big otherwise (in terms of lines of source code, not what
they compile into).  The theory in this is that the number of tables
that use the unlabelled structure initializers is still kept relatively
small, so a change to pci_device_id that would require changing the
initializers would involve changing only a relatively small number
of drivers, as opposed to potentially all ~150 PCI drivers.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/3w-xxxx.c	Wed Nov  8 17:09:50 2000
+++ 3w-xxxx.c	Wed Nov 22 04:04:27 2000
@@ -87,6 +87,7 @@
 #include <linux/smp.h>
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include <asm/errno.h>
 #include <asm/io.h>
@@ -100,6 +101,17 @@
 #include "hosts.h"
 
 #include "3w-xxxx.h"
+
+static struct pci_device_id tw_scsi_pci_tbl[] __initdata = {
+	{
+	  vendor: TW_VENDOR_ID,
+	  device: TW_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, tw_scsi_pci_tbl);
 
 static int tw_copy_info(TW_Info *info, char *fmt, ...);
 static void tw_copy_mem_info(TW_Info *info, char *data, int len);
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/AM53C974.c	Sun Nov 12 20:40:42 2000
+++ AM53C974.c	Wed Nov 22 04:28:10 2000
@@ -340,6 +340,18 @@
 #define TAG_NONE	-2	/* Establish I_T_L nexus instead of I_T_L_Q
 				   * even on SCSI-II devices */
 
+static struct pci_device_id am53c974_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_AMD,
+	  device: PCI_DEVICE_ID_AMD_SCSI,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, am53c974_pci_tbl);
+
+
 /************ LILO overrides *************/
 typedef struct _override_t {
 	int host_scsi_id;	/* SCSI id of the bus controller */
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/BusLogic.c	Sat Nov 11 19:01:11 2000
+++ BusLogic.c	Wed Nov 22 04:07:16 2000
@@ -54,6 +54,29 @@
 #include "FlashPoint.c"
 
 
+static struct pci_device_id buslogic_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER_NC,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, buslogic_pci_tbl);
+
 /*
   BusLogic_DriverOptionsCount is a count of the number of BusLogic Driver
   Options specifications provided via the Linux Kernel Command Line or via
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/NCR53C9x.c	Mon Jun 19 17:59:41 2000
+++ NCR53C9x.c	Sat Nov 18 03:22:01 2000
@@ -21,10 +21,7 @@
  * 4) Maybe change use of "esp" to something more "NCR"'ish.
  */
 
-#ifdef MODULE
 #include <linux/module.h>
-#endif
-
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -3604,6 +3601,15 @@
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 #endif
+
+EXPORT_SYMBOL(esp_intr);
+EXPORT_SYMBOL(esp_allocate);
+EXPORT_SYMBOL(esp_initialize);
+EXPORT_SYMBOL(esp_reset);
+EXPORT_SYMBOL(esp_abort);
+EXPORT_SYMBOL(esps_in_use);
+EXPORT_SYMBOL(esp_deallocate);
+EXPORT_SYMBOL(esp_queue);
 
 #ifdef MODULE
 int init_module(void) { return 0; }
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/advansys.c	Sat Nov 11 19:01:11 2000
+++ advansys.c	Wed Nov 22 04:02:15 2000
@@ -4071,6 +4071,18 @@
 #endif /* ASC_CONFIG_PCI */
 #endif /* version < v2.1.93 */
 
+#if LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0)
+static struct pci_device_id advansys_pci_tbl[] __initdata = {
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1100, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1200, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2500, PCI_ANY_ID, PCI_ANY_ID },
+    { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, advansys_pci_tbl);
+#endif
+
 /*
  * Used with the LILO 'advansys' option to eliminate or
  * limit I/O port probing at boot time, cf. advansys_setup().
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/aic7xxx.c	Thu Oct 12 14:19:32 2000
+++ aic7xxx.c	Wed Nov 22 03:24:03 2000
@@ -9380,6 +9380,52 @@
   }
 }
 
+static struct pci_device_id aic7xxx_pci_tbl[] __initdata = {
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7810,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7850,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7855,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7821,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_3860,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_38602,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_38602,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7860,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7861,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7870,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7871,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7872,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7873,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7874,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7880,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7881,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7882,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7883,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7884,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7885,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7886,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7887,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7888,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_7895,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7890,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7890B,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_2930U2,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_2940U2,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7896,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_3940U2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_3950U2D,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC,PCI_DEVICE_ID_ADAPTEC_1480A,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7892A,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7892B,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7892D,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7892P,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7899A,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7899B,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7899D,PCI_ANY_ID,PCI_ANY_ID},
+  {PCI_VENDOR_ID_ADAPTEC2,PCI_DEVICE_ID_ADAPTEC2_7899P,PCI_ANY_ID,PCI_ANY_ID},
+  { }
+};
+
+MODULE_DEVICE_TABLE(pci, aic7xxx_pci_tbl);
+
 /*+F*************************************************************************
  * Function:
  *   aic7xxx_detect
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/atp870u.c	Sat Nov 11 19:01:11 2000
+++ atp870u.c	Wed Nov 22 04:40:46 2000
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <linux/pci.h>
@@ -1614,6 +1615,18 @@
 	tmport = wkport + 0x3a;
 	outb((unsigned char) (inb(tmport) & 0xef), tmport);
 }
+
+static struct pci_device_id atp870u_pci_tbl[] __initdata = {
+{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8020, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8030, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8040, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8050, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8060, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{ } 	/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, atp870u_pci_tbl);
 
 /* return non-zero on detection */
 int atp870u_detect(Scsi_Host_Template * tpnt)
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/cpqfcTSinit.c	Sat Nov 11 19:01:11 2000
+++ cpqfcTSinit.c	Wed Nov 22 04:40:46 2000
@@ -247,6 +247,24 @@
 // Agilent XL2 
 #define HBA_TYPES 2
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id cpqfcTS_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_COMPAQ,
+	  device: CPQ_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_HP,
+	  device: AGILENT_XL2_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, cpqfcTS_pci_tbl);
+#endif
 
 int cpqfcTS_detect(Scsi_Host_Template *ScsiHostTemplate)
 {
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/dmx3191d.c	Sat Nov 11 19:01:11 2000
+++ dmx3191d.c	Wed Nov 22 03:36:09 2000
@@ -52,6 +52,17 @@
 #include "NCR5380.h"
 #include "NCR5380.c"
 
+static struct pci_device_id dmx3191d_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DOMEX,
+	  device: PCI_DEVICE_ID_DOMEX_DMX3191D,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, dmx3191d_pci_tbl);
+
 
 int __init dmx3191d_detect(Scsi_Host_Template *tmpl) {
 	int boards = 0;
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/eata_dma.c	Sat Nov 11 19:01:11 2000
+++ eata_dma.c	Wed Nov 22 04:40:46 2000
@@ -73,6 +73,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <asm/byteorder.h>
 #include <asm/types.h>
 #include <asm/io.h>
@@ -91,6 +92,19 @@
 
 #include <linux/stat.h>
 #include <linux/config.h>	/* for CONFIG_PCI */
+
+#ifdef CONFIG_PCI
+static struct pci_device_id eata_dma_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DPT,
+	  device: PCI_DEVICE_ID_DPT,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, eata_dma_pci_tbl);
+#endif
 
 static u32 ISAbases[] =
 {0x1F0, 0x170, 0x330, 0x230};
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/fdomain.c	Sat Nov 11 19:01:11 2000
+++ fdomain.c	Wed Nov 22 03:31:00 2000
@@ -426,7 +426,18 @@
 				*/
 static char * fdomain = NULL;
 MODULE_PARM(fdomain, "s");
+static struct pci_device_id fdomain_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_FD,
+	  device: PCI_DEVICE_ID_FD_36C70,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, fdomain_pci_tbl);
 #endif
+
 
 static unsigned long addresses[] = {
    0xc8000,
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/gdth.c	Thu Nov 16 14:08:25 2000
+++ gdth.c	Wed Nov 22 03:27:43 2000
@@ -164,10 +164,7 @@
  * The other example: "modprobe gdth reserve_list=0,1,2,0,0,1,3,0 rescan=1".
  */
 
-#ifdef MODULE
 #include <linux/module.h>
-#endif
-
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -428,6 +425,44 @@
 static int max_ids = MAXID;
 /* rescan all IDs */
 static int rescan = 0;
+
+static struct pci_device_id gdth_pci_tbl[] __initdata = {
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT60x0, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6000B, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x10, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x20, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6530, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6550, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x17, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x27, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6537, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6557, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x15, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x25, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6535, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6555, PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x17RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x27RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6537RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6557RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x11RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x21RP,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x17RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x27RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6537RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6557RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x11RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x21RP1,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x17RP2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x27RP2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6537RP2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6557RP2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x11RP2,PCI_ANY_ID,PCI_ANY_ID},
+ {PCI_VENDOR_ID_VORTEX, PCI_DEVICE_ID_VORTEX_GDT6x21RP2,PCI_ANY_ID,PCI_ANY_ID},
+ { }
+};
+MODULE_DEVICE_TABLE(pci, gdth_pci_tbl);
+
 
 #ifdef MODULE
 /* parameters for modprobe/insmod */
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/ibmmca.c	Tue Oct 31 16:10:44 2000
+++ ibmmca.c	Sun Nov 12 00:46:13 2000
@@ -22,6 +22,7 @@
 #undef OLDKERN
 #endif
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
@@ -505,7 +506,6 @@
    (that is kernel version 2.1.x) */
 #if defined(MODULE)
 static char *boot_options = NULL;
-#include <linux/module.h>
 MODULE_PARM(boot_options, "s");
 MODULE_PARM(io_port, "1-" __MODULE_STRING(IM_MAX_HOSTS) "i");
 MODULE_PARM(scsi_id, "1-" __MODULE_STRING(IM_MAX_HOSTS) "i"); 
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/ini9100u.c	Sat Nov 11 19:01:11 2000
+++ ini9100u.c	Wed Nov 22 03:06:24 2000
@@ -209,6 +209,16 @@
 	{ DMX_VENDOR_ID, I920_DEVICE_ID },
 };
 
+static struct pci_device_id ini9100u_pci_tbl[] __initdata = {
+  { INI_VENDOR_ID, I950_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I940_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I935_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { DMX_VENDOR_ID, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ini9100u_pci_tbl);
+
 /*
  *  queue services:
  */
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/inia100.c	Sat Nov 11 19:01:11 2000
+++ inia100.c	Wed Nov 22 04:40:46 2000
@@ -139,6 +139,24 @@
 extern int orc_num_scb;
 extern ORC_HCS orc_hcs[];
 
+static struct pci_device_id inia100_pci_tbl[] __initdata = {
+	{
+	  vendor: ORC_VENDOR_ID,
+	  device: I920_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: ORC_VENDOR_ID,
+	  device: ORC_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, inia100_pci_tbl);
+
+
 /*****************************************************************************
  Function name  : inia100AppendSRBToQueue
  Description    : This function will push current request into save list
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/ips.c	Wed Nov  8 17:09:50 2000
+++ ips.c	Wed Nov 22 03:04:51 2000
@@ -473,6 +473,27 @@
 __setup("ips=", ips_setup);
 #endif
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id ips_pci_tbl[] __initdata = {
+	{
+	  vendor: IPS_VENDORID,
+	  device: IPS_MORPHEUS_DEVICEID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: IPS_VENDORID,
+	  device: IPS_MORPHEUS_DEVICEID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ips_pci_tbl);
+#endif
+
+
+
 /****************************************************************************/
 /*                                                                          */
 /* Routine Name: ips_detect                                                 */
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/megaraid.c	Wed Nov  8 17:09:50 2000
+++ megaraid.c	Wed Nov 22 04:40:46 2000
@@ -201,6 +201,31 @@
 #define COM_BASE 0x2f8
 
 
+#if defined(MODULE) && LINUX_VERSION_CODE >= 0x020400
+static struct pci_device_id megaraid_pci_tbl[] __initdata = {
+	{
+	  vendor: 0x101E,
+	  device: 0x9010,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: 0x101E,
+	  device: 0x9060,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: 0x8086,
+	  device: 0x1960,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);
+#endif
+
 u32 RDINDOOR (mega_host_config * megaCfg)
 {
   return readl (megaCfg->base + 0x20);
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/ncr53c8xx.c	Mon Sep 18 13:36:25 2000
+++ ncr53c8xx.c	Wed Nov 22 04:23:30 2000
@@ -200,6 +200,7 @@
 #define NAME53C8XX		"ncr53c8xx"
 #define DRIVER_SMP_LOCK		ncr53c8xx_lock
 
+#define base_io port
 #include "sym53c8xx_comm.h"
 
 /*==========================================================
@@ -9468,6 +9469,25 @@
 	PCI_DEVICE_ID_NCR_53C895A,
 	PCI_DEVICE_ID_NCR_53C1510D
 };
+
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id ncr53c8xx_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C815, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C820, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C825, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C860, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875J, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C885, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C896, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895A, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510D, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ncr53c8xx_pci_tbl);
+#endif
 
 /*==========================================================
 **
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/pci2000.c	Sat Nov 11 19:01:11 2000
+++ pci2000.c	Wed Nov 22 04:12:36 2000
@@ -53,6 +53,7 @@
 #include "hosts.h"
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include "pci2000.h"
 #include "psi_roy.h"
@@ -102,6 +103,16 @@
 #define HOSTDATA(host) ((PADAPTER2000)&host->hostdata)
 #define consistentLen (MAX_BUS * MAX_UNITS * (16 * sizeof (SCATGATH) + MAX_COMMAND_SIZE))
 
+static struct pci_device_id pci2000_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_ROY_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2000_pci_tbl);
 
 static struct	Scsi_Host 	   *PsiHost[MAXADAPTER] = {NULL,};  // One for each adapter
 static			int				NumAdapters = 0;
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/pci2220i.c	Sat Nov 11 19:01:11 2000
+++ pci2220i.c	Wed Nov 22 04:40:47 2000
@@ -51,6 +51,7 @@
 #include <linux/blk.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -75,6 +76,22 @@
 
 #define MAXADAPTER 4					// Increase this and the sizes of the arrays below, if you need more.
 
+static struct pci_device_id pci2220i_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_DALE_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_BIGD_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2220i_pci_tbl);
 
 typedef struct
 	{
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/qla1280.c	Mon Sep 18 13:36:25 2000
+++ qla1280.c	Wed Nov 22 04:15:16 2000
@@ -207,6 +207,7 @@
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
 #include <linux/tqueue.h>
+#include <linux/init.h>
 /* MRS #include <linux/tasks.h> */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,95)
 # include <linux/bios32.h>
@@ -486,6 +487,18 @@
                &fw12160i_code01[0],  (unsigned long *)&fw12160i_length01,&fw12160i_addr01, &fw12160i_version_str[0] },       
   {"        ",                 0,           0}
 };
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
+static struct pci_device_id qla1280_pci_tbl[] __initdata = {
+  { QLA1280_VENDOR_ID, QLA1080_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA1240_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA1280_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA12160_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA10160_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qla1280_pci_tbl);
+#endif
 
 static unsigned long qla1280_verbose = 1L;
 static scsi_qla_host_t *qla1280_hostlist = NULL;
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/qlogicfc.c	Mon Sep 18 13:36:25 2000
+++ qlogicfc.c	Wed Nov 22 04:16:46 2000
@@ -57,6 +57,7 @@
 #include <linux/delay.h>
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -713,6 +714,24 @@
 #if DEBUG_ISP2x00_INTR
 static void isp2x00_print_status_entry(struct Status_Entry *);
 #endif
+
+static struct pci_device_id qlogicfc_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP2100,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP2200,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qlogicfc_pci_tbl);
+
 
 static inline void isp2x00_enable_irqs(struct Scsi_Host *host)
 {
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/qlogicisp.c	Mon Sep 18 13:36:25 2000
+++ qlogicisp.c	Wed Nov 22 02:50:23 2000
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
+#include <linux/init.h>
 
 #include "sd.h"
 #include "hosts.h"
@@ -67,6 +68,19 @@
 /* End Configuration section *************************************************/
 
 #include <linux/module.h>
+
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id qlogicisp_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP1020,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qlogicisp_pci_tbl);
+#endif
 
 #if TRACE_ISP
 
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/scsi_debug.c	Sat Nov 11 19:01:11 2000
+++ scsi_debug.c	Sat Nov 11 23:48:05 2000
@@ -662,7 +662,6 @@
 
 int scsi_debug_biosparam(Disk * disk, kdev_t dev, int *info)
 {
-	int size = disk->capacity;
 	info[0] = N_HEAD;
 	info[1] = N_SECTOR;
 	info[2] = N_CYLINDER;
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/sym53c8xx.c	Tue Sep 19 08:31:53 2000
+++ sym53c8xx.c	Wed Nov 22 04:23:35 2000
@@ -601,6 +601,27 @@
 
 #endif	/* LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0) */
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id sym53c8xx_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C815, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C820, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C825, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C860, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875J, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C885, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C896, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895A, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510D, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_LSI_53C1010, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_LSI_53C1010_66, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, sym53c8xx_pci_tbl);
+#endif
+
 /*==========================================================
 **
 **	Debugging tags
@@ -13153,6 +13174,8 @@
 
 static ncr_chip	ncr_chip_table[] __initdata	= SCSI_NCR_CHIP_TABLE;
 static ushort	ncr_chip_ids[]   __initdata	= SCSI_NCR_CHIP_IDS;
+
+
 
 #ifdef	SCSI_NCR_PQS_PDS_SUPPORT
 /*===================================================================
--- /tmp/adam/linux-2.4.0-test11/drivers/scsi/tmscsim.c	Mon Sep 18 14:26:56 2000
+++ tmscsim.c	Wed Nov 22 02:29:41 2000
@@ -159,6 +159,7 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/blk.h>
+#include <linux/init.h>
 
 #include "scsi.h"
 #include "hosts.h"
@@ -207,6 +208,19 @@
 # if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,30)
 #  define USE_SPINLOCKS 2
 # endif
+#endif
+
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0)
+static struct pci_device_id tmscsim_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_AMD,
+	  device: PCI_DEVICE_ID_AMD53C974,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, tmscsim_pci_tbl);
 #endif
 
 #ifdef USE_SPINLOCKS

--opJtzjQTFsWo+cga--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
