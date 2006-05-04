Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWEDTru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWEDTru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWEDTru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:47:50 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:22714 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030305AbWEDTru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:47:50 -0400
Message-ID: <445A5A1B.60903@ru.mvista.com>
Date: Thu, 04 May 2006 23:46:35 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT3xx: fix PCI clock detection
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com>
In-Reply-To: <4457DC97.3010807@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050003000709010102060002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003000709010102060002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Use the f_CNT value saved by the HighPoint BIOS if available as reading it 
directly would give us a wrong PCI frequency after DPLL has already been 
calibrated by BIOS.

    Should apply on top of my recent patches.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------050003000709010102060002
Content-Type: text/plain;
 name="HPT3xx-use-f_CNT-saved-by-BIOS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-use-f_CNT-saved-by-BIOS.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -71,6 +71,8 @@
  *   needed and had many modes over- and  underclocked,  HPT372 33 MHz table was
  *   for 66 MHz and 50 MHz table missed UltraDMA mode 6, HPT374 33 MHz table was
  *   really for 50 MHz; switch to using HPT372 tables for HPT374...
+ * - use f_CNT value saved by  the HighPoint BIOS as reading it directly gives
+ *   the wrong PCI frequency since DPLL has already been calibrated by BIOS
  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
  * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
@@ -1050,8 +1052,8 @@ static void __devinit hpt37x_clocking(id
 	struct hpt_info *info = ide_get_hwifdata(hwif);
 	struct pci_dev *dev = hwif->pci_dev;
 	int adjust, i;
-	u16 freq;
-	u32 pll;
+	u16 freq = 0;
+	u32 pll, temp = 0;
 	u8 reg5bh = 0, mcr1 = 0;
 	
 	/*
@@ -1065,15 +1067,34 @@ static void __devinit hpt37x_clocking(id
 	pci_write_config_byte(dev, 0x5b, 0x23);
 
 	/*
-	 * set up the PLL. we need to adjust it so that it's stable. 
-	 * freq = Tpll * 192 / Tpci
+	 * We'll have to read f_CNT value in order to determine
+	 * the PCI clock frequency according to the following ratio:
 	 *
-	 * Todo. For non x86 should probably check the dword is
-	 * set to 0xABCDExxx indicating the BIOS saved f_CNT
+	 * f_CNT = Fpci * 192 / Fdpll
+	 *
+	 * First try reading the register in which the HighPoint BIOS
+	 * saves f_CNT value before  reprogramming the DPLL from its
+	 * default setting (which differs for the various chips).
+	 * In case the signature check fails, we'll have to resort to
+	 * reading the f_CNT register itself in hopes that nobody has
+	 * touched the DPLL yet...
 	 */
-	pci_read_config_word(dev, 0x78, &freq);
-	freq &= 0x1FF;
-	
+	pci_read_config_dword(dev, 0x70, &temp);
+	if ((temp & 0xFFFFF000) != 0xABCDE000) {
+		int i;
+
+		printk(KERN_WARNING "HPT37X: no clock data saved by BIOS\n");
+
+		/* Calculate the average value of f_CNT */
+		for (temp = i = 0; i < 128; i++) {
+			pci_read_config_word(dev, 0x78, &freq);
+			temp += freq & 0x1ff;
+			mdelay(1);
+		}
+		freq = temp / 128;
+	} else
+		freq = temp & 0x1ff;
+
 	/*
 	 * HPT3xxN chips use different PCI clock information.
 	 * Currently we always set up the PLL for them.
@@ -1146,11 +1167,8 @@ static void __devinit hpt37x_clocking(id
 	info->flags |= PLL_MODE;
 	
 	/*
-	 * FIXME: make this work correctly, esp with 372N as per
-	 * reference driver code.
-	 *
-	 * adjust PLL based upon PCI clock, enable it, and wait for
-	 * stabilization.
+	 * Adjust the PLL based upon the PCI clock, enable it, and
+	 * wait for stabilization...
 	 */
 	adjust = 0;
 	freq = (pll < F_LOW_PCI_50) ? 2 : 4;


--------------050003000709010102060002--
