Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSE3PbZ>; Thu, 30 May 2002 11:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSE3PbZ>; Thu, 30 May 2002 11:31:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316715AbSE3PbX>; Thu, 30 May 2002 11:31:23 -0400
Date: Thu, 30 May 2002 08:31:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <3CF63535.6000907@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205300826100.877-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 May 2002, Martin Dalecki wrote:
>
> LAST WARNING:
>
> Every body out there: watch out to use LABEL= in /etc/fstab or you will
> not be able to reboot between 2.4 and 2.5 soon!

Absolutely not, Martin. We need to have people be able to upgrade easily,
we're already scaring away too many people from this.

> 1. Extract device registration from SCSI code.
>
> 2. Let the ATA/ATAPI code hook up on it. (ide-cs is the most difficult one.)
>
> 3. Let the old ATA/ATAPI major go down the bin...

The minor/major numbers should stay the same, they are just "mappings".
Device drivers shouldn't even care, and in fact we should aim for a setup
where we have a new cleaned-up "disk major", but at the same time we
should support the old major/minors so that people can easily use the same
disk images across different kernel versions.

That should be fairly easy to do, by just making sure that we (a) remove
the kdev_t from "struct request", (b) replace it with a controller and
disk index and (c) make "open()" do some fairly trivial mapping and save
that mapping in the "bdev", so that make_request() and friends can
trivially just fill in the data.

Voila, end of minor/major problems, and you can suddenly do things like
show the _same_ device on many minor/major numbers (so that you can have
it _both_ on a backwards-compatible place _and_ a new cleaned-up place).

And the device drivers wouldn't ever even _know_ what device number the
user saw on disk was.

		Linus

