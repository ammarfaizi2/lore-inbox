Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275259AbTHGJ6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275258AbTHGJ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:58:03 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13758 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275259AbTHGJ5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:57:55 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 11:57:49 +0200 (MEST)
Message-Id: <UTC200308070957.h779vnj22394.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl, aebr@win.tue.nl
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Cc: alan@lxorguk.ukuu.org.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > The part I most object to are things like
    >
    > > +    id->lba_capacity_2 = capacity_2 = set_max_ext;
    >
    > There have been many problems in the past, and it is a bad idea to add
    > more of this. We should be eliminating all cases.

    What problems?  This reflects real change in drive's identify
    and I think should be replaced by rereading drive->id from a drive.

In order to be able to troubleshoot problems we need to be able
to reconstruct the information involved.

One part is the disk identity info that existed at boot time.
It was read by the kernel, and stored. It is returned by the
HDIO_GET_IDENTIFY ioctl, as used in e.g. hdparm -i.

There is also the current disk identity info.
It is found by asking the disk now, and is returned by e.g. hdparm -I.

    > We have info from BIOS, user, disk etc and conclude
    > to a certain geometry.

    I can't spot place when we get info from a BIOS.

See arch/i386/boot/setup.S
(I ripped out ide-geometry.c recently, so the use has diminished.)

    > Sneakily changing what the disk reported is very ugly. I recall a case
    > where a disk bounced between two capacities because the value that this
    > computation concluded to was not a fixed point. Also, the user gets an
    > incorrect report from HDIO_GET_IDENTITY.

    User gets correct report from HDIO_GET_IDENTIFY as drive's identify was
    really changed.  Moreover HDIO_GET_IDENTIFY needs fixing to actually
    reread drive->id from a drive (similarly like /proc identify was fixed).

There are at least two objections.
First: we do not want the new identity, we want the old.
Second: if we ask the disk for identity again, you'll see that
more than this single field was changed.

If the user only wanted to know the current max size then there are
other means, like BLKGETSIZE.

    > So, the clean way is to examine what the disk reported, never change it

    Even if disk's info changes?  I don't think so.

Yes. The disk geometry data that we use is drive->*
What the disk reported to us is drive->id->*.


Andries
