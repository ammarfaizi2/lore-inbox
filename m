Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319219AbSIDQqb>; Wed, 4 Sep 2002 12:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319215AbSIDQqb>; Wed, 4 Sep 2002 12:46:31 -0400
Received: from magic.adaptec.com ([208.236.45.80]:54746 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S319209AbSIDQqa>; Wed, 4 Sep 2002 12:46:30 -0400
Date: Wed, 04 Sep 2002 10:50:09 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
Message-ID: <12750000.1031158209@aslan.btc.adaptec.com>
In-Reply-To: <200209041613.g84GDtv02639@localhost.localdomain>
References: <200209041613.g84GDtv02639@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dledford@redhat.com said:
>> Now, granted, that is more complex than going straight to a BDR, but I
>>  have to argue that it *isn't* that complex.  It certainly isn't the
>> nightmare you make it sound like ;-) 
> 
> It's three times longer even in pseudocode...

To make this work, you really need to use the QErr bit in the
disconnect/reconnect page and/or ECA or ACA.  QErr I believe is
well supported in devices, but ECA (pre SCSI-3) and ACA most
likely receive very little testing.

I will also voice my opinion (again) that watchdog timer recovery
is in the wrong place in Linux.  It belongs in the controller drivers:

1) Only the controller driver knows when to start the timeout
2) Only the controller driver knows the current status of the bus/transport
3) Only the controller can close timeout/just completed races
4) Only the controller driver knows the true transport type
   (SPI/FC/ATA/USB/1394/IP) and what recovery actions are appropriate
   for that transport type given the capabilities of the controller.
5) The algorithm for recovery and maintaining order becomes quite simple:
	1) Freeze the input queue for the controller
	2) Return all transactions unqueued to a device to the mid-layer
	3) Perform the recovery actions required
	4) Unfreeze the controller's queue
	5) Device type driver (sd, cd, tape, etc) decides what errors
	   at what rates should cause the failure of a device.  The
	   controller driver just needs to have the error codes so
	   it can honestly and fully report to the type driver what
	   really happens so it can make good decissions

   This of course assumes that all transactions have a serial number and
   that requeuing transactions orders them by serial number.  With QErr
   set, the device closes the rest if the barrier race for you, but even
   without barriers, full transaction ordering is required if you don't
   want a read to inadvertantly pass a write to the same location during
   recovery.

   For prior art, take a look at FreeBSD.  In the worst case, where
   escalation to a bus reset is required, recovery takes 5 seconds.

--
Justin
