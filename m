Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSKCOve>; Sun, 3 Nov 2002 09:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSKCOve>; Sun, 3 Nov 2002 09:51:34 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:22184 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262036AbSKCOvc>; Sun, 3 Nov 2002 09:51:32 -0500
From: <benh@kernel.crashing.org>
To: "Alan Cox" <alan@redhat.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: <torvalds@transmeta.com>, "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Sun, 3 Nov 2002 15:57:34 +0100
Message-Id: <20021103145735.14872@smtp.wanadoo.fr>
In-Reply-To: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here's patch to prevent random scribling over disks during
>> suspend... In the meantime alan killed (unreferenced at that time)
>> idedisk_suspend() and idedisk_release(), so I have to reintroduce
>> them.
>
>Please fix this at a different level. idedisk is not the place to be
>doing this. If the device layer is doing the right thing then the
>request queue will be idle. 

Hrm... I don't think so Alan. The PM ordering is bus driven,
so actual bus binding of the disk is it's controller, not
the request queue which is the functional binding. It's up to
the disk driver to shut down processing of the request queue.

On the same idea, it's not the network layer that will stop
sending packets to an eth driver, it's the eth driver that
gets suspended by it's bus binding (PCI for example) that
will eventually request the network layer not to send it
any more packets (netif_stop_queue() typically).

So in our case, what we want is the pci controller driver
getting the suspend request (and non-PCI IDE controller will
have to write their own bus binding according to the new model).

It will then tell it's own subdevices (disks in this case) to
suspend (hrm... I don't have the source at hand, I'm away for
a few days right now, does disks have struct device attached
as childs of the ATA controller ? they should...). At that
point, it's up to the _disk_ suspend() function to actually
request the block layer to stop queue processing, typically
this can be done by just not eating requests from the queue,
or better, by (un)plugging the queue on suspend/resume.

Now, there is indeed as subtle race if the disk driver wants
to queue itself a request to actually send the suspend command
to the disk. This request has to be the _last_ of the queue.
That is, the queue must be stopped right after processing this
request with no room for a new request to be taken in between.

The way I see it is that the queue should be stopped not by
the suspend function itself, but by the request processing
function when fetching that STANDBY request from the queue.
We need special care not to mixup with hdparm originated
STANDBY though (but do those go through the queue ? I'm not
sure how far the cleanup went here....)

Ben.



