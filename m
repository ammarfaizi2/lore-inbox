Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSGMDP0>; Fri, 12 Jul 2002 23:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318083AbSGMDPZ>; Fri, 12 Jul 2002 23:15:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58764 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S318078AbSGMDPY>;
	Fri, 12 Jul 2002 23:15:24 -0400
Date: Fri, 12 Jul 2002 20:16:02 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile warning in fs/partitions/check.c
In-Reply-To: <Pine.LNX.4.44.0207121640180.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.33.0207122003330.961-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> Compiling fs/partitions/check.c, I get a couple of warnings of "pointer to 
> integer of different size":
> 
> 
> kdev is a kdev_t here, driverfs_dev is a struct device.
> 
> 	kdev.value=(int)driverfs_dev->driver_data;
> 
> Is it okay to replace this with
> 
> 	kdev.value=(unsigned short)driverfs_dev->driver_data;
> 
> to make the warnings go away?

This code definitely shouldn't rely on the format of the kdev_t structure. 
It looks like it should be something like:

-	kdev.value=(int)driverfs_dev->driver_data;
-	return off ? 0 : sprintf (page, "%x\n",kdev.value);
+	kdev = val_to_kdev((int)driverfs_dev->driver_data);
+	return off ? 0 : sprintf (page, "%x\n",kdev_val(kdev));

> Also, struct driver_file_entry->show gets initialized here:
> 
> 	show: partition_device_kdev_read,
> 
> show being (ssize_t *)(struct device *driverfs_dev, char *page, size_t 
> 		       count, loff_t off);
> but expecting (ssize_t *)(void *, char *page, size_t count, loff_t off);

First off, you might want to specify that you are using a specific patch. 
The change of the first parameter of the show() and store() callbacks was 
in a patch I posted last week. As of a few seconds ago, it hadn't been 
merged into Linus' kernel.org tree. 

Second, the definition of the callbacks should change, and there should be
an appropriate cast in the function. I have patches for all the users of
those callbacks, but I'm waiting until I finally resolve the refcounting
issues and post and updated patch to post those. FWIW, the pointer passed
to those callbacks is guaranteed to be a struct device, so the warning is, 
for now, harmless. 

Finally, if you have driverfs questions/problems/concerns, please copy me 
(and not Richard). :)

	-pat

