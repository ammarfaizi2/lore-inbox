Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJaVw0>; Wed, 31 Oct 2001 16:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJaVwM>; Wed, 31 Oct 2001 16:52:12 -0500
Received: from patan.Sun.COM ([192.18.98.43]:4227 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S273364AbRJaVvt>;
	Wed, 31 Oct 2001 16:51:49 -0500
Message-ID: <3BE07523.5A540AE@sun.com>
Date: Wed, 31 Oct 2001 14:03:15 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@aslab.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE: hpt366.c and serverworks.c 
In-Reply-To: <Pine.LNX.4.21.0110290333300.12058-200000@athy.aslab.com>
Content-Type: multipart/mixed;
 boundary="------------E980EFA47240A2CA4844C65E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E980EFA47240A2CA4844C65E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre,
Attached you'll find the patch to hpt366.c (against your base you sent me)
and serverworks.c.  Both of these have been in use for some time.



Tim




-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------E980EFA47240A2CA4844C65E
Content-Type: text/plain; charset=us-ascii;
 name="hpt366.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpt366.diff"

--- /home/thockin/andre-hpt366.c	Tue Oct 30 16:30:08 2001
+++ drivers/ide/hpt366.c	Wed Oct 31 13:56:44 2001
@@ -1,7 +1,8 @@
 /*
- * linux/drivers/ide/hpt366.c		Version 0.18	June. 9, 2000
+ * linux/drivers/ide/hpt366.c		Version 0.22	20 Sep 2001
  *
  * Copyright (C) 1999-2000		Andre Hedrick <andre@linux-ide.org>
+ * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * May be copied or modified under the terms of the GNU General Public License
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
@@ -11,6 +12,34 @@
  *
  * Note that final HPT370 support was done by force extraction of GPL.
  *
+ * - add function for getting/setting power status of drive
+ * - the HPT370's state machine can get confused. reset it before each dma 
+ *   xfer to prevent that from happening.
+ * - reset state engine whenever we get an error.
+ * - check for busmaster state at end of dma. 
+ * - use new highpoint timings.
+ * - detect bus speed using highpoint register.
+ * - use pll if we don't have a clock table. added a 66MHz table that's
+ *   just 2x the 33MHz table.
+ * - removed turnaround. NOTE: we never want to switch between pll and
+ *   pci clocks as the chip can glitch in those cases. the highpoint
+ *   approved workaround slows everything down too much to be useful. in
+ *   addition, we would have to serialize access to each chip.
+ * 	Adrian Sun <a.sun@sun.com>
+ *
+ * add drive timings for 66MHz PCI bus,
+ * fix ATA Cable signal detection, fix incorrect /proc info
+ * add /proc display for per-drive PIO/DMA/UDMA mode and
+ * per-channel ATA-33/66 Cable detect.
+ * 	Duncan Laurie <void@sun.com>
+ *
+ * fixup /proc output for multiple controllers
+ *	Tim Hockin <thockin@sun.com>
+ *
+ * On hpt366: 
+ * Reset the hpt366 on error, reset on dma
+ * Fix disabling Fast Interrupt hpt366.
+ * 	Mike Waychison <crlf@sun.com>
  */
 
 #include <linux/config.h>
@@ -28,6 +57,7 @@
 #include <linux/init.h>
 #include <linux/ide.h>
 
+#include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -35,6 +65,11 @@
 
 #define DISPLAY_HPT366_TIMINGS
 
+/* various tuning parameters */
+#define HPT_RESET_STATE_ENGINE
+/*#define HPT_DELAY_INTERRUPT*/
+/*#define HPT_SERIALIZE_IO*/
+
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -106,146 +141,302 @@
 
 struct chipset_bus_clock_list_entry {
 	byte		xfer_speed;
-	unsigned int	chipset_settings_write;
-	unsigned int	chipset_settings_read;
+	unsigned int	chipset_settings;
 };
 
+/* key for bus clock timings
+ * bit
+ * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
+ *        DMA. cycles = value + 1
+ * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
+ *        DMA. cycles = value + 1
+ * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
+ *        register access.
+ * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
+ *        register access.
+ * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
+ *        during task file register access.
+ * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
+ *        xfer.
+ * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
+ *        register access.
+ * 28     UDMA enable
+ * 29     DMA enable
+ * 30     PIO_MST enable. if set, the chip is in bus master mode during
+ *        PIO.
+ * 31     FIFO enable.
+ */
 struct chipset_bus_clock_list_entry forty_base [] = {
 
-	{	XFER_UDMA_4,	0x900fd943,	0x900fd943	},
-	{	XFER_UDMA_3,	0x900ad943,	0x900ad943	},
-	{	XFER_UDMA_2,	0x900bd943,	0x900bd943	},
-	{	XFER_UDMA_1,	0x9008d943,	0x9008d943	},
-	{	XFER_UDMA_0,	0x9008d943,	0x9008d943	},
-
-	{	XFER_MW_DMA_2,	0xa008d943,	0xa008d943	},
-	{	XFER_MW_DMA_1,	0xa010d955,	0xa010d955	},
-	{	XFER_MW_DMA_0,	0xa010d9fc,	0xa010d9fc	},
-
-	{	XFER_PIO_4,	0xc008d963,	0xc008d963	},
-	{	XFER_PIO_3,	0xc010d974,	0xc010d974	},
-	{	XFER_PIO_2,	0xc010d997,	0xc010d997	},
-	{	XFER_PIO_1,	0xc010d9c7,	0xc010d9c7	},
-	{	XFER_PIO_0,	0xc018d9d9,	0xc018d9d9	},
-	{	0,		0x0120d9d9,	0x0120d9d9	}
+	{	XFER_UDMA_4,    0x900fd943	},
+	{	XFER_UDMA_3,	0x900ad943	},
+	{	XFER_UDMA_2,	0x900bd943	},
+	{	XFER_UDMA_1,	0x9008d943	},
+	{	XFER_UDMA_0,	0x9008d943	},
+
+	{	XFER_MW_DMA_2,	0xa008d943	},
+	{	XFER_MW_DMA_1,	0xa010d955	},
+	{	XFER_MW_DMA_0,	0xa010d9fc	},
+
+	{	XFER_PIO_4,	0xc008d963	},
+	{	XFER_PIO_3,	0xc010d974	},
+	{	XFER_PIO_2,	0xc010d997	},
+	{	XFER_PIO_1,	0xc010d9c7	},
+	{	XFER_PIO_0,	0xc018d9d9	},
+	{	0,		0x0120d9d9	}
 };
 
 struct chipset_bus_clock_list_entry thirty_three_base [] = {
 
-	{	XFER_UDMA_4,	0x90c9a731,	0x90c9a731	},
-	{	XFER_UDMA_3,	0x90cfa731,	0x90cfa731	},
-	{	XFER_UDMA_2,	0x90caa731,	0x90caa731	},
-	{	XFER_UDMA_1,	0x90cba731,	0x90cba731	},
-	{	XFER_UDMA_0,	0x90c8a731,	0x90c8a731	},
-
-	{	XFER_MW_DMA_2,	0xa0c8a731,	0xa0c8a731	},
-	{	XFER_MW_DMA_1,	0xa0c8a732,	0xa0c8a732	},	/* 0xa0c8a733 */
-	{	XFER_MW_DMA_0,	0xa0c8a797,	0xa0c8a797	},
-
-	{	XFER_PIO_4,	0xc0c8a731,	0xc0c8a731	},
-	{	XFER_PIO_3,	0xc0c8a742,	0xc0c8a742	},
-	{	XFER_PIO_2,	0xc0d0a753,	0xc0d0a753	},
-	{	XFER_PIO_1,	0xc0d0a7a3,	0xc0d0a7a3	},	/* 0xc0d0a793 */
-	{	XFER_PIO_0,	0xc0d0a7aa,	0xc0d0a7aa	},	/* 0xc0d0a7a7 */
-	{	0,		0x0120a7a7,	0x0120a7a7	}
+	{	XFER_UDMA_4,	0x90c9a731	},
+	{	XFER_UDMA_3,	0x90cfa731	},
+	{	XFER_UDMA_2,	0x90caa731	},
+	{	XFER_UDMA_1,	0x90cba731	},
+	{	XFER_UDMA_0,	0x90c8a731	},
+
+	{	XFER_MW_DMA_2,	0xa0c8a731	},
+	{	XFER_MW_DMA_1,	0xa0c8a732	},	/* 0xa0c8a733 */
+	{	XFER_MW_DMA_0,	0xa0c8a797	},
+
+	{	XFER_PIO_4,	0xc0c8a731	},
+	{	XFER_PIO_3,	0xc0c8a742	},
+	{	XFER_PIO_2,	0xc0d0a753	},
+	{	XFER_PIO_1,	0xc0d0a7a3	},	/* 0xc0d0a793 */
+	{	XFER_PIO_0,	0xc0d0a7aa	},	/* 0xc0d0a7a7 */
+	{	0,		0x0120a7a7	}
 };
 
 struct chipset_bus_clock_list_entry twenty_five_base [] = {
 
-	{	XFER_UDMA_4,	0x90c98521,	0x90c98521	},
-	{	XFER_UDMA_3,	0x90cf8521,	0x90cf8521	},
-	{	XFER_UDMA_2,	0x90cf8521,	0x90cf8521	},
-	{	XFER_UDMA_1,	0x90cb8521,	0x90cb8521	},
-	{	XFER_UDMA_0,	0x90cb8521,	0x90cb8521	},
-
-	{	XFER_MW_DMA_2,	0xa0ca8521,	0xa0ca8521	},
-	{	XFER_MW_DMA_1,	0xa0ca8532,	0xa0ca8532	},
-	{	XFER_MW_DMA_0,	0xa0ca8575,	0xa0ca8575	},
-
-	{	XFER_PIO_4,	0xc0ca8521,	0xc0ca8521	},
-	{	XFER_PIO_3,	0xc0ca8532,	0xc0ca8532	},
-	{	XFER_PIO_2,	0xc0ca8542,	0xc0ca8542	},
-	{	XFER_PIO_1,	0xc0d08572,	0xc0d08572	},
-	{	XFER_PIO_0,	0xc0d08585,	0xc0d08585	},
-	{	0,		0x01208585,	0x01208585	}
+	{	XFER_UDMA_4,	0x90c98521	},
+	{	XFER_UDMA_3,	0x90cf8521	},
+	{	XFER_UDMA_2,	0x90cf8521	},
+	{	XFER_UDMA_1,	0x90cb8521	},
+	{	XFER_UDMA_0,	0x90cb8521	},
+
+	{	XFER_MW_DMA_2,	0xa0ca8521	},
+	{	XFER_MW_DMA_1,	0xa0ca8532	},
+	{	XFER_MW_DMA_0,	0xa0ca8575	},
+
+	{	XFER_PIO_4,	0xc0ca8521	},
+	{	XFER_PIO_3,	0xc0ca8532	},
+	{	XFER_PIO_2,	0xc0ca8542	},
+	{	XFER_PIO_1,	0xc0d08572	},
+	{	XFER_PIO_0,	0xc0d08585	},
+	{	0,		0x01208585	}
+};
+
+#if 1
+/* these are the current (4 sep 2001) timings from highpoint */
+struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
+        {       XFER_UDMA_5,    0x12446231      },
+        {       XFER_UDMA_4,    0x12446231      },
+        {       XFER_UDMA_3,    0x126c6231      },
+        {       XFER_UDMA_2,    0x12486231      },
+        {       XFER_UDMA_1,    0x124c6233      },
+        {       XFER_UDMA_0,    0x12506297      },
+
+        {       XFER_MW_DMA_2,  0x22406c31      },
+        {       XFER_MW_DMA_1,  0x22406c33      },
+        {       XFER_MW_DMA_0,  0x22406c97      },
+
+        {       XFER_PIO_4,     0x06414e31      },
+        {       XFER_PIO_3,     0x06414e42      },
+        {       XFER_PIO_2,     0x06414e53      },
+        {       XFER_PIO_1,     0x06814e93      },
+        {       XFER_PIO_0,     0x06814ea7      },
+        {       0,              0x06814ea7      }
 };
 
