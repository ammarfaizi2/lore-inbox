Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbRAELbu>; Fri, 5 Jan 2001 06:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130207AbRAELbk>; Fri, 5 Jan 2001 06:31:40 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:46779 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129744AbRAELbg>;
	Fri, 5 Jan 2001 06:31:36 -0500
Message-Id: <m14ESx7-000OXmC@amadeus.home.nl>
Date: Fri, 5 Jan 2001 10:14:25 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: dax@gurulabs.com (Dax Kelson)
Subject: Re: IEEE1394 2.4.0 (final) compile problems
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010102213916.B2103@storm.local> <Pine.SOL.4.30.0101050155330.20242-100000@ultra1.inconnect.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SOL.4.30.0101050155330.20242-100000@ultra1.inconnect.com> you wrote:

> video1394.o(.data+0x0): multiple definition of `ohci_csr_rom'
> ohci1394.o(.data+0x0): first defined here

Known bug, fix attached below.

Greetings,
    Arjan van de Ven

diff -urN /mnt/kernel/clean/linuxprereleaseac5/drivers/ieee1394/ohci1394.c linux/drivers/ieee1394/ohci1394.c
--- /mnt/kernel/clean/linuxprereleaseac5/drivers/ieee1394/ohci1394.c	Thu Jan  4 10:10:00 2001
+++ linux/drivers/ieee1394/ohci1394.c	Thu Jan  4 17:32:30 2001
@@ -112,6 +112,80 @@
 #define DBGMSG(card, fmt, args...)
 #endif
 
+/* This structure is not properly initialized ... it is taken from
+   the lynx_csr_rom written by Andreas ... Some fields in the root
+   directory and the module dependent info needs to be modified
+   I do not have the proper doc */
+quadlet_t ohci_csr_rom[] = {
+        /* bus info block */
+        0x04040000, /* info/CRC length, CRC */
+        0x31333934, /* 1394 magic number */
+        0xf07da002, /* cyc_clk_acc = 125us, max_rec = 1024 */
+        0x00000000, /* vendor ID, chip ID high (written from card info) */
+        0x00000000, /* chip ID low (written from card info) */
+        /* root directory - FIXME */
+        0x00090000, /* CRC length, CRC */
+        0x03080028, /* vendor ID (Texas Instr.) */
+        0x81000009, /* offset to textual ID */
+        0x0c000200, /* node capabilities */
+        0x8d00000e, /* offset to unique ID */
+        0xc7000010, /* offset to module independent info */
+        0x04000000, /* module hardware version */
+        0x81000026, /* offset to textual ID */
+        0x09000000, /* node hardware version */
+        0x81000026, /* offset to textual ID */
+        /* module vendor ID textual */
+        0x00080000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54455841, /* "Texas Instruments" */
+        0x5320494e,
+        0x53545255,
+        0x4d454e54,
+        0x53000000,
+        /* node unique ID leaf */
+        0x00020000, /* CRC length, CRC */
+        0x08002856, /* vendor ID, chip ID high */
+        0x0000083E, /* chip ID low */
+        /* module dependent info - FIXME */
+        0x00060000, /* CRC length, CRC */
+        0xb8000006, /* ??? offset to module textual ID */
+        0x81000004, /* ??? textual descriptor */
+        0x00000000, /* SRAM size */
+        0x00000000, /* AUXRAM size */
+        0x00000000, /* AUX device */
+        /* module textual ID */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54534231, /* "TSB12LV22" */
+        0x324c5632,
+        0x32000000,
+        /* part number */
+        0x00060000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x39383036, /* "9806000-0001" */
+        0x3030342d,
+        0x30303431,
+        0x20000001,
+        /* module hardware version textual */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x5453424b, /* "TSBKOHCI403" */
+        0x4f484349,
+        0x34303300,
+        /* node hardware version textual */
+        0x00050000, /* CRC length, CRC */
+        0x00000000,
+        0x00000000,
+        0x54534234, /* "TSB41LV03" */
+        0x314c5630,
+        0x33000000
+};
+
+
 /* print general (card independent) information */
 #define PRINT_G(level, fmt, args...) \
 printk(level "ohci1394: " fmt "\n" , ## args)
diff -urN /mnt/kernel/clean/linuxprereleaseac5/drivers/ieee1394/ohci1394.h linux/drivers/ieee1394/ohci1394.h
--- /mnt/kernel/clean/linuxprereleaseac5/drivers/ieee1394/ohci1394.h	Thu Jan  4 10:10:00 2001
+++ linux/drivers/ieee1394/ohci1394.h	Thu Jan  4 17:32:15 2001
@@ -280,74 +280,7 @@
    the lynx_csr_rom written by Andreas ... Some fields in the root
    directory and the module dependent info needs to be modified
    I do not have the proper doc */
-quadlet_t ohci_csr_rom[] = {
-        /* bus info block */
-        0x04040000, /* info/CRC length, CRC */
-        0x31333934, /* 1394 magic number */
-        0xf07da002, /* cyc_clk_acc = 125us, max_rec = 1024 */
-        0x00000000, /* vendor ID, chip ID high (written from card info) */
-        0x00000000, /* chip ID low (written from card info) */
-        /* root directory - FIXME */
-        0x00090000, /* CRC length, CRC */
-        0x03080028, /* vendor ID (Texas Instr.) */
-        0x81000009, /* offset to textual ID */
-        0x0c000200, /* node capabilities */
-        0x8d00000e, /* offset to unique ID */
-        0xc7000010, /* offset to module independent info */
-        0x04000000, /* module hardware version */
-        0x81000026, /* offset to textual ID */
-        0x09000000, /* node hardware version */
-        0x81000026, /* offset to textual ID */
-        /* module vendor ID textual */
-        0x00080000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54455841, /* "Texas Instruments" */
-        0x5320494e,
-        0x53545255,
-        0x4d454e54,
-        0x53000000,
-        /* node unique ID leaf */
-        0x00020000, /* CRC length, CRC */
-        0x08002856, /* vendor ID, chip ID high */
-        0x0000083E, /* chip ID low */
-        /* module dependent info - FIXME */
-        0x00060000, /* CRC length, CRC */
-        0xb8000006, /* ??? offset to module textual ID */
-        0x81000004, /* ??? textual descriptor */
-        0x00000000, /* SRAM size */
-        0x00000000, /* AUXRAM size */
-        0x00000000, /* AUX device */
-        /* module textual ID */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54534231, /* "TSB12LV22" */
-        0x324c5632,
-        0x32000000,
-        /* part number */
-        0x00060000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x39383036, /* "9806000-0001" */
-        0x3030342d,
-        0x30303431,
-        0x20000001,
-        /* module hardware version textual */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x5453424b, /* "TSBKOHCI403" */
-        0x4f484349,
-        0x34303300,
-        /* node hardware version textual */
-        0x00050000, /* CRC length, CRC */
-        0x00000000,
-        0x00000000,
-        0x54534234, /* "TSB41LV03" */
-        0x314c5630,
-        0x33000000
-};
+extern quadlet_t ohci_csr_rom[57];
 
 
 /* 2 KiloBytes of register space */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
