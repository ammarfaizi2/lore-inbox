Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274928AbTHFIkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274929AbTHFIkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:40:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:17384 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274928AbTHFIkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:40:16 -0400
Date: Wed, 6 Aug 2003 01:41:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       piggin@cyberone.com.au, kernel@kolivas.org, linux-mm@kvack.org
Subject: Re: [patch] real-time enhanced page allocator and throttling
Message-Id: <20030806014148.5408cfbd.akpm@osdl.org>
In-Reply-To: <1060142290.4494.197.camel@localhost>
References: <1060121638.4494.111.camel@localhost>
	<20030805170954.59385c78.akpm@osdl.org>
	<1060130368.4494.166.camel@localhost>
	<20030805174536.6cb5fbf0.akpm@osdl.org>
	<1060142290.4494.197.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> On Tue, 2003-08-05 at 17:45, Andrew Morton wrote:
> 
> > It's testing time.
> 
> Just via some instrumenting, I can see that a real-time task never
> begins throttling and this translates to a ~1ms reduction in worst case
> allocation on a fast machine latency under extreme page dirtying and
> writeback (basically, I cannot reproduce any variation in page
> allocation, now, for a real-time test app). So it works.
> 
> But I do not have any real world test to confirm a benefit, which is
> what matters. Have you poked and prodded?
> 

It's pretty easy to demonstrate the benefit of the balance_dirty_pages()
change.  Just do:

while true
do
	dd if=/dev/zero of=foo bs=1M count=512 conv=notrunc
done

and also:

rm 1 ; sleep 3; time dd if=/dev/zero of=1 bs=16M count=1

The 16M dd normally takes 1.5 seconds (I'm pretty please with that btw. 
Very repeatable and fair).  If you run the 16M dd with SCHED_FIFO it takes
a repeatable 0.12 seconds.

But it's pretty easy to make the machine do bad things with no dirty memory
throttling.  Probably we should just treat realtime tasks in the same way
as PF_LESS_THROTTLE tasks.


It's a bit harder to demonstrate benefits from the page allocator change. 
Allocate 4 megs while there is a huge amount of swapout happening is much
quicker and repeatable.  But generally things work pretty well with just
SCHED_OTHER.  Needs some more careful testing.

Often you get great big stalls because your SCHED_RR task is stuck in
ext3's journal_start, waiting for kjournald to finish a commit, due to an
atime update.  So noatime is needed there.  And then it gets stuck in a
disk read.

So running a program off disk isn't a very good test.

