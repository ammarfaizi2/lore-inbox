Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSHLEoe>; Mon, 12 Aug 2002 00:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSHLEoe>; Mon, 12 Aug 2002 00:44:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318706AbSHLEod>;
	Mon, 12 Aug 2002 00:44:33 -0400
Message-ID: <3D57406E.D39E9B89@zip.com.au>
Date: Sun, 11 Aug 2002 21:58:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> ...
> I did a bit of testing since I've always thought 2.4 (and 2.5) writeout behavior
> left something to be desired. Testbed was a SMP x86 (2xPPro-200) with 160 MB
> of RAM. I used everyone's favorite 2.5 scapegoat: IDE, with a single not-very-
> fast IBM disk. Filesystem was ext3 in data=ordered mode.

ext3 performs its own writeback alongside the core kernel's writeback
decisions, so that complicates things.

> Test workload was an
> inbound (from the point of view of the system under test) FTP transfer of a
> 600 MB iso image. All test runs were from a clean boot with all unnecessary
> services shut down.
> 
> Results (average of 4 runs):
> 
> 2.5.31-akpm: 2m 43s
> 2.5.31:      2m 33s
> 2.4.19:      2m 18s

yes.  For this workload (10 mbyte/sec ftp transfer onto a >20 meg/sec
disk) the application should never block on IO - all writeback should 
happen via pdflush.

2.4 starts background writeback at 30% dirty and synchronous writeback
at 60% dirty.

2.5 starts background writeback at 40% dirty and synchronous writeback
at 50% dirty.

You can make 2.5 use the 2.4 settings with

cd /proc/sys/vm
echo 30 > dirty_background_ratio 
echo 60 > dirty_async_ratio 
echo 70 > dirty_sync_ratio 

and I expect you'll find that fixes it up.  Setting dirty_background_ratio
to 10% will make it even better.  But it will hurt dbench numbers at
certain client counts, which is a national emergency.

Sigh.  I don't know what the right numbers are.  There aren't any; that's
the problem with magic numbers.  That part of the kernel is making writeback
and throttling decisions in total ignorance of the overall state of
the system.

Worst comes to worst, we can set the 2.5 knobs at the same level as the
2.4 ones, but I'd rather prefer that we can some up with something dynamic.

In fact, I'd be inclined to set the background ratio much lower than
2.4, and to hell with dbench.  Because the lower level is better for
real programs, as you've observed.

Care to tune and retest?
