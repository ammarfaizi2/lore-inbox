Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUEOBBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUEOBBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUEOA6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:58:14 -0400
Received: from nacho.zianet.com ([216.234.192.105]:776 "HELO nacho.zianet.com")
	by vger.kernel.org with SMTP id S264641AbUEOAzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:55:00 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andy Isaacson <adi@bitmover.com>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Fri, 14 May 2004 18:54:33 -0600
User-Agent: KMail/1.6.1
Cc: Steven Cole <scole@lanl.gov>, support@bitmover.com,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200405122234.06902.elenstev@mesatop.com> <200405131723.15752.elenstev@mesatop.com> <20040514165311.GC6908@bitmover.com>
In-Reply-To: <20040514165311.GC6908@bitmover.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141854.33613.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 10:53 am, Andy Isaacson wrote:

> So, in the oddball config department, you've got a ISAPnP modem over
> which you're running PPP; CONFIG_PREEMPT is on.
> 
> That corruption size really does make me think of network packets, so
> I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
> link?  "ifconfig ppp0" or something like that.

ppp0      Link encap:Point-to-Point Protocol
          inet addr:216.31.65.245  P-t-P:216.31.65.1  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:123 errors:0 dropped:0 overruns:0 frame:0
          TX packets:152 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:77312 (75.5 Kb)  TX bytes:8212 (8.0 Kb)
> 
> Can you try doing something like
> 
> #!/bin/sh
> x=0
> while true; do
> 	bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
> 	(cd foo; bk pull -q)
> 	rm -rf foo
> 	x=`expr $x + 1`
> 	echo -n "$x "
> done
> 
> (I just pulled that key at random out of the kernel repository; there's
> nothing special about it except that it's far enough back for the revert
> and pull to be very involved operations.)
> 
> That ought to do a nice test of the CPU, memory, disk, and kernel sans
> PPP.  If that loop runs for, say, 10 iterations without errors, keep it
> running and try doing some non-BK network IO for a half hour (or two
> iterations of the clone/pull loop, whichever is longer) and see if it
> fails.  You might want to increase the runtimes, say, overnight and two
> hours of network activity, if you don't see any failures.
> 
> This test is designed to check the theory that in your config, PPP
> somehow corrupts random buffer cache pages.

It didn't need PPP to fail.
It looks like it failed on the 7th iteration of the script supplied by Andy.

[snipped list of files]
sound/core/SCCS/s.Kconfig
Your repository should be back to where it was before undo started
We are running a consistency check to verify this.
check passed
Undo failed, repository left locked.
WARNING: deleting orphan file /home/steven/tmp/bk_clone2_mVmrsk
Entire repository is locked by:
        RESYNC directory.
ERROR-Unable to lock repository for update.
6

[steven@spc BK]$ ls -ls foo/RESYNC/SCCS/*
40048 -r--r--r--  1 steven steven 41007273 May 14 18:08 foo/RESYNC/SCCS/s.ChangeSet
   68 -r--r--r--  1 steven steven    67791 May 14 18:11 foo/RESYNC/SCCS/s.CREDITS
   76 -r--r--r--  1 steven steven    75264 May 14 18:11 foo/RESYNC/SCCS/s.MAINTAINERS
  124 -r--r--r--  1 steven steven   124747 May 14 18:11 foo/RESYNC/SCCS/s.Makefile
  
Let me know if you want any of these files.  I can compress them and send them
the usual way.

The kernel was 2.6.6 plus whatever is in Linus' tree, and bk was 3.0.4.

Steven
