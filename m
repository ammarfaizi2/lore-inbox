Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJTNlx>; Sat, 20 Oct 2001 09:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJTNlp>; Sat, 20 Oct 2001 09:41:45 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:20484 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S273261AbRJTNl2>;
	Sat, 20 Oct 2001 09:41:28 -0400
Date: Sat, 20 Oct 2001 15:37:50 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: nils@kernelconcepts.de, mj@suse.cz, jgarzik@mandrakesoft.com,
        prumpf@mandrakesoft.com, stelian.pop@fr.alcove.com,
        m.ashley@unsw.edu.au, jun1m@mars.dti.ne.jp, t-kinjo@tc4.so-net.ne.jp,
        tridge@valinux.com, andre@linux-ide.org, saw@saw.sw.com.sg,
        jmaurer@cck.uni-kl.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for linux-2.4.12 - i8xx series chipsets
Message-ID: <20011020153750.A11070@medelec.uia.ac.be>
Reply-To: wim@iguana.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been looking at the i8xx series chipsets in general. To be more specific I have been looking at the 82801 series of chipsets. This 82801 series are IDE/USB/LPC/... PCI bridges that work with the i8xx series chipsets. Based on the datasheets of the 82801 series, I patched some of the drivers to include the newer versions of the 82801 series of chipsets. In the process I also noticed that the PCI_ID's for the 82801BA series was not very neatly in the include/linux/pci_ids.h file. Thus I changed this so that we have a more uniform way to handle all 82801 chipsets.

Greetings,
Wim.


