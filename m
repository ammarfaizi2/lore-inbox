Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbTFVVAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbTFVVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:00:11 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:25984 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S265884AbTFVVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:00:07 -0400
Date: Sun, 22 Jun 2003 16:17:30 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Florin Iucha <florin@iucha.net>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
In-Reply-To: <20030622204607.GA16386@iucha.net>
Message-ID: <Pine.LNX.4.56.0306221615230.11747@dust>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
 <20030622204607.GA16386@iucha.net>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Florin Iucha wrote:

> drivers/built-in.o(.text+0x3106): In function `pci_remove_bus_device':
> : undefined reference to `pci_destroy_dev'
> 
> pci_destroy_dev is defined under CONFIG_HOTPLUG and used outside.
> 
> florin
> 
> PS: I think changeset referenced in 10560659712069@kroah.com
> causes the problem.

An attempt at a fix.  It just moves pci_desroy_dev outside the #ifdef).  
I have no idea if this is the correct way to fix this.  It compiles okay.

diff -Naurp hotplug.c.orig hotplug.c
--- hotplug.c.orig      2003-06-22 16:00:25.000000000 -0500
+++ hotplug.c   2003-06-22 16:01:20.000000000 -0500
@@ -219,6 +219,24 @@ int pci_hotplug (struct device *dev, cha
 
 #endif /* CONFIG_HOTPLUG */

+static void pci_destroy_dev(struct pci_dev *dev)
+{
+       pci_proc_detach_device(dev);
+       device_unregister(&dev->dev);
+
+       /* Remove the device from the device lists, and prevent any 
further
+        * list accesses from this device */
+       spin_lock(&pci_bus_lock);
+       list_del(&dev->bus_list);
+       list_del(&dev->global_list);
+       dev->bus_list.next = dev->bus_list.prev = NULL;
+       dev->global_list.next = dev->global_list.prev = NULL;
+       spin_unlock(&pci_bus_lock);
+
+       pci_free_resources(dev);
+       pci_dev_put(dev);
+}
+
 static void
 pci_free_resources(struct pci_dev *dev)
 {

-- 
Alex Goddard
agoddard@purdue.edu
