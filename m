Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUKTX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUKTX4F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKTXpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:45:11 -0500
Received: from dp.samba.org ([66.70.73.150]:26093 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261528AbUKTXSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:18:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.53353.686239.419507@samba.org>
Date: Sun, 21 Nov 2004 10:16:57 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419F6D1F.10001@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<419ECAB5.10203@namesys.com>
	<16798.59519.63931.494579@samba.org>
	<419F6D1F.10001@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > mkfs.reiser4 -o extent=extent40

This lowered the performance by a small amount (from 52 MB/sec to 50
MB/sec).

It also revealed a bug. I have been doing my tests on a cleanly
formatted filesystem each time, but this time I re-ran the test a few
times in a row to determine just how consistent the results are. The
results I got were:

  mkfs.reiser4 -o extent=extent40    50 MB/sec
                                     48
                                     43
                                     41
                                     37 (stuck)

the "stuck" result meant that smbd locked into a permanent D state at
the end of the fifth run. Unfortunately ps showed the wait-channel as
'-' so I don't have any more information about the bug. I needed to
power cycle the machine to recover.

To check if this is reproducable I tried it again and got the following:

reboot, mkfs again                   50 MB/sec
                                     48
                                     44
                                     42
                                     40
                                     (failed)

the "failed" on the sixth run was smbd stuck in D state again, this
time before the run completed so I didn't get a performance number.

I should note that the test completely wipes the directory tree
between runs, and the server processes restart, so the only way there
can be any state remaining that explains the slowdown between runs is
a filesystem bug. Do you think reiser4 could be "leaking" some on-disk
structures? 

To determine if this problem is specific to the extent=extent40
option, I ran the same series of tests against reiser4 without the
extent option:

reboot, mkfs.reiser4 without options  52 MB/sec
                                      52
                                      45
                                      41
                                      (failed)

The failure on the fifth run showed the same symptoms as above.

To determine if the bug is specific to reiser4, I then ran the same
series of tests against ext3, using the same kernel:

  reboot, mke2fs -j                  70 MB/sec
                                     70
                                     69
                                     70
                                     71
                                     70

So it looks like the gradual slowdown and eventual lockup is specific
to reiser4. What can I do to help you track this down? Would you like
me to write a "howto" for running this test, or would you prefer to
wait till I have an emulation of the test in dbench? 

To give you an idea of the scales involved, each run lasts 100
seconds, and does approximately 1 million filesystem operations (the
exact number of operations completed in the 100 seconds is roughly
proportional to the performance result).

> Ah, that explains a lot.  For that kind of workload, the simpler the fs 
> the better, because really all you are doing is adding overhead to 
> copy_to_user and copy_from_user.  All of reiser4's advanced features 
> will add little or no value if you are staying in ram. 

I'll do some runs with larger numbers of simulated clients and send
you those results shortly. Do you think a working set size of about
double the total machine memory would be a good size to start showing
the reiser4 features?

Cheers, Tridge
