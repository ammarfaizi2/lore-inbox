Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281180AbRKEP2C>; Mon, 5 Nov 2001 10:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281182AbRKEP1y>; Mon, 5 Nov 2001 10:27:54 -0500
Received: from mailrelay1.inwind.it ([212.141.54.101]:51107 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S281180AbRKEP1m>; Mon, 5 Nov 2001 10:27:42 -0500
Message-Id: <3.0.6.32.20011105163057.020022e0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 05 Nov 2001 16:30:57 +0100
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: VM: qsbench numbers
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Forgot to CC linux-kernel people, sorry]

At 17.03 04/11/01 -0800, you wrote:
>
>On Sun, 4 Nov 2001, Lorenzo Allegrucci wrote:
>> >
>> >Does "free" after a run has completed imply that there's still lots of
>> >swap used? We _should_ have gotten rid of it at "free_swap_and_cache()"
>> >time, but if we missed it..
>>
>> 70.590u 7.640s 2:31.06 51.7%    0+0k 0+0io 19036pf+0w
>> lenstra:~/src/qsort> free
>>              total       used       free     shared    buffers     cached
>> Mem:        255984       6008     249976          0        100       1096
>> -/+ buffers/cache:       4812     251172
>> Swap:       195512       5080     190432
>
>That's not a noticeable amount, and is perfectly explainable by simply
>having deamons that got swapped out with truly inactive pages. So a
>swapcache leak does not seem to be the reason for the unstable numbers.
>
>> >What happens if you make the "vm_swap_full()" define in <linux/swap.h> be
>> >unconditionally defined to "1"?
>>
>> 70.530u 7.290s 2:33.26 50.7%    0+0k 0+0io 19689pf+0w
>> 70.830u 7.100s 2:29.52 52.1%    0+0k 0+0io 18488pf+0w
>> 70.560u 6.840s 2:28.66 52.0%    0+0k 0+0io 18203pf+0w
>>
>> Performace improved and numbers stabilized.
>
>Indeed.
>
>Mind doing some more tests? In particular, the "vm_swap_full()" macro is
>only used in two places: mm/memory.c and mm/swapfile.c. Are you willing to
>test _which_ one (or is it both together) it is that seems to bring on the
>unstable numbers?

mm/memory.c:
#undef vm_swap_full()
#define vm_swap_full() 1

swap=200M
70.480u 7.440s 2:35.74 50.0%    0+0k 0+0io 19897pf+0w
70.640u 7.280s 2:28.87 52.3%    0+0k 0+0io 18453pf+0w
70.750u 7.170s 2:36.26 49.8%    0+0k 0+0io 19719pf+0w

swap=400M
70.120u 6.940s 2:29.55 51.5%    0+0k 0+0io 18598pf+0w
70.160u 7.320s 2:37.34 49.2%    0+0k 0+0io 19720pf+0w
70.020u 11.310s 3:15.09 41.6%   0+0k 0+0io 28330pf+0w


mm/memory.c:
/* #undef vm_swap_full() */
/* #define vm_swap_full() 1 */

mm/swapfile.c:
#undef vm_swap_full()
#define vm_swap_full() 1

swap=200M
69.610u 7.830s 2:33.47 50.4%    0+0k 0+0io 19630pf+0w
70.260u 7.810s 2:54.06 44.8%    0+0k 0+0io 22816pf+0w
70.420u 7.420s 2:42.71 47.8%    0+0k 0+0io 20655pf+0w

swap=400M
70.240u 6.980s 2:40.37 48.1%    0+0k 0+0io 20437pf+0w
70.430u 6.450s 2:25.36 52.8%    0+0k 0+0io 18400pf+0w
70.270u 6.420s 2:25.52 52.7%    0+0k 0+0io 18267pf+0w
70.850u 6.530s 2:35.82 49.6%    0+0k 0+0io 19481pf+0w

These above are bad numbers but the worst is still to come..

I repeated the "What happens if you make the "vm_swap_full()" define
in <linux/swap.h> be unconditionally defined to "1"?" thing.

swap=200M
70.510u 7.510s 2:33.91 50.6%    0+0k 0+0io 19584pf+0w
70.100u 7.620s 2:42.20 47.9%    0+0k 0+0io 20562pf+0w
69.840u 7.910s 2:51.61 45.3%    0+0k 0+0io 22541pf+0w
70.370u 7.910s 2:52.06 45.4%    0+0k 0+0io 22793pf+0w

swap=400M
70.560u 7.580s 2:37.38 49.6%    0+0k 0+0io 19962pf+0w
70.120u 7.560s 2:45.04 47.0%    0+0k 0+0io 20403pf+0w
70.390u 7.130s 2:29.82 51.7%    0+0k 0+0io 18159pf+0w <-
70.080u 7.190s 2:29.63 51.6%    0+0k 0+0io 18580pf+0w <-
70.300u 6.810s 2:29.70 51.5%    0+0k 0+0io 18267pf+0w <-
69.770u 7.670s 2:49.68 45.6%    0+0k 0+0io 20980pf+0w

Well, numbers are unstable again.

Either I made some error patching the kernel, or my previous test:
>> 70.530u 7.290s 2:33.26 50.7%    0+0k 0+0io 19689pf+0w
>> 70.830u 7.100s 2:29.52 52.1%    0+0k 0+0io 18488pf+0w
>> 70.560u 6.840s 2:28.66 52.0%    0+0k 0+0io 18203pf+0w
was a statistical "fluctuation".
I don't know, and I would be very thankful if somebody can
confirm/deny these results.


-- 
Lorenzo