+/* 2x 33MHz timings */
+struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
+	{       XFER_UDMA_5,    0x1488e673       },
+	{       XFER_UDMA_4,    0x1488e673       },
+	{       XFER_UDMA_3,    0x1498e673       },
+	{       XFER_UDMA_2,    0x1490e673       },
+	{       XFER_UDMA_1,    0x1498e677       },
+	{       XFER_UDMA_0,    0x14a0e73f       },
+
+	{       XFER_MW_DMA_2,  0x2480fa73       },
+	{       XFER_MW_DMA_1,  0x2480fa77       }, 
+	{       XFER_MW_DMA_0,  0x2480fb3f       },
+
+	{       XFER_PIO_4,     0x0c82be73       },
+	{       XFER_PIO_3,     0x0c82be95       },
+	{       XFER_PIO_2,     0x0c82beb7       },
+	{       XFER_PIO_1,     0x0d02bf37       },
+	{       XFER_PIO_0,     0x0d02bf5f       },
+	{       0,              0x0d02bf5f       }
+};
+#else
+/* from highpoint documentation. these are old values */
 struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
-	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	},
-	{	XFER_UDMA_4,	0x16454e31,	0x16454e31	},
-	{	XFER_UDMA_3,	0x166d4e31,	0x166d4e31	},
-	{	XFER_UDMA_2,	0x16494e31,	0x16494e31	},
-	{	XFER_UDMA_1,	0x164d4e31,	0x164d4e31	},
-	{	XFER_UDMA_0,	0x16514e31,	0x16514e31	},
-
-	{	XFER_MW_DMA_2,	0x26514e21,	0x26514e21	},
-	{	XFER_MW_DMA_1,	0x26514e33,	0x26514e33	},
-	{	XFER_MW_DMA_0,	0x26514e97,	0x26514e97	},
-
-	{	XFER_PIO_4,	0x06514e21,	0x06514e21	},
-	{	XFER_PIO_3,	0x06514e22,	0x06514e22	},
-	{	XFER_PIO_2,	0x06514e33,	0x06514e33	},
-	{	XFER_PIO_1,	0x06914e43,	0x06914e43	},
-	{	XFER_PIO_0,	0x06914e57,	0x06914e57	},
-	{	0,		0x06514e57,	0x06514e57	}
+	{	XFER_UDMA_5,	0x16454e31	},
+	{	XFER_UDMA_4,	0x16454e31	},
+	{	XFER_UDMA_3,	0x166d4e31	},
+	{	XFER_UDMA_2,	0x16494e31	},
+	{	XFER_UDMA_1,	0x164d4e31	},
+	{	XFER_UDMA_0,	0x16514e31	},
+
+	{	XFER_MW_DMA_2,	0x26514e21	},
+	{	XFER_MW_DMA_1,	0x26514e33	},
+	{	XFER_MW_DMA_0,	0x26514e97	},
+
+	{	XFER_PIO_4,	0x06514e21	},
+	{	XFER_PIO_3,	0x06514e22	},
+	{	XFER_PIO_2,	0x06514e33	},
+	{	XFER_PIO_1,	0x06914e43	},
+	{	XFER_PIO_0,	0x06914e57	},
+	{	0,		0x06514e57	}
+};
+
+struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
+	{       XFER_UDMA_5,    0x14846231      },
+	{       XFER_UDMA_4,    0x14886231      },
+	{       XFER_UDMA_3,    0x148c6231      },
+	{       XFER_UDMA_2,    0x148c6231      },
+	{       XFER_UDMA_1,    0x14906231      },
+	{       XFER_UDMA_0,    0x14986231      },
+	
+	{       XFER_MW_DMA_2,  0x26514e21      },
+	{       XFER_MW_DMA_1,  0x26514e33      },
+	{       XFER_MW_DMA_0,  0x26514e97      },
+	
+	{       XFER_PIO_4,     0x06514e21      },
+	{       XFER_PIO_3,     0x06514e22      },
+	{       XFER_PIO_2,     0x06514e33      },
+	{       XFER_PIO_1,     0x06914e43      },
+	{       XFER_PIO_0,     0x06914e57      },
+	{       0,              0x06514e57      }
+};
+#endif
+
+struct chipset_bus_clock_list_entry fifty_base_hpt370[] = {
+	{       XFER_UDMA_5,    0x12848242      },
+	{       XFER_UDMA_4,    0x12ac8242      },
+	{       XFER_UDMA_3,    0x128c8242      },
+	{       XFER_UDMA_2,    0x120c8242      },
+	{       XFER_UDMA_1,    0x12148254      },
+	{       XFER_UDMA_0,    0x121882ea      },
+
+	{       XFER_MW_DMA_2,  0x22808242      },
+	{       XFER_MW_DMA_1,  0x22808254      },
+	{       XFER_MW_DMA_0,  0x228082ea      },
+
+	{       XFER_PIO_4,     0x0a81f442      },
+	{       XFER_PIO_3,     0x0a81f443      },
+	{       XFER_PIO_2,     0x0a81f454      },
+	{       XFER_PIO_1,     0x0ac1f465      },
+	{       XFER_PIO_0,     0x0ac1f48a      },
+	{       0,              0x0ac1f48a      }
 };
 
 #define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT370_ALLOW_ATA100_5		1
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
+#define HPT366_MAX_DEVS			8
+
+#define F_LOW_PCI_33      0x23
+#define F_LOW_PCI_40      0x29
+#define F_LOW_PCI_50      0x2d
+#define F_LOW_PCI_66      0x42
+
+static struct pci_dev *hpt_devs[HPT366_MAX_DEVS];
+static int n_hpt_devs;
+
+static unsigned int pci_rev_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev2_check_hpt3xx(struct pci_dev *dev);
+byte hpt366_proc = 0;
+byte hpt363_shared_irq;
+byte hpt363_shared_pin;
+extern char *ide_xfer_verbose (byte xfer_rate);
 
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 static int hpt366_get_info(char *, char **, off_t, int);
 extern int (*hpt366_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 extern char *ide_media_verbose(ide_drive_t *);
-static struct pci_dev *bmide_dev;
-static struct pci_dev *bmide2_dev;
 
 static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
 {
-	char *p		= buffer;
-	u32 bibma	= bmide_dev->resource[4].start;
-	u32 bibma2 	= bmide2_dev->resource[4].start;
-	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A"};
-	u8  c0 = 0, c1 = 0;
-	u32 class_rev;
-
-	pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
-
-        /*
-         * at that point bibma+0x2 et bibma+0xa are byte registers
-         * to investigate:
-         */
-	c0 = inb_p((unsigned short)bibma + 0x02);
-	if (bmide2_dev)
-		c1 = inb_p((unsigned short)bibma2 + 0x02);
-
-	p += sprintf(p, "\n                                %s Chipset.\n", chipset_names[class_rev]);
-	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	p += sprintf(p, "                %sabled                         %sabled\n",
-			(c0&0x80) ? "dis" : " en",
-			(c1&0x80) ? "dis" : " en");
-	p += sprintf(p, "--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------\n");
-	p += sprintf(p, "DMA enabled:    %s              %s             %s               %s\n",
-			(c0&0x20) ? "yes" : "no ", (c0&0x40) ? "yes" : "no ",
-			(c1&0x20) ? "yes" : "no ", (c1&0x40) ? "yes" : "no " );
-
-	p += sprintf(p, "UDMA\n");
-	p += sprintf(p, "DMA\n");
-	p += sprintf(p, "PIO\n");
+	char *p	= buffer;
+	char *chipset_nums[] = {"366", "366", "368", "370", "370A"};
+	int i;
+
+	p += sprintf(p, "\n                             "
+		"HighPoint HPT366/368/370\n");
+	for (i = 0; i < n_hpt_devs; i++) {
+		struct pci_dev *dev = hpt_devs[i];
+		unsigned short iobase = dev->resource[4].start;
+		u32 class_rev;
+		u8 c0, c1;
+
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+		class_rev &= 0xff;
+
+		p += sprintf(p, "\nController: %d\n", i);
+		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		p += sprintf(p, "--------------- Primary Channel "
+				"--------------- Secondary Channel "
+				"--------------\n");
+
+		/* get the bus master status registers */
+		c0 = inb_p(iobase + 0x2);
+		c1 = inb_p(iobase + 0xa);
+		p += sprintf(p, "Enabled:        %s"
+				"                             %s\n",
+			(c0 & 0x80) ? "no" : "yes",
+			(c1 & 0x80) ? "no" : "yes");
+
+		if (pci_rev_check_hpt3xx(dev)) {
+			u8 cbl;
+			cbl = inb_p(iobase + 0x7b);
+			outb_p(cbl | 1, iobase + 0x7b);
+			outb_p(cbl & ~1, iobase + 0x7b);
+			cbl = inb_p(iobase + 0x7a);
+			p += sprintf(p, "Cable:          ATA-%d"
+					"                          ATA-%d\n",
+				(cbl & 0x02) ? 33 : 66,
+				(cbl & 0x01) ? 33 : 66);
+			p += sprintf(p, "\n");
+		}
 
+		p += sprintf(p, "--------------- drive0 --------- drive1 "
+				"------- drive0 ---------- drive1 -------\n");
+		p += sprintf(p, "DMA capable:    %s              %s" 
+				"            %s               %s\n",
+			(c0 & 0x20) ? "yes" : "no ", 
+			(c0 & 0x40) ? "yes" : "no ",
+			(c1 & 0x20) ? "yes" : "no ", 
+			(c1 & 0x40) ? "yes" : "no ");
+
+		{
+			u8 c2, c3;
+			/* older revs don't have these registers mapped 
+			 * into io space */
+			pci_read_config_byte(dev, 0x43, &c0);
+			pci_read_config_byte(dev, 0x47, &c1);
+			pci_read_config_byte(dev, 0x4b, &c2);
+			pci_read_config_byte(dev, 0x4f, &c3);
+
+			p += sprintf(p, "Mode:           %s             %s"
+					"           %s              %s\n",
+				(c0 & 0x10) ? "UDMA" : (c0 & 0x20) ? "DMA " : 
+					(c0 & 0x80) ? "PIO " : "off ",
+				(c1 & 0x10) ? "UDMA" : (c1 & 0x20) ? "DMA " :
+					(c1 & 0x80) ? "PIO " : "off ",
+				(c2 & 0x10) ? "UDMA" : (c2 & 0x20) ? "DMA " :
+					(c2 & 0x80) ? "PIO " : "off ",
+				(c3 & 0x10) ? "UDMA" : (c3 & 0x20) ? "DMA " :
+					(c3 & 0x80) ? "PIO " : "off ");
+		}
+	}
+	p += sprintf(p, "\n");
+	
 	return p-buffer;/* => must be less than 4k! */
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-byte hpt366_proc = 0;
-
-extern char *ide_xfer_verbose (byte xfer_rate);
-byte hpt363_shared_irq;
-byte hpt363_shared_pin;
-
 static unsigned int pci_rev_check_hpt3xx (struct pci_dev *dev)
 {
 	unsigned int class_rev;
@@ -282,16 +473,16 @@
 	return 0;
 }
 
-static unsigned int pci_bus_clock_list (byte speed, int direction, struct chipset_bus_clock_list_entry * chipset_table)
+static unsigned int pci_bus_clock_list (byte speed, struct chipset_bus_clock_list_entry * chipset_table)
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
-			return (direction) ? chipset_table->chipset_settings_write : chipset_table->chipset_settings_read;
+			return chipset_table->chipset_settings;
 		}
-	return (direction) ? chipset_table->chipset_settings_write : chipset_table->chipset_settings_read;
+	return chipset_table->chipset_settings;
 }
 
