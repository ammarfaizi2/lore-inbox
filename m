Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267755AbUHJVty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267755AbUHJVty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbUHJVtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:49:53 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:46236 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267755AbUHJVtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:49:17 -0400
Date: Tue, 10 Aug 2004 23:48:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408102148.i7ALmULH014645@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: alan@lxorguk.ukuu.org.uk, diablod3@gmail.com, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, skraw@ithnet.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From axboe@suse.de  Tue Aug 10 20:49:03 2004

>Ehm yes, aren't you contradicting yourself? Here's the mail I'm
>referring to:

I don't - I have a clean and orthogonal idea for useful interfacew. As I did 
already tell, your patch did not enhance cdrecord but rather tries to remove 
useful warnings.

If you however would ever send any patch that would _really_
increase the features of cdrtools, there is a big chance that it will be 
included.

Here is what I did send as reply. It verifies that I am really taking you for 
serious and did send you a serious reply.

/*--------------------------------------------------------------------------*/
>From joerg Tue Jan 13 16:29:42 2004
To: axboe@suse.de
Subject: Re: open by devname

>From axboe@suse.de  Mon Jan 12 16:50:19 2004


>With 2.6 and SG_IO for generic block devices, it's pretty annoying and
>confusing to users that cdrecord outputs:

>"Open by 'devname' is unintentional and not supported."

The reason is to tell people that they are going to use an annoying
interface that is not really needed and that breaks the SCSI protocol layering.

In addition, it tells users that there may be problems because the Linux 
kernel folks did not include correct ioctl interfaces for

ioctl(f, SCSI_IOCTL_GET_IDLUN, &sg_id)

ioctl(f, SCSI_IOCTL_GET_BUS_NUMBER, &Bus)

and

ioctl(scgp->fd, SG_EMULATED_HOST, &emulated)

but just implemented dummies that may cause problems.

>This leads them to think they did something wrong, which they really
>didn't. Any chance you could be talked into taking that message out?

Sorry no, because what you wrote is only halfway correct.

They are forced to use something inherently wrong because the Linux kernel
now includes another SCSI interface that is not needed. Note that the
efforts that have ben put into writing this piece of code should have better
be put into writing an orthogonal DMA access interface and fixing the
DMA problems that cause DMA sizes % 512 != 0 to disable DMA for _all_ devices
and _all_ interfaces provided by the kernel.

Open by devname definitly breaks clean protocol layering on a OS
where you already have a generic SCSI transport interface like Linux has
with /dev/sg*

The  vanilla way to go is to run cdrecord -scanbus and then 
use one of the listed devices. 

ATAPI is SCSI over ATA transport and there are a lot of different official 
SCSI transport media. 

ide-scsi is not the best possible solution, but it definitely fits much better
into a  clean layering model than what Linux Torvalds likes to 
enforce (note that he doesn't own any CD writer so he is definitely unable 
to even judge about the problems). 

I really hope that Jeff Garzik continues to implement his clean way of dealing 
with ATAPI devices and that the ugly /dev/hd* based SCSI interface is becoming
obsolete soon.

libscg does not offer a service that is at the layering level that 
the /dev/hd* driver provides.

libscg instead offers a service that is just below the service of 
the /dev/hd* driver. 

It makes no sense to use naming schemes made for high level device  
acces for low level tasks like SCSI command transport. 

Libscg provides an interface for the mid level SCSI transport.
This protocol level is _above_ the Hostadaptordriver where transport
specific things are handled. It is _below_ the Blockdevice layer
where hard disk, CD-ROM and Tape specifics are handled. Libscg provides
just the protocol layer that is used by the lower end of the block device
drivers. It is inapropriate to use a naming scheme that applies to a higher
protocol layer that is not used by libscg. 

Forcing users to be unable to list all devices that use the SCSI protocol
in a single name space is just a bad idea.

As kernels usually use instance numbers for internal purposes, it is obvious
to use just something similar to implement the name space for libscg.
 
/*--------------------------------------------------------------------------*/


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
