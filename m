Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271928AbRIVSk3>; Sat, 22 Sep 2001 14:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271931AbRIVSkT>; Sat, 22 Sep 2001 14:40:19 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:21498 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S271928AbRIVSkH>;
	Sat, 22 Sep 2001 14:40:07 -0400
Date: Sun, 23 Sep 2001 02:38:36 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems,
 kupdated bugfixes
In-Reply-To: <20010921152627.C13862@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.30.0109230226210.25332-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Matthias Andree wrote:

> On Thu, 20 Sep 2001, Beau Kuiper wrote:
>
> > Patch 3
> >
> > This patch was generated as I was exploring the buffer cache, wondering
> > why reiserfs was so slow on 2.4. I found that kupdated may write buffers
> > that are not actually old back to disk. Eg
> >
> > Imagine that there are 20 dirty buffers. 16 of them are more that 30
> > seconds old (and should be written back), but the other 4 are younger than
> > 30 seconds. The current code would force all 20 out to disk, interrupting
> > programs still using the young 4 until the disk write was complete.
> >
> > I know that it isn't a major problem, but I found it and I have written
> > the patch for it :-)
>
> Be careful! MTAs rely on this behaviour on fsync(). The official
> consensus on ReiserFS and ext3 on current Linux 2.4.x kernels (x >= 9)
> is that "any synchronous operation flushes all pending operations", and
> if that is changed, you MUST make sure that the changed ReiserFS/ext3fs
> still make all the guarantees that softupdated BSD file systems make,
> lest you want people to run their mail queues off "sync" disks.

This code change does not affect the functionality of fsync(), only
kupdated. kupdated is responsible for flushing buffers that have been
sitting around too long to disk.

>
> Note also, if these blocks belong to newly-opened files, you definitely
> want kupdated to flush these to disk on its next run so that the files
> are still there after a crash.

They still are (they would be flushed out by the sync_inodes call in
sync_old_buffers. But why are the file records for any new file more
important than changes to old files? (This is what an application can
determince, the kernel should just do what the app says, and treat
everything else fairly)

>
> I'm not exactly sure what your patch 3 does and how the buffers work,
> but I'm absolutely sure we want the "fsync on an open file also syncs
> all pending rename/link/open operations the corresponding file has
> undergone."

That still works.

>
> Softupdates FFS (BSD) does that, and ReiserFS/ext3fs also do that by
> just flushing all pending operations on a synchronous one, and it's not
> slow.
>

But this isn't about sync operations, it is about kupdated (a kernel
thread)

> This may cause additional writes, but the reliability issues must be
> taken into account here. We don't gain anything if files get lost over a
> crash just because you want to save 4 writes.
>

We never gain everything in a crash. We have to set limits to the amount
of damage we can accept, and try to keep within that limit. However,
performace is another critical limit. The four writes could consume
a lot of time, and be invalidated by changes the application could
make (and written out AGAIN)

For example, given a fast hard drive, with 2 writes on one side of the
driver and the other 2 on the other side, the application could be stalled
for

	15ms for first seek and write
	8ms for second seek and write
	15ms to seek and write the 3rd buffer
	8ms for the fourth write.

Umm, 46 ms. Do this often (if you are extremely unlucky) and you could
chew through a lot of time where it would have been more sane just to sit
back and let the application finish with the file.

Beau Kuiper
kuib-kl@ljbc.wa.edu.au



