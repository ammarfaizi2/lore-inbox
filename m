Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318979AbSHFERW>; Tue, 6 Aug 2002 00:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSHFERV>; Tue, 6 Aug 2002 00:17:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318979AbSHFERV>;
	Tue, 6 Aug 2002 00:17:21 -0400
Message-ID: <3D4F50F7.2DE00276@zip.com.au>
Date: Mon, 05 Aug 2002 21:30:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
References: <1028232945.3147.99.camel@spc9.esa.lanl.gov> <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On 1 Aug 2002, Steven Cole wrote:
> 
> > Here are some dbench numbers, from the "for what it's worth" department.
> > This was done with SMP kernels, on a dual p3 box, SCSI disk, ext2.
> > The first column is dbench clients.  The numbers are throughput
> > in MB/sec.  The 2.5.29 kernel had a few RR-supplied smp fixes.
> > Looks like for this limited test, 2.4.19-rc5 holds up pretty well.
> > I've also ran this set of tests several times on -rc5 using ext3
> > and data=writeback, and everything looks fine.
> >
> > Steven
> 
> Call me an optimist, but after all the reliability problems we had win the
> 2.5 series, I sort of hoped it would be better in performance, not
> increasingly worse. Am I misreading this? Can we fall back to the faster
> 2.4 code :-(

IO in 2.5 is much more CPU efficient that in 2.4, and straight-line
bandwidth is better as well.

The scheduling of that IO has a few problems, so in wildly seeky loads
like dbench the kernel still falls over its own feet a bit.  The
two main culprits here are the lock_buffer() in block_write_full_page()
against the blockdev mapping, and the writeback of dirty pages from the
tail of the LRU in page reclaim.

And no, the eventual dbench numbers will not be a measure of the success
of the tuning which will happen on the run in to 2.6.  Dbench throughput
may well be lower, because we probably should be starting writeback
at lower dirty thresholds.

If you want good dbench numbers:

echo 70 > /proc/sys/vm/dirty_background_ratio
echo 75 > /proc/sys/vm/dirty_async_ratio
echo 80 > /proc/sys/vm/dirty_sync_ratio
echo 30000 > /proc/sys/vm/dirty_expire_centisecs
