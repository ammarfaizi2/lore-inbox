Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbSJDHes>; Fri, 4 Oct 2002 03:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJDHer>; Fri, 4 Oct 2002 03:34:47 -0400
Received: from boden.synopsys.com ([204.176.20.19]:46047 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S261516AbSJDHeq>; Fri, 4 Oct 2002 03:34:46 -0400
Date: Fri, 4 Oct 2002 09:40:08 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe bugfix /cleanup
Message-ID: <20021004074008.GB941@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210031514230.19230-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210031514230.19230-100000@dbl.q-ag.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:27:49PM +0200, Manfred Spraul wrote:
> Hi Linus,
> 
> pipe_write contains a wakeup storm, 2 writers that write into the same 
> fifo can wake each other up, and spend 100% cpu time with wakeup/schedule, 
> without making any progress.
> 
> The patch below was part of -dj, and IIRC even of -ac, for a few months, 
> but it's more a rewrite of pipe_read and _write.
> 
> Could you merge it, or do you want a minimal fix?
> 
> The only regression I'm aware of is that
> 
>   $ dd if=/dev/zero | grep not_there

This makes 2.4.19 + Con Kolivas patch behave very bad.
The system goes slow, freeze, than wakes up, freeze again, etc.

I did "cat /dev/zero | grep nothing".

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0 124592 292056  60624  70488   0   1    27    19    7     2   5   1   2
 0  0  0 124592 292048  60632  70488   0   0     0    12  132   141   0   0 100
 0  0  0 124588 292048  60632  70488   0   0     0     0  126   109   0   0 100
 0  0  0 124588 292048  60632  70488   0   0     0     0  126   108   0   0 100
 0  0  0 124588 292048  60632  70488   0   0     0     0  127   102   0   0 100
 0  0  0 124588 292048  60632  70488   0   0     0     0  130   122   1   0  99
 0  0  0 124568 292004  60632  70488  28   0    28     0  151  1836   5   1  94
 1  0  0 124552 292004  60632  70488   0   0     0     0  150   530   6   1  93
 0  0  0 124552 292004  60632  70488   0   0     0     0  130   496   4   1  95
 0  0  0 124552 292004  60632  70488   0   0     0     0  138  1935   4   3  93
 0  0  0 124528 290956  60632  70488   0   0     0     0  250  3075  17   2  81
 0  0  0 124528 290948  60640  70488   0   0     0    44  143   197   0   0 100
 0  0  0 124516 290948  60640  70488   0   0     0     0  134   170   0   0 100
 1  0  0 124516 290952  60644  70488   0   0     4     0  143   186   0   1  99
 1  0  0 124516 290944  60644  70488   0   0     0     0  126   104   0   0 100
 2  0  0 124516 208760  60644  70488   4   0     4     0  136 37577  39  45  17
 2  0  0 124516 126544  60652  70488   0   0     0    12  123 16596  72  28   0
 2  0  1 253164   4832  54036  70120  16 660    16   660  148 69994   0 100   0
 1  1  2 439472   3264  53880  70120   0 20704     0 20696  398   978   0  28  72
 0  1  1 438920   3656  53088  70120   0 19496     0 19496  450   722   0   5  95
 0  1  1 438596   3716  53024  70120   0 19944     0 19944  442   134   0   7  93
 0  1  2 438364   3712  53004  70132   0 19944    20 19944  507   252   0   5  95
 1  1  3 438104   3784  52932  70132   0 19804     0 19804  442   171   0   1  99
 0  2  1 437884   3804  52892  70132   8 17956     8 17956  452   219   0   5  95
 0  2  1 437660   3736  52860  70132 100 18124   100 18124  435   205   0   1  99
 0  2  1 437440   3168  52796  70132   4 20392     4 20392  493   542   0   5  95
 0  2  2 437328   3144  52760  70168   0 19976     0 20180  602   341   1   1  98
10  0  6 143432 294816  52384  70168   8 128296     8 128436 2961   502   0   5  95
 1  0  0 133448 307256  52320  70168 352   0   356    44  225   330   0   1  99
 1  0  0 133372 307256  52320  70168   0   0     0     0  130   109   0   0 100
 1  0  0 133296 307240  52336  70168   0   0     0    56  123   101   0   0 100
 1  0  0 133244 307240  52336  70168   0   0     0     0  119    96   0   0 100
 2  0  0 132952 307240  52336  70168   0   0     0     0  124   309   1   1  98


> will fail due to OOM, because grep does something like
> 
> 	for(;;) {
> 		rlen = read(fd, buf, len);
> 		if (rlen == len) {
> 			len *= 2;
> 			buf = realloc(buf, len);
> 		}
> 	}
> 
> if it operates on pipes, and due to the improved syscall merging, read 
> will always return the maximum possible amount of data. But that's a grep 
> bug, not a kernel problem.
> 
> The diff is older, but applies to 2.5.40 without offsets.

doesn't apply to 2.4.19

-alex
