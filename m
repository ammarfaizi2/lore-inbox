Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129891AbQKNMz3>; Tue, 14 Nov 2000 07:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbQKNMzU>; Tue, 14 Nov 2000 07:55:20 -0500
Received: from hermes.mixx.net ([212.84.196.2]:32520 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129891AbQKNMzH>;
	Tue, 14 Nov 2000 07:55:07 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: blocks read/written counters
Date: Tue, 14 Nov 2000 13:25:09 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A112F25.D3A22B31@innominate.de>
In-Reply-To: <200011132031.OAA15635@kenobi.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974204705 8319 10.0.0.90 (14 Nov 2000 12:25:05 GMT)
X-Complaints-To: news@innominate.de
To: Marlys Kohnke <kohnke@sgi.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marlys Kohnke wrote:
> 
>      As part of the new resource counters I'm adding for our job
> accounting feature, I'm trying to gather blocks read and written
> on a per task basis (which will get rolled into a per job statistic
> outside of the kernel).  I added task struct counters which get
> incremented in drivers/block/ll_rw_blk.c in the drive_stat_acct() procedure,
> which is where the kernel stats are gathered for blocks read/written.
> 
>      What I noticed, though, was that some system daemons would be
> the current task when going through drive_stat_acct() for writes, but
> usually it was kupdate.  In doing some searching, I now see that kupdate
> is the kernel thread responsible to flush the dirty buffers out to disk.
> I need to capture this blocks read/written information for user
> processes, not kupdate.
> 
>      We were able to get this block info on the Cray systems (which
> have separate direct IO and buffered IO) and somewhat on the IRIX
> systems (where whichever process is running when the buffers get flushed
> is the process which gets charged for those buffers).  Apparently, this
> information is useful for capacity planning and in cache thrashing
> situations.  It's not used for billing purposes.
> 
>      Is there a reasonable way on Linux to get any blocks read and
> written information on a per task basis?  Thanks for any help.

In general it is impossible to assign all block read/writes to
particular tasks because many tasks may use the same block.  Maybe you
want to track block requests instead?  These happen in the task context,
but the paths are scattered.  Metadata is generally read using
ll_rw_block but written using mark_buffer_dirty (and the actual write
will be initiated by kflush or kupdate later).  Sometimes ll_rw_block is
used for writing, usually for synchronous operations.  The paths for
page cache data - most of your data - are even more scattered.  To track
then down, look for _find_page and variants.

Reads are associated pretty closely in time with the requesting process
but writes are not, so charging the transfers to the most recent
userspace task might be ok for reads - it doesn't work very well at all
for writes.

It doesn't sound very promising, does it?  You might consider tracking
block transfers by inode (easy for data, harder for metadata) and moving
the counts into per-task totals on file close.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
