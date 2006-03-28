Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWC1EaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWC1EaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWC1EaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:30:14 -0500
Received: from javad.com ([216.122.176.236]:53259 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751210AbWC1EaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:30:12 -0500
From: Sergei Organov <s.organov@javad.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>, <linux@horizon.com>,
       <kalin@thinrope.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Lifetime of flash memory
References: <20060326162100.9204.qmail@science.horizon.com>
	<4426C320.9010002@yandex.ru>
	<20060327161845.GA16775@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
Date: Tue, 28 Mar 2006 08:28:56 +0400
In-Reply-To: <Pine.LNX.4.61.0603271242100.16721@chaos.analogic.com>
	(linux-os@analogic.com's message of "Mon, 27 Mar 2006 12:44:50 -0500")
Message-ID: <87acbb6vlj.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
[...]
> CompactFlash(tm) like SanDisk(tm) has very good R/W characteristics.

Try to write 512-byte sectors in random order, and I'm sure write
characteristics won't be that good.

> It consists of a connector that exactly emulates an IDE drive connector
> in miniature, an interface controller that emulates and responds to
> most IDE commands, plus a method of performing reads and writes using
> static RAM buffers and permanent storage in NVRAM.

Are you sure they do have NVRAM? What kind of NVRAM? Do they have backup
battery inside to keep NVRAM alive?

[...]

> Note that the actual block size is usually 64k, not the 512 bytes of a
> 'sector'. Apparently, some of the data-space on each block is used for
> relocation and logical-to-physical mapping.

Wrong. AFAIK, first disks had FLASH with 512b blocks, then next
generation had 16K blocks, and currently most of cards have 128K
blocks. Besides, each page of a block (64 pages * 2K for 128K block) has
additional "system" area of 64 bytes. One thing that is in the system
area is bad block indicator (2 bytes) to mark some blocks as bad on
factory, and the rest could be used by application[1] the same way the
rest of the page is used. So physical block size is in fact 64 * (2048 +
64) = 135168 bytes.

Due to FLASH properties, it's a must to have ECC protection of the data
on FLASH, and AFAIK 22-bits ECC is stored for every 256 bytes of data,
so part of that extra memory on each page is apparently used for ECC
storage taking about 24 bytes out of those 64. I have no idea how the
rest of extra memory is used though.

BTW, the actual block size could be rather easily found from outside, --
just compare random access write speed against sequential write speed
using different number of 512b sectors as a write unit. Increase number
of sectors in a write unit until you get a jump in random access write
performance, -- that will give you the number of sectors in the block.

[1] By application here I mean the code that works inside the CF card
and deals with the FLASH directly. This memory is invisible from outside
of CF card.

-- Sergei.
