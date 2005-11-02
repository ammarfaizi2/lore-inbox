Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVKBUef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVKBUef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVKBUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:34:35 -0500
Received: from gold.veritas.com ([143.127.12.110]:28799 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965226AbVKBUee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:34:34 -0500
Date: Wed, 2 Nov 2005 20:33:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: bad page state under possibly oom situation
In-Reply-To: <20051102194800.GM6137@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0511022013390.17675@goblin.wat.veritas.com>
References: <20051102143502.GE6137@in.ibm.com>
 <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
 <20051102194800.GM6137@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 20:34:34.0263 (UTC) FILETIME=[D5D3CA70:01C5DFEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Dipankar Sarma wrote:
> On Wed, Nov 02, 2005 at 04:33:21PM +0000, Hugh Dickins wrote:
> 
> I am really not comfortable with the SLAB_DESTROY_BY_RCU thing.
> I am not familiar with rmap code, so I could be wrong but
> it isn't clear to me why you are protecting only the slab
> and not the anon_vma slab objects. How do you ensure that
> the anon_vma objects don't get re-used ? If they do,
> then how do you prevent freeing an in-use anon_vma ?
> It seems that the critical sections are not clearly
> identified here.

The whole idea is that they may indeed get reused, but so long as
they're reused as anon_vma slab objects, with the same layout as before,
it's safe for page_lock_anon_vma to spin_lock(&anon_vma->lock): that
will still be a valid anon_vma->lock it's taking, and the worst that
can happen is that the caller will then search an irrelevant list for
the page it's looking for, and not find it (usually it'll just be an
empty list, when the anon_vma has not yet been put to use again).

An in-use anon_vma is only freed back to slab cache when its list
of vmas is empty, determined while holding anon_vma->lock.

The danger that RCU is used to guard against there, is that the slab
might be destroyed in between reading page->mapping and acquiring
anon_vma->lock, and its memory reused for something very different
e.g. anon_vma->lock no longer a spin_lock, but something which will
freeze that attempt to get the lock.

I think it's a technique which deserves to be used more widely.

> > If you don't get the Bad page state with that kernel, then it'll
> > be worth scrutinizing the SLAB_DESTROY_BY_RCU path in mm/slab.c.
> 
> I tried commenting out SLAB_DESTROY_BY_RCU for anon_vma caache,
> but I still hit the problem. So, that may not be it. I guess I can
> look at the bad page and see if I can extract some information
> from there.

Phew!  It seems I'm off the hook (but having said that, I'll probably
turn out to be guilty in some other way).  Sorry, I don't have any
ideas (and have never reproduced this here).

Hugh
