Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVDHFwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDHFwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVDHFwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:52:35 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9636 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261196AbVDHFwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:52:32 -0400
Message-ID: <42561C5B.2060507@soft.fujitsu.com>
Date: Fri, 08 Apr 2005 14:53:31 +0900
From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 'is_enabled' flag should be set/cleared when the device is
 actually enabled/disabled
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think 'is_enabled' flag in pci_dev structure should be set/cleared
when the device actually enabled/disabled. Especially about
pci_enable_device(), it can be failed. By this change, we will also
get the possibility of refering 'is_enabled' flag from the functions
called through pci_enable_device()/pci_disable_device().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.12-rc2-kanesige/drivers/pci/pci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/pci/pci.c~fix_update_is_enabled drivers/pci/pci.c
--- linux-2.6.12-rc2/drivers/pci/pci.c~fix_update_is_enabled	2005-04-07 18:59:47.058814755 +0900
+++ linux-2.6.12-rc2-kanesige/drivers/pci/pci.c	2005-04-07 19:02:25.843969060 +0900
@@ -398,10 +398,10 @@ pci_enable_device(struct pci_dev *dev)
 {
 	int err;
 
-	dev->is_enabled = 1;
 	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
+	dev->is_enabled = 1;
 	return 0;
 }
 
@@ -427,16 +427,15 @@ pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 	
-	dev->is_enabled = 0;
-	dev->is_busmaster = 0;
-
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+	dev->is_busmaster = 0;
 
 	pcibios_disable_device(dev);
+	dev->is_enabled = 0;
 }
 
 /**

_