-static void hpt366_tune_chipset (ide_drive_t *drive, byte speed, int direction)
+static void hpt366_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	byte regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
 	byte regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
@@ -304,36 +495,24 @@
 	byte drive_fast		= 0;
 
 	/*
-	 * Disable the "fast interrupt" prediction.
+	 * Disable the "fast interrupt" prediction. 
 	 */
 	pci_read_config_byte(HWIF(drive)->pci_dev, regfast, &drive_fast);
-
-	/*
-	 * FIXME kludge to correct a detection problem or driver design flaw.
-	 */
-	if (pci_rev_check_hpt3xx(HWIF(drive)->pci_dev)) {
-		if (drive_fast & 0x80)
-			pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x80);
-	} else {
-		if (drive_fast & 0x02)
-			pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast& ~0x20);
-	}
-	/*
-	 * FIXME kludge end of fsckup
-	 */
+	if (drive_fast & 0x80)
+		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x80);
 
 	pci_read_config_dword(HWIF(drive)->pci_dev, regtime, &reg1);
 	/* detect bus speed by looking at control reg timing: */
 	switch((reg1 >> 8) & 15) {
 		case 5:
-			reg2 = pci_bus_clock_list(speed, direction, forty_base);
+			reg2 = pci_bus_clock_list(speed, forty_base);
 			break;
 		case 9:
-			reg2 = pci_bus_clock_list(speed, direction, twenty_five_base);
+			reg2 = pci_bus_clock_list(speed, twenty_five_base);
 			break;
 		default:
 		case 7:
-			reg2 = pci_bus_clock_list(speed, direction, thirty_three_base);
+			reg2 = pci_bus_clock_list(speed, thirty_three_base);
 			break;
 	}
 	/*
@@ -349,40 +528,47 @@
 	pci_write_config_dword(HWIF(drive)->pci_dev, regtime, reg2);
 }
 
-static void hpt370_tune_chipset (ide_drive_t *drive, byte speed, int direction)
+static void hpt370_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	byte regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
-	byte reg5bh		= (speed != XFER_UDMA_5) ? 0x22 : (direction) ? 0x20 : 0x22;
-	unsigned int list_conf	= pci_bus_clock_list(speed, direction, thirty_three_base_hpt370);
+	unsigned int list_conf	= 0;
 	unsigned int drive_conf = 0;
 	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
-	byte drive_pci		= 0;
-	byte drive_fast		= 0;
+	byte drive_pci		= 0x40 + (drive->dn * 4);
+	byte new_fast, drive_fast		= 0;
+	struct pci_dev *dev 	= HWIF(drive)->pci_dev;
 
-	switch (drive->dn) {
-		case 0: drive_pci = 0x40; break;
-		case 1: drive_pci = 0x44; break;
-		case 2: drive_pci = 0x48; break;
-		case 3: drive_pci = 0x4c; break;
-		default: return;
-	}
 	/*
 	 * Disable the "fast interrupt" prediction.
+	 * don't holdoff on interrupts. (== 0x01 despite what the docs say) 
 	 */
