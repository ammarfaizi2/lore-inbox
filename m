Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGQMbc>; Wed, 17 Jul 2002 08:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSGQMbb>; Wed, 17 Jul 2002 08:31:31 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:27367 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S313181AbSGQMb2>; Wed, 17 Jul 2002 08:31:28 -0400
Date: Wed, 17 Jul 2002 14:32:43 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207171232.g6HCWhbE027917@burner.fokus.gmd.de>
To: James.Bottomley@steeleye.com, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From James.Bottomley@SteelEye.com Tue Jul 16 16:33:32 2002
>schilling@fokus.gmd.de said:
>> Why should the character interface be connected to the block layer?
>> This would contradict UNIX rules. 

>Well, first and foremost Linux isn't UNIX, especially where block and 
>character devices are concerned.  But secondly, the block layer provides 
>command queueing.  If any device (SCSI, IDE or more exotic) can't accept a 
>character command (like QUEUE_FULL in SCSI), it goes back to the block layer 
>queue to await reissue.  It's really exactly a block request without the block 
>position.

You describe here how the block layer in UNIX works....

>This is actually almost the way linux operates now:  all the character tap for 
>a SCSI tape device does is take the read or write and convert it into an 
>appropriate SCSI command, which now has a block extent attached.  Since we 
>have all the machinery for handling block command queuing in the block layer, 
>it makes no sense to duplicate it for the character layer.

If Linux really handles it this way, then I don't see any sense in it.
If you like to do things that are different from the UNIX default for block
or character drivers for disk devices, you should try to use mmap() and 
madvise().

>Error handling is more than local.  Some errors, you are correct, can only be 
>handled at the SCSI layer.  However, a large class of drivers (Think 
>multi-path or software raid) want the ability to direct how SCSI handles 
>errors themselves.  It is unacceptable to have SCSI all on its own retry a 
>medium error command x times, taking minutes before the upper layers become 
>aware anything went wrong.

It looks like you have the wrong ideas about software raid. If you have 
software raid, you will stack a SW raid driver just on top of the disk drivers 
that handle the access to the real drives. The real drives first do own error 
handling and if they cannot correct errors, the error is handled inside the 
raid layer. As the raid layer itself will at it's top level act as if it was a 
disk driver, there is no relation to the block layer.


>The solution is to have a stacking error handler where the error handler for 
>upper devices would be notified of a problem and asked for direction as soon 
>as it occurs.

See above, this makes no sense.

>But the new scheme allows that.  The block queues accept translated requests 
>(that's really what sg does).

A SCSI request is _not_ a translated request. It is the real request itself. 
You usually even cannot translate a SCSI request into something else.


>> It would help, if somebody would correct the current SCSI addressng

>> Why do you believe that you need to have something that is not a
>> bumber? 

>Look at a solaris fibre driver for instance.  On the fabric, most of them 
>think of targets in terms of WWN/PORT (because that's what the fibre LIP 
>uses).  They then have an internal database to translate what they use 
>(WWN/PORT, soft loop ID, etc.) into a target number for the user to see.  
>Next, because the fibre topology is mutable, they have to have a way of 
>mapping the WWN/PORT to the device across reboots, hence persistent binding.  
>Ultimately you get a huge chunk of code whose sole job is to preserve the 
>fiction that targets are numbers.

You also need to authenticate yourself before you may get access to the network 
media. Once you did this, you simply may assign a Bus number to the cabinet.


>> Let me add my modified artwork: 

>But you're still too SCSI transport specific.  The ongoing goal is to make the 
>physical transport protocol an adjunct to the Linux internal transport (the 
>struct request) so that we can treat all block/character devices on an equal 
>footing.

You seem to forget that all main control is done via SCSI commands. You are too 
anti SCSI wthout a real reason.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
