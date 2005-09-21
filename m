Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVIUPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVIUPQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIUPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:16:48 -0400
Received: from gold.veritas.com ([143.127.12.110]:39611 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751062AbVIUPQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:16:47 -0400
Date: Wed, 21 Sep 2005 16:16:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Remap_file_pages, RSS limits, security implications (was: Re:
 [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection support (for
 UML), try 3)
In-Reply-To: <200509201706.06852.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0509211547270.6584@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
 <200509042110.01968.blaisorblade@yahoo.it> <Pine.LNX.4.61.0509071259380.17612@goblin.wat.veritas.com>
 <200509201706.06852.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 15:16:45.0349 (UTC) FILETIME=[7A84ED50:01C5BEBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Blaisorblade wrote:
> On Wednesday 07 September 2005 14:00, Hugh Dickins wrote:
> 
> Ahh, ok... VM_MAYSHARE is the recorded MAP_SHARED, while VM_SHARED says 
> whether the pages are actually shared and writable.

That's it (let's say "potentially writable" - VM_SHARED says they're
shared and already writable or shared and could be mprotected writable).

It is confusing, but it's been that way for years, and once you grasp it,
you like to keep it that way, so as to feel superior to everyone else ;)

> > Though thinking through that again now, the user of the nonlinear vma
> > is penalized,
> 
> Where? Not in the page fault path.... it's as penalized as the rest of the 
> system. Or will direct reclaim have a preference for pages of the calling 
> process?

Not in the page fault path, no; and no, direct reclaim doesn't have that
preference (sounds quite a good idea, but would need a different way of
choosing pages to free, and would conflict with the swap token idea?).

I meant in reclaim: that since try_to_unmap_cluster makes such poor
choices of what to reclaim, and tries to reclaim more than asked because
it's unable to target the page in question, I'd expect the user of a
nonlinear vma to suffer more thrashing under memory pressure.

> So, it would really be better to actually enforce the RSS rlimit when mapping 
> in pages in *nonlinear* areas (and fallback on setting file PTE's like on 
> NONBLOCK & page not in cache), rather than the "current" Rik's idea of 
> marking pages as inactive on memory-hog processes.

I'd go mad if I delved into these issues, luckily we have suckers like Rik
and Nick and Con who are prepared to give their lives to such endless tuning.

> But oh, right in mm/trash.c, the code which should do part of this is fully 
> commented out - and it was in the very first version of the code (looking 
> through bkcvs-git repository).

mm/trash.c?  I got quite excited, but now it looks like you just mean
mm/thrash.c.  Yawn.

Hugh
