Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312720AbSDAXpE>; Mon, 1 Apr 2002 18:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312724AbSDAXoz>; Mon, 1 Apr 2002 18:44:55 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:11145 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312720AbSDAXoi>; Mon, 1 Apr 2002 18:44:38 -0500
Date: Mon, 1 Apr 2002 15:44:55 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Questions about /proc/stat
In-Reply-To: <Pine.LNX.4.33L2.0204011441230.13412-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0204011532060.4450-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Randy.Dunlap wrote:

> Of course the basic answer is something like
>   Try cscope

I can't find this -- does it come with Red Hat??

> or
>   cd /usr/src/linux
>   grep -r "kstat.p" * | more

This worked.

>
> Using the latter one:
>
> | 1. Why are kstat.pgpgin and kstat.pgpgout shifted right / halved?
>
> I had wondered that also, so you made me look.
>
> pgpgin and pgpgout are maintained (counted) in units of 512-byte
> blocks but displayed in /proc/stat in 1 KB (KiB :) blocks by shifting
> right by 1.

Yes ... that I managed to figure out. Seems strange that pgpgin/out are
in units of kilobytes and pswpin/out are in units of pages, though. Just
another little hole that needs plugging in the documentation.

> | 2. Are the "page" and "swap" numbers mutually exclusive? That is, if a
> | page is brought in from swap and counted in kstat.pswpin, is it also
> | counted in kstat.pgpgin? I found the places in the code where the counts
> | are incremented, but I couldn't tell if the swapin routine calls the
> | block driver or not.

> No, "page" and "swap" counts are not mutually exclusive.
> Both paths call submit_bh().
>
> For swap:
>
> mm/page_io.c::rw_swap_page_base():
> 	/* reads or writes a swap page */
> 	kstat.pswpin++;
> 	kstat.pswpout++;
> 	calls brw_page();
> 		which calls submit_bh();
>
> For all low-level block I/O:
>
> drivers/block/ll_rw_blk.c::ll_rw_block():
> 	/* low-level access to block devices */
> 	calls submit_bh();
>
> drivers/block/ll_rw_blk.c::submit_bh():
> 	count := is number of 512-byte blocks;
> 	kstat.pgpgout += count;
> 	kstat.pgpgin += count;
> 	calls generic_make_request();

Ah ... so every page to/from swap is counted in pswpin/out (as a page)
and again in pgpgin/out as half-kilobytes :-). Incidentally, I also
followed the third fork in this road, the one which derives the "blocks"
read and written per device that show up in /proc/stat. Those "blocks"
turn out to be 512 bytes long.

All of this is quite useful, actually, because I'm trying to make sense
of some high-frequency (every 15 seconds) samples of I/O data. Thanks!!

-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

How to Stop A Folksinger Cold # 4
"Tie me kangaroo down, sport..."
Tie your own kangaroo down -- and stop calling me "sport"!

