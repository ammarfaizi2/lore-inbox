Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSIZWEE>; Thu, 26 Sep 2002 18:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSIZWEE>; Thu, 26 Sep 2002 18:04:04 -0400
Received: from packet.digeo.com ([12.110.80.53]:36334 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261581AbSIZWED>;
	Thu, 26 Sep 2002 18:04:03 -0400
Message-ID: <3D938588.4508FDF@digeo.com>
Date: Thu, 26 Sep 2002 15:09:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
References: <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 22:09:09.0042 (UTC) FILETIME=[563B9920:01C265A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> ...
> another implementation would be an idea from Linus: the page's lru list
> pointer can in theory be used for pinned pages (pinned pages do not have
> much LRU meaning anyway), and this pointer could specify the 'owner' MM of
> the physical page. The COW fault handler then checks the sticky page:

Overloading page->lru in this way is tricky.   If we can guarantee
that the page is anonymous (anonymise it if it's file-backed, pull
it out of swapcache) then fine, ->mapping, ->list.next, ->list.prev,
->index and ->private are available.

Can we do that?

>  - if the faulting context is a non-owner (ie. the fork()-ed child), then
>    the normal COW path is taken - new page allocated and installed.
> 
>  - if the faulting context is the owner, then the pte chain is walked, and
>    the new page is installed into every 'other' pte. This needs a
>    cross-CPU single-page TLB flush though. The TLB flush could be
>    optimized if we had a way to get to the mapping MM's of the individual
>    pte chain entries - is this possible?

Going from a pte back up to the owning MM is possible, yes.  See
mm/rmap.c:try_to_unmap_one().  The caller would have to hold the
page's rmap_lock.
