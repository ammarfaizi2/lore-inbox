Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIFOBs>; Thu, 6 Sep 2001 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRIFOBi>; Thu, 6 Sep 2001 10:01:38 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:58288 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270825AbRIFOBb>;
	Thu, 6 Sep 2001 10:01:31 -0400
Date: Thu, 06 Sep 2001 15:01:49 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <594419049.999788509@[10.132.112.53]>
In-Reply-To: <20010906154212.442bdf7b.skraw@ithnet.com>
In-Reply-To: <20010906154212.442bdf7b.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If there's no memory pressure, data stays in InactiveDirty, caches,
>> etc., forever. What makes you think more memory would have helped
>> the NFS performance? It's possible these all were served out of caches
>> too.
>
> Negative. Switching off export-option "no_subtree_check" (which basically
> leads to more small allocs during nfs action) shows immediately mem
> failures and truncated files on the server and stale nfs handles on the
> client. So the system _is_ under pressure. This exactly made me start (my
> branch of) the discussion.
> Besides I would really like to know what useable _data_ is in these
> pages, as I cannot see which application should hold it (the CD stuff was
> quit "long ago"). FS should have sync'ed several times, too.

Yes, but this is because VM system's targets & pressure calcs do not
take into account fragmentation of the underlying physical memory.
IE, in theory you could have half your memory free, but
not be able to allocate a single 8k block. Nothing would cause
cache, or InactiveDirty stuff to be written.

You yourself proved this, by switching rsize,wsize to 1k and said
it all worked fine! (unless I misread your email).

The other potential problem is that if the memory requirement
is all extremely bursty and without __GFP_WAIT (i.e. allocated
GFP_ATOMIC) then it is conceivable you need a whole pile of
memory allocated before the system has time to retrieve it
from things which require locks, I/O, etc. However, I suspect
this isn't the problem.

Put my instrumentation patch on, and if I'm right you'll see something
like the following, but worse. Look at 32kB allocations (order 3,
which is what I think you said was failing), and look at the %fragmentation.
This is the % of free memory which cannot be allocated as (in this
case) contiguous 32kB chunks (as it's all in smaller blocks). As
this approaches 100, the VM system is going to think 'no memory
pressure' and not free up pages, but you are going to be unable
to allocate.

The second of these examples was after a single bonnie run,
a sync, and 5 minutes of idle activity. Note that in this
example, and few order 4 allocations which required DMA would
fail, though the VM system would see plenty of memory. And they
will continue failing.

I think what you want isn't more memory, its less
fragmented memory. Or an underlying system which can
cope with fragmentation.

--
Alex Bligh


Before
$ cat /proc/memareas
   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB  1024kB  2048kB Tot Pages/kb
    DMA       2       2       4       3       3       3       1       1       0       6 =     3454
  @frag      0%      0%      0%      1%      1%      3%      6%      7%     11%     11%      13816kB
 Normal       0       0       6      29      18       8       4       0       1      23 =    13088
  @frag      0%      0%      0%      0%      2%      4%      6%      8%      8%     10%      52352kB
HighMem = 0kB - zero size zone

After
$ cat /proc/memareas
   Zone     4kB     8kB    16kB    32kB    64kB   128kB   256kB   512kB 1024kB  2048kB Tot Pages/kb
    DMA     522     382     210      53       8       2       1       0       0       0 =     2806
  @frag      0%     19%     46%     76%     91%     95%     98%    100%    100%    100%      11224kB
 Normal       0    1155    1656     756     163      29       0       1       0       0 =    18646
  @frag      0%      0%     12%     48%     80%     94%     99%     99%    100%    100%      74584kB
                                    ^^^
					Order 3
HighMem = 0kB - zero size zone


