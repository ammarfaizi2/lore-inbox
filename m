Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWCVRp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWCVRp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCVRp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:45:27 -0500
Received: from silver.veritas.com ([143.127.12.111]:59258 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932221AbWCVRpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:45:25 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,119,1141632000"; 
   d="scan'208"; a="36270745:sNHT26497280"
Date: Wed, 22 Mar 2006 17:46:21 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1143043088.17406.17.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.61.0603221729300.8148@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
  <1142523201.25297.56.camel@camp4.serpentine.com> 
 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com> 
 <1142538765.10950.16.camel@serpentine.pathscale.com> 
 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com> 
 <1142974347.29199.87.camel@serpentine.pathscale.com> 
 <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
 <1143043088.17406.17.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Mar 2006 17:45:24.0640 (UTC) FILETIME=[66033A00:01C64DD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Bryan O'Sullivan wrote:
> 
> ...the driver actually works just fine under 2.6.16-final.  No memory
> leaks, no funnies with page counting being wrong.

Ah, great, then I needn't look through your code, phew (no offence)!

> Under 2.6.15, what seems to be actually happening is that vmops->nopage
> is being called on each page of a 32K compound page, driving the page
> count from 1 (prior to any nopage calls) to 9.  By the time I get to my
> cleanup code, the page count has gone from 9 to 8 (whereas under 2.6.16,
> the page count has gone from 9 back to 1, where it belongs).  From this,
> it seems fairly clear that the kernel isn't decrementing the use counts
> correctly on compound pages in 2.6.15.

I'm sure Linus is right about that.  I remembered put_page_testzero
checking the wrong part of the compound page in its BUG_ON, but I'd
forgotten that release_pages ended up not freeing the compound page
at all.  Yes, 2.6.15 and its relatives do indeed leak there.

> I think my next step, rather than boring you to tears with an
> interminable slog through unfamiliar source code, is to try Linus's
> suggestion from last week of just shooting nopage in the head, and
> instead use remap_pfn_range in fops->mmap.  If the stars are aligned,
> perhaps this will give me something that works on a wide variety of
> kernels.

That may well be a good plan (given the doubts Nick raised about
whether dma_alcohol_rent gives the right kind of struct page non-slab
memory on all arches).  But one way in which the stars will be slightly
misaligned: for 2.6.14 and earlier you'll need to SetPageReserved on
each constituent of the >0-page, to get remap_pfn_range to map it (and
ClearPageReserved before freeing the >0-page); that won't do any harm
on 2.6.15 and 2.6.16 (apart from enlarging the code unnecessarily);
but we might one day remove those macros, from driver use anyway.

Hugh
