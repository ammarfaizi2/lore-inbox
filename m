Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUHFXPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUHFXPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267912AbUHFXPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:15:30 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:34950 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266197AbUHFXP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:15:27 -0400
Date: Sat, 7 Aug 2004 01:15:29 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806231529.GA9997@ucw.cz>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Let me lead you to the right place to look for:
> 
> 	The CAM interface (which is from the SCSI standards group)
> 	usually is implemeted in a way that applications open /dev/cam and
> 	later supply bus, target and lun in order to get connected
> 	to any device on the system that talks SCSI.
> 
> Let me repeat: If you believe that this is a bad idea, give very good reasons.

There is one: hotplug. The physical topology of buses where all the SCSI-like
devices (being it ATAPI devices, iSCSI, USB disks or other such beasts)
are connected is too complex, so every attempt to map them to the
(bus, target, lun) triplets in any sane way is destined to fail.

Hence, the triplets will be just some magic numbers with no connection
to reality and while in a static world, you can assign them in some
consistent (although completely virtual) way, once you admit that
devices can be hotplugged, nobody can guarantee that these numbers will be the
same on every boot. In practice, they aren't.

Also, no matter what the SCSI standard group thinks, the traditional UNIX
way how to refer to devices is by the name of the corresponding special
file. Unless you have very strong reasons why this model is wrong for
SCSI-like devices, you should keep to the tradition. Refering to the
CD burner in different ways depending on whether I want to mount the disk
or to burn it, is outright silly.

Sure, just using device names is not a panacea for the hotplug problems,
but it makes the problems much easier to solve. And given that this has
to be done anyway, maintaining one more dynamic namespace (the SCSI triplets)
is just another pile of unnecessary extra work.

> Looks like a typical answer from somebody who's thoughts are limited to a Linux
> environment. Take into account, that cdrecord runs on more than 30 different
> platforms and that several of these platforms do not have device nodes like
> UNIX has. Cdrecord has been implemented to use a portable addressing method.

Portable, as the problems with Linux show, it isn't. There is probably no
such thing like an universal addressing scheme working on all systems.

> The importance could be limited if there were unique instance numbers
> for ATAPI devices using the same address space as the other SCSI devices.

Such "numbers" are there -- the device node names. All other SCSI devices
have them, too.

> Let's see whether "Linux" is open enough to listen to the demands of the
> users......

So far, I haven't heard much users longing for the triplet addressing
of devices. To be precise, exactly one. On the other side, whenever I have
heard people talking about cdrecord (which is otherwise a very fine piece
of software), they complained about the (lack of) device naming.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Ctrl and Alt keys stuck -- press Del to continue.
