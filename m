Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265728AbSJYAOv>; Thu, 24 Oct 2002 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSJYAOv>; Thu, 24 Oct 2002 20:14:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16900 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265724AbSJYAOs>;
	Thu, 24 Oct 2002 20:14:48 -0400
Message-ID: <3DB88E61.2010909@pobox.com>
Date: Thu, 24 Oct 2002 20:20:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Dake <sdake@mvista.com>
CC: Greg KH <greg@kroah.com>, Scott Murray <scottm@somanetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
References: <Pine.LNX.4.33L2.0210241350230.20950-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0210241839490.10937-100000@rancor.yyz.somanetworks.com> <20021024232258.GA26093@kroah.com> <3DB886B9.3060304@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Dake wrote:

> Montavista has discussed at length Compact PCI hotswap using surprise 
> removal events.
>
> The key feature of any hotswap operation that happens in a surprise 
> fashion is that
> the device driver might want a hint that the hardware is no longer 
> present so it can
> immediatly dump its buffers/io maps/etc and totally stop accessing the 
> device.  An
> expected removal, on the other hand, would give the device driver time 
> to flush its
> buffers (for example a scsi driver could dump its outstanding queued 
> scsi messages).
> Once the driver is done accessing the device, the blue led on the 
> CompactPCI board
> can be lit and it can be removed.
>
> This is the main difference.  Since the driver model of Linux doesn't 
> support a surprise
> extract method call for drivers, I don't think its been implemented 
> here.  Further the
> drivers must be modified to actually use the hint instead of doing its 
> normal shutdown
> operation. 


Wrong.  The _only_ supported method so far has been surprise removal. 
 For years now.  This happens every day in the land of CardBus, which 
was the first "PCI" hotplug implementation in the Linux kernel.  PCI 
HotPlug introduces a new, non-surprise removal.

Thus, the current model should be assumed to be surprise removal, and 
you need an additional notification from the system if a "nice" removal 
is about to occur.

> Surprise extraction is not a simple problem especially to ensure the 
> device drivers exit
> cleanly without dumping more data on the PCI bus to a PCI device that 
> may not
> exist. 

PCI is electrically safe.  Reads to non-existent areas return 
0xffffffff, etc.  Take a look at net drivers some day, we have been 
handling this for years.

Surprise removal is actually easier from many perspectives -- you don't 
have to worry about quiescing the hardware, you simply have to error out 
all I/Os, and clean up the kernel structures that are left behind (host 
info, device info, etc.).  The non-surprise removal is more annoying, in 
that you could potentially have an indefinite wait (and must actively 
avoid such a situation) while shutting down the hardware, completing 
I/Os, etc.

    Jeff




