Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268468AbTANBZg>; Mon, 13 Jan 2003 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTANBZg>; Mon, 13 Jan 2003 20:25:36 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:41268 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268468AbTANBZe>; Mon, 13 Jan 2003 20:25:34 -0500
Message-ID: <3E2368CF.6050608@google.com>
Date: Mon, 13 Jan 2003 17:33:03 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: PATCH: [2.4.21-pre3] Fix for Promise PIO Lockup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Newer kernels will lock up when a drive command (SMART, hdparm -I, etc.) 
is issued to a drive connected to a Promise 20265 or 20267 controller 
while the controller is in DMA mode.  The problem appears to be that 
tune_chipset incorrectly clears the high PIO bit thinking that it is a 
"PIO force on" bit.  The documentation I have access to does not seem to 
mention a PIO force bit.  Not changing that bit seems to fix the problem 
with drive commands on a promise controller.

The documentation I have also says the values for the TB and TC 
variables should be the same for all UDMA modes and they are not. 
 However the driver seems to work anyway, so I left them the way they are.

To reproduce this problem make sure your drive is set to a DMA mode, eg 
hdparm -X 67 and then issue a drive command, e.g. hdparm -I.

This problem may also be present in the drivers for other Promise chips.

This change has only been minimally tested.

------ snip here -------
diff -durbB linux-2.4.20-p2/drivers/ide/pci/pdc202xx_old.c 
linux-2.4.20-p3/drivers/ide/pci/pdc202xx_old.c
--- linux-2.4.20-p2/drivers/ide/pci/pdc202xx_old.c    Wed Jan  8 
15:44:11 2003
+++ linux-2.4.20-p3/drivers/ide/pci/pdc202xx_old.c    Fri Jan 10 
15:05:28 2003
@@ -268,7 +268,9 @@
         if ((BP & 0xF0) && (CP & 0x0F)) {
             /* clear DMA modes of upper 842 bits of B Register */
             /* clear PIO forced mode upper 1 bit of B Register */
-            pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xF0);
+                        /* The documentation I have access to says there
+                           is no PIO forced mode bit. -- RAB 01/10/03 */
+            pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xE0);
             pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
 
             /* clear DMA modes of lower 8421 bits of C Register */


