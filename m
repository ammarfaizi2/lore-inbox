Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273857AbRIRFsT>; Tue, 18 Sep 2001 01:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273861AbRIRFsK>; Tue, 18 Sep 2001 01:48:10 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:47882 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273857AbRIRFsH>; Tue, 18 Sep 2001 01:48:07 -0400
Message-ID: <3BA6E032.587A1DBF@zip.com.au>
Date: Mon, 17 Sep 2001 22:48:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Ok, the big thing here is continued merging, this time with Andrea.
> 

In one test here the VM changes seem fragile, and slower.

Dual x86, 512 megs RAM, 512 megs swap.  No highmem.

The workload is:

	while true
	do
		/usr/src/ext3/tools/usemem 300
	done

	(This just mallocs 300 megs, touches it then exits)

in parallel with

	time /usr/src/ext3/tools/bash-shared-mapping -n 5 -t 3 foo 300000000

on ext2.

(bash-shared-mapping is a tool which I wrote for ext3.  It's one of the
 most aggressive VM/MM stress testers around, and has found a number of
 kernel bugs).

On 2.4.9-ac10, the b-s-m run took 294 seconds.  On 2.4.10-pre11 it
took 330 seconds DESPITE the fact that one of the b-s-m instances
was oom-killed quite early in the test.

`vmstat' took about thirty seconds to start (this is usual), but
was promptly killed, despite having (presumably) a small RSS.  Instances
of `usemem' were oom-killed quite frequently.  In 2.4.9-ac10, nothing
was oom-killed.

With a gig of VM and a 600 meg working set I don't see why it's necessary
to kill processes?   Each oom-kill was associated with a 0-order allocation
failure.

These tools are available at http://www.uow.edu.au/~andrewm/ext3-tools.tar.gz

OK, so this was a seriously loony workload.  But suddenly, the number of people
who understand the Linux VM has gone from maybe 10 down to just one-and-a-bit.
A large number of comments have been removed, and a year's worth of
discussion has been invalidated.

Andrea, it would be most useful if you were to spend some time (say, four hours)
commenting the code and telling us how it works.
