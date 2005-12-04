Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVLDPDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVLDPDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVLDPDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:03:05 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:63619 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751006AbVLDPDE (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 4 Dec 2005 10:03:04 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17299.1331.368159.374754@gargle.gargle.HOWL>
Date: Sun, 4 Dec 2005 18:03:15 +0300
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
In-Reply-To: <20051204134818.GA4305@mail.ustc.edu.cn>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071609.755741000@localhost.localdomain>
	<17298.56560.78408.693927@gargle.gargle.HOWL>
	<20051204134818.GA4305@mail.ustc.edu.cn>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang writes:
 > On Sun, Dec 04, 2005 at 03:11:28PM +0300, Nikita Danilov wrote:
 > > Wu Fengguang writes:
 > >  > When a page is referenced the second time in inactive_list, mark it with
 > >  > PG_activate instead of moving it into active_list immediately. The actual
 > >  > moving work is delayed to vmscan time.
 > >  > 
 > >  > This implies two essential changes:
 > >  > - keeps the adjecency of pages in lru;
 > > 
 > > But this change destroys LRU ordering: at the time when shrink_list()
 > > inspects PG_activate bit, information about order in which
 > > mark_page_accessed() was called against pages is lost. E.g., suppose
 > 
 > Thanks.
 > But this order of re-access time may be pointless. In fact the original
 > mark_page_accessed() is doing another inversion: inversion of page lifetime.
 > In the word of CLOCK-Pro, a page first being re-accessed has lower

The brave new world of CLOCK-Pro is still yet to happen, right?

 > inter-reference distance, and therefore should be better protected(if ignore
 > possible read-ahead effects). If we move re-accessed pages immediately into
 > active_list, we are pushing them closer to danger of eviction.

Huh? Pages in the active list are closer to the eviction? If it is
really so, then CLOCK-pro hijacks the meaning of active list in a very
unintuitive way. In the current MM active list is supposed to contain
hot pages that will be evicted last.

Anyway, these issues should be addressed in CLOCK-pro
implementation. Current MM tries hard to maintain LRU approximation in
both active and inactive lists.

[...]

 > 
 > Though I have a strong feeling that with the extra PG_activate bit, the
 > +                       ClearPageReferenced(page);
 > line should be removed. That is, let the extra reference record live through it.
 > The point is to smooth out the inter-reference distance. Imagine the following
 > situation:
 > 
 > -      +            -   +           +   -                   -   +              -
 > 1                   2                   3                   4                  5
 >         +: reference time
 >         -: shrink_list time
 > 
 > One page have an average inter-reference distance that is smaller than the
 > inter-scan distance. But the distances vary a bit. Here we'd better let the
 > reference count accumulate, or at the 3rd shrink_list time it will be evicted.

I think this is pretty normal and acceptable variance. Idea is that when
system is short on memory scan rate increases together with the
precision of reference tracking.

[...]

 > 
 > Thanks,

Che-che,

 > Wu

Nikita.
