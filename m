Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbTCKWxh>; Tue, 11 Mar 2003 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCKWxh>; Tue, 11 Mar 2003 17:53:37 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:59275 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261648AbTCKWxg>; Tue, 11 Mar 2003 17:53:36 -0500
Message-ID: <3E6E6B81.4E7CD256@attbi.com>
Date: Tue, 11 Mar 2003 18:04:33 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.64bk4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] self tuning scheduler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

I made a bit of progress on understanding the irman problem with 
my scheduler change.  When I run irman and top, the processes end
up with priorities like:

	irman parent	36
	irman child	21
	process_child	31-33   (group of 9 processes)

Since I expanded the range of priorities (to 0-79) these are quite
favorable priorities.  They are all have MAX_SLEEP_AVG bonus
equivelent of nice +10.

It's a priority inversion problem.  The irman child is waiting for
a read.  The process_child processes are happly running as a group
at approximately the same priority.  The irman parent is starved
because it is at a lower priority.  It is at a lower priority because
it uses more cpu on each pass.  It is doing the gettimeofday calls
while the child only does the pipe read & write.  The parent gets
an occasional boost from the fairness_update() code so it doesn't 
totally starve.

I'm contemplating making synchronous wakeups share the run_avg between
the processes so that groups of cooperating processes would clump
at the same priority.

I also wonder about trying to detect cycles of synchronous wakeups.
It seems that a group of processes passing a token should be treated as
compute bound.

I'm still playing with the "make -j 30".  I can adjust the priority
range where I start enforcing interactive behavior.  I may wire it
into the rq->prio_avg.  I assume that you can tolerate a bit more
timing jitter when doing a "make -j 30".

Jim Houston - Concurrent Computer Corp.
