Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVAJRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVAJRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVAJRgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:36:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20443 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262365AbVAJRVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:08 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <110537765824@kroah.com>
Date: Mon, 10 Jan 2005 09:20:59 -0800
Message-Id: <11053776592895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.16, 2004/12/21 16:48:08-08:00, rddunlap@osdl.org

[PATCH] cpqphp: reduce stack usage

Reduce local stack usage in cpqhp_set_irq()
from 1028 bytes to 12 bytes (on x86-32).

This was the 16th largest offender according to my
recent 'make checkstack' run (and 2 other patches
for large ones have recently been submitted).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpqphp_pci.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	2005-01-10 09:00:02 -08:00
+++ b/drivers/pci/hotplug/cpqphp_pci.c	2005-01-10 09:00:02 -08:00
@@ -151,18 +151,29 @@
  */
 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-	int rc;
-	u16 temp_word;
-	struct pci_dev fakedev;
-	struct pci_bus fakebus;
+	int rc = 0;
 
 	if (cpqhp_legacy_mode) {
-		fakedev.devfn = dev_num << 3;
-		fakedev.bus = &fakebus;
-		fakebus.number = bus_num;
+		struct pci_dev *fakedev;
+		struct pci_bus *fakebus;
+		u16 temp_word;
+
+		fakedev = kmalloc(sizeof(*fakedev), GFP_KERNEL);
+		fakebus = kmalloc(sizeof(*fakebus), GFP_KERNEL);
+		if (!fakedev || !fakebus) {
+			kfree(fakedev);
+			kfree(fakebus);
+			return -ENOMEM;
+		}
+
+		fakedev->devfn = dev_num << 3;
+		fakedev->bus = fakebus;
+		fakebus->number = bus_num;
 		dbg("%s: dev %d, bus %d, pin %d, num %d\n",
 		    __FUNCTION__, dev_num, bus_num, int_pin, irq_num);
-		rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
+		rc = pcibios_set_irq_routing(fakedev, int_pin - 0x0a, irq_num);
+		kfree(fakedev);
+		kfree(fakebus);
 		dbg("%s: rc %d\n", __FUNCTION__, rc);
 		if (!rc)
 			return !rc;
@@ -176,9 +187,10 @@
 		// This should only be for x86 as it sets the Edge Level Control Register
 		outb((u8) (temp_word & 0xFF), 0x4d0);
 		outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
+		rc = 0;
 	}
 
-	return 0;
+	return rc;
 }
 
 

