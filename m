Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbTBUVSU>; Fri, 21 Feb 2003 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBUVSU>; Fri, 21 Feb 2003 16:18:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:57071 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267710AbTBUVST>;
	Fri, 21 Feb 2003 16:18:19 -0500
Date: Fri, 21 Feb 2003 13:25:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: piggin@cyberone.com.au, wli@holomorphy.com, david.lang@digitalinsight.com,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-Id: <20030221132549.14fac60d.akpm@digeo.com>
In-Reply-To: <20030221114143.GS31480@x30.school.suse.de>
References: <20030220212304.4712fee9.akpm@digeo.com>
	<Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com>
	<20030221001624.278ef232.akpm@digeo.com>
	<20030221103140.GN31480@x30.school.suse.de>
	<20030221105146.GA10411@holomorphy.com>
	<20030221110807.GQ31480@x30.school.suse.de>
	<3E560AE3.8030309@cyberone.com.au>
	<20030221114143.GS31480@x30.school.suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 21:28:20.0651 (UTC) FILETIME=[2803C7B0:01C2D9F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I don't
> buy Andrew complaining about the write throttling when he still allows
> several dozen mbytes of ram in flight and invisible to the VM,

The 2.5 VM accounts for these pages (/proc/meminfo:Writeback) and throttling
decisions are made upon the sum of dirty+writeback pages.

The 2.5 VFS limits the amount of dirty+writeback memory, not just the amount
of dirty memory.

Throttling in both write() and the page allocator is fully decoupled from the
queue size.  An 8192-slot (4 gigabyte) queue on a 32M machine has been
tested.

The only tasks which block in get_request_wait() are the ones which we want
to block there: heavy writers.

Page reclaim will never block page allocators in get_request_wait().  That
causes terrible latency if the writer is still active.

Page reclaim will never block a page-allocating process on I/O against a
particular disk block.  Allocators are instead throttled against _any_ write
I/O completion.  (This is broken in several ways, but it works well enough to
leave it alone I think).

