Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJURYJ>; Mon, 21 Oct 2002 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJURYI>; Mon, 21 Oct 2002 13:24:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48768 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261565AbSJURYH>;
	Mon, 21 Oct 2002 13:24:07 -0400
Date: Mon, 21 Oct 2002 10:33:28 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org, <andmike@us.ibm.com>, <patmans@us.ibm.com>
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and
 the global_device_list
In-Reply-To: <20021021053622.GA493@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0210211021560.963-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Oct 2002, Jurriaan wrote:

> I tried this patch:
...

> and it didn't work - still hangs in 'Shutting down devices'.

> and I see a loop when shutting down:
> 
> ID 'scsi0'
> ID '0:0:1:0:gen'
> ID '0:0:1:0'
> ID '0:0:2:0:gen'
> ID '0:0:5:0:gen'
> ID '0:0:5:0'
> ID 'scsi0'
> 
> and then it goes on to 0:0:1:0:gen and repeats itself.
> 
> With the crude '>128 devices, skip the rest of it' above, it actually
> shuts down. I still wonder if this warning about might-sleep in my dmesg
> can have anything to do with this; it occurs just when registering the
> scsi card. A full dmesg has been attached.

It is related to the __might_sleep() dump on boot, but not necessarily 
because of it. In short, Mike Anderson posted the patch I've appended. 
That should fix it. Could you please try it? 

The problem again is ncr_attach() in sym5c8xx.c. It's calling 
scsi_set_pci_device(), which is registering the device a second time. 

[ A note on that: the reason I didn't find this before is that it's a
static inline in drivers/scsi/host.h, and I was grepping through .c files
only.  Does this really need to be static inline? It doesn't appear so. ]

The dump happens because ncr_attach(), on line 5838, NCR_LOCK()  
(homebrewed locking macro wrappers for compatability) is called (which
does a spin_lock_irqsave()), and is held until line 5908. That's not
necessarily an ungodly long time, but probably unncessary.
scsi_set_pci_device() is called on line 5893, which calls
device_register(), which calls functions that can definitely sleep.

	-pat

--- 1.19/drivers/scsi/hosts.h	Wed Oct 16 17:53:47 2002
+++ edited/drivers/scsi/hosts.h	Sun Oct 20 19:45:35 2002
@@ -551,9 +551,6 @@
 {
 	shost->pci_dev = pdev;
 	shost->host_driverfs_dev.parent=&pdev->dev;
-
-	/* register parent with driverfs */
-	device_register(&shost->host_driverfs_dev);
 }
 
 

