Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSKGCok>; Wed, 6 Nov 2002 21:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266301AbSKGCoj>; Wed, 6 Nov 2002 21:44:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:45526 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266298AbSKGCoj>;
	Wed, 6 Nov 2002 21:44:39 -0500
Message-ID: <3DC9D51B.4CF2B06D@digeo.com>
Date: Wed, 06 Nov 2002 18:51:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: PageLRU BUG() when preemption is turned on (2.4 kernel)
References: <20021106183317.E15363@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 02:51:11.0406 (UTC) FILETIME=[87AF2CE0:01C28608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Sun wrote:
> 
> I am chasing a nasty bug that shows up in 2.4 kernel when preemption
> is turned on.  I would appreciate any help.  Please cc your reply
> to me email account.
> 
> I caught the BUG() live with kgdb (on a MIPS board).  See the backtrace
> attached at the end.
> 
> In a nutshell, access_process_vm() calls put_page(), which
> calls __free_pages(), where it finds page->count is 0 but does not
> like the fact that page->flags still has LRU bit set.
> 

That's a bug in older 2.4 kernels.  You'll need to use a more recent
kernel, or change that put_page() to be a page_cache_release(),
or forward-port this chunk:


        /*
         * Yes, think what happens when other parts of the kernel take 
         * a reference to a page in order to pin it for io. -ben
         */
        if (PageLRU(page)) {
                if (unlikely(in_interrupt()))
                        BUG();
                lru_cache_del(page);
        }

to your __free_pages_ok().

The problem is that `put_page()' doesn't know how to deal with the
final release of a page which is on the LRU.  Someone else released
their reference, leaving access_process_vm() unexpectedly holding
the last reference to the page.  But it does put_page(), which then
says "why didn't you remove this page from the LRU?  BUG."
