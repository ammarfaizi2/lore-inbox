Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWGZOqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWGZOqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWGZOqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:46:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:31378 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S932170AbWGZOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:46:29 -0400
Subject: Re: [PATCH] mm: inactive-clean list
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Martin Schwidefsky <schwidefsky@googlemail.com>
Cc: Rik van Riel <riel@redhat.com>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6e0cfd1d0607260604w3e8636e4taaea4bc918397b34@mail.gmail.com>
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
	 <6e0cfd1d0607260400r731489a1tfd9e6c5a197fb0bd@mail.gmail.com>
	 <1153912268.2732.30.camel@taijtu>
	 <6e0cfd1d0607260604w3e8636e4taaea4bc918397b34@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 16:45:04 +0200
Message-Id: <1153925104.2762.11.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 15:04 +0200, Martin Schwidefsky wrote:
> On 7/26/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > > Hmm, I wonder how the inactive clean list helps in regard to the fast
> > > host reclaim
> > > scheme. In particular since the memory pressure that triggers the
> > > reclaim is in the
> > > host, not in the guest. So all pages might be on the active list but
> > > the host still
> > > wants to be able to discard pages.
> > >
> >
> > I think Rik would want to set all the already unmapped pages to volatile
> > state in the hypervisor.
> >
> > These pages can be dropped without loss of information on the guest
> > system since they are all already on a backing-store, be it regular
> > files or swap.
> 
> I guessed that as well. It isn't good enough. Consider a guest with a
> large (virtual) memory size and a host with a small physical memory
> size. The guest will never put any page on the inactive_clean list
> because it does not have memory pressure. vmscan will never run. The
> host wants to reclaim memory of the guest, but since the
> inactive_clean list is empty it will find only stable pages.
> 

Wouldn't we typically have all free pages > min_free in state U?
Also wouldn't all R/O mapped pages not also be V, all R/W mapped pages
and unmapped page-cache pages P like you state in your paper.

This patch would just increase the number of V pages with the tail end
of the guest LRU, which are typically the pages you would want to evict
(perhaps even add 5th guest state to indicate that these V pages are
preferable over the others?)

But isn't it so that for the gross over-commit scenario you outline the
host OS will have to swap out S pages eventually?


