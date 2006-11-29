Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758083AbWK2VSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083AbWK2VSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757854AbWK2VSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:18:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:17673 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1758083AbWK2VSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:18:11 -0500
Date: Wed, 29 Nov 2006 21:18:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux PCI mailing list <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>
Subject: /sys/bus/pci/drivers/<driver>/new_id
Message-ID: <20061129211803.GB15186@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux PCI mailing list <linux-pci@atrey.karlin.mff.cuni.cz>,
	Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the .../new_id feature does not work with the 8250_pci
driver.

The reason for this comes down to the way .../new_id is implemented.
When PCI tries to match a driver to a device, it checks the modules
static device ID tables _before_ checking the dynamic new_id tables.

When a driver is capable of matching by ID, and falls back to matching
by class (as 8250_pci does), this makes it absolutely impossible to
specify a board by ID, and as such the correct driver_data value to
use with it.

Let's say you have a serial board with vendor 0x1234 and device 0x5678.
It's class is set to PCI_CLASS_COMMUNICATION_SERIAL.

On boot, this card is matched to the 8250_pci driver, which tries to
probe it because it matched using the class entry.  The driver finds
that it is unable to automatically detect the correct settings to use,
so it returns -ENODEV.

You know that the information the driver needs is to match this card
using a device_data value of '7'.  So you echo 1234 5678 0 0 0 0 7
into new_id.

The kernel attempts to re-bind 8250_pci to this device.  However,
because it scans the PCI driver tables, it _again_ matches the class
entry which has the wrong device_data.  It fails.

End of story.  You can't support the card without rebuilding the
kernel (or writing a specific PCI probe module to support it.)

So, can we make new_id override the driver-internal PCI ID tables?
IOW, like this:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 194f1d2..dc0bca9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -165,10 +165,6 @@ const struct pci_device_id *pci_match_de
 	const struct pci_device_id *id;
 	struct pci_dynid *dynid;
 
-	id = pci_match_id(drv->id_table, dev);
-	if (id)
-		return id;
-
 	/* static ids didn't match, lets look at the dynamic ones */
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
@@ -178,7 +174,8 @@ const struct pci_device_id *pci_match_de
 		}
 	}
 	spin_unlock(&drv->dynids.lock);
-	return NULL;
+
+	return pci_match_id(drv->id_table, dev);
 }
 
 static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
