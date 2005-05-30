Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVE3Jir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVE3Jir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVE3Jir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:38:47 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:16877 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261578AbVE3Jh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:37:58 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 May 2005 11:36:18 +0200
To: schilling@fokus.fraunhofer.de, 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429ADE92.nail4ZG3GSIPT@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
 <4295005F.nail2KW319F89@burner>
 <Pine.LNX.4.58.0505260205390.19389@be1.lrz>
 <4296F088.nail3L121R2F5@burner>
 <Pine.LNX.4.58.0505271633200.3055@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0505271633200.3055@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> > If you have fragmentation problems, do you use the wrong filesystem type?
>
> No, just small writes to random locations in large sparse files on filled 
> disks.

Did you ever try to compare this behavior with UFS?
The last time I did notice fragmentation problems on UFS is more than 15 years
a go when I had full news feed with B-news running on a Sun-3/50 and did a 
higly selective expire.

I am still sure that your problems are a problem of the filesystem 
implementation you use.

> > With network speed, you should set up a sufficiently designed infrastructure.
> > If you like to write a CD in 32x, you need 5.6 MB/s which easily goes over
> > a 100 MB/s network connection.
>
> Mostly it does, but sometimes there are other users on my server.

This is why cdrecord puts itself into the highest priority real time class
on every OS that supports this. If you voluntarily decline on this feature,
please don't blame cdrecord.


> > There are many other commands needed by cdrecord.
> > The initiator of the good/bad SCSI op code table hack claimed to have checked
> > cdrecord for a list of used commands. If you check the current table, you may
> > easily find that this cannot be true.
>
> So we'll need a function to add more commands to the allowed list of each 
> device.

No, the command list was an ungly hack from the beginning and it just is not
suitable for what it is used.

	If you like decent and reliable security, you need privillege separation.

-	Disallow sending SCSI commands via ioctl() on /dev/hd*

-	Tell people that they have to use /dev/sg* in order to send SCSI 
	commands to devices.

-	Introduce a privillege check for /dev/hd* that is suitable for the
	users of a block device interface.

-	Introduce a privillege check for /dev/sg* that is suitable for the
	users of a SCSI pass though interface.

The current problems in Linux are just a result of mixing unrelated interfaces
together.


> > > You'll want to grant raw disk access for some databases, which will run as
> > > a unprivileged user. These databases should not be able to kill HDDs.
> > 
> > A database may kill a hdd in many other ways.
>
> IMO, those should be plugged, too, and I'm sure they will.

See above: the clean solution is privilleges separation.


> > It is higly improbable that
> > a trustworthy database includes the knowwledge to set up a firmware to the
> > drive that us accepted by the drive but does not work.
>
> A database may very well have exploits or provide system access to the 
> database admin. Neither should result in raw SCSI access.

See above: If you have clean privilleges separation (and Linux did have it 
before the unsuited SG_IO ioctl was introduced on /dev/hd*) you don't even come
close to similar problems.

Just give the database an interfase that allows the database to do what a 
database needs to do (reading and writing to a media) but not more.


> > The same applies for
> > your kernel. You need to trust your database the same way as you need to trust 
> > your kernel.
>
> NACK. Databases can't be trusted.

Wunderfull, so you are also a fan of privillege separation. Let us together
vote for removing ioctl(sg_IO) from /dev/hd* and similar devices.


> > > No, it's a feature, see man 3 cap_get_proc.
> > 
> > If Linux is designed in a way that needs applications like cdrecord to be 
> > changed in order to include support for a Linux proprietary new security
> > mechanism, then the new mechanism should be rethought.
>
> You don't need to implement that, but you shouldn't asume root to be more 
> special than other users.

In contrary to many other programs, cdrecord is cleanly written and does not
make such assumptions! It will have no problems as long as the environment
is not contradictive.


> BTW: IIRC, it was ported from solaris. There will probably the same issue.
>
> > So for the Linux equivalent: don't force users tu use interfaces that are not
> > yet ready for the public.
>
> You're not forced to use it, but you might be served non-dirty plates.

It seems that you did not understand this, so let me explain it in a different
way: If you start to implement a new security mechanism, either do it in a way 
that does not affect software that assumes historical UNIX interfaces at all,
or keep it private for developers untill it is suitable for the mass.

> > So it makes sense for the Linux to have a look at the Solaris implementation.
> > The database is much simpler to manage than what is present for Linux.
>
> This is a userspace issue. The kernel doesn't enforce anything.

An OS is the kernel _and_ the user space support software.
Even a "kernel only" subsystem like Linux cannot ignore these facts when
trying to introduce interfaces that need special useland programs in order
to mahe use out of it.

> > BTW: it would also make sense to implement the new holey file interface 
> > I designed together with the Solaris kernel crew for star.
>
> Google gives no good pointers.

If it did, soneone would have ignored his NDA. The current interface is not
yet 100% stable, it will be officially published when it is closer to something
that could be used by anyone. If someone from LKML is really interested in 
implementing the interface soon, I would be willing to give away basic
details that allow to implement 99% if the code. The error handling is 
still in dispute.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
