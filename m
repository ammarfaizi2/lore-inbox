Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbTCHTML>; Sat, 8 Mar 2003 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbTCHTML>; Sat, 8 Mar 2003 14:12:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:23566 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261605AbTCHTMK>;
	Sat, 8 Mar 2003 14:12:10 -0500
Date: Sat, 8 Mar 2003 11:12:37 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308191237.GA26374@kroah.com>
References: <20030308104749.A29145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308104749.A29145@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> Hi,
> 
> What prevents the following scenario from happening?  It's purely
> theoretical - I haven't seen this occuring.
> 
> - Load PCI driver.
> 
> - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> 
> - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
>   driver, and calls the PCI drivers probe function.

Ugh, yes you are correct, I can't believe I missed this before.

How does this patch look?

thanks,

greg k-h


===== drivers/pci/pci-driver.c 1.17 vs edited =====
--- 1.17/drivers/pci/pci-driver.c	Sat Nov 23 13:23:03 2002
+++ edited/drivers/pci/pci-driver.c	Sat Mar  8 11:21:06 2003
@@ -48,6 +48,12 @@
 	if (!pci_dev->driver && drv->probe) {
 		const struct pci_device_id *id;
 
+		if (!try_module_get(drv->owner)) {
+			dev_err(dev, "Can't get a module reference for %s\n",
+				drv->name);
+			error = -ENODEV;
+			goto exit;
+		}
 		id = pci_match_device(drv->id_table, pci_dev);
 		if (id)
 			error = drv->probe(pci_dev, id);
@@ -55,7 +61,9 @@
 			pci_dev->driver = drv;
 			error = 0;
 		}
+		module_put(drv->owner);
 	}
+exit:
 	return error;
 }
 
@@ -66,7 +74,10 @@
 
 	if (drv) {
 		if (drv->remove)
-			drv->remove(pci_dev);
+			if (try_module_get(drv->owner)) {
+				drv->remove(pci_dev);
+				module_put(drv->owner);
+			}
 		pci_dev->driver = NULL;
 	}
 	return 0;
===== include/linux/pci.h 1.36 vs edited =====
--- 1.36/include/linux/pci.h	Tue Mar  4 21:09:58 2003
+++ edited/include/linux/pci.h	Sat Mar  8 11:20:15 2003
@@ -493,6 +493,7 @@
 
 struct pci_driver {
 	struct list_head node;
+	struct module *owner;
 	char *name;
 	const struct pci_device_id *id_table;	/* NULL if wants all devices */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
