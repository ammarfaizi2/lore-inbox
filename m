Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSCIHOj>; Sat, 9 Mar 2002 02:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291394AbSCIHOb>; Sat, 9 Mar 2002 02:14:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291401AbSCIHON>;
	Sat, 9 Mar 2002 02:14:13 -0500
Date: Fri, 08 Mar 2002 21:47:04 -0800
From: "Martin J. Bligh" <fletch@aracnet.com>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <82825246.1015624024@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"time make -j32 bzImage" is now down to 23 seconds.
(16 way NUMA-Q, 700MHz P3's, 4Gb RAM).

Below is a description of which patches helped get there.

	Start (2.4.18)
47s	
	{make NUMA local memory allocation work}
	memalloc-15setup                       (Pat Gaughen)
	memalloc-16discont                     (Pat Gaughen)
	pageallocnull fix + force CONFIG_NUMA  (Martin Bligh)
27s
	{O(1) scheduler}
	sched-O1-2.4.18-pre8-K3.patch          (Ingo Molnar)
25s
	{NUMA scheduler}
	numaK3.patch                           (Mike Kravetz)
24s
	{dcache cacheline bouncing fixes}
	dcache/fast_walkA2-2.4.18.patch        (Hanna Linder)
23s

Appling Ingo's patch alone took time from 47s to 30s.
The benefits after the local mem stuff aren't quite as
stunning, but still good.

Top 10 profile hitters left:

 21439 total                                      0.0228
  9112 default_idle                             175.2308
  3364 _text_lock_swap                           62.2963
   790 lru_cache_add                              8.5870
   750 _text_lock_namei                           0.7184
   587 do_anonymous_page                          1.7681
   572 lru_cache_del                             26.0000
   569 do_generic_file_read                       0.5117
   510 __free_pages_ok                            0.9733
   421 _text_lock_dec_and_lock                   17.5417
   318 _text_lock_read_write                      2.6949

Big locks left:

pagemap_lru_lock
20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%  

pagecache_lock
17.5% 31.3%  7.5us(  99us)   52us(4023us)( 2.4%)    631988 68.7% 31.3%    0% 

others:
dcache_lock (much improved, but still work to be done)
BKL (isn't it always ;-)

Planned work next:

1. Try John Stultz's mcslocks 
	(note high max wait vs low max hold currently)
2. Try rmap + pagemap_lru_breakup from Arjan
3. Try radix tree pagecache.
4. Try grafting NUMA-Q page local alloc onto -aa tree
5. Try SGI NUMA zone ordering stuff.
6. [HARD] Break up ZONE_NORMAL between nodes 
   (all currently on node 0).

Any other suggestions are welcome. I'd also be interested
to know if 23s is fast for make bzImage, or if other big
iron machines can kick this around the room.

Thanks,

Martin.
