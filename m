Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTKASfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTKASfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 13:35:11 -0500
Received: from main.gmane.org ([80.91.224.249]:59117 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263412AbTKASe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 13:34:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Sat, 1 Nov 2003 18:34:56 +0000 (UTC)
Message-ID: <slrnbq7v6g.5q7.psavo@varg.dyndns.org>
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031031112615.GA10530@k3.hellgate.ch> <200310310755.36224.edt@aei.ca>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ed Tomlinson <edt@aei.ca>:
> On October 31, 2003 06:26 am, Roger Luethi wrote:
>> On Thu, 30 Oct 2003 22:57:23 -0500, Rik van Riel wrote:
>>
>> > On Wed, 29 Oct 2003, Chris Vine wrote:
>> > 
>> >
>> > > However, on a low end machine (200MHz Pentium MMX uniprocessor with
>> > > only 32MB  of RAM and 70MB of swap) I get poor performance once
>> > > extensive use is made of the swap space.
>> >
>> > 
>> > Could you try the patch Con Kolivas posted on the 25th ?
>> > 
>> > Subject: [PATCH] Autoregulate vm swappiness cleanup
>>
>> 
>> I suppose it will show some improvement but fail to get performance
>> anywhere near 2.4 -- at least that's what my own tests found. I've been
>> working on a break-down of where we're losing it.
>> Bottom line: It's not simply a price we pay for feature X or Y. It's
>> all over the map, and thus no single patch can possibly fix it.
>
> With 2.6 its possible to tell the kernel how much to swap.  Con's patch
> tries to keep applications in memory.  You can also play with 
> /proc/sys/vm/swappiness which is what Con's patch tries to replace.

FWIW, I've been getting horrible performance when FREEING swap space. UI
would just hang for several seconds. It've been that way all the -test
timeframe. 
test9 has been much better, but seemingly only because it doesn't seem
to like swap as good as before, it doesn't use it unless in dire need.

It's not exactly low-end machine either: 2x1800, 512M + 1G swap.
DMA is on for IDE.

below is 'vmstat 1', I loaded some 30MB images into GIMP and made tight
operations (undo level at 100). Loaded some more heavy apps, then moved
to GIMP's workspace and closed it. There was 'no-response' -time at
marked places:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
...
 1  1 318784   6788   9500 134092  964    0  1652   220 1262  1185  9  2 44 46
 0  1 318784   5188   9512 134164 1548    0  1620     4 1162   861  8  1 32 59
 0  1 318784   3140   9268 132052 8000    0  8000     0 1299  1130  4  2 48 46
 0  2 331280   2812   8860 127072 7360 13336  7360 13336 1502  1700  1  4 44 51
 0  1 331280   3800   8644 125816 4648    0  4648     4 1368  1330  1  3 29 67
 0  2 333596   3104   8632 125312 3136 2340  3136  2372 1466  1809  2  4 44 51
 1  2 336548   3620   8588 124924 5736 2972  5736  2972 1658  2163  3  5 23 69
 0  2 336468   3752   8668 124836  736   92   816   112 1454  1697  3  4 23 71
 0  1 336468   5232   8760 123288 5468    0  5536   136 1694  2265  3  4 28 65
- click GIMP 'Quit' -
 1  0 334848   4680   8808 124088 2200    0  3000    56 1339  1404  3  2 34 61
 0  1 291692 150596   8812 124496  876    0  1248     0 1232  1116 13  3 48 36
- GUI freeze -
 0  1 291692 148432   8812 124164 2576    0  2576     0 1369   561  1  1 50 49
 0  1 291692 146128   8812 124132 2344    0  2344     0 1284   488  1  1 50 49
 0  2 291692 143828   8812 124048 2396    0  2396    28 1254   373  0  2 49 49
 0  2 291692 141588   8828 124092 2320    0  2320    52 1270   583  0  1  6 92
 0  2 291692 139228   8848 124044 2272    0  2272    32 1257   524  0  1 13 86
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1 291692 136988   8848 124064 2224    0  2224     0 1213   401  1  1 50 49
 0  1 291692 134688   8848 124048 2328    0  2328     0 1349   362  1  1 49 49
 0  1 291692 132128   8848 124040 2524    0  2524     0 1408   371  0  2 49 49
 0  1 291692 129824   8848 124028 2324    0  2324     0 1210   361  0  1 49 50
 0  1 291692 127520   8852 124044 2292    0  2292   164 1266   474  0  1 29 69
 0  2 291692 125348   8868 124060 2144    0  2144    28 1225   473  0  2  8 90
 0  2 291692 122788   8888 124100 2524    0  2524    32 1283   557  1  1 24 75
 0  1 291692 120612   8888 124092 2184    0  2184     0 1181   367  0  1 43 56
 0  1 291692 118052   8888 124092 2516    0  2516     0 1176   346  1  1 50 49
 0  1 291692 115684   8888 124068 2404    0  2404     0 1178   337  1  1 50 49
 0  1 291692 113124   8888 124112 2540    0  2540     0 1183   349  1  1 50 49
 0  1 291692 111080   8888 123688 2464    0  2464     0 1186   336  1  1 49 50
 0  0 291692 109920   8924 123712 1164    0  1164    60 1165   869  3  1 57 39
- GUI available -
 0  0 291692 109924   8924 123712    0    0     0     0 1079   632  0  0 100  0
 0  0 291692 109924   8924 123712    0    0     0     0 1079   687  0  0 100  0
 0  0 291692 109924   8924 123712    0    0     0     0 1074   645  0  0 100  0
 0  0 291692 109928   8924 123712    0    0     0     0 1122   797  1  0 100  0


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>
Vivake -- Virtuaalinen valokuvauskerho <http://members.lycos.co.uk/vivake/>

