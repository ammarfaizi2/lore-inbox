Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312690AbSDAXRL>; Mon, 1 Apr 2002 18:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSDAXQw>; Mon, 1 Apr 2002 18:16:52 -0500
Received: from air-2.osdl.org ([65.201.151.6]:3599 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312690AbSDAXQj>;
	Mon, 1 Apr 2002 18:16:39 -0500
Date: Mon, 1 Apr 2002 15:14:34 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Questions about /proc/stat
In-Reply-To: <Pine.LNX.4.33.0203280908530.1795-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.33L2.0204011441230.13412-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, M. Edward (Ed) Borasky wrote:

| I have some questions about the "page" and "swap" entries in /proc/stat.
| Here is the relevant code from 2.4.12
| /usr/src/linux/fs/proc/proc_misc.c:
|
|     292         len += sprintf(page + len,
|     293                 "page %u %u\n"
|     294                 "swap %u %u\n"
|     295                 "intr %u",
|     296                         kstat.pgpgin >> 1,
|     297                         kstat.pgpgout >> 1,
|     298                         kstat.pswpin,
|     299                         kstat.pswpout,
|     300                         sum
|     301         );

Of course the basic answer is something like
  Try cscope
or
  cd /usr/src/linux
  grep -r "kstat.p" * | more

Using the latter one:

| 1. Why are kstat.pgpgin and kstat.pgpgout shifted right / halved?

I had wondered that also, so you made me look.

pgpgin and pgpgout are maintained (counted) in units of 512-byte
blocks but displayed in /proc/stat in 1 KB (KiB :) blocks by
shifting right by 1.

| 2. Are the "page" and "swap" numbers mutually exclusive? That is, if a
| page is brought in from swap and counted in kstat.pswpin, is it also
| counted in kstat.pgpgin? I found the places in the code where the counts
| are incremented, but I couldn't tell if the swapin routine calls the
| block driver or not.

No, "page" and "swap" counts are not mutually exclusive.
Both paths call submit_bh().

For swap:

mm/page_io.c::rw_swap_page_base():
	/* reads or writes a swap page */
	kstat.pswpin++;
	kstat.pswpout++;
	calls brw_page();
		which calls submit_bh();

For all low-level block I/O:

drivers/block/ll_rw_blk.c::ll_rw_block():
	/* low-level access to block devices */
	calls submit_bh();

drivers/block/ll_rw_blk.c::submit_bh():
	count := is number of 512-byte blocks;
	kstat.pgpgout += count;
	kstat.pgpgin += count;
	calls generic_make_request();

-- 
~Randy

