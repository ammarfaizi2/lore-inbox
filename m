Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVHQWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVHQWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVHQWay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:30:54 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:14778 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751301AbVHQWay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:30:54 -0400
Date: Thu, 18 Aug 2005 00:30:00 +0200
Message-Id: <200508172230.j7HMU0l8017191@tirith.ics.muni.cz>
In-reply-to: <20050817150523.GA19487@infomag.infomag.iguana.be>
Subject: Re: watchdog-mm git tree
From: Jiri Slaby <jirislaby@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Hardeman <david@2gen.com>, Naveen Gupta <ngupta@google.com>,
       P@draigBrady.com, Ben Dooks <ben-linux@fluff.org>,
       James Chapman <jchapman@katalix.com>, Olaf Hering <olh@suse.de>
X-Muni-Spam-TestIP: 147.251.53.71
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Author: Jiri Slaby <xslaby@fi.muni.cz>
>Date: Tue Aug 16 14:35:42 2005 -0700
>
>[WATCHDOG] removes pci_find_device from i6300esb.c
>
>This patch changes
>pci_find_device to pci_get_device (encapsulated in for_each_pci_dev) in
>i6300esb watchdog card with appropriate adding pci_dev_put. Generated in
>2.6.13-rc5-mm1 kernel version.
This is bad. One pci_dev_put was misused (there was one case without putting
the device).
Thanks to Naveen Gupta.

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

i6300esb.c |    6 ++++--
1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/watchdog/i6300esb.c b/drivers/char/watchdog/i6300esb.c
--- a/drivers/char/watchdog/i6300esb.c
+++ b/drivers/char/watchdog/i6300esb.c
@@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
          *      Find the PCI device
          */
 
-        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+        for_each_pci_dev(dev)
                 if (pci_match_id(esb_pci_tbl, dev)) {
                         esb_pci = dev;
                         break;
                 }
-        }
 
         if (esb_pci) {
         	if (pci_enable_device(esb_pci)) {
@@ -432,6 +431,7 @@ err_disable:
 		pci_disable_device(esb_pci);
 	}
 out:
+	pci_dev_put(esb_pci);
 	return 0;
 }
 
@@ -481,6 +481,7 @@ err_unmap:
 	pci_release_region(esb_pci, 0);
 /* err_disable: */
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 /* out: */
         return ret;
 }
@@ -497,6 +498,7 @@ static void __exit watchdog_cleanup (voi
 	iounmap(BASEADDR);
 	pci_release_region(esb_pci, 0);
 	pci_disable_device(esb_pci);
+	pci_dev_put(esb_pci);
 }
 
 module_init(watchdog_init);