diff -u --recursive --new-file linux-2.4.12/Documentation/i8xx-tco.txt v2.4.12-patched/Documentation/i8xx-tco.txt
--- linux-2.4.12/Documentation/i8xx-tco.txt	Thu Jan  1 01:00:00 1970
+++ v2.4.12-patched/Documentation/i8xx-tco.txt	Sun Oct 14 13:45:39 2001
@@ -0,0 +1,126 @@
+i8xx-tco.txt -- Information regarding the TCO watchdog driver for i8xx chipsets
+===============================================================================
+
+Introduction:
+
+	The i810-tco device driver is a watchdog driver that is able to 
+	reboot your system in case of problems. The timer for this watchdog
+	driver is programmable and can be set from 2.4 till 38 seconds.
+	This driver works for all Intel(R) 800 series of chipsets.
+
+About the Intel(R) 800 series hardware, from the various datasheets:
+
+	The Intel(R) 800 series of chipsets are comprised of multiple 
+	components. The key items to identify are the I/O Controller 
+	Hub (ICH), Memory Controller Hub (MCH), Graphics Memory Controller 
+	Hub (GMCH), and Firmware Hub (FWH) components. The table below 
+	shows the combinations that make up the various Intel chipsets 
+	that are supported by the Intel(R) 800 series.
+
+	* Intel Chipsets with Integrated Graphics:
+
+	+------------------------+------------+--------------+------------+
+	| Intel Chipset          | ICH        | GMCH         | FWH        |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 810 chipset   | 82801AA or | FW82810 or   | 82802AB or |
+	|                        | 82801AB    | FW82810DC100 | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 810E chipset  | 82801AA or | FW82810E or  | 82802AB or |
+	|                        | 82801AB    | FW82810DC100 | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 810E2 chipset | 82801BA    | FW82810E or  | 82802AB or |
+	|                        |            | FW82810DC100 | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815 chipset   | 82801AA or | FW82815      | 82802AB or |
+	|                        | 82801AB    |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815E chipset  | 82801BA    | FW82815E     | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815EM chipset | 82801BAM   | FW82815EM    | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815 chipset   | 82801BA    | FW82815B     | 82802AB or |
+	| (B-step)               |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815G chipset  | 82801AA or | 82815G       | 82802AB or |
+	|                        | 82801AB    |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815EG chipset | 82801BA    | 82815EG      | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+
+	* Intel Chipsets without Integrated Graphics:
+
+	+------------------------+------------+--------------+------------+
+	| Intel Chipset          | ICH        | MCH          | FWH        |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815EP chipset | 82801BA    | 82815EP      | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 815P chipset  | 82801AA or | 82815P       | 82802AB or |
+	|                        | 82801AB    |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 820 chipset   | 82801AA or | 82820        | 82802AB or |
+	|                        | 82801AB    |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 820E chipset  | 82801BA    | 82820        | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 830MP chipset | 82801CAM   | 82830MP      | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 840 chipset   | 82801AA or | 82840        | 82802AB or |
+	|                        | 82801AB    |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 845 chipset   | 82801BA    | 82845        | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 850 chipset   | 82801BA    | 82850        | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+	| Intel(R) 860 chipset   | 82801BA    | 82860        | 82802AB or |
+	|                        |            |              | 82802AC    |
+	+------------------------+------------+--------------+------------+
+
+	The I/O Controller Hub (ICH) provides various functions to make a 
+	system easier to manage and to lower the Total Cost of Ownership 
+	(TCO) of the System. Features and functions can be augmented via 
+	external A/D convertors and GPIO, as well as an external 
+	microcontroller.
+
+	The following features and functions are supported by the ICH:
+	* Processor present detection.
+	  - Detects if the processor fails to fetch the first instruction
+	    after reset.
+	* Various Error detection, reported by the host controller
+	  - Can generate SMI#, SCI, SERR, NMI or TCO interrupt.
+	* Intruder Detect input
+	  - Can generate TCO interrupt or SMI# when the system cover is 
+	    removed.
+
+	One of the Error detection functions in the ICH is a watchdog
+	that can be programmed to reboot the system if the timer isn't 
+	reset/restarted.
+
+Usage:
+
+	The i8xx TCO watchdog is a module that can be configured with the 
+	"i810_margin" commandline argument which specifies the counter 
+	initial value. The counter is decremented every 0.6 seconds and 
+	defaults to 50 (30 seconds). Values can range between 4 and 63 
+	(values of 0 till 3 are ignored and should not be attempted).
+
+	The i810 TCO watchdog driver also implements the WDIOC_GETSTATUS 
+	and WDIOC_GETBOOTSTATUS ioctl()s. WDIOC_GETSTATUS returns the actual 
+	counter value and WDIOC_GETBOOTSTATUS returns the value of TCO2 
+	Status Register (see Intel's documentation for the 82801 datasheets).
+
+More info:
+
+	The TCO timer is implemented in the following I/O controller hubs:
+	(See the intel documentation on http://developer.intel.com.)
+	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
+	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
+	82801CA & 82801CAM chip : document number 290716-001, 290718-001
+
diff -u --recursive --new-file linux-2.4.12/arch/i386/kernel/pci-irq.c v2.4.12-patched/arch/i386/kernel/pci-irq.c
--- linux-2.4.12/arch/i386/kernel/pci-irq.c	Thu Jul  5 00:39:28 2001
+++ v2.4.12-patched/arch/i386/kernel/pci-irq.c	Sun Oct 14 22:36:23 2001
@@ -443,7 +443,12 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
diff -u --recursive --new-file linux-2.4.12/drivers/char/i810-tco.c v2.4.12-patched/drivers/char/i810-tco.c
--- linux-2.4.12/drivers/char/i810-tco.c	Fri Sep 14 00:21:32 2001
+++ v2.4.12-patched/drivers/char/i810-tco.c	Sun Oct 14 22:35:24 2001
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.02:	TCO timer driver for i810 chipsets
+ *	i810-tco 0.03:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -17,17 +17,22 @@
  *				developed for
  *                              Jentro AG, Haar/Munich (Germany)
  *
- *	TCO timer driver for i810/i815 chipsets
+ *	TCO timer driver for i8xx chipsets
  *	based on softdog.c by Alan Cox <alan@redhat.com>
  *
- *	The TCO timer is implemented in the 82801AA (82801AB) chip,
- *	see intel documentation from http://developer.intel.com,
- *	order number 290655-003
+ *	The TCO timer is implemented in the following I/O controller hubs:
+ *	(See the intel documentation on http://developer.intel.com.)
+ *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
+ *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
+ *	82801CA & 82801CAM chip : document number 290716-001, 290718-001
+ *
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
  *  20000728 Nils Faerber
  *      0.02 Fix for SMI_EN->TCO_EN bit, some cleanups
+ *  20010801 Wim Van Sebroeck
+ *	0.03 Support for 82801CA(M) chipset
  */
  
 #include <linux/module.h>
@@ -46,13 +51,8 @@
 #include "i810-tco.h"
 
 
-/* Just in case that the PCI vendor and device IDs are not yet defined */
-#ifndef PCI_DEVICE_ID_INTEL_82801AA_0
-#define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
-#endif
-
 /* Default expire timeout */
-#define TIMER_MARGIN	50	/* steps of 0.6sec, 2<n<64. Default is 30 seconds */
+#define TIMER_MARGIN	50	/* steps of 0.6sec, 3<n<64. Default is 30 seconds */
 
 static unsigned int ACPIBASE;
 static spinlock_t tco_lock;	/* Guards the hardware */
@@ -69,7 +69,7 @@
 static int boot_status;
 
 /*
- * Some i810 specific functions
+ * Some TCO specific functions
  */
 
 
@@ -120,7 +120,7 @@
 
 	/* from the specs: */
 	/* "Values of 0h-3h are ignored and should not be attempted" */
-	if (tmrval > 0x3f || tmrval < 0x03)
+	if (tmrval > 0x3f || tmrval < 0x04)
 		return -1;
 	
 	spin_lock(&tco_lock);
@@ -181,7 +181,7 @@
 	/*
 	 *      Shut off the timer.
 	 */
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
 	tco_timer_stop ();
 	timer_alive = 0;
 #endif	
@@ -241,10 +241,12 @@
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id i810tco_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
@@ -279,7 +281,7 @@
 		ACPIBASE = badr;
 		/* Something's wrong here, ACPIBASE has to be set */
 		if (badr == 0x0001 || badr == 0x0000) {
-			printk (KERN_ERR "i810tco init: failed to get TCOBASE address\n");
+			printk (KERN_ERR "i810 TCO timer: failed to get TCOBASE address\n");
 			return 0;
 		}
 		/*
@@ -291,7 +293,7 @@
 			pci_write_config_byte (i810tco_pci, 0xd4, val1);
 			pci_read_config_byte (i810tco_pci, 0xd4, &val1);
 			if (val1 & 0x02) {
-				printk (KERN_ERR "i810tco init: failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
+				printk (KERN_ERR "i810 TCO timer: failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
 				return 0;	/* Cannot reset NO_REBOOT bit */
 			}
 		}
@@ -342,7 +344,7 @@
 	tco_timer_reload ();
 
 	printk (KERN_INFO
-		"i810 TCO timer: V0.02, timer margin: %d sec (0x%04x)\n",
+		"i810 TCO timer: V0.03, timer margin: %d sec (0x%04x)\n",
 		(int) (i810_margin * 6 / 10), TCOBASE);
 	return 0;
 }
