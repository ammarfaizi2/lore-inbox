Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVBZW2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVBZW2A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 17:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVBZW2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 17:28:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:57023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261284AbVBZW15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 17:27:57 -0500
Date: Sat, 26 Feb 2005 14:28:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, Uwe Bonnes wrote:
> 
> Andrew,
> 
>     Andries> I think nobody uses such partitions seriously, but nevertheless
>     Andries> this should probably live in -mm for a while to see if anybody
>     Andries> complains.
> 
> the partition table of the USB stick in question is valid:
> 
>  1B0:  00 00 00 00 00 00 00 00   53 3F 3C B9 00 00 00 01 ........S?<.....
>  1C0:  01 00 06 10 21 7D 25 00   00 00 DB F3 01 00 00 00 ....!}%.........
>  1D0:  00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00 ................
>    *
>  1F0:  00 00 00 00 00 00 00 54   72 75 6D 70 4D 53 55 AA .......TrumpMSU.
> 
> Entry 1 is a FAT partition of exactly the size of the stick, and entries 2
> to 4 are empty, marked by id zero. However the manufacturer decided to put a
> name string  "Trump" ( /sbin/lsusb gives
> Bus 004 Device 012: ID 090a:1bc0 Trumpion Microelectronics, Inc.) just before
> the "55 AA" partition table magic and our code reads this string as a
> (bogus) size for the fourth entry, taking it for real.

Would it not make more sense to just sanity-check the size itself, and
throw it out if the partition size (plus start) is bigger than the disk
size?

We already do that within extended partitions, ie we do

	if (offs + size > this_size)
		continue;

to just ignore crap. For some reason we don't do this for the primary one 
(possibly because we don't trust disk size reporting, I guess).

There might well be people use use partition type 0, just because they
just never _set_ the partition type.. I don't think Linux has ever cared
about any type except for the "extended partition" type, so checking for 
zero doesn't seem very safe..

		Linus
