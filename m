Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbRGKTeT>; Wed, 11 Jul 2001 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266035AbRGKTeA>; Wed, 11 Jul 2001 15:34:00 -0400
Received: from fire.osdlab.org ([65.201.151.4]:56475 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S265586AbRGKTdy>;
	Wed, 11 Jul 2001 15:33:54 -0400
Message-ID: <3B4CA9FC.92AE39BC@osdlab.org>
Date: Wed, 11 Jul 2001 12:33:16 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>,
        Linus <torvalds@transmeta.com>, nils@kernelconcepts.de
Subject: [patch] i810-tco OOPS
Content-Type: multipart/mixed;
 boundary="------------390F0A04D1B45D5BE3DAD850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------390F0A04D1B45D5BE3DAD850
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Please apply to 2.4.7-preX and to 2.4.6-acX.

If one builds a kernel with the i810 tco watchdog driver
but does not have this chipset, the i810tco_getdevice()
function doesn't detect this and still calls pci_read_config_byte(),
which promptly oopses...since the pci_for_each_dev() loop
termination wasn't checked  [i.e., <dev> is non-null after the
loop whether the device was found or not].

-- 
~Randy
--------------390F0A04D1B45D5BE3DAD850
Content-Type: text/plain; charset=us-ascii;
 name="i810found.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810found.diff"

--- linux/drivers/char/i810-tco.c.org	Mon Jul  2 13:56:41 2001
+++ linux/drivers/char/i810-tco.c	Wed Jul 11 12:11:22 2001
@@ -256,14 +256,19 @@
 	struct pci_dev *dev;
 	u8 val1, val2;
 	u16 badr;
+	int found = 0;
 	/*
 	 *      Find the PCI device
 	 */
 
 	pci_for_each_dev(dev) {
-		if (pci_match_device(i810tco_pci_tbl, dev))
+		if (pci_match_device(i810tco_pci_tbl, dev)) {
+			found = 1;
 			break;
+		}
 	}
+	if (!found)
+		return 0;
 
 	if ((i810tco_pci = dev)) {
 		/*

--------------390F0A04D1B45D5BE3DAD850--

