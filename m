Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272131AbTHHX6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 19:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTHHX6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 19:58:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:11922 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S272131AbTHHX6u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 19:58:50 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E19l8EM-0006R3-00@calista.inka.de>
References: <E19l8EM-0006R3-00@calista.inka.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1060387128.11983.34.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Sat, 09 Aug 2003 00:58:48 +0100
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Rcpt-To: ecki-lkm@lina.inka.de, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You didn't Cc me; there are 7240 unread messages in my linux-kernel
folder which are about to be read with the 'd' key... it's lucky I saw
your reply at all. Please don't drop recipients.

On Fri, 2003-08-08 at 15:28, Bernd Eckenfels wrote:
> In article <1060351312.25209.468.camel@passion.cambridge.redhat.com> you wrote:
> > The practice of using JFFS2 on CF (and other real block devices) isn't
> > really something I encourage, but it seems to have happened because
> > there isn't a 'real' block device based file system which is
> > powerfail-save, optimised for space and which uses compression. If
> > reiser4 can fill that gap, that would be pleasing to me.
> 
> Thanks for that great article, would you care to describe where the slowness
> of JFFS2 is coming from?

During mount, it comes from the fact that we need to find every single
log entry (node) in the file system. It's a purely log-structured file
system -- there is _no_ positional information; it's just a jumble of
log entries with version numbers to show ordering, and we need to find
them all and note which inode# they belong to.

We've already got about an order of magnitude improvement in mount time
from 2.4 to 2.5 by deferring much of the work (in particular crc32
checking on all those nodes) from the actual mount to later, and by
eliminating memcpy() into RAM of data on NOR flash where we can actually
just use pointers directly into flash instead.

The scan is still slow on NAND flash, which we can't directly
dereference and _have_ to copy from the flash to read it. As I said
elsewhere, it's about 30 seconds for a 30%-full 144MiB DiskOnChip
device. The fix for this, yet to be implemented, will be a 'tailer' at
the end of each flash eraseblock, containing all the information which
we would otherwise have to glean by scanning the whole of the eraseblock
looking for log entries. Then we just need to read the tailer from the
end of each block rather than reading the whole block.

In this way we trade off a small amount of space for a large improvement
in mount time. This seems like an eminently sensible tradeoff especially
given that it was the large size of these devices which caused the mount
time to become problematic in the first place -- there's room to spare.
It can also be a configurable option. For embedded devices which almost
never cold-boot and usually suspend to RAM instead, a very slow mount
isn't necessarily a show-stopper. 


Performance during runtime isn't often cited as a problem, but can also
be improved somewhat. Currently, our garbage collection is rather naïve;
it picks a 'victim' eraseblock, generally one of the 'dirtiest' (i.e.
containing the most log entries which are obsoleted by subsequent writes
elsewhere). It then proceeds to obsolete all the nodes in that
eraseblock which remain valid, by just writing out the same data
elsewhere -- at which point it can erase the 'victim' and add it back to
the free_list.

Garbage collection is most efficient when the 'victim' block in fact
contains almost no still-valid nodes, and can just about be deleted
straight away. It's at its least efficient when we pick a completely
clean block in which _all_ the nodes need to be copied elsewhere -- we
copy and entire eraseblock without making _any_ extra free space in that
case (we do it very occasionally for wear levelling purposes).

This garbage collection is generally done in the background thread,
which has some primitive heuristics to tell it how much space to keep
available. But it's also done just-in-time, if you either kill the GC
thread or if you're saturating the FS with writes and the GC thread
hasn't had time to keep making space for you before you needed it.

The problem here is that GC writes which obsolete nodes in the victim
eraseblock are mingled with the ongoing new writes driven from
userspace. So we tend to end up writing out new eraseblocks full of data
nodes which are half new and volatile data, and half old stuff which
almost never changes like libraries and binaries. The new stuff like
temporary datafiles tends to get changed, overwritten or deleted -- and
the old stuff tends not to. So (referring to the paragraph on GC
efficiency above) our behaviour is such that we tend to end up with none
of the mostly-dirty blocks which are most efficient to garbage-collect
from; instead we have blocks which are roughly half-clean and
half-dirty.

The proposed fix for this is to split writes into two ongoing streams
instead of the current one stream -- we write new data into one
eraseblock while we write GC'd data into another. That way, the old
stable data nodes tend to get grouped together into 100% clean blocks
which we can just ignore (until we decide to wear level them), and 100%
_dirty_ blocks which are nice and quick to GC.


I worry about the memory usage sometimes, and play some rather
disgusting tricks to keep it down -- but in practice that's more of an
issue for the eCos port of JFFS2 than Linux; Linux boxen generally have
enough memory that it's not a problem.

> Do you have experiences with XFS and ext3 (datajournal) filesystems in terms
> of power fail security?

No. I've been at the receiving end of an automated powerfail script
which has been stress-testing JFFS2 and forcibly power cycling the
device in question every few minutes -- which gave rise to all kinds of
interesting observations about flash behaviour under those
circumstances. But I'm not aware of similar tests being done on XFS or
ext3 with repeated power failure and integrity tests.

-- 
dwmw2


