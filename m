Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319835AbSINARV>; Fri, 13 Sep 2002 20:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319836AbSINARU>; Fri, 13 Sep 2002 20:17:20 -0400
Received: from holomorphy.com ([66.224.33.161]:47573 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319835AbSINARS>;
	Fri, 13 Sep 2002 20:17:18 -0400
Date: Fri, 13 Sep 2002 17:12:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, colpatch@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
Message-ID: <20020914001235.GG3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
	colpatch@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com> <20020913234653.GF3530@holomorphy.com> <3D827CB0.D227D0E9@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D827CB0.D227D0E9@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> From 64 parallel tiobench 64's (higher counts livelock in fork() etc.):
>>    38 root      15   0     0    0     0 RW   23.0  0.0   1:11 kswapd0
>>  4779 wli       22   0  4460 3588  1648 R    17.9  0.0   0:16 top
>> ...
>>  4779 wli       25   0  4460 3592  1648 R    14.1  0.0   0:27 top
>>    38 root      15   0     0    0     0 DW    3.5  0.0   1:31 kswapd0

On Fri, Sep 13, 2002 at 05:02:56PM -0700, Andrew Morton wrote:
> Why do I see only one kswapd here?
> Are you claiming an overall 4x improvement, or what?
> I'll add some instrumentation whch tells us how many pages
> kswapd is reclaiming versus direct reclaim.

I can catch the others running if I refresh more often:

   38 root      15   0     0    0     0 DW    4.8  0.0   1:57 kswapd0
   36 root      15   0     0    0     0 SW    2.7  0.0   0:16 kswapd2

 4779 wli       22   0  4476 3604  1648 R     9.2  0.0   0:58 top
   37 root      15   0     0    0     0 SW    2.6  0.0   0:16 kswapd1

   38 root      15   0     0    0     0 DW    2.9  0.0   2:12 kswapd0
   36 root      15   0     0    0     0 SW    1.8  0.0   0:22 kswapd2

 4779 wli       25   0  4476 3600  1648 R     7.4  0.0   1:18 top
   37 root      15   0     0    0     0 SW    2.7  0.0   0:21 kswapd1

 4779 wli       24   0  4476 3600  1648 R    37.5  0.0   1:49 top
   37 root      16   0     0    0     0 RW   11.1  0.0   0:23 kswapd1

 4779 wli       25   0  4476 3600  1648 R    14.1  0.0   1:51 top
   35 root      15   0     0    0     0 SW    6.9  0.0   0:24 kswapd3

   38 root      15   0     0    0     0 RW    2.9  0.0   2:29 kswapd0
   37 root      16   0     0    0     0 SW    1.4  0.0   0:28 kswapd1

etc.

Not sure about baselines. I'm happier because there's more cpu
utilization. kswapd0 is relatively busy so the other ones take some
load off of it. The benchmark isn't quite done yet. I think four
dbench 512's in parallel might be easier to extract results from.
tiobench also looks like it's getting some cpu:

  procs                      memory           io        system       cpu
r  b    w   swpd   free   buff  cache      bi    bo    in    cs   us  sy  id
7 3649  2      0  12516  13460 15365328   32    11209 1349  3334   3   8  90
0 3474  3      0  11216   9648 15354584   760   10333 1360  3089   2  10  88
7 3222  3      0  11872  10744 15367528   3883  8841  1371  2362   1   8  91
1 2958  2      0  12572  10304 15373820   569   10617 1347  2214   2   8  90


Cheers,
Bill
