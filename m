Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUBWW0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUBWWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:25:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:59287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbUBWWYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:24:34 -0500
Date: Mon, 23 Feb 2004 14:26:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040223142626.48938d7c.akpm@osdl.org>
In-Reply-To: <200402232027.26958.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
	<20040221113044.7deb60b9.akpm@osdl.org>
	<200402222039.58702.gluk@php4.ru>
	<200402232027.26958.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> > > OK, so everything is stuck trying to allocate memory.  Perhaps you ran out
> > > of swapspace, or some process has gone berzerk allocating memory.
> 
> The memory exhaustion is indeed possible for this box. I'll double check
> ulimit and /etc/security/limits.conf stuff. The only thing which worries
> me that this box had been running for months without any problems with
> 2.4.23aa1.

It is conceivable that you have some application which runs OK on 2.4.x but
has some subtle bug which causes the app to go crazy on a 2.6 kernel
consuming lots of memory.  Or there's a bug in the 2.6 kernel ;)

> I have added another 2Gb to swap space (hope this give enough time
> to find the memory hungry process(es)).
> 
> > >
> > > How much memory does the machine have, and how much swap space?
> > >
> > # free
> >              total       used       free     shared    buffers     cached
> > Mem:       2073868    2067508       6360          0     232708     897828
> > -/+ buffers/cache:     936972    1136896
> > Swap:      1535976       5228    1530748
> > 
> > > I suggest that you run a `vmstat 30' trace on a terminal somewhere, see
> > > what it says prior to the hangs. 
> > Ok.We'll try to get it next time.
> 
> Here it is:
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  0 551920   8108 203744 933532    0    0     4    68 1214   426  5  1 92  2
>  0  0 551928   7140 203756 930316    0    0    17    61 1240   529  8  1 89  2
>  0  0 551976   5788 203772 928224    1    6   360   139 1297   317  7  2 83  8
>  0  0 551968   7588 203812 923504    0    0    19   125 1303   308  8  2 87  4
>  0  1 551976  10444 203892 914100    0    0    25   127 1433   438 10  3 85  3
>  0  0 551976   9220 204004 914804    0    0   123   126 1278   325  6  1 88  5
>  0  0 551976   8108 204044 912248    0    0    38    69 1279   291  6  1 91  2
>  0  1 551976  11828 204144 912320    1    0   135    94 1249   296  6  1 89  3
>  0  5 562204   3280 203952 157084    1  566   305   674 1281   313  6  4 73 17
>  0 18 598224   4276   1888  33356   91 2734   233  2761 1090   199  0  2  0 97
>  1 38 662520   2760   2104  30520  110 3721   261  3738 1161   831  1  2  0 97
> 10 41 699936   2772   1920  28716  123 2924   249  2946 1103  1273  0  3  0 97
>  0 39 748588   2956   1956  22668  160 3313   245  3331 1056  1047  0  2  0 98
>  0 38 796100   3108   1888  21348  321 3191   430  3206 1045  1002  0  2  0 97
>  4 43 844532   3308   1956  17644  518 3719   670  3733 1357   999  0  2  0 98
>  0 51 882596   2940   2052  13960  520 2796   705  2810 1048  1182  0  2  0 98
>  3 59 913392   2456   2048  10900 1013 2524  1308  2542 1144   601  0  2  0 98
>  5 71 937816   2760   2072   8584 1534 2681  1860  2702 1234   607  0  2  0 97

OK, so it's doing a lot of swapping and your swap utilisation is
continuously increasing.  I would suspect an application or kernel memory
leak.

I suggest you keep that `vmstat 30' running all the time.  When the machine
dies, take a look at the final 20 lines.

Also, run

	while true
	do
		cat /proc/meminfo
		sleep 10
	done

and record the info which that leaves behind when the machine locks up. 
This should tell us whether it is an application or kernel memory leak.  If
it is indeed a leak.

