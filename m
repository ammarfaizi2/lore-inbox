Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423142AbWJYJY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423142AbWJYJY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423149AbWJYJY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:24:56 -0400
Received: from main.gmane.org ([80.91.229.2]:43909 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423142AbWJYJYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:24:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: [BUG] DMA timeout errors on Dell Latitude XPi CD P150ST
Date: Wed, 25 Oct 2006 09:24:04 +0000 (UTC)
Message-ID: <loom.20061025T111524-521@post.gmane.org>
References: <ae7121c60610240805l6f244bf5vdad31d6fd17e10f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.6 (Mozilla/5.0 (X11; U; Linux i686; nl; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Panagiotis Issaris <panagiotis <at> gmail.com> writes:
> When booting Linux 2.6.19-rc3 (or 2.6.8-16sarge5 so it is not specific
> to the current kernels) on a friends laptop, I'm getting a lot of
> errormessages from the IDE controller related to DMA problems. When
> disabling all DMA related options, the kernel boots fine (and fast).
> With DMA enabled, it takes about 1 minute to stumble over the DMA
> problems. The laptop is Dell Latitude XPi CD P150ST.
Debian developer Frederik Schueler noted that as far as he knows the laptop does
not support DMA. 

It seems that in drivers/ide/setup-pci.c, DMA is being forced on:
177 static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
...
225         switch(dev->device) {
...
22x             case PCI_DEVICE_ID_CMD_643:
...
234                 if (simplex_stat & 0x80) {
235                     printk(KERN_INFO "%s: simplex device: "
236                         "DMA forced\n",
...
240             default:
241                 /*
242                  * If the device claims "simplex" DMA,
243                  * this means only one of the two interfaces
244                  * can be trusted with DMA at any point in time.
245                  * So we should enable DMA only on one of the
246                  * two interfaces.
247                  */
...
259                         printk(KERN_INFO "%s: simplex device: "
260                             "DMA disabled\n",
...

I would guess it would be enough to remove the PCI_DEVICE_ID_CMD_643 and let it
be handled by the default case, thus disabling DMA. I will try the attached
patch on my friends laptop as soon as he brings it along.

With friendly regards,
Takis

diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index 0719b64..5a7b6f6 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -226,7 +226,6 @@ #endif /* CONFIG_BLK_DEV_IDEDMA_FORCED *
                        case PCI_DEVICE_ID_AL_M5219:
                        case PCI_DEVICE_ID_AL_M5229:
                        case PCI_DEVICE_ID_AMD_VIPER_7409:
-                       case PCI_DEVICE_ID_CMD_643:
                        case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
                        case PCI_DEVICE_ID_REVOLUTION:
                                simplex_stat = hwif->INB(dma_base + 2);


