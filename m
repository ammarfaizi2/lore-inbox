Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272445AbTHEFyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272446AbTHEFyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:54:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:50086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272445AbTHEFyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:54:21 -0400
Date: Mon, 4 Aug 2003 22:55:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: piggin@cyberone.com.au, wli@holomorphy.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O11int for interactivity
Message-Id: <20030804225532.494bfd31.akpm@osdl.org>
In-Reply-To: <200308050454.h754sBqM004950@turing-police.cc.vt.edu>
References: <200307301038.49869.kernel@kolivas.org>
	<20030802225513.GE32488@holomorphy.com>
	<200308030119.47474.m.c.p@wolk-project.de>
	<200308042106.51676.m.c.p@wolk-project.de>
	<20030804195335.GK32488@holomorphy.com>
	<3F2F00B0.9050804@cyberone.com.au>
	<20030805024103.GM32488@holomorphy.com>
	<3F2F1F80.7060207@cyberone.com.au>
	<20030805031341.GN32488@holomorphy.com>
	<3F2F231C.3030901@cyberone.com.au>
	<20030805033119.GO32488@holomorphy.com>
	<3F2F26BA.3060904@cyberone.com.au>
	<200308050454.h754sBqM004950@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> The *odd* part is that the pgpgin, pgpgout, and pswpin numbers do *NOT*
>  seem to be correlated.  High I/O loads from read/write don't seem to cause
>  a problem - untarring the Linux distro won't do it, running badblocks won't do it.
> 
>  But if somebody has to swap out, all hell breaks loose...

swapout tends to happen via page reclaim, whereas normal writeback does
not.

What's the difference?  When swapout is happening you can expect increased
latency in the page allocator.

My guess is that xmms is getting throttled in try_to_free_pages().

There is a very good argument for giving !SCHED_OTHER tasks "special
treatment" in the VM.  ie:

a) exempt them from balance_dirty_pages() throttling treatment altogether

b) let them dip further into the page reserves in __alloc_pages.

iirc, -aa kernels do some of this.  As does the Digeo kernel.  Just haven't
got around to it in 2.6.  It's pretty simple.

If xmms isn't running SCHED_FIFO/SCHED_RR, well, you lose.

The instrumentation to add is page allocation latency.


Another possibility is that xmms is getting stuck in a read.  The
anticipatory scheduler is currently rather tuned for throughput.  Judging
by the vmstat trace which was posted, we have a classic
read-stream-vs-write-stream going on.  We trade off latency versus
throughput; perhaps wrongly.  You can decrease latency (at the expense of
throughput) by decreasing the settings in /sys/block/hda/queue/iosched.

To a point, it is a nice linear tradeoff, and someone should put the time
in to tweak and characterise it.

