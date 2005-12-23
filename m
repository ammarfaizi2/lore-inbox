Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVLWP3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVLWP3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVLWP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:29:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965005AbVLWP3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:29:01 -0500
Date: Fri, 23 Dec 2005 07:27:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: rmk+lkml@arm.linux.org.uk, nico@cam.org, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051223072747.0b481dac.akpm@osdl.org>
In-Reply-To: <1135350288.6493.258.camel@capoeira>
References: <20051222122011.GA20789@elte.hu>
	<20051222050701.41b308f9.akpm@osdl.org>
	<1135257829.2940.19.camel@laptopd505.fenrus.org>
	<20051222054413.c1789c43.akpm@osdl.org>
	<1135260709.10383.42.camel@localhost.localdomain>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<20051222221311.2f6056ec.akpm@osdl.org>
	<Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
	<20051223065118.95738acc.akpm@osdl.org>
	<20051223145746.GA2077@flint.arm.linux.org.uk>
	<1135350288.6493.258.camel@capoeira>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> wrote:
>
> On Fri, 2005-12-23 at 15:57, Russell King wrote:
> > On Fri, Dec 23, 2005 at 06:51:18AM -0800, Andrew Morton wrote:
> > > Nicolas Pitre <nico@cam.org> wrote:
> > > > How can't you get the fact that semaphores could _never_ be as simple as 
> > > > mutexes?  This is a theoritical impossibility, which maybe turns out not 
> > > > to be so true on x86, but which is damn true on ARM where the fast path 
> > > > (the common case of a mutex) is significantly more efficient.
> > > 
> > > I did notice your comments.  I'll grant that mutexes will save some tens of
> > > fastpath cycles on one minor architecture.  Sorry, but that doesn't seem
> > > very important.
> > 
> > Wow.
> 
> Yes, wow. Andrew doesn't seem aware of embedded linux people, for whom
> cycles are important and ARM is king.
> 

Please, spare me the rhetoric.

Adding a new locking primitive is a big deal.  We need good reasons for
doing it.  And no, I don't think a few cycles on ARM is good enough.  I'd
be very surprised if it was measurable - the busiest semaphore is probably
i_sem and when it's taken we're also doing heavy filesystem operations
which would swamp any benefit.  And if we're going to churn i_sem then we
perhaps should turn it into an rwsem so we can perform concurrent lookups
(at least).  We do disk I/O with that thing held.

Look, I'm not wildly against mutexes - it's not exactly a large amount of
code.  I just think they're fairly pointless and I regret that we seem to
be diving into adding yet another locking primitive without having fully
investigated improving the existing one.
