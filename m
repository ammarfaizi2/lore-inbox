Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUBICzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUBICzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:55:23 -0500
Received: from data.idl.com.au ([203.32.82.9]:8859 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S264898AbUBICzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:55:09 -0500
From: Athol Mullen <me@privacy.net>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Newsgroups: linux.kernel
References: <1mLsS-6Oq-7@gated-at.bofh.it> <1mLsS-6Oq-9@gated-at.bofh.it> <1mLsS-6Oq-5@gated-at.bofh.it> <1mRHV-4Xn-7@gated-at.bofh.it>
Organization: Mullen Automotive Engineering
User-Agent: tin/1.5.16-20030125 ("Bubbles") (UNIX) (Linux/2.4.22 (i686))
Message-ID: <c06jlm$13ju4j$1@ID-215292.news.uni-berlin.de>
Date: Mon, 9 Feb 2004 02:50:31 +0000
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> On Sun, Feb 08, 2004 at 11:45:18AM +1100, Athol Mullen wrote:

> I captured dmesg and /proc/ide/piix, but forgot to post them. They're at
> work now. But I did the change, by commenting out the call to
> eighty_ninety_three() in piix.c, and my disks came back to 54 MB/s each,
> and 64 MB/s cumulated.  dmesg showed UDMA33 before and now displays
> UDMA100 again. But I obviously cannot let it like that because if I
> install this kernel in a 40-pin machine, I will get some surprizes !

That's what worries me...

> I understand. But could you please post your ICH5 detection code so that
> I can try it on this machine. I still can play with it for a few days
> before it gets racked. And I can try with both 40 and 80-pin cables.

This patch inserts the piix code into eighty_ninty_three() - obviously
this is for testing purposes only.  The patch was diff'd against 2.4.22,
but patches okay to 2.6.1 with:
    Hunk #1 succeeded at 719 (offset -10 lines).

--- ide-iops.c.orig	2004-01-18 15:04:24.000000000 +1100
+++ ide-iops.c	2004-01-18 16:41:16.000000000 +1100
@@ -729,6 +729,34 @@
 
 #else
 
+#ifdef CONFIG_BLK_DEV_PIIX
+	/* ICH BIOSes are supposed to set a bit flags for us */
+	
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	u16 cr_flag		= 0x10 << drive->dn;
+	u16			reg54;
+
+	if (hwif->pci_dev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch(hwif->pci_dev->device) {
+			case PCI_DEVICE_ID_INTEL_82801BA_8:
+	    		case PCI_DEVICE_ID_INTEL_82801BA_9:
+	    		case PCI_DEVICE_ID_INTEL_82801CA_10:
+	    		case PCI_DEVICE_ID_INTEL_82801CA_11:
+	    		case PCI_DEVICE_ID_INTEL_82801E_11:
+	    		case PCI_DEVICE_ID_INTEL_82801DB_10:
+			case PCI_DEVICE_ID_INTEL_82801DB_11:
+			case PCI_DEVICE_ID_INTEL_82801EB_11:
+			case PCI_DEVICE_ID_INTEL_82801AA_1:
+			case PCI_DEVICE_ID_INTEL_82372FB_1:
+			    {
+			    pci_read_config_word(dev, 0x54, &reg54);
+			    return ((reg54 & cr_flag) ? 1 : 0);
+			    }
+		}
+	}
+#endif /* CONFIG_BLK_DEV_PIIX */
+
 	return ((u8) ((HWIF(drive)->udma_four) &&
 #ifndef CONFIG_IDEDMA_IVB
 			(drive->id->hw_config & 0x4000) &&



(Still fudging via Kmail because tin won't work properly...)

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.


