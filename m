Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWEUNYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWEUNYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWEUNYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:24:22 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:5291 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964866AbWEUNYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:24:21 -0400
Message-ID: <447069F7.1010407@myri.com>
Date: Sun, 21 May 2006 15:24:07 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>, Greg KH <gregkh@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com> <20060521131025.GR30211@mellanox.co.il>
In-Reply-To: <20060521131025.GR30211@mellanox.co.il>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------050409090307040604070304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409090307040604070304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
>> @@ -925,8 +926,9 @@
>>  	if (dev->no_msi)
>>  		return status;
>>  
>> -	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
>> -		return -EINVAL;
>> +	for (bus = dev->bus; bus; bus = bus->parent)
>> +		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
>> +			return -EINVAL;
>>  
>>  	temp = dev->irq;
>>     
>
> It seems we must add this loop to pci_enable_msix as well.
>   

Right, thanks. Greg, what do you think of putting the attached patch in
2.6.17 ?

By the way, do we need to check dev->no_msi in pci_enable_msix() too ?

For 2.6.18, I don't know what's the best. We could drop the fact that
bus flags should be inherited and keep looking at parent busses. It
might be good to add a pci_check_flag_in_parent_busses(dev, flag) to
provide a generic way to do my for loop.

thanks,
Brice


Signed-off-by: Brice Goglin <brice@myri.com>


--------------050409090307040604070304
Content-Type: text/x-patch;
 name="look_at_parent_busses_flags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="look_at_parent_busses_flags.patch"

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-05-21 15:12:04.000000000 +0200
+++ linux-mm/drivers/pci/msi.c	2006-05-21 15:15:34.000000000 +0200
@@ -916,6 +916,7 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
+	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
 	u16 control;
 
@@ -925,8 +926,9 @@
 	if (dev->no_msi)
 		return status;
 
-	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-		return -EINVAL;
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1162,6 +1164,7 @@
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
+	struct pci_bus *bus;
 	int status, pos, nr_entries, free_vectors;
 	int i, j, temp;
 	u16 control;
@@ -1170,6 +1173,10 @@
 	if (!pci_msi_enable || !dev || !entries)
  		return -EINVAL;
 
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
+
 	status = msi_init();
 	if (status < 0)
 		return status;

--------------050409090307040604070304--