-	pci_read_config_byte(HWIF(drive)->pci_dev, regfast, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x80);
+	pci_read_config_byte(dev, regfast, &drive_fast);
+	new_fast = drive_fast;
+	if (new_fast & 0x02)
+		new_fast &= ~0x02;
+
+#ifdef HPT_DELAY_INTERRUPT
+	if (new_fast & 0x01)
+		new_fast &= ~0x01;
+#else
+	if ((new_fast & 0x01) == 0)
+		new_fast |= 0x01;
+#endif
+	if (new_fast != drive_fast)
+		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, new_fast);
 
-	pci_read_config_dword(HWIF(drive)->pci_dev, drive_pci, &drive_conf);
-	pci_write_config_byte(HWIF(drive)->pci_dev, 0x5b, reg5bh);
+	list_conf = pci_bus_clock_list(speed, 
+				       (struct chipset_bus_clock_list_entry *)
+				       dev->sysdata);
 
+	pci_read_config_dword(dev, drive_pci, &drive_conf);
 	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
-	/*
-	 * Disable on-chip PIO FIFO/buffer (to avoid problems handling I/O errors later)
-	 */
-	list_conf &= ~0x80000000;
+	
+	if (speed < XFER_MW_DMA_0) {
+		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
+	}
 
-	pci_write_config_dword(HWIF(drive)->pci_dev, drive_pci, list_conf);
+	pci_write_config_dword(dev, drive_pci, list_conf);
 }
 
 static int hpt3xx_tune_chipset (ide_drive_t *drive, byte speed)
