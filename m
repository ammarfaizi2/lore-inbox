Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUEZKho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUEZKho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUEZKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:37:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:26616 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265475AbUEZKhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:37:10 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>, <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 03:40:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B4590A.1090006@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRC/b0aiFb4uyUUSg2uJVv9mCA9wwAAT95g
Message-Id: <S265475AbUEZKhK/20040526103710Z+1487@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Buddy,
> Even for systems that don't *need* the extra memory space, swap can
> actually provide performance improvements by allowing unused memory
> to be replaced with often-used memory.

> For example, I have 57MB swapped right now. It allows me to instantly
> grep the kernel tree. If I turned swap off, each grep would probably
> take 30 seconds.

Your analogy is flawed. There are many reasons why this doesn't work in the
real world.

I don't think any modern and popular OS contains mechanisms that silently
stage old pages to disk. The constant twitching of the hard drive this
causes for no apparent reason drives people insane and drains precious
battery life on laptops. (see description for the pages_min, pages_low and
pages_high watermarks for clarity)

Pages are evicted from memory due to a memory shortfall, plain and simple.
If your actually benefiting from the 57mb of anonymous memory that was
evicted during a memory shortfall on your system then your in the unique
position of not needing to do any more filesystem I/O, or allocating any
more anonymous memory space.

The fact is, if your doing filesystem I/O, you will eventually exhaust all
available physical memory on the system. At that point, you have to evict
pages before you can read or write another page to/from the filesystem. The
page replacement algorithms being somewhat LRU based make this better than
FILO, but only as long as they don't get too clever and kill the corner
cases due to complexity.

Your grep analogy incorrectly assumes that you have a bunch of vacant memory
just waiting to store those filesystem pages, but that simply isn't the
case. Rather 57MB of anonymous memory was evicted to make room for 57MB of
anonymous or file system backed pages. Unless you have freed anonymous
memory on the system by closing applications. Your physical memory pages are
still mostly occupied. 

This means your grep is only going to run faster if you already read those
files recently and they are already in the pagecache. You still have the
burdon of pushing pages that have not been used recently out of ram before
you can read in the new ones. And as long as you are performing a sufficient
amount of file system I/O, this is guaranteed to happen.

One thing that can be done to minimize the problem where heavy filesystem
I/O flushes important pages from memory like pages from shared libraries and
executables only for them to fault back in as soon as they become runnable,
is to implement something similar to what Sun implemented in Solaris 8
called the cyclical page cache. The idea is that the pagecache pages against
itself and is actually considered free memory from an anonymous memory
perspective. The pagecache is free to grow all it wants, but since it is
counted as free memory, anonymous memory allocation will cause the pagecache
to shrink because it is considered free memory.

As these pages are evicted from the pagecache, they are placed on the
opposite side of the cachelist (linked list that stores pages that have a
vnode+offset already) than the side where pages are being overwritten. This
way frequently re-accessed pages that were placed on the cache list and were
eligible to be reclaimed, are found when the next minor fault occurs for
that vnode+offset and moved back to the opposite side of the list so that
they are not evicted.

Since the cache list is counted as free memory, there is no way to wake up
the LRU mechanism to scan physical memory until 1/64 of physical memory is
consumed by anonymous memory.  

> The VM doesn't always get it right, and to make matters worse, desktop
> users don't appreciate their long running jobs finishing earlier, but
> *hate* having to wait a few seconds for a window to appear if it hasn't
> been used for 24 hours.

Again, if you have had enough file system I/O during that time, it would
eventually cause pages from your application to be paged to the swap device
as the processes that represent your window slept.

--Buddy

