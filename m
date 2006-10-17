Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423126AbWJQGAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423126AbWJQGAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423128AbWJQGAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:00:24 -0400
Received: from relay03.pair.com ([209.68.5.17]:2315 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1423126AbWJQGAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:00:23 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 00:59:47 -0500
User-Agent: KMail/1.9.4
Cc: Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
References: <11587449471424@2ka.mipt.ru> <4532C2C5.6080908@redhat.com> <453465B6.1000401@densedata.com>
In-Reply-To: <453465B6.1000401@densedata.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610170100.10500.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 00:09, Johann Borck wrote:
> Regarding mukevent I'm thinking of a event-type specific struct, that is
> filled by the originating code, and placed into a per-event-type ring
> buffer (which  requires modification of kevent_wait).

I'd personally worry about an implementation that used a per-event-type ring 
buffer, because you're still left having to hack around starvation issues in 
user-space. It is of course possible under the current model for anyone who 
wants per-event-type ring buffers to have them - just make separate kevent 
sets.

I haven't thought this through all the way yet, but why not have variable 
length event structures and have the kernel fill in a "next" pointer in each 
one? This could even be used to keep backwards binary compatibility while 
adding additional fields to the structures over time, though no space would 
be wasted on modern programs. You still end up with a question of what to do 
in case of overflow, but I'm thinking the thing to do in that case might be 
to start pushing overflow events onto a linked list which can be written back 
into the ring buffer when space becomes available. The appropriate behavior 
would be to throw new events on the linked list if the linked list had any 
events, so that things are delivered in order, but write to the mapped buffer 
directly otherwise.

Deciding when to do that is tricky, and I haven't thought through the 
implications fully when I say this, but what about activating a bottom half 
when more space becomes available, and let that drain overflowed events back 
into the mapped buffer? Or perhaps the time to do it would be in the next 
blocking wait, when the queue emptied? 

I think it is very important to avoid any limits that can not be adjusted on 
the fly at run-time by CAP_SYS_ADMIN or what have you. Doing it this way may 
have other problems I've ignored but at least the big one - compile-time 
capacity limits in the year 2006 - would be largely avoided :P

Nothing real solid yet, just some electrical storms in the grey matter...

Thanks,
Chase
