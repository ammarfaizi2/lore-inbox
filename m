Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268476AbTBWO7J>; Sun, 23 Feb 2003 09:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268477AbTBWO7J>; Sun, 23 Feb 2003 09:59:09 -0500
Received: from [195.223.140.107] ([195.223.140.107]:15750 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268476AbTBWO7I>;
	Sun, 23 Feb 2003 09:59:08 -0500
Date: Sun, 23 Feb 2003 16:09:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: piggin@cyberone.com.au, wli@holomorphy.com, david.lang@digitalinsight.com,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030223150937.GA29467@dualathlon.random>
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de> <20030221105146.GA10411@holomorphy.com> <20030221110807.GQ31480@x30.school.suse.de> <3E560AE3.8030309@cyberone.com.au> <20030221114143.GS31480@x30.school.suse.de> <20030221132549.14fac60d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221132549.14fac60d.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 01:25:49PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I don't
> > buy Andrew complaining about the write throttling when he still allows
> > several dozen mbytes of ram in flight and invisible to the VM,
> 
> The 2.5 VM accounts for these pages (/proc/meminfo:Writeback) and throttling
> decisions are made upon the sum of dirty+writeback pages.
> 
> The 2.5 VFS limits the amount of dirty+writeback memory, not just the amount
> of dirty memory.
> 
> Throttling in both write() and the page allocator is fully decoupled from the
> queue size.  An 8192-slot (4 gigabyte) queue on a 32M machine has been
> tested.

the 32M case is probably fine with it, you moved the limit of in-flight
I/O in the writeback layer, and the write throttling will limit the
amount of ram in flight to 16M or so. I would be much more interesting
to see some latency benchmark on a 8G machine with 4G simultaneously
locked in the I/O queue. a 4G queue on a IDE disk can only waste lots of
cpu and memory resources, increasing the latency too, without providing
any benefit. Your 4G queue thing provides only disavantages as far as I
can tell.

> 
> The only tasks which block in get_request_wait() are the ones which we want
> to block there: heavy writers.
> 
> Page reclaim will never block page allocators in get_request_wait().  That
> causes terrible latency if the writer is still active.
> 
> Page reclaim will never block a page-allocating process on I/O against a
> particular disk block.  Allocators are instead throttled against _any_ write
> I/O completion.  (This is broken in several ways, but it works well enough to
> leave it alone I think).

2.4 on desktop boxes could fill all ram with locked and dirty stuff
because of the excessive size of the queue, so any comparison with 2.4
in terms of page reclaim should be repeated on 2.4.21pre4aa3 IMHO, where
the VM has a chance not to find the machine in collapsed state where the
only thing it can do is to either wait or panic(), feel free to choose
what you prefer.

Andrea