@@ -394,9 +580,9 @@
 		drive->init_speed = speed;
 
 	if (pci_rev_check_hpt3xx(HWIF(drive)->pci_dev)) {
-		hpt370_tune_chipset(drive, speed, 0);
+		hpt370_tune_chipset(drive, speed);
         } else {
-                hpt366_tune_chipset(drive, speed, 0);
+                hpt366_tune_chipset(drive, speed);
         }
 	drive->current_speed = speed;
 	return ((int) ide_config_drive_speed(drive, speed));
@@ -525,9 +711,8 @@
 
 void hpt3xx_intrproc (ide_drive_t *drive)
 {
-	if (drive->quirk_list) {
+	if (!drive->quirk_list) {
 		/* drives in the quirk_list may not like intr setups/cleanups */
-	} else {
 		OUT_BYTE((drive)->ctl|2, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
 	}
 }
@@ -553,13 +738,6 @@
 	}
 }
 
-void hpt370_rw_proc (ide_drive_t *drive, ide_dma_action_t func)
-{
-	if ((func != ide_dma_write) || (func != ide_dma_read))
-		return;
-	hpt370_tune_chipset(drive, drive->current_speed, (func == ide_dma_write));
-}
-
 static int config_drive_xfer_rate (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -573,7 +751,7 @@
 		}
 		dma_func = ide_dma_off_quietly;
 		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x003F) {
+			if (id->dma_ultra & 0x002F) {
 				/* Force if Capable UltraDMA */
 				dma_func = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
@@ -636,17 +814,13 @@
 				reg50h, reg52h, reg5ah);
 			if (reg5ah & 0x10)
 				pci_write_config_byte(HWIF(drive)->pci_dev, 0x5a, reg5ah & ~0x10);
-			/* how about we flush and reset, mmmkay? */
-			pci_write_config_byte(HWIF(drive)->pci_dev, 0x51, 0x1F);
+			/* fall through to a reset */
 
-			break;
-#if 0
 		case ide_dma_begin:
 		case ide_dma_end:
 			/* reset the chips state over and over.. */
 			pci_write_config_byte(HWIF(drive)->pci_dev, 0x51, 0x13);
 			break;
-#endif
 		case ide_dma_timeout:
 		default:
 			break;
@@ -656,8 +830,11 @@
 
 int hpt370_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
 {
-	byte dma_stat = 0;
-	unsigned long dma_base = HWIF(drive)->dma_base;
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long dma_base = hwif->dma_base;
+	byte regstate = hwif->channel ? 0x54 : 0x50;
+	byte reginfo = hwif->channel ? 0x56 : 0x52;
+	byte dma_stat;
 
 	switch (func) {
 		case ide_dma_check:
@@ -665,15 +842,40 @@
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
 			return (dma_stat & 4) == 4;	/* return 1 if INTR asserted */
-		case ide_dma_lostirq:
-			/* how about we flush and reset, mmmkay? */
-			pci_write_config_byte(HWIF(drive)->pci_dev, 0x51, 0x1F);
-			break;
-		case ide_dma_begin:
+
 		case ide_dma_end:
-			/* reset the chips state over and over.. */
-			pci_write_config_byte(HWIF(drive)->pci_dev, 0x51, 0x13);
+			dma_stat = inb(dma_base + 2);
+			if (dma_stat & 0x01) {
+				udelay(20); /* wait a little */
+				dma_stat = inb(dma_base + 2);
+			}
+			if ((dma_stat & 0x01) == 0) 
+				break;
+
+			func = ide_dma_timeout;
+			/* fallthrough */
+
+		case ide_dma_timeout:
+		case ide_dma_lostirq:
+			pci_read_config_byte(hwif->pci_dev, reginfo, 
+					     &dma_stat); 
+			printk("%s: %d bytes in FIFO\n", drive->name, 
+			       dma_stat);
+			pci_write_config_byte(hwif->pci_dev, regstate, 0x37);
+			udelay(10);
+			dma_stat = inb(dma_base);
+			outb(dma_stat & ~0x1, dma_base); /* stop dma */
+			dma_stat = inb(dma_base + 2); 
+			outb(dma_stat | 0x6, dma_base+2); /* clear errors */
+			/* fallthrough */
+
+#ifdef HPT_RESET_STATE_ENGINE
+	        case ide_dma_begin:
+#endif
+			pci_write_config_byte(hwif->pci_dev, regstate, 0x37);
+			udelay(10);
 			break;
+
 		default:
 			break;
 	}
@@ -681,6 +883,87 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
+static void __init init_hpt370(struct pci_dev *dev)
+{
+	int adjust, i;
+	u16 freq;
+	u32 pll;
+	byte reg5bh;
+
+	/* default to pci clock. make sure MA15/16 are set to output
+	 * to prevent drives having problems with 40-pin cables. */
+	pci_write_config_byte(dev, 0x5b, 0x23);
+
+	/* set up the PLL. we need to adjust it so that it's stable. 
+	 * freq = Tpll * 192 / Tpci */
+	pci_read_config_word(dev, 0x78, &freq);
+	freq &= 0x1FF;
+	if (freq < 0x9c) {
+	  pll = F_LOW_PCI_33;
+	  dev->sysdata = (void *) thirty_three_base_hpt370;
+	  printk("HPT370: using 33MHz PCI clock\n");
+	} else if (freq < 0xb0)
+	  pll = F_LOW_PCI_40;
+	else if (freq < 0xc8) {
+	  pll = F_LOW_PCI_50;
+	  dev->sysdata = (void *) fifty_base_hpt370;
+	  printk("HPT370: using 50MHz PCI clock\n");
+	} else {
+	  pll = F_LOW_PCI_66;
+	  dev->sysdata = (void *) sixty_six_base_hpt370;
+	  printk("HPT370: using 66MHz PCI clock\n");
+	}
+	
+	/* only try the pll if we don't have a table for the clock
+	 * speed that we're running at. NOTE: the internal PLL will
+	 * result in slow reads when using a 33MHz PCI clock. we also
+	 * don't like to use the PLL because it will cause glitches
+	 * on PRST/SRST when the HPT state engine gets reset. */
+	if (dev->sysdata) 
+		goto init_hpt370_done;
+	
+	/* adjust PLL based upon PCI clock, enable it, and wait for
+	   stabilization. */
+	adjust = 0;
+	freq = (pll < F_LOW_PCI_50) ? 2 : 4;
+	while (adjust++ < 6) {
+		pci_write_config_dword(dev, 0x5c, (freq + pll) << 16 |
+				       pll | 0x100);
+
+		/* wait for clock stabilization */
+		for (i = 0; i < 0x50000; i++) {
+			pci_read_config_byte(dev, 0x5b, &reg5bh);
+			if (reg5bh & 0x80) {
+				/* spin looking for the clock to destabilize */
+				for (i = 0; i < 0x1000; ++i) {
+					pci_read_config_byte(dev, 0x5b, 
+							     &reg5bh);
+					if ((reg5bh & 0x80) == 0)
+						goto pll_recal;
+				}
+				pci_read_config_dword(dev, 0x5c, &pll);
+				pci_write_config_dword(dev, 0x5c, 
+						       pll & ~0x100);
+				pci_write_config_byte(dev, 0x5b, 0x21);
+				dev->sysdata = (void *) fifty_base_hpt370;
+				printk("HPT370: using 50MHz internal PLL\n");
+				goto init_hpt370_done;
+			}
+		}
+pll_recal:
+		if (adjust & 1)
+			pll -= (adjust >> 1);
+		else
+			pll += (adjust >> 1);
+	} 
+
+init_hpt370_done:
+	/* reset state engine */
+	pci_write_config_byte(dev, 0x50, 0x37); 
+	pci_write_config_byte(dev, 0x54, 0x37); 
+	udelay(100);
+}
+
 unsigned int __init pci_init_hpt366 (struct pci_dev *dev, const char *name)
 {
 	byte test = 0;
@@ -689,14 +972,8 @@
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 
 	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &test);
-
-#if 0
-	if (test != 0x08)
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 0x08);
-#else
 	if (test != (L1_CACHE_BYTES / 4))
 		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
-#endif
 
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &test);
 	if (test != 0x78)
