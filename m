Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934011AbWKTIo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934011AbWKTIo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934009AbWKTIo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:44:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:8628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934008AbWKTIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:44:28 -0500
Date: Mon, 20 Nov 2006 00:43:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-Id: <20061120004301.d1815a95.akpm@osdl.org>
In-Reply-To: <20061120082500.GA25467@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru>
	<45564EA5.6020607@redhat.com>
	<20061113105458.GA8182@2ka.mipt.ru>
	<4560F07B.10608@redhat.com>
	<20061120082500.GA25467@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 11:25:01 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Sun, Nov 19, 2006 at 04:02:03PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> > Evgeniy Polyakov wrote:
> > >>Possible solution:
> > >>
> > >>a) it would be possible to have a "used" flag in each ring buffer entry.
> > >>   That's too expensive, I guess.
> > >>
> > >>b) kevent_wait needs another parameter which specifies the which is the
> > >>   last (i.e., least recently added) entry in the ring buffer.
> > >>   Everything between this entry and the current head (in ->kidx) is
> > >>   occupied.  If multiple threads arrive in kevent_wait the highest idx
> > >>   (with wrap around possibly lowest) is used.
> > >>
> > >>   kevent_wait will not try to move more entries into the ring buffer
> > >>   if ->kidx and the higest index passed in to any kevent_wait call
> > >>   is equal (i.e., the ring buffer is full).
> > >>
> > >>   There is one issue, though, and that is that a system call is needed
> > >>   to signal to the kernel that more entries in the ring buffer are
> > >>   processed and that they can be refilled.  This goes against the
> > >>   kernel filling the ring buffer automatically (see below)
> > >
> > >If thread calls kevent_wait() it means it has processed previous entries, 
> > >one can call kevent_wait() with $num parameter as zero, which
> > >means that thread does not want any new events, so nothing will be
> > >copied.
> > 
> > This doesn't solve the problem.  You could only request new events when 
> > all previously reported events are processed.  Plus: how do you report 
> > events if the you don't allow get_event pass them on?
> 
> Userspace should itself maintain order and possibility to get event in
> this implementation, kernel just returns events which were requested.

That would mean that in a multithreaded application (or multi-processes
sharing the same MAP_SHARED ringbuffer), all threads/processes will be
slowed down to wait for the slowest one.

> > >They all already imeplemented. Just all above, and it was done several
> > >months ago already. No need to reinvent what is already there.
> > >Even if we will decide to remove kevent_get_events() in favour of ring
> > >buffer-only implementation, winting-for-event syscall will be
> > >essentially kevent_get_events() without pointer to the place where to
> > >put events.
> > 
> > Right, but this limitation of the interface is important.  It means the 
> > interface of the kernel is smaller: fewer possibilities for problems and 
> > fewer constraints if in future something should be changed (and smaller 
> > kernel).
> 
> Ok, lets see for ring buffer implementation right now, and then we will
> decide if we want to remove or to stay with kevent_get_events() syscall.

I agree that kevent_get_events() is duplicative and we shouldn't need it. 
Better to concentrate all our development effort on the single and most
flexible means of delivery.

