Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWCVQT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWCVQT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWCVQT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:19:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751348AbWCVQTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:19:55 -0500
Date: Wed, 22 Mar 2006 08:19:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       rdreier@cisco.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1143043088.17406.17.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.64.0603220810170.26286@g5.osdl.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Mar 2006, Bryan O'Sullivan wrote:
> 
> Under 2.6.15, what seems to be actually happening is that vmops->nopage
> is being called on each page of a 32K compound page, driving the page
> count from 1 (prior to any nopage calls) to 9.  By the time I get to my
> cleanup code, the page count has gone from 9 to 8 (whereas under 2.6.16,
> the page count has gone from 9 back to 1, where it belongs).  From this,
> it seems fairly clear that the kernel isn't decrementing the use counts
> correctly on compound pages in 2.6.15.

Ahh. Isn't this the same problem that the fairly recent "mm: compound 
release fix" by Nick should fix?

Git commit ID 8519fb30e438f8088b71a94a7d5a660a814d3872, to be exact:

Author: Nick Piggin <npiggin@suse.de>
Date:   Tue Feb 7 12:58:52 2006 -0800

    [PATCH] mm: compound release fix
    
    Compound pages on SMP systems can now often be freed from pagetables via
    the release_pages path.  This uses put_page_testzero which does not handle
    compound pages at all.  Releasing constituent pages from process mappings
    decrements their count to a large negative number and leaks the reference
    at the head page - net result is a memory leak.
    
    The problem was hidden because the debug check in put_page_testzero itself
    actually did take compound pages into consideration.
    
    Fix the bug and the debug check.
    
    Signed-off-by: Nick Piggin <npiggin@suse.de>
    Acked-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

But anything based on 2.6.16-rc6 should be fine (The bug was fixed by 
2.6.16-rc3, methinks). You said:

   "First of all, it turns out that the BUG I mentioned was reported 
    against the SLES10 2.6.16-rc6 kernel.  I haven't had a chance to chase 
    it down yet, but I'm going to have to, because..."

but if that _really_ is 2.6.16-rc6-based, this problem should have been 
fixed already.

Maybe SLES is based on 2.6._15_-rc6?

		Linus
