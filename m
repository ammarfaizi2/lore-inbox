Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVKJPjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVKJPjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVKJPjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:39:33 -0500
Received: from gold.veritas.com ([143.127.12.110]:3332 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750929AbVKJPjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:39:32 -0500
Date: Thu, 10 Nov 2005 15:38:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051110150010.GA30859@elte.hu>
Message-ID: <Pine.LNX.4.61.0511101519480.8566@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
 <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu>
 <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
 <20051110045144.40751a42.akpm@osdl.org> <Pine.LNX.4.61.0511101323540.7464@goblin.wat.veritas.com>
 <20051110150010.GA30859@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 15:39:32.0231 (UTC) FILETIME=[F1E61170:01C5E60C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Ingo Molnar wrote:
> * Hugh Dickins <hugh@veritas.com> wrote:
> > Of course, someone may extend spinlock debugging info tomorrow; but 
> > when they do, presumably they'll try it out, and hit the BUILD_BUG_ON. 
> > They'll then probably want to extend the suppression in mm/Kconfig.
> 
> why not do the union thing so that struct page grows automatically as 
> new fields are added? It is quite bad design to introduce a hard limit 
> like that. The only sizing concern is to make sure that the common 
> .configs dont increase the size of struct page, but otherwise why not 
> allow a larger struct page - it's for debugging only.

Yes, we wouldn't be worrying much about DEBUG_SPINLOCK enlarging struct
page (unnecessary as that currently is): it's the PREEMPT case adding
break_lock that's of concern (and only on 32-bit, I think: on all the
64-bits we'd have two unsigned ints in unsigned long private).

Going the union way doesn't give any more guarantee that another level
isn't using the fields, than the overlay way I did.  Going the union
way, without enlarging the common struct page, seems to involve either
lots of abstraction edits all over the tree (break_lock coinciding with
with page->mapping on 32-bit), or ruling out gcc 2.95.  Either seems to
me like a lose with no real win.

I'm certainly not arguing against break_lock itself: it's one of the
reasons why I went for a proper spinlock_t there; and agree with you
that trying to squeeze it in with the lock would likely go deep into
architectural complications.

Hugh
