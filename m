Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGMGPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGMGPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 02:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGMGPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 02:15:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:64729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264609AbUGMGP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 02:15:27 -0400
Date: Mon, 12 Jul 2004 23:14:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: devenyga@mcmaster.ca, ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: Preempt Threshold Measurements
Message-Id: <20040712231406.427caa2a.akpm@osdl.org>
In-Reply-To: <cone.1089697919.186986.12958.502@pc.kolivas.org>
References: <200407121943.25196.devenyga@mcmaster.ca>
	<20040713024051.GQ21066@holomorphy.com>
	<200407122248.50377.devenyga@mcmaster.ca>
	<cone.1089687290.911943.12958.502@pc.kolivas.org>
	<20040712210107.1945ac34.akpm@osdl.org>
	<cone.1089697919.186986.12958.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Andrew Morton writes:
> 
> > Con Kolivas <kernel@kolivas.org> wrote:
> >> Certainly the do_munmap and exit_mmap seem to be repeat offenders on my 
> >> machine too (more the latter in my case).
> >> 
> > 
> > This is a false positive.  Nothing is setting need_resched(), so
> > unmap_vmas() doesn't bother dropping the lock.
> 
> Ok well excluding do_munmap and exit_mmap the ones that have shown up 
> (some more frequently than others) are: 
> 
> 6ms at ksoftirqd+0x6b

Dunno.  There's an unresolved RCU dentry reaping problem, but that's
unlikely to occur within ksoftirqd context.

> 2ms at sys_ioctl+0x47

uses lock_kernel() at the top level.  Need to know the call trace to work
out who the offender is.  rtc-debug+amlat will tell you that, because it
catches the CPU hog while it's being hoggy, rather than after it has
finished.

> 2ms at b44_open

Lots of udelays() inside spin_lock_irq().  This is a "don't do that", I
suspect.

> 6ms at fget+0x28

Would need to see the amlat trace.

> 2ms at write_ordered_buffers+0x37

reiserfs

> 4ms at blkdev_put+0x48

This can run under one of two depths of lock_kernel.  filemap_fdatawrite()
and filemap_fdatawait() both do cond_resched(), so this is odd.

Try this:

--- 25/mm/truncate.c~truncate_inode_pages-latency-fix	2004-07-12 23:12:53.871816320 -0700
+++ 25-akpm/mm/truncate.c	2004-07-12 23:13:00.993733624 -0700
@@ -155,6 +155,7 @@ void truncate_inode_pages(struct address
 
 	next = start;
 	for ( ; ; ) {
+		cond_resched();
 		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 			if (next == start)
 				break;
_

> 5ms at add_wait_queue+0x21

Need to see the whole trace.

> Now which of the above are not false positives and should I try to extract 
> the exact locations of them?

You'll get better traces from

http://www.zip.com.au/~akpm/linux/patches/stuff/rtc-debug.patch
and
http://www.zip.com.au/~akpm/linux/amlat.tar.gz

Just apply rtc-debug, set CONFIG_RTC=y and run `amlat' as root while doing
testing.

