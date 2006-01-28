Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422756AbWA1Alm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWA1Alm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbWA1All
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:41:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:15765 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422756AbWA1Alk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:41:40 -0500
Message-ID: <43DABDBF.7010006@us.ibm.com>
Date: Fri, 27 Jan 2006 16:41:35 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Paul Jackson <pj@sgi.com>, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
References: <1138217992.2092.0.camel@localhost.localdomain>	 <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>	 <43D954D8.2050305@us.ibm.com>	 <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>	 <43D95BFE.4010705@us.ibm.com> <20060127000304.GG10409@kvack.org>	 <43D968E4.5020300@us.ibm.com>	 <84144f020601262335g49c21b62qaa729732e9275c0@mail.gmail.com>	 <20060127021050.f50d358d.pj@sgi.com> <84144f020601270307t7266a4ccs5071d4b288a9257f@mail.gmail.com>
In-Reply-To: <84144f020601270307t7266a4ccs5071d4b288a9257f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> Pekka wrote:
> 
>>>As as side note, we already have __GFP_NOFAIL. How is it different
>>>from GFP_CRITICAL and why aren't we improving that?
> 
> 
> On 1/27/06, Paul Jackson <pj@sgi.com> wrote:
> 
>>Don't these two flags invoke two different mechanisms.
>>  __GFP_NOFAIL can sleep for HZ/50 then retry, rather than return failure.
>>  __GFP_CRITICAL can steal from the emergency pool rather than fail.
>>
>>I would favor renaming at least the __GFP_CRITICAL to something
>>like __GFP_EMERGPOOL, to highlight the relevant distinction.
> 
> 
> Yeah you're right. __GFP_NOFAIL guarantees to never fail but it
> doesn't guarantee to actually succeed either. I think the suggested
> semantics for __GFP_EMERGPOOL are that while it can fail, it tries to
> avoid that by dipping into page reserves. However, I do still think
> it's a bad idea to allow the slab allocator to steal whole pages for
> critical allocations because in low-memory condition, it should be
> fairly easy to exhaust the reserves and waste most of that memory at
> the same time.

The main pushback I got on my previous attempt at somethign like
__GFP_EMERGPOOL was that a single, system-wide pool was unacceptable.
Determining the appropriate size for such a pool would be next to
impossible, particularly as the number of users of __GFP_EMERGPOOL grows.
The general concensus was that per-subsystem or dynamically created pools
would be a more useful addition to the kernel.  Do any of you who are now
requesting the single pool approach have any suggestions as to how to
appropriately size a pool with potentially dozens of users so as to offer
any kind of useful guarantee?  The less users of a single pool, obviously
the easier it is to appropriately size that pool...

As far as allowing the slab allocator to steal a whole page from the
critical pool to satisfy a single slab request, I think that is ok.  The
only other suggestion I've heard is to insert a SLOB layer between the
critical pool's page allocator and the slab allocator, and have this SLOB
layer chopping up pages into pieces to handle slab requests that cannot be
satisfied through the normal slab/page allocator combo.  This involves
adding a fair bit of code and complexity for the benefit of a few pages of
memory.  Now, a few pages of memory could be incredibly crucial, since
we're discussing an emergency (presumably) low-mem situation, but if we're
going to be getting several requests for the same slab/kmalloc-size then
we're probably better of giving a whole page to the slab allocator.  This
is pure speculation, of course... :)

-Matt
