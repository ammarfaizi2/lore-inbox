Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUGMIEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUGMIEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGMIEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:04:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60391 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264503AbUGMIDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:03:39 -0400
Subject: Re: Preempt Threshold Measurements
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, devenyga@mcmaster.ca, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
In-Reply-To: <20040712231406.427caa2a.akpm@osdl.org>
References: <200407121943.25196.devenyga@mcmaster.ca>
	 <20040713024051.GQ21066@holomorphy.com>
	 <200407122248.50377.devenyga@mcmaster.ca>
	 <cone.1089687290.911943.12958.502@pc.kolivas.org>
	 <20040712210107.1945ac34.akpm@osdl.org>
	 <cone.1089697919.186986.12958.502@pc.kolivas.org>
	 <20040712231406.427caa2a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089705827.20381.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 04:03:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 02:14, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > Andrew Morton writes:
> > 
> > > Con Kolivas <kernel@kolivas.org> wrote:
> > >> Certainly the do_munmap and exit_mmap seem to be repeat offenders on my 
> > >> machine too (more the latter in my case).
> > >> 
> > > 
> > > This is a false positive.  Nothing is setting need_resched(), so
> > > unmap_vmas() doesn't bother dropping the lock.
> > 
> > Ok well excluding do_munmap and exit_mmap the ones that have shown up 
> > (some more frequently than others) are: 
> > 
> > 6ms at ksoftirqd+0x6b
> 
> Dunno.  There's an unresolved RCU dentry reaping problem, but that's
> unlikely to occur within ksoftirqd context.
> 
> > 2ms at sys_ioctl+0x47
> 
> uses lock_kernel() at the top level.  Need to know the call trace to work
> out who the offender is.  rtc-debug+amlat will tell you that, because it
> catches the CPU hog while it's being hoggy, rather than after it has
> finished.
> 
> > 2ms at b44_open
> 
> Lots of udelays() inside spin_lock_irq().  This is a "don't do that", I
> suspect.
> 
> > 6ms at fget+0x28
> 
> Would need to see the amlat trace.
> 
> > 2ms at write_ordered_buffers+0x37
> 
> reiserfs
> 
> > 4ms at blkdev_put+0x48
> 
> This can run under one of two depths of lock_kernel.  filemap_fdatawrite()
> and filemap_fdatawait() both do cond_resched(), so this is odd.
> 

Reiserfs uses lock_kernel heavily, could this be related?

./include/linux/reiserfs_fs.h:/* Right now we are still falling back to (un)lock_kernel, but eventually that
./include/linux/reiserfs_fs.h:#define reiserfs_write_lock( sb ) lock_kernel()
./include/linux/reiserfs_fs.h:#define reiserfs_write_unlock( sb ) unlock_kernel()

Lee

