Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135908AbRDZUEf>; Thu, 26 Apr 2001 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135905AbRDZUEZ>; Thu, 26 Apr 2001 16:04:25 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:22610 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S135477AbRDZUES>; Thu, 26 Apr 2001 16:04:18 -0400
Date: Thu, 26 Apr 2001 20:48:26 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
Reply-To: Bjorn Wesen <bjorn@sparta.lu.se>
To: Padraig Brady <padraig@antefacto.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE879AE.387D3B78@antefacto.com>
Message-ID: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Padraig Brady wrote:
> I'm working on an embedded system here which has no harddisk.
> So, I can't swap to disk and need to have /var & /tmp in RAM.
> I'm confused between the various options for in RAM file-
> systems. At the moment I've created a ramdisk and made an 
> ext2 partition in it (which is compressed as I applied the 
> e2compr patch), which is working fine. Anyway questions:

Ouch.. yes you had to do stuff like that in the old days but it's very 
cumbersome and inefficient compared to ramfs for what you're trying to do.

> 1. I presume the kernel is clever enough to not cache any
>    files from these filesystems? Would it ever need to?

You always need to "cache" pages read. Because a page is the smallest
possible granularity for the MMU, and a block-based filesystem does not
need to be page-aligned, so it's impossible to do it otherwise in a
general way.

> 3. If I've no backing store (harddisk?) is there any advantage 
>    of using tmpfs instead of ramfs? Also does tmpfs need a 
>    backing store?

I don't know what tmpfs does actually, but if it is like you suggest (a
ramfs that can be swapped out ?) then you don't need it obviously (since
you don't have any swap).

ramfs simply inserts any files written into the kernels cache and tells it
not to forget it. it can't get much more simple than that.

> 5. Can you set size limits on ramfs/tmpfs/memfs?

i don't think you can set a limit in the current ramfs implementation but
it would not be particularly difficult to make it work I think

> 6. Is a ramdisk resizable like the others. If so, do you have
>    to delete/recreate or umount/resize a fs (e.g. ext2) every
>    time it's resized? Do ramfs/tmpfs/memfs do this transparently?
>    Are ramdisks resizable in kernel 2.2?

ramfs does not need any "resizing" because there is no filesystem behind
it. there is only the actual file data and metadata in the cache itself.
if you delete a file, it disapperas, if you create a new one new pages are
brought in.

> 7. What's memfs?
> 8. Is there a way I can get transparent compression like I now
>    have using a ramdisk+ext2+e2compr with ramfs et al?

you could try using jffs2 on a RAM-simulated MTD partition. i think that
would work but i have not tried it..

> 9. Apart from this transparent compression, is there any other
>    functionality ext2 would have over ramfs for e.g, for /tmp
>    & /var? Also would ramfs have less/more speed over ext2?

ramfs has all the bells and whistles you need except size limiting. and
obviously its faster than simulating a harddisk in ram and using ext2 on
it.. 

-bw