@@ -710,17 +987,15 @@
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
+	if (pci_rev_check_hpt3xx(dev)) 
+		init_hpt370(dev);
+
+	hpt_devs[n_hpt_devs++] = dev;
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!hpt366_proc) {
 		hpt366_proc = 1;
-		bmide_dev = dev;
-		if (pci_rev_check_hpt3xx(dev))
-			bmide2_dev = dev;
 		hpt366_display_info = &hpt366_get_info;
 	}
-	if ((hpt366_proc) && ((dev->devfn - bmide_dev->devfn) == 1)) {
-		bmide2_dev = dev;
-	}
 #endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
 
 	return dev->irq;
@@ -729,37 +1004,121 @@
 unsigned int __init ata66_hpt366 (ide_hwif_t *hwif)
 {
 	byte ata66 = 0;
+	int is33 = 0;
 
 	pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
+	if (hwif->channel) {
+		is33 = ata66 & 1;
+	} else {
+		is33 = ata66 & 2;
+	}
+
 #ifdef DEBUG
 	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",
-		ata66, (ata66 & 0x02) ? "33" : "66",
+		ata66, is33 ? "33" : "66",
 		PCI_FUNC(hwif->pci_dev->devfn));
 #endif /* DEBUG */
-	return ((ata66 & 0x02) ? 0 : 1);
+	return (!is33);
+}
+
+/* 
+ * set/get power state for a drive.
+ * turning the power off does the following things:
+ *   1) soft-reset the drive
+ *   2) tri-states the ide bus
+ *
+ * when we turn things back on, we need to re-initialize things.
+ */
+#define TRISTATE_BIT  0x8000
+static int hpt3xx_busproc(ide_hwif_t *hwif, int state)
+{
+	byte tristate, resetmask, bus_reg;
+	u16 tri_reg;
+
+	if (!hwif)
+		return -EINVAL;
+
+	hwif->bus_state = state;
+
+	if (hwif->channel) { 
+		/* secondary channel */
+		tristate = 0x56;
+		resetmask = 0x80; 
+	} else { 
+		/* primary channel */
+		tristate = 0x52;
+		resetmask = 0x40;
+	}
+
+	/* grab status */
+	pci_read_config_word(hwif->pci_dev, tristate, &tri_reg);
+	pci_read_config_byte(hwif->pci_dev, 0x59, &bus_reg);
+
+	/* set the state. we don't set it if we don't need to do so.
+	 * make sure that the drive knows that it has failed if it's off */
+	switch (state) {
+	case BUSSTATE_ON:
+		hwif->drives[0].failures = 0;
+		hwif->drives[1].failures = 0;
+		if ((bus_reg & resetmask) == 0)
+			return 0;
+		tri_reg &= ~TRISTATE_BIT;
+		bus_reg &= ~resetmask;
+		break;
+	case BUSSTATE_OFF:
+		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
+		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+		if ((tri_reg & TRISTATE_BIT) == 0 && (bus_reg & resetmask))
+			return 0;
+		tri_reg &= ~TRISTATE_BIT;
+		bus_reg |= resetmask;
+		break;
+	case BUSSTATE_TRISTATE:
+		hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
+		hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+		if ((tri_reg & TRISTATE_BIT) && (bus_reg & resetmask))
+			return 0;
+		tri_reg |= TRISTATE_BIT;
+		bus_reg |= resetmask;
+		break;
+	}
+	pci_write_config_byte(hwif->pci_dev, 0x59, bus_reg);
+	pci_write_config_word(hwif->pci_dev, tristate, tri_reg);
+
+	return 0;
 }
 
 void __init ide_init_hpt366 (ide_hwif_t *hwif)
 {
+	int hpt_rev;
+
 	hwif->tuneproc	= &hpt3xx_tune_drive;
 	hwif->speedproc	= &hpt3xx_tune_chipset;
 	hwif->quirkproc	= &hpt3xx_quirkproc;
 	hwif->intrproc	= &hpt3xx_intrproc;
 	hwif->maskproc	= &hpt3xx_maskproc;
 
-	if (pci_rev2_check_hpt3xx(hwif->pci_dev)) {
-		/* do nothing now but will split device types */
+#ifdef HPT_SERIALIZE_IO
+	/* serialize access to this device */
+	if (hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
+#endif
+
+	hpt_rev = pci_rev_check_hpt3xx(hwif->pci_dev);
+	if (hpt_rev) {
+		/* set up ioctl for power status. note: power affects both
+		 * drives on each channel */
+		hwif->busproc = &hpt3xx_busproc;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
-		if (pci_rev_check_hpt3xx(hwif->pci_dev)) {
+		if (hpt_rev) {
 			byte reg5ah = 0;
 			pci_read_config_byte(hwif->pci_dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */
 				pci_write_config_byte(hwif->pci_dev, 0x5a, reg5ah & ~0x10);
 			hwif->dmaproc = &hpt370_dmaproc;
-			hwif->rwproc = &hpt370_rw_proc;
 		} else {
 			hwif->dmaproc = &hpt366_dmaproc;
 		}

--------------E980EFA47240A2CA4844C65E
Content-Type: text/plain; charset=us-ascii;
 name="drivers_ide_serverworks.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_ide_serverworks.c.diff"

diff -ruN dist-2.4.13+patches/drivers/ide/serverworks.c linux-2.4/drivers/ide/serverworks.c
--- dist-2.4.13+patches/drivers/ide/serverworks.c	Mon Oct  1 16:43:56 2001
+++ linux-2.4/drivers/ide/serverworks.c	Fri Oct 26 19:39:02 2001
@@ -1,16 +1,26 @@
 /*
- * linux/drivers/ide/serverworks.c		Version 0.2	17 Oct 2000
+ * linux/drivers/ide/serverworks.c		Version 0.3	26 Oct 2001
  *
- *  Copyright (C) 2000 Cobalt Networks, Inc. <asun@cobalt.com>
- *  May be copied or modified under the terms of the GNU General Public License
+ * May be copied or modified under the terms of the GNU General Public License
  *
- *  interface borrowed from alim15x3.c:
- *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
- *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
+ * Copyright (C) 1998-2000 Michel Aubry
+ * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
+ * Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+ * Portions copyright (c) 2001 Sun Microsystems
  *
- *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *
- *  IDE support for the ServerWorks OSB4 IDE chipset
+ * RCC/ServerWorks IDE driver for Linux
+ *
+ *   OSB4: `Open South Bridge' IDE Interface (fn 1)
+ *         supports UDMA mode 2 (33 MB/s)
+ *
+ *   CSB5: `Champion South Bridge' IDE Interface (fn 1)
+ *         all revisions support UDMA mode 4 (66 MB/s)
+ *         revision A2.0 and up support UDMA mode 5 (100 MB/s)
+ *
+ *         *** The CSB5 does not provide ANY register ***
+ *         *** to detect 80-conductor cable presence. ***
+ *
  *
  * here's the default lspci:
  *
@@ -83,15 +93,15 @@
 
 #include "ide_modes.h"
 
-#define SVWKS_DEBUG_DRIVE_INFO		0
-
-#define DISPLAY_SVWKS_TIMINGS
+#define DISPLAY_SVWKS_TIMINGS	1
+#undef SVWKS_DEBUG_DRIVE_INFO
 
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
 static struct pci_dev *bmide_dev;
+static byte svwks_revision = 0;
 
 static int svwks_get_info(char *, char **, off_t, int);
 extern int (*svwks_display_info)(char *, char **, off_t, int); /* ide-proc.c */
@@ -103,7 +113,7 @@
 	u32 bibma = pci_resource_start(bmide_dev, 4);
 	u32 reg40, reg44;
 	u16 reg48, reg56;
-	u8  c0 = 0, c1 = 0, reg54;
+	u8  reg54, c0=0, c1=0;
 
 	pci_read_config_dword(bmide_dev, 0x40, &reg40);
 	pci_read_config_dword(bmide_dev, 0x44, &reg44);
@@ -120,20 +130,23 @@
 
 	switch(bmide_dev->device) {
 		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
-			p += sprintf(p, "\n                                ServerWorks CSB5 Chipset.\n");
+			p += sprintf(p, "\n                            "
+				     "ServerWorks CSB5 Chipset (rev %02x)\n",
+				     svwks_revision);
 			break;
-		case PCI_DEVICE_ID_SERVERWORKS_OSB4:
-			p += sprintf(p, "\n                                ServerWorks OSB4 Chipset.\n");
+		case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
+			p += sprintf(p, "\n                            "
+				     "ServerWorks OSB4 Chipset (rev %02x)\n",
+				     svwks_revision);
 			break;
 		default:
-			p += sprintf(p, "\n                                ServerWorks 0x%04x Chipset.\n", bmide_dev->device);
+			p += sprintf(p, "\n                            "
+				     "ServerWorks %04x Chipset (rev %02x)\n",
+				     bmide_dev->device, svwks_revision);
 			break;
 	}
 
 	p += sprintf(p, "------------------------------- General Status ---------------------------------\n");
-#if 0
-	p += sprintf(p, "                                     : %s\n", "str");
-#endif
 	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
 	p += sprintf(p, "                %sabled                         %sabled\n",
 			(c0&0x80) ? "dis" : " en",
@@ -191,11 +204,7 @@
 				((reg44&0x00210000)==0x00210000)?"1":
 				((reg44&0x00770000)==0x00770000)?"0":
 				((reg44&0x00FF0000)==0x00FF0000)?"X":"?");
-#if 0
-	if (bmide_dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
-		p += sprintf(p, "PIO  enabled:   %s                %s               %s                 %s\n",
-	if (bmide_dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4)
-#endif
+
 		p += sprintf(p, "PIO  enabled:   %s                %s               %s                 %s\n",
 			((reg40&0x00002000)==0x00002000)?"4":
 				((reg40&0x00002200)==0x00002200)?"3":
@@ -221,7 +230,7 @@
 }
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-static byte svwks_revision = 0;
+#define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 
 byte svwks_proc = 0;
 
@@ -292,6 +301,7 @@
 			pio_timing |= pio_modes[speed - XFER_PIO_0];
 			csb5_pio   |= ((speed - XFER_PIO_0) << (4*drive->dn));
 			break;
+
 #ifdef CONFIG_BLK_DEV_IDEDMA
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
@@ -307,9 +317,9 @@
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
-			pio_timing |= pio_modes[pio];
-			csb5_pio   |= (pio << (4*drive->dn));
-			dma_timing |= dma_modes[2];
+			pio_timing   |= pio_modes[pio];
+			csb5_pio     |= (pio << (4*drive->dn));
+			dma_timing   |= dma_modes[2];
 			ultra_timing |= ((udma_modes[speed - XFER_UDMA_0]) << (4*unit));
 			ultra_enable |= (0x01 << drive->dn);
 #endif
@@ -322,9 +332,9 @@
 		drive->name, ultra_timing, dma_timing, pio_timing);
 #endif
 
-#if OSB4_DEBUG_DRIVE_INFO
+#if SVWKS_DEBUG_DRIVE_INFO
 	printk("%s: %s drive%d\n", drive->name, ide_xfer_verbose(speed), drive->dn);
-#endif /* OSB4_DEBUG_DRIVE_INFO */
+#endif /* SVWKS_DEBUG_DRIVE_INFO */
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
@@ -338,11 +348,10 @@
 	pci_write_config_byte(dev, drive_pci3, ultra_timing);
 	pci_write_config_byte(dev, 0x54, ultra_enable);
 	
-	if (speed > XFER_PIO_4) {
+	if (speed > XFER_PIO_4)
 		outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
-	} else {
+	else
 		outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
-	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 	err = ide_config_drive_speed(drive, speed);
@@ -354,25 +363,24 @@
 {
 	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
-	byte			timing, speed, pio;
+	byte timing, speed, pio;
 
 	pio = ide_get_best_pio_mode(drive, 255, 5, NULL);
 
 	if (xfer_pio> 4)
 		xfer_pio = 0;
 
-	if (drive->id->eide_pio_iordy > 0) {
+	if (drive->id->eide_pio_iordy > 0)
 		for (xfer_pio = 5;
 			xfer_pio>0 &&
 			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
 			xfer_pio--);
-	} else {
+	else
 		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
 			   (drive->id->eide_pio_modes & 2) ? 0x04 :
 			   (drive->id->eide_pio_modes & 1) ? 0x03 :
 			   (drive->id->tPIO & 2) ? 0x02 :
 			   (drive->id->tPIO & 1) ? 0x01 : xfer_pio;
-	}
 
 	timing = (xfer_pio >= pio) ? xfer_pio : pio;
 
@@ -407,12 +415,10 @@
 {
 	struct hd_driveid *id	= drive->id;
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	byte udma_66		= eighty_ninty_three(drive);
-	byte			speed;
-
-	int ultra66		= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
-	/* need specs to figure out if osb4 is capable of ata/66/100 */
-	int ultra100		= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
+	byte udma_66	= eighty_ninty_three(drive);
+	int ultra66	= (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : 0;
+	int ultra100 	= (ultra66 && svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 1 : 0;
+	byte speed;
 
 	if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
 		speed = XFER_UDMA_5;
@@ -499,7 +505,7 @@
 	switch (func) {
 		case ide_dma_check:
 			return config_drive_xfer_rate(drive);
-		default :
+		default:
 			break;
 	}
 	/* Other cases are done by generic IDE-DMA code. */
@@ -509,30 +515,43 @@
 
 unsigned int __init pci_init_svwks (struct pci_dev *dev, const char *name)
 {
-	unsigned int reg64;
+	unsigned int reg;
+	byte btr;
 
+	/* save revision id to determine DMA capability */
 	pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);
 
-	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
-		isa_dev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4, NULL);
+	/* force Master Latency Timer value to 64 PCICLKs */
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x40);
 
-		pci_read_config_dword(isa_dev, 0x64, &reg64);
-#ifdef DEBUG
-		printk("%s: reg64 == 0x%08x\n", name, reg64);
-#endif
+	/* OSB4 : South Bridge and IDE */
+	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
+		isa_dev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+			  PCI_DEVICE_ID_SERVERWORKS_OSB4, NULL);
+		if (isa_dev) {
+			pci_read_config_dword(isa_dev, 0x64, &reg);
+			reg &= ~0x00002000; /* disable 600ns interrupt mask */
+			reg |=  0x00004000; /* enable UDMA/33 support */
+			pci_write_config_dword(isa_dev, 0x64, reg);
+		}
+	}
 
-//		reg64 &= ~0x0000A000;
-//#ifdef CONFIG_SMP
-//		reg64 |= 0x00008000;
-//#endif
-	/* Assume the APIC was set up properly by the BIOS for now . If it
-	   wasnt we need to do a fix up _way_ earlier. Bits 15,10,3 control
-	   APIC enable, routing and decode */
-	   
-		reg64 &= ~0x00002000;	
-		pci_write_config_dword(isa_dev, 0x64, reg64);
+	/* setup CSB5 : South Bridge and IDE */
+	else if (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE) {
+		/* setup the UDMA Control register
+		 *
+		 * 1. clear bit 6 to enable DMA
+		 * 2. enable DMA modes with bits 0-1
+		 *      00 : legacy
+		 *      01 : udma2
+		 *      10 : udma2/udma4
+		 *      11 : udma2/udma4/udma5
+		 */
+		pci_read_config_byte(dev, 0x5A, &btr);
+		btr &= ~0x40;
+		btr |= (svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 0x3 : 0x2;
+		pci_write_config_byte(dev, 0x5A, btr);
 	}
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x40);
 
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!svwks_proc) {
@@ -551,26 +570,46 @@
  * Bit 14 clear = primary IDE channel does not have 80-pin cable.
  * Bit 14 set   = primary IDE channel has 80-pin cable.
  */
-
 static unsigned int __init ata66_svwks_dell (ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	= hwif->pci_dev;
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL        &&
-	    dev->vendor           == PCI_VENDOR_ID_SERVERWORKS &&
-	    dev->device           == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
+	struct pci_dev *dev = hwif->pci_dev;
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
+	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
+	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
 		return ((1 << (hwif->channel + 14)) &
 			dev->subsystem_device) ? 1 : 0;
-
 	return 0;
+}
 
+/* Sun Cobalt Alpine hardware avoids the 80-pin cable
+ * detect issue by attaching the drives directly to the board.
+ * This check follows the Dell precedent (how scary is that?!)
+ *
+ * WARNING: this only works on Alpine hardware!
+ */
+static unsigned int __init ata66_svwks_cobalt (ide_hwif_t *hwif)
+{
+	struct pci_dev *dev = hwif->pci_dev;
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
+	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
+	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
+		return ((1 << (hwif->channel + 14)) &
+			dev->subsystem_device) ? 1 : 0;
+	return 0;
 }
 
 unsigned int __init ata66_svwks (ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	= hwif->pci_dev;
+	struct pci_dev *dev = hwif->pci_dev;
+
+	/* Dell PowerEdge */
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL)
 		return ata66_svwks_dell (hwif);
-	
+
+	/* Cobalt Alpine */
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN)
+		return ata66_svwks_cobalt (hwif);
+
 	return 0;
 }
 
@@ -586,9 +625,7 @@
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 	hwif->autodma = 0;
-	return;
 #else /* CONFIG_BLK_DEV_IDEDMA */
-
 	if (hwif->dma_base) {
 		if (!noautodma)
 			hwif->autodma = 1;

--------------E980EFA47240A2CA4844C65E--