diff -u --recursive --new-file linux-2.4.12/drivers/char/i810-tco.h v2.4.12-patched/drivers/char/i810-tco.h
--- linux-2.4.12/drivers/char/i810-tco.h	Sat Aug 12 00:57:57 2000
+++ v2.4.12-patched/drivers/char/i810-tco.h	Sun Oct 14 13:48:05 2001
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.02:	TCO timer driver for i810 chipsets
+ *	i810-tco 0.03:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -17,19 +17,20 @@
  *				developed for
  *                              Jentro AG, Haar/Munich (Germany)
  *
- *	TCO timer driver for i810 chipsets
+ *	TCO timer driver for i8xx chipsets
  *	based on softdog.c by Alan Cox <alan@redhat.com>
  *
- *      The TCO timer is implemented in the 82801AA (82801AB) chip,
- *	see intel documentation from http://developer.intel.com,
- *	order number 290655-003
+ *	The TCO timer is implemented in the following I/O controller hubs:
+ *	(See the intel documentation on http://developer.intel.com.)
+ *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
+ *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
+ *	82801CA & 82801CAM chip : document number 290716-001, 290718-001
  *
  *	For history see i810-tco.c
  */
 
-
 /*
- * Some address definitions for the i810 TCO
+ * Some address definitions for the i8xx TCO
  */
 
 #define	TCOBASE		ACPIBASE + 0x60	/* TCO base address		*/
diff -u --recursive --new-file linux-2.4.12/drivers/char/i810_rng.c v2.4.12-patched/drivers/char/i810_rng.c
--- linux-2.4.12/drivers/char/i810_rng.c	Thu Apr 12 21:15:25 2001
+++ v2.4.12-patched/drivers/char/i810_rng.c	Sun Oct 14 22:33:33 2001
@@ -332,9 +332,10 @@
  * want to register another driver on the same PCI id.
  */
 static struct pci_device_id rng_pci_tbl[] __initdata = {
-	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0x8086, 0x1130, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_8, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_14, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
diff -u --recursive --new-file linux-2.4.12/drivers/char/sonypi.c v2.4.12-patched/drivers/char/sonypi.c
--- linux-2.4.12/drivers/char/sonypi.c	Tue Sep 18 07:52:35 2001
+++ v2.4.12-patched/drivers/char/sonypi.c	Sun Oct 14 22:30:38 2001
@@ -659,7 +659,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 	  (unsigned long) SONYPI_DEVICE_MODEL_NORMAL },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_12,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 	  (unsigned long) SONYPI_DEVICE_MODEL_R505 },
 	{ }
diff -u --recursive --new-file linux-2.4.12/drivers/ide/ide-pci.c v2.4.12-patched/drivers/ide/ide-pci.c
--- linux-2.4.12/drivers/ide/ide-pci.c	Sun Sep 30 21:26:05 2001
+++ v2.4.12-patched/drivers/ide/ide-pci.c	Sun Oct 14 22:29:29 2001
@@ -35,8 +35,10 @@
 #define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
 #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
 #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
