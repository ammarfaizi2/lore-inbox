Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbRD0PXf>; Fri, 27 Apr 2001 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbRD0PX0>; Fri, 27 Apr 2001 11:23:26 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:59269 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S136088AbRD0PXQ>; Fri, 27 Apr 2001 11:23:16 -0400
Message-ID: <3AE99CE8.BD325F52@antefacto.com>
Date: Fri, 27 Apr 2001 17:23:04 +0100
From: Padraig Brady <padraig@antefacto.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the replies!

Would anyone have any objections to me writing a 
Documentation/ramdisks.txt or Documentation/filesystems/ram.txt
as this stuff is very hard to find info on?

Anyway seems like ramfs is the way to go with the limits patch
applied. I loose compression, but gain as there is no data
duplication in RAM, and also I don't need to preallocate space
for a partition. If I understand correctly ramfs just points
to the file data which are pages in the cache marked not to be
uncached. Doh! is ramfs supported in 2.2?

dwmw2 mentioned, for ramfs, it would be useful to compress unused
pages (to someplace in RAM would be very good for my application),
but I guess this would add a lot of complexity.

btw I get my initial root filesystem from a compact flash that
can be accessed just like a hardisk. It's writeable also like
a harddisk, but we boot with it readonly, and only mount it rw
if we want to save config or whatever. We definitely wouldn't
swap to it as it has limited erase/write cycles. The filesystem
is compressed ext2.

I don't have swap so don't need tmpfs, but could probably
use it anyway without a backing store? Anyway why was ramfs
created if tmpfs existed, unless tmpfs requires backing store?
They both seem to have been written around the same time?

As for using JFFS2 + MTD ramdisk intead of ext2+e2compr+ramdisk
is not an option as the only advantage would be journalling, you
still can't resize. IMHO JFFS is only required where you have
flash without an IDE interface.

cheers,
Padraig.


Bjorn Wesen wrote:
> 
> On Thu, 26 Apr 2001, Padraig Brady wrote:
> > I'm working on an embedded system here which has no harddisk.
> > So, I can't swap to disk and need to have /var & /tmp in RAM.
> > I'm confused between the various options for in RAM file-
> > systems. At the moment I've created a ramdisk and made an
> > ext2 partition in it (which is compressed as I applied the
> > e2compr patch), which is working fine. Anyway questions:
> 
> Ouch.. yes you had to do stuff like that in the old days but it's very
> cumbersome and inefficient compared to ramfs for what you're trying to do.
> 
> > 1. I presume the kernel is clever enough to not cache any
> >    files from these filesystems? Would it ever need to?
> 
> You always need to "cache" pages read. Because a page is the smallest
> possible granularity for the MMU, and a block-based filesystem does not
> need to be page-aligned, so it's impossible to do it otherwise in a
> general way.
> 
> > 3. If I've no backing store (harddisk?) is there any advantage
> >    of using tmpfs instead of ramfs? Also does tmpfs need a
> >    backing store?
> 
> I don't know what tmpfs does actually, but if it is like you suggest (a
> ramfs that can be swapped out ?) then you don't need it obviously (since
> you don't have any swap).
> 
> ramfs simply inserts any files written into the kernels cache and tells it
> not to forget it. it can't get much more simple than that.
> 
> > 5. Can you set size limits on ramfs/tmpfs/memfs?
> 
> i don't think you can set a limit in the current ramfs implementation but
> it would not be particularly difficult to make it work I think
> 
> > 6. Is a ramdisk resizable like the others. If so, do you have
> >    to delete/recreate or umount/resize a fs (e.g. ext2) every
> >    time it's resized? Do ramfs/tmpfs/memfs do this transparently?
> >    Are ramdisks resizable in kernel 2.2?
> 
> ramfs does not need any "resizing" because there is no filesystem behind
> it. there is only the actual file data and metadata in the cache itself.
> if you delete a file, it disapperas, if you create a new one new pages are
> brought in.
> 
> > 7. What's memfs?
> > 8. Is there a way I can get transparent compression like I now
> >    have using a ramdisk+ext2+e2compr with ramfs et al?
> 
> you could try using jffs2 on a RAM-simulated MTD partition. i think that
> would work but i have not tried it..
> 
> > 9. Apart from this transparent compression, is there any other
> >    functionality ext2 would have over ramfs for e.g, for /tmp
> >    & /var? Also would ramfs have less/more speed over ext2?
> 
> ramfs has all the bells and whistles you need except size limiting. and
> obviously its faster than simulating a harddisk in ram and using ext2 on
> it..
> 
> -bw
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
