Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUFDHTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUFDHTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 03:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbUFDHTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 03:19:48 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12685 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265663AbUFDHTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 03:19:46 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Bill Davidsen'" <davidsen@tmr.com>, "'Con Kolivas'" <kernel@kolivas.org>
Cc: "'FabF'" <fabian.frederick@skynet.be>,
       "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Fri, 4 Jun 2004 00:23:10 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40BF3250.9040901@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRJdYQhcZMsWK1YR06lfxvRhYQ5vQAiQxjQ
Message-Id: <S265663AbUFDHTq/20040604071946Z+537@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But swap behaviour kills performance even when memory is more than 
> adequate. Consider building a DVD image in a 4GB system. The i/o forces 
> all of the unused programs out, in spite of the fact that an extra 100MB 
> doesn't make a measurable difference in performance. But when I click 
> Mozilla paging most of it in from disk make a big difference in 
> performance to the user.


We really need a server option. Something that ages out file backed pages
naturally with less overhead than kswapd. One method would be to keep the
pagecache on it's own list, and move pages to the head of the list any time
they are modified or referenced, and reclaim from the tail. 

All pages on this list can be considered as "free memory", because any new
memory requests would just cause pages to be evicted from the tail of the
list.

Anonymous memory would *not* be on this list. This way any time anonymous
memory is allocated, the pages can be readily stolen from the pagecache
list.

Lastly one nifty configuration parameter that could exist as a knob for
sys-admins is the ability to tell the VM not to add file backed pages with
the execute bit set to the page cache list but rather, leave them to be
reclaimed if kswapd wakes up in a true low memory situation (pagecache is
exhausted and memory is still low). This would require a sys-admin to make
sure only executables have the execute bit set and "data files", etc... do
not have the execute bit set.


A system that works like this is nice for the following reasons:

1) The system administrator can size a system so that all programs
    Safely run within physical RAM. Extra RAM
    Could be added and sized based on the need
    for caching files.

2) Anonymous pages (and possibly executable if you read 
     the last paragraph above) will only be evicted if kswapd is
     awaken due to a true memory shortage (1/128th pagable memory?).


I like to view the VM system as always being full, because if enough unique
file system IO takes place, that is exactly what eventually happens. A
system that counts page cache as free memory and uses a gentler mechanism to
evict pages from the page cache would benefit IO bound servers significantly
IMHO.

--Buddy