-#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_9})
-#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_8})
+#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_10})
+#define DEVID_PIIX4U4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_11})
+#define DEVID_PIIX4U5	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_10})
+#define DEVID_PIIX4U6	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801CA_11})
 #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
 #define DEVID_MR_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C576_1})
 #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
@@ -385,6 +387,8 @@
 	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_PIIX4U4, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U5, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
+	{DEVID_PIIX4U6, "PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
 	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_MR_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
 	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
diff -u --recursive --new-file linux-2.4.12/drivers/ide/piix.c v2.4.12-patched/drivers/ide/piix.c
--- linux-2.4.12/drivers/ide/piix.c	Mon Aug 13 23:56:19 2001
+++ v2.4.12-patched/drivers/ide/piix.c	Sun Oct 14 21:24:56 2001
@@ -89,8 +89,10 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801BA_8:
-		case PCI_DEVICE_ID_INTEL_82801BA_9:
+		case PCI_DEVICE_ID_INTEL_82801BA_10:
+		case PCI_DEVICE_ID_INTEL_82801BA_11:
+		case PCI_DEVICE_ID_INTEL_82801CA_10:
+		case PCI_DEVICE_ID_INTEL_82801CA_11:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
 			break;
 		case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -363,8 +365,10 @@
 	byte			speed;
 
 	byte udma_66		= eighty_ninty_three(drive);
-	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_8) ||
-				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_9)) ? 1 : 0;
+	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801BA_11) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_10) ||
+				   (dev->device == PCI_DEVICE_ID_INTEL_82801CA_11)) ? 1 : 0;
 	int ultra66		= ((ultra100) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
 				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
diff -u --recursive --new-file linux-2.4.12/drivers/net/eepro100.c v2.4.12-patched/drivers/net/eepro100.c
--- linux-2.4.12/drivers/net/eepro100.c	Sun Sep 30 21:26:08 2001
+++ v2.4.12-patched/drivers/net/eepro100.c	Sun Oct 14 21:19:56 2001
@@ -2230,7 +2230,7 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0,}
 };
diff -u --recursive --new-file linux-2.4.12/include/linux/pci_ids.h v2.4.12-patched/include/linux/pci_ids.h
--- linux-2.4.12/include/linux/pci_ids.h	Thu Oct 11 08:19:30 2001
+++ v2.4.12-patched/include/linux/pci_ids.h	Sun Oct 14 21:16:37 2001
@@ -1559,15 +1559,6 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
-#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
-#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
-#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
-#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
-#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
-#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
-#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
-#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
-#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_2	0x2412
@@ -1583,17 +1574,33 @@
 #define PCI_DEVICE_ID_INTEL_82801AB_6	0x2426
 #define PCI_DEVICE_ID_INTEL_82801AB_8	0x2428
 #define PCI_DEVICE_ID_INTEL_82801BA_0	0x2440
-#define PCI_DEVICE_ID_INTEL_82801BA_1	0x2442
-#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2443
-#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2444
-#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2445
-#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2446
-#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2448
-#define PCI_DEVICE_ID_INTEL_82801BA_7	0x2449
-#define PCI_DEVICE_ID_INTEL_82801BA_8	0x244a
-#define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
-#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
-#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2442
+#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2443
+#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2444
+#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2445
+#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2446
+#define PCI_DEVICE_ID_INTEL_82801BA_8	0x2448
+#define PCI_DEVICE_ID_INTEL_82801BA_9	0x2449
+#define PCI_DEVICE_ID_INTEL_82801BA_10	0x244a
+#define PCI_DEVICE_ID_INTEL_82801BA_11	0x244b
+#define PCI_DEVICE_ID_INTEL_82801BA_12	0x244c
+#define PCI_DEVICE_ID_INTEL_82801BA_14	0x244e
+#define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
+#define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
+#define PCI_DEVICE_ID_INTEL_82801CA_5	0x2485
+#define PCI_DEVICE_ID_INTEL_82801CA_6	0x2486
+#define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
+#define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
+#define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
+#define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
+#define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
+#define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
+#define PCI_DEVICE_ID_INTEL_82437VX	0x7030
+#define PCI_DEVICE_ID_INTEL_82439TX	0x7100
+#define PCI_DEVICE_ID_INTEL_82371AB_0	0x7110
+#define PCI_DEVICE_ID_INTEL_82371AB	0x7111
+#define PCI_DEVICE_ID_INTEL_82371AB_2	0x7112
+#define PCI_DEVICE_ID_INTEL_82371AB_3	0x7113
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
 #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
