Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUBJAPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUBJALi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:11:38 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32222 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265540AbUBJAE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:04:59 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Willy Tarreau <willy@w.ods.org>, Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Date: Tue, 10 Feb 2004 01:10:26 +0100
User-Agent: KMail/1.5.3
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1mtPj-7oQ-3@gated-at.bofh.it> <200402081145.19027.athol_SPIT_SPAM@idl.net.au> <20040208073151.GC29363@alpha.home.local>
In-Reply-To: <20040208073151.GC29363@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402100110.26513.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 of February 2004 08:31, Willy Tarreau wrote:
> On Sun, Feb 08, 2004 at 11:45:18AM +1100, Athol Mullen wrote:
> > Before I modified eighty_ninty_three(), it returning 0 caused the
> > _indicated_ mode to drop to UDMA33.  Check in /proc/ide/piix to see what
> > mode the driver tells you.  IIRC (could be wrong), dmesg and hdparm both
> > believe it to be in UDMA33 while the init code and /proc/ide/piix both
> > showed it as UDMA5.

So host recognizes 80-wires cable correctly, but drive doesn't.
eighty_ninty_three() is for checking _drive_ side.

> I captured dmesg and /proc/ide/piix, but forgot to post them. They're at
> work now. But I did the change, by commenting out the call to
> eighty_ninety_three() in piix.c, and my disks came back to 54 MB/s each,
> and 64 MB/s cumulated. dmesg showed UDMA33 before and now displays UDMA100
> again. But I obviously cannot let it like that because if I install this
> kernel in a 40-pin machine, I will get some surprizes !

This is eighty_ninty_three() in 2.6.x (except #if 0 (...) #endif code):

u8 eighty_ninty_three (ide_drive_t *drive)
{
	return ((u8) ((HWIF(drive)->udma_four) &&
#ifndef CONFIG_IDEDMA_IVB
			(drive->id->hw_config & 0x4000) &&
#endif /* CONFIG_IDEDMA_IVB */
			(drive->id->hw_config & 0x6000)) ? 1 : 0);
#endif
}

Maybe you have accidentally enabled CONFIG_IDEDMA_IVB?
If not please send me copy of /proc/ide/hdX/identify for your drives.

--bart

