Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318892AbSHMAWa>; Mon, 12 Aug 2002 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSHMAWa>; Mon, 12 Aug 2002 20:22:30 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:19963 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318892AbSHMAW1>;
	Mon, 12 Aug 2002 20:22:27 -0400
Date: Mon, 12 Aug 2002 20:26:03 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020813002603.GA20817@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com> <3D56A83E.ECF747C6@zip.com.au> <20020812002739.GA778@www.kroptech.com> <3D57406E.D39E9B89@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D57406E.D39E9B89@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 09:58:22PM -0700, Andrew Morton wrote:
> ext3 performs its own writeback alongside the core kernel's writeback
> decisions, so that complicates things.

I ran the test after mounting the partition as ext2 and saw a slight
decrease in performance (7-10 seconds over the duration of the test), but I
did not have time to run more than once so this could be a fluke. In general,
the `vmstat 1` output looked the same to me.

> > Results (average of 4 runs):
> > 
> > 2.5.31-akpm: 2m 43s
> > 2.5.31:      2m 33s
> > 2.4.19:      2m 18s
> 
> yes.  For this workload (10 mbyte/sec ftp transfer onto a >20 meg/sec
> disk) the application should never block on IO - all writeback should 
> happen via pdflush.

> You can make 2.5 use the 2.4 settings with
> 
> cd /proc/sys/vm
> echo 30 > dirty_background_ratio 
> echo 60 > dirty_async_ratio 
> echo 70 > dirty_sync_ratio 

These settings bring -akpm in line with stock 2.5.31, but they are both
still slower than 2.4.19 (which itself could do better, I think).

> and I expect you'll find that fixes it up.  Setting dirty_background_ratio
> to 10% will make it even better.  But it will hurt dbench numbers at

No real change at 10%. It's consistently a second or two faster than -akpm is at
30%, but not a drastic change.

> certain client counts, which is a national emergency.
> 
> Sigh.  I don't know what the right numbers are.  There aren't any; that's
> the problem with magic numbers.  That part of the kernel is making writeback
> and throttling decisions in total ignorance of the overall state of
> the system.

It certainly seems something is amiss. If we could actually manage to keep
the disk busy (and this is a fairly slow disk), we'd do wonderfully. But with
a 2-3 second pause every 4-5 seconds, we're transferring data barely 50% of the
time. (Yes, the pause is long enough the disk activity LED actually goes out.)
The short-term average transfer rate over the FTP connection is very
respectable for older hardware: 7-8 MB/s. But with the stalls, the overall
throughput is just over 4 MB/s.

> In fact, I'd be inclined to set the background ratio much lower than
> 2.4, and to hell with dbench.  Because the lower level is better for
> real programs, as you've observed.

> Care to tune and retest?

Absolutely. I'll try whatever ideas/patches you want to throw at me.

BTW, full `vmstat 1` logs are available for all these tests if you want them.

--Adam

