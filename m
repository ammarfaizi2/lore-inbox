Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRLRQZ0>; Tue, 18 Dec 2001 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284177AbRLRQZQ>; Tue, 18 Dec 2001 11:25:16 -0500
Received: from manson.clss.net ([65.211.158.2]:48552 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id <S284176AbRLRQZK>;
	Tue, 18 Dec 2001 11:25:10 -0500
Message-ID: <20011218162509.6476.qmail@manson.clss.net>
From: pacman@manson.clss.net
Subject: swapping problem 2.4.16
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Dec 2001 11:25:09 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine (8 MB RAM, please hold the applause) hangs with 2.4.16 whenever it
needs to swap (which usually coincides with the launching of gettys).

AltGr+ScrollLock during the freeze shows a call trace like this:
sys_newstat->getname->kmalloc->try_to_free_pages->shrink_caches->shrink_cache
(some entries omitted; all this data is from pencil-and-paper notes, there
may be some transcription errors)

Shift+ScrollLock says this:

Mem-info:
Free pages: 84 kB (0kB HighMem)
Zone:DMA freepages: 84kB min: 80kB low: 160kB high: 240kB
Zone:Normal freepages: 0kB min: 0kB low: 0kB high: 0kB
Zone:HighMem freepages: 0kB min: 0kB low: 0kB high: 0kB
( Active: 84, inactive: 1360, free: 21 )
1*4kB 0*8kB 1*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB = 84 kB)
= 0 kB)
= 0 kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap: 31076 kB
2048 pages of RAM
0 pages of HIGHMEM
394 reserved pages
877 pages shared
0 pages swap cached
8 pages in page table cache
Buffer memory: 92kB

Loading up shrink_cache with printks was very revealing. shrink_cache is
called repeatedly, with nr_pages=32 with priority looping from 6 down to 1,
and it returns 32 every time. I don't understand exactly how shrink_cache is
supposed to work, but I assume that what I need it to do is call swap_out().
That call is never being reached, because of these formulae:

int max_scan = nr_inactive_pages / priority;
int max_mapped = nr_pages << (9 - priority);

max_scan is the number of iterations of the big loop that surrounds most of
the function. max_mapped is decremented at most once per iteration of that
outer loop, and swap_out will never be called until max_mapped reaches 0.
Therefore if the initial value of max_mapped is greater than the initial
value of max_scan, there is no chance of reaching the swap_out() call. And
using my numbers:

                   max_scan =                  max_mapped =
priority | nr_inactive_pages / priority | nr_pages << (9 - priority)
       6 |       1360 / 6 = 226         | 32 << 3 = 256
       5 |       1360 / 5 = 272         | 32 << 4 = 512
       4 |       1360 / 4 = 340         | 32 << 5 = 1024
       3 |       1360 / 3 = 453         | 32 << 6 = 2048
       2 |       1360 / 2 = 680         | 32 << 7 = 4096
       1 |       1360 / 1 = 1360        | 32 << 8 = 8192

Not only is max_mapped larger than max_scan, the gap between them widens as
the priority approaches 1. That seems to go against my understanding of what
the priority is supposed to mean - that as you get close to 1 you should get
*more* likely to swap something out.

As an experiment I changed this statement:

                        if (--max_mapped >= 0)
                                continue;

to this:

                        if (--max_mapped >= 0 && priority!=1)
                                continue;

and now it boots, swaps, and survives.

