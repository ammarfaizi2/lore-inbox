Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbTCNMjt>; Fri, 14 Mar 2003 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbTCNMjt>; Fri, 14 Mar 2003 07:39:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:4852 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262988AbTCNMjs>;
	Fri, 14 Mar 2003 07:39:48 -0500
Date: Fri, 14 Mar 2003 04:50:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Message-Id: <20030314045029.2f05eeb5.akpm@digeo.com>
In-Reply-To: <20030314090825.GB1375@dualathlon.random>
References: <20030314090825.GB1375@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 12:50:29.0594 (UTC) FILETIME=[4AE57BA0:01C2EA28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Only in 2.4.21pre5aa1: 00_clean-inode-fix-1
> 
> 	Reset r_dev.

oops.  What problem was this observed to cause btw?

> Only in 2.4.21pre5aa1: 00_smp-timers-not-deadlocking-1
> 
> 	Corrected varsion of the smp timers that can deadlock in 2.5
> 	and in all kernels that were used to incorporate this patch,
> 	including jam.

OK, I'll take a look at that thanks.

> 	This is fixed so that a timer reinserting
> 	itself to run immediate, won't loop forever deadlocking
> 	a CPU spinning in a tight loop. This bug was present in
> 	ancient 2.4 kernels too and this is been fixed after bugreports
> 	in both 2.2 and again in 2.4 because we forgotten to forward
> 	port it to 2.4, these fixes must be forward ported today
> 	to 2.5 too. Fixed also run_all_timers to correctly convert
> 	the logical to physical cpu id (doesn't matter on x86, but
> 	run_all_timers doesn't matter either on x86, other archs
> 	may need this fix to avoid crashing too). This patch
> 	was originally written from Ingo Molnar, David Miller with the help of
> 	Alexey Kuznetsov, for more details see the timer.c added credit lines.

This code is buggy.  See

http://linux.bkbits.net:8080/linux-2.5/user=akpm/cset@1.786.202.5?nav=!-|index.html|stats|!+|index.html|ChangeSet@-6M


> Only in 2.4.21pre5aa1: 9999_fsync-msync-async-errors-1
> 
> 	Allow userspace to always be notified about async write failures
> 	when calling msync and fsync even if they happened long before
> 	the systemcall run.

The code in shrink_cache() has a couple of problems.

a) If someone else is truncating the file at the same time,
   block_write_full_page() will see the page is outside i_size and will
   return -EIO.  That will be propagated into the address_space and
   userspace will see a bogus I/O error.

   Fix: just return zero from writepage-outside-i_size.  There are several
   instances.

b) Can't touch `mapping' after calling writepage().  The page can now be
   unlocked, truncated off the inode and the inode could be freed up.

   No, I don't have a testcase ;)

   The fix is to lock the page again, see if it still has a ->mapping,
   then set mapping->error.


