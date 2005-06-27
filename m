Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVF0Gee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVF0Gee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVF0GdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:33:00 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:18569 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261869AbVF0Gaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:30:35 -0400
Message-ID: <42BF9CD1.2030102@yahoo.com.au>
Date: Mon, 27 Jun 2005 16:29:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [rfc] lockless pagecache
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is going to be a fairly long and probably incoherent post. The
idea and implementation are not completely analysed for holes, and
I wouldn't be surprised if some (even fatal ones) exist.

That said, I wanted something to talk about at Ottawa and I think
this is a promising idea - it is at the stage where it would be good
to have interested parties pick it apart. BTW. this is my main reason
for the PageReserved removal patches, so if this falls apart then
some good will have come from it! :)

OK, so my aim is to remove the requirement to take mapping->tree_lock
when looking up pagecache pages (eg. for a read/write or nopage fault).
Note that this does not deal with insertion and removal of pages from
pagecache mappings - that is usually a slower path operation associated
with IO or page reclaim or truncate. However if there was interest in
making these paths more scalable, there are possibilities for that too.

What for? Well there are probably lots of reasons, but suppose you have
a big app with lots of processes all mmaping and playing around with
various parts of the same big file (say, a shared memory file), then
you might start seeing problems if you want to scale this workload up
to say 32+ CPUs.

Now the tree_lock was recently(ish) converted to an rwlock, precisely
for such a workload and that was apparently very successful. However
an rwlock is significantly heavier, and as machines get faster and
bigger, rwlocks (and any locks) will tend to use more and more of Paul
McKenney's toilet paper due to cacheline bouncing.

So in the interest of saving some trees, let's try it without any locks.

First I'll put up some numbers to get you interested - of a 64-way Altix
with 64 processes each read-faulting in their own 512MB part of a 32GB
file that is preloaded in pagecache (with the proper NUMA memory
allocation).

[best of 5 runs]

plain 2.6.12-git4:
  1 proc    0.65u   1.43s 2.09e 99%CPU
64 proc    0.75u 291.30s 4.92e 5927%CPU

64 proc prof:
3242763 total                                      0.5366
1269413 _read_unlock_irq                         19834.5781
842042 do_no_page                               355.5921
779373 cond_resched                             3479.3438
100667 ia64_pal_call_static                     524.3073
  96469 _spin_lock                               1004.8854
  92857 default_idle                             241.8151
  25572 filemap_nopage                            15.6691
  11981 ia64_load_scratch_fpregs                 187.2031
  11671 ia64_save_scratch_fpregs                 182.3594
   2566 page_fault                                 2.5867

It has slowed by a factor of 2.5x when going from serial to 64-way, and it
is due to mapping->tree_lock. Serial is even at the disadvantage of reading
from remote memory 62 times out of 64.

2.6.12-git4-lockless:
  1 proc    0.66u   1.38s 2.04e 99%CPU
64 proc    0.68u   1.42s 0.12e 1686%CPU

64 proc prof:
  81934 total                                      0.0136
  31108 ia64_pal_call_static                     162.0208
  28394 default_idle                              73.9427
   3796 ia64_save_scratch_fpregs                  59.3125
   3736 ia64_load_scratch_fpregs                  58.3750
   2208 page_fault                                 2.2258
   1380 unmap_vmas                                 0.3292
   1298 __mod_page_state                           8.1125
   1089 do_no_page                                 0.4599
    830 find_get_page                              2.5938
    781 ia64_do_page_fault                         0.2805

So we have increased performance exactly 17x when going from 1 to 64 way,
however if you look at the CPU utilisation figure and the elapsed time,
you'll see my test didn't provide enough work to keep all CPUs busy, and
for the amount of CPU time used, we appear to have perfect scalability.
In fact, it is slightly superlinear probably due to remote memory access
on the serial run.

I'll reply to this post with the series of commented patches which is
probably the best way to explain how it is done. They are against
2.6.12-git4 + some future iteration of the PageReserved patches. I
can provide the complete rollup privately on request.

Comments, flames, laughing me out of town, etc. are all very welcome.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
