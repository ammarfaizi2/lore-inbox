Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275286AbTHGLuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275289AbTHGLuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:50:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10884 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275286AbTHGLuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:50:11 -0400
Date: Thu, 7 Aug 2003 13:49:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <andersen@codepoet.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
In-Reply-To: <UTC200308071123.h77BN7x00083.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308071334390.7644-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:

>     From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
>
>     > In order to be able to troubleshoot problems we need to be able
>     > to reconstruct the information involved.
>
>     What problems are we talking about? :-)
>
> I am happy that you think there are no problems.
> I spent a considerable time eliminating.
> On the other hand, if you don't know from experience
> then a simple google search will tell you that this
> has been a very painful area in the past.

Very informative answer, thanks ;-).

>     > One part is the disk identity info that existed at boot time.
>     > It was read by the kernel, and stored. It is returned by the
>     > HDIO_GET_IDENTIFY ioctl, as used in e.g. hdparm -i.
>     >
>     > There is also the current disk identity info.
>     > It is found by asking the disk now, and is returned by e.g. hdparm -I.
>
>     What is a value of having these two identities
>
> It helps a little in two ways. One, to help people with fdisk/LILO/..
> disk geometry problems. Two, to investigate new disks.
>
> It is good to have clean data.

Exacty, but I understand it differently.

> Long ago distributions contained privately modified versions of packages.
> Today they use rpms where the pristine sources and the patches are
> clearly visible. Much better.
>
>     > Second: if we ask the disk for identity again, you'll see that
>     > more than this single field was changed.
>
>     We are updating drive->id for changing DMA modes,
>     should this be "fixed" as well?
>
> Yes.
>
> drive->id is what the drive says it can do.

Nope, drive->id is what drive says it can do,
but also what it currently does.

> If the kernel is satisfied with that then it just uses this data.
> If the kernel is of the opinion that it also has to check
> what kind of cable, and what kind of controller, then it
> does not change drive->id->* but determines the mode it wants to use
> and writes that to drive->*.

drive->id also reports *current* active mode
(it changes on a drive itself).

> Moreover, drive->id tells you the situation after the BIOS did its setup.
> Sometimes the BIOS knows things the kernel doesnt know. It is good to
> have the information. Destroying information serves no useful purpose.
>
>     >   > So, the clean way is to examine what the disk reported,
>     >   > never change it
>     >
>     >   Even if disk's info changes?  I don't think so.
>     >
>     > Yes. The disk geometry data that we use is drive->*
>     > What the disk reported to us is drive->id->*.
>
>     This is a contradiction if geometry of disk was changed cause
>     disk reported to us geometry data second time.
>
> I am not sure I can parse that.

After issuing SET_MAX_ADDRESS or SET_MAX_ADDRESS_EXT hardware drive->id
is updated and we are using this information, so disk reports to us geometry,
nope?

> -----
> >From "man hdparm"
>
>        -i     Display the identification info that  was  obtained
>               from the drive at boot time, if available.
>        -I     Request  identification  info  directly  from   the
>               drive.

This is a show-stopper only for changing HDIO_GET_IDENTITY semantics,
not driver itself (we can have separate drive->boot_id for this).

I am starting to think that drive->id (reflecting actual identity) and
drive->boot_id (saved boot drive->id) is a long-term solution.

--
Bartlomiej

