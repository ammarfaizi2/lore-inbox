Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbVKRT7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbVKRT7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbVKRT7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:59:41 -0500
Received: from gold.veritas.com ([143.127.12.110]:50546 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161144AbVKRT7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:59:40 -0500
Date: Fri, 18 Nov 2005 19:58:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 09/11] unpaged: ZERO_PAGE in VM_UNPAGED
In-Reply-To: <200511172225.31973.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.61.0511181942320.3305@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511171938080.4563@goblin.wat.veritas.com>
 <200511172225.31973.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 19:59:35.0487 (UTC) FILETIME=[9977FCF0:01C5EC7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Ingo Oeser wrote:
> 
> We do we refcount ZERO_PAGE at all?

We never used to.  They were, and for the moment still are, marked
PageReserved.  Prior to 2.6.15-rc we didn't refcount reserved pages,
but now we're trying to move away from PageReserved (some differences
of opinion how far to go), so refcounting them.

We're currently refcounting the ZERO_PAGE(s) simply because the
common case is refcounted: it would just be extra tests and code
NOT to refcount the ZERO_PAGE(s).  If they were a commoner case,
then it would indeed be worth avoiding refcounting them, but it
currently doesn't appear to be worth the effort.

But it is still up in the air: there is or may be an issue with
refcounts overflowing, and if it's clear that the ZERO_PAGE is
the only one vulnerable on any architecture, then I'm sure we'd
deal with it by not refcounting them.  However, I believe the
issue extends to mapped file pages too: though you need a huge
amount of RAM to reach overflow, so it's not something we need
to resolve this week.

> Ok, there may be multiple, but they exist always and always at
> the same physical addresses, right?

Right.

> So why do we care at all?
> Memory hotplug?
> Doesn't it suffice there, that they are reverse mappable?

Actually, they're not reverse mappable: we tend to find
there's not much gained by swapping out the ZERO_PAGE ;)

Hugh
