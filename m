Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTH0Hjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTH0Hjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:39:42 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:15012
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263116AbTH0Hjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:39:35 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.24623.273818.861350@wombat.chubb.wattle.id.au>
Date: Wed, 27 Aug 2003 17:39:27 +1000
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mfedyk@matchmail.com, Andrew Morton <akpm@osdl.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
In-Reply-To: <20030827071648.GY1715@holomorphy.com>
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
	<20030826181807.1edb8c48.akpm@osdl.org>
	<20030827012914.GB5280@matchmail.com>
	<20030827071648.GY1715@holomorphy.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Command exited with non-zero status 100 Command being timed:
>> "apt-get update" User time (seconds): 0.01 System time (seconds):
>> 0.00 Percent of CPU this job got: 6% Elapsed (wall clock) time
>> (h:mm:ss or m:ss): 0:00.32 Average shared text size (kbytes): 0
>> Average unshared data size (kbytes): 0 Average stack size (kbytes):
>> 0 Average total size (kbytes): 0 The averages might be nice...

William> The averages themselves aren't reported with getrusage(),
William> only direct usage measurements. Presumably luserspace
William> computes the averages itself.  i.e. the counters are all for
William> non-average versions of these stats and (because we're seeing
William> all 0's) are not reported at all.


Yes, the kernel is (supposed) to calculate the integral over time of
the memory sizes; user space divides these integrals by elapsed time
to get averages.

To calculate these you need a timestamp for last change, and a set of
counters.
Then code to update all the counters every time one of the sizes
change (otherwise you need a timestamp for each counter) by adding
current_size*(current_time - last_change_time) to each counter.

William> On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
>> Maximum resident set size (kbytes): 0 But the maximum would allow
>> any polling app to do its polling less often.  As well as the
>> averages above...  Average resident set size (kbytes): 0 Major
>> (requiring I/O) page faults: 320 Minor (reclaiming a frame) page
>> faults: 21

William> The fault counters are vaguely bogus when threads are
William> involved. There's a comment alluding to that nearby.

The fault counters are incorrect anyway --- faults satisfied from the
page cache are counted as major faults, whereas we expect only faults
that sleep for disk I/O to be counted as major faults.


William> On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
>> Swaps: 0 Counting swaps would be nice too.

William> This already has two counters in the task_t (no, I will not
William> use Finnish Hungarian notation in my general posts) that are
William> 100% unused. Probably the only thing preventing slab poison
William> from showing up there outright is the whole task_t copy in
William> kernel/fork.c and the bss zeroing for init_task.

It's unclear what `swaps' are in Linux.  Traditionally, this rusage
field was the number of complete swapouts --- I'm not sure what the
equivalent is when processes are not swapped out holus-bolus, but are
paged gradually.


William> On Tue, Aug 26, 2003 at 06:29:14PM -0700, Mike Fedyk wrote:
>> File system inputs: 0 File system outputs: 0 Socket messages sent:
>> 0 Socket messages received: 0 Signals delivered: 0 Yes, yes, yes.

William> These would be easy to set up, they just need counters and
William> the ticking of the counters dropped in.

It's on my list of things to do, if not soon, then I'm hoping for a
summer student to do some of this stuff.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
