Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283757AbRLRDbc>; Mon, 17 Dec 2001 22:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283758AbRLRDbX>; Mon, 17 Dec 2001 22:31:23 -0500
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:57132 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S283757AbRLRDbM>; Mon, 17 Dec 2001 22:31:12 -0500
Message-ID: <3C1EB87C.7090103@chartermi.net>
Date: Mon, 17 Dec 2001 21:31:08 -0600
From: Todd Inglett <tinglett@chartermi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE dma reset for sl82c105
Content-Type: multipart/mixed;
 boundary="------------000502060400050300010303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502060400050300010303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have found that the IDE controller on a w83c553f (a sl82c105 function) 
can get into a hung state if the interrupt line is wired to INTC and a 
timeout occurs.  The following patch implements a hard reset for the 
controller as documented in a Windbond engineering notice.

This patch needs some testing and there appears to be no maintainer for 
the sl83c105 IDE driver :(.  The conditions to repeat the problem are 
that the controller must be wired for PCI INTC, DMA must be in use, and 
a timeout error must occur (try mounting a music CD).  My fix checks for 
INTC configuration so hopefully this patch will only affect systems that 
exhibit the hang.  I have tested it on an IBM pSeries model 610 which 
has the hardware operating in this mode.

The patch should apply to 2.5.13 - 2.5.16 (at least).

-todd


--------------000502060400050300010303
Content-Type: text/plain;
 name="sl82c105-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sl82c105-reset.patch"

--- drivers/ide/sl82c105.c	16 Aug 2001 13:50:23 -0000	1.3
+++ drivers/ide/sl82c105.c	17 Dec 2001 19:14:28 -0000
@@ -156,6 +156,29 @@
 }
 
 /*
+ * Reset the controller.
+ * If we are using INTC under a w83c553 we need to use a magic test
+ * bit to do this.  Return zero if successful (or applicable).
+ * 
+ */
+static int sl82c105_hard_reset(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	unsigned int reg;
+
+	pci_read_config_dword(dev, 0x40, &reg);	/* LEGIRQ register */
+	if (reg & (1<<11)) {	/* Using INTC? */
+		printk("sl82c105: resetting device\n");
+		pci_read_config_dword(dev, 0x7e, &reg);
+		pci_write_config_word(dev, 0x7e, reg | (1<<2));
+		pci_write_config_word(dev, 0x7e, reg & (~(1<<2)));
+		return 0;
+	}
+	return 1;
+}
+
+/*
  * Our own dmaproc, only to intercept ide_dma_check
  */
 static int sl82c105_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
@@ -171,6 +194,11 @@
 	case ide_dma_off:
 		config_for_pio(drive, 4, 0);
 		break;
+	case ide_dma_lostirq:
+	case ide_dma_timeout:
+	        if (sl82c105_hard_reset(drive) == 0)
+			return 0;
+	        break;
 	default:
 		break;
 	}


--------------000502060400050300010303--

