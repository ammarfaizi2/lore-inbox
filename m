Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbVIVOVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVIVOVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVIVOVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:21:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:55783 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030347AbVIVOVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:21:35 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Richard Purdie <rpurdie@rpsys.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Mark Lord <liml@rtr.ca>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <1127396382.18840.79.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
	 <1127347845.18840.53.camel@localhost.localdomain>
	 <20050922102221.GD16949@flint.arm.linux.org.uk>
	 <1127396382.18840.79.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 15:21:16 +0100
Message-Id: <1127398876.8242.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets try a different way of illustrating the problem. We'll hopefully
all agree that my ide CDROM drive is a removable device.

When my system boots, it creates a /dev/hdd entry for the cdrom. When I
insert a disk and mount it, udev doesn't touch the device node as its
already there and ready to go. If the media changes, this is detected
and the same device node is used to present the new data.

/dev/hdd *always* exists and may or may not have media present.

When I boot a system with an empty PCMCIA slot, no ide device exists.
ide-cs knows nothing about the PCMCIA slot and therefore no device nodes
exist. When you insert the CF card, PCMCIA realises its an ide device,
tells ide-cs which creates the appropriate devices through the ide
layer. When the card is removed, the devices and controller are removed.

The /dev/* entries only exist when the ide controller is present. There
is no state where the controller is present with no media.

Under Linux, removable is defined to mean the device can exist with no
media. That is clearly not the case for CF and therefore it shouldn't be
marked as such. 

If it were removable, ide-cs should be informed of every card slot in
the system and should create ide controllers for each of them whether
they have cards in or not. We could then correctly check for media
changes. Yes, this would be ridiculous but it illustrates that CF cards
should not have the removable flag set.


There are other bugs which this issue is getting confused with. In
summary, I see the following separate issues:

1. Are ide-cs devices removable or not. See above.
2. The following loop exists for removable devices:

Device node is created (by udev).
An attempt to mount the device results in a media change check.
The media change check defaults to media changed.
The device node is removed and recreated (by udev).

Technically, the device node you mounted is now invalid and has changed
so you should remount it. You then have a loop.

This can be solved by having the media change check look at serial
numbers as mentioned by Alan in a previous email.

3. ide-cs sometimes can't/doesn't detect the removal of an ide
controller.

Using media_change events to see if the controller has changed/been
unplugged is incorrect. 


Each of the above are separate bugs. I'm trying to fix one of them (and
might try and work on the others if I can).

Richard


