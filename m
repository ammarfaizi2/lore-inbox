Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVEPNDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVEPNDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVEPNDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:03:40 -0400
Received: from alog0701.analogic.com ([208.224.223.238]:63109 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261605AbVEPNDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:03:09 -0400
Date: Mon, 16 May 2005 09:01:33 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Mark Lord <lkml@rtr.ca>
cc: Denis Vlasenko <vda@ilport.com.ua>, mhw@wittsend.com,
       linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
In-Reply-To: <4287E807.6070502@rtr.ca>
Message-ID: <Pine.LNX.4.61.0505160859450.18210@chaos.analogic.com>
References: <1116001207.5239.38.camel@localhost.localdomain>
 <200505152200.26432.vda@ilport.com.ua> <4287E807.6070502@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005, Mark Lord wrote:

> All flashcards (other than dumb "smart media" cards) have integrated
> NAND controllers which perform automatic page/block remapping and
> which implement various wear-leveling algorithms.  Rewriting "Sector 0"
> 10000 times probably only writes once to the first sector of a 1GB card.
> The other writes are spread around the rest of the card, and remapped
> logically by the integrated controller.
>
> Linux could be more clever about it all, though.  Wear-leveling can only
> be done efficiently on "unused" or "rewritten" blocks/pages on the cards,
> and not so well with areas that hold large static data files (from the point
> of view of the flash controller, not the O/S).
>
> If we were really clever about it, then when Linux deletes a file from a
> flashcard device, it would also issue CFA ERASE commands for the newly
> freed sectors.  This would let the card's controller know that it can
> remap/reuse that area of the card as it sees fit.
>
> But it's dubious that a *short term* use (minutes/hours) of O_SYNC
> would have killed a new 1GB card.
>
> Cheers


CompactFlash(tm) like Sandisk and PNY do not write directly
to the 'flash' part of the device. Instead, the page-oriented
structure, copies the contents of the current page into
static RAM. It is only when the page gets changed that the
contents of static RAM get written before the actual page-
change occurs. The write to flash-RAM is preceded by an
erase, which sets all bits, because the flash-RAM bits can
only be reset by writing.

These flash-RAM devices are designed to emulate IDE/ATA
disk drives so no special software is required except that
the software must not fail when the flash-RAM device doesn't
respond to a "hardware" command. Some versions of Linux
issue large amounts of error messages when accessing these
devices. Other versions have very long, annoying, time-outs.
Nevertheless, all Linux versions I have tried in resent times
will work once the initialization process that occurs during
boot is over.

We have systems that mount these CompactFlash(tm) devices
R/W, without denying ATIME, and have not had any field failures.
Recent design reviews have required that we mount these NOATIME,
but it was only a guess that there may be problems many years
into the future.

Regular NAND flash-RAM, installed on PC/Boards have been written
many more times than the 100k guarantee. The first observation
of a "wearing" mechanism is that the erase-cycle for programming
takes a shorter time. This means that it takes less time to
program the flash-RAM than it did when it was new. NAND flash-RAM
fails in an interesting way. Some bits that were low, slowly drift
high. This means that sometimes it will be read correctly and
sometimes not. With failed NAND flash-RAM, the erase-cycle becomes
very short. It will still program okay, but in a few days
one will have problems consistently reading correct data.

Therefore, I believe that the end-of-life could be determined
if the manufacturer just published end-of-life erase times.

The original poster did not tell how the flash-RAM fails in
his system. If he did not encounter the wear-out mechanism
I described it is likely that there is an electrical problem
that is killing his flash-RAM.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
