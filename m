Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265494AbRGHBEe>; Sat, 7 Jul 2001 21:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGHBEZ>; Sat, 7 Jul 2001 21:04:25 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:42894 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265494AbRGHBEO>; Sat, 7 Jul 2001 21:04:14 -0400
Message-ID: <3B47B1DC.3B7C387C@uow.edu.au>
Date: Sun, 08 Jul 2001 11:05:32 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ext3-users@redhat.com
CC: lkml <linux-kernel@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@clusterfilesystem.com>
Subject: Re: ext3-2.4-0.9.0
In-Reply-To: message from Andrew Morton on Saturday July 7,
		<3B45D6DB.70B9D754@uow.edu.au> <15175.35317.985921.670835@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Saturday July 7, andrewm@uow.edu.au wrote:
> > An update of the ext3 journalling filesystem for 2.4 kernels
> > is available at
> >
> >       http://www.uow.edu.au/~andrewm/linux/ext3/
> >
> > Patches are against 2.4.6-ac1 and 2.4.6.
> 
> I thought it was time to try out ext3 between nfsd and raid5, so I
> built 2.4.6  plus this patch, and an ext3 filesystem on a largish
> raid5 volume, exported it (with the "sync" flag), mounted it from
> another machines with NFSv2, and ran "dbench 4".
> 
> This produces a live-lock (I think that it the right term).
> Throughput would drop to zero (determined by watching the counts in
> /proc/nfs/rpc/nfsd), but could be coaxed along by generating other
> filesystem activity.
> 
> I tried nfs over ext3 on a plain ide disc and it worked fine.
> I tried dbench directly on ext3/raid5 and it worked fine.
> I tried dbench/nfs/ext2/raid5 and it worked fine.
> 
> So I think it is some interaction between ext3fs and raid5 triggered
> by the high rate of "fsync" calls made by nfsd.  Naturally I blame
> ext3 because I know more about raid5 and nfsd :-)

fsync will cause ext3 to commit the current transaction once all
handles against it close - so that will produce rapid bursts
of small numbers of writes.

> One particular aspect of raid5 that *could* be related is that it is
> very reticent to schedule write requests. It tries to hang on the them
> as long as possible in the hope of getting more write requests in the
> same stripe.  My guess as to what is happening is that as write
> request is submitted and then waited-for without an intervening
>                 run_task_queue(&tq_disk);

Could well be.  ext3 will happily feed 2,000 buffers into submit_bh()
prior to running tq_disk.  Everything else is happy with this, so I blame
nfsd and raid5 :)  Rapid fsyncs will break this up, however.

Does this patch help?

--- fs/jbd/commit.c	2001/07/01 04:24:42	1.40
+++ fs/jbd/commit.c	2001/07/08 00:53:42
@@ -202,6 +202,7 @@
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);
 			ll_rw_block(WRITE, bufs, wbuf);
+			run_task_queue(&tq_disk);
 			lock_journal(journal);
 			journal_brelse_array(wbuf, bufs);
 			goto write_out_data;
@@ -410,6 +411,7 @@
 				bh->b_end_io = end_buffer_io_sync;
 				submit_bh(WRITE, bh);
 			}
+			run_task_queue(&tq_disk);
 			lock_journal(journal);
 
 			/* Force a new descriptor to be generated next

> When the system is livelocked, all I can tell at the moment (I am at
> home and the console is at work so I cannot use alt-sysrq) is that
> kjournal is waiting in wait_on_buffer and an nfsd thread is waiting on
> the journal.

That sounds like Something Wierd is going on.  wait_on_buffer will
unplug and the disks should be going hell-for-leather.

> I will try to explore it more deeply next time I am at work, but if
> there are any suggestions as to what it might be, or how I might more
> easily find out what is going on, I am all ears.
> 

I'll see if I can get it to happen here.  Thanks.

-
