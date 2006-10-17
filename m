Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWJQNMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWJQNMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWJQNMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:12:42 -0400
Received: from relay01.pair.com ([209.68.5.15]:42761 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1750881AbWJQNMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:12:41 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 08:12:04 -0500
User-Agent: KMail/1.9.4
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
References: <11587449471424@2ka.mipt.ru> <200610170100.10500.chase.venters@clientec.com> <20061017104242.GB19246@2ka.mipt.ru>
In-Reply-To: <20061017104242.GB19246@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610170812.28027.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 05:42, Evgeniy Polyakov wrote:
> On Tue, Oct 17, 2006 at 12:59:47AM -0500, Chase Venters 
(chase.venters@clientec.com) wrote:
> > On Tuesday 17 October 2006 00:09, Johann Borck wrote:
> > > Regarding mukevent I'm thinking of a event-type specific struct, that
> > > is filled by the originating code, and placed into a per-event-type
> > > ring buffer (which  requires modification of kevent_wait).
> >
> > I'd personally worry about an implementation that used a per-event-type
> > ring buffer, because you're still left having to hack around starvation
> > issues in user-space. It is of course possible under the current model
> > for anyone who wants per-event-type ring buffers to have them - just make
> > separate kevent sets.
> >
> > I haven't thought this through all the way yet, but why not have variable
> > length event structures and have the kernel fill in a "next" pointer in
> > each one? This could even be used to keep backwards binary compatibility
> > while
>
> Why do we want variable size structures in mmap ring buffer?

Flexibility primarily. So when we all decide to add a new event type six 
months from now, or add more information to an existing one, we don't run the 
risk that the existing mukevent isn't big enough.

> > adding additional fields to the structures over time, though no space
> > would be wasted on modern programs. You still end up with a question of
> > what to do in case of overflow, but I'm thinking the thing to do in that
> > case might be to start pushing overflow events onto a linked list which
> > can be written back into the ring buffer when space becomes available.
> > The appropriate behavior would be to throw new events on the linked list
> > if the linked list had any events, so that things are delivered in order,
> > but write to the mapped buffer directly otherwise.
>
> I think in a similar way.
> Kevent actually do not require such list, since it has already queue of
> the ready events.

The current event types coalesce if there are multiple events, correct? It 
sounds like there may be other event types where coalescing multiple events 
is not the correct approach.

Thanks,
Chase
