Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWJDGZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWJDGZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWJDGZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:25:36 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57566 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030397AbWJDGZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:25:35 -0400
Date: Wed, 4 Oct 2006 10:24:02 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061004062401.GA10965@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060922122207.3b716028.akpm@osdl.org> <20060923042350.GA24099@2ka.mipt.ru> <a36005b50610032309u2a8b5797x43e5cce2fbd1d18e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a36005b50610032309u2a8b5797x43e5cce2fbd1d18e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 04 Oct 2006 10:24:03 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:09:15PM -0700, Ulrich Drepper (drepper@gmail.com) wrote:
> On 9/22/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >The only two things missed in patchset after his suggestions are
> >new POSIX-like interface, which I personally consider as very unconvenient,
> 
> This means you really do not know at all what this is about.  We
> already have these interfaces.  Several of them and there will likely
> be more.  These are interfaces for functionality which needs the new
> event notification.  There is *NO* reason whatsoever to not make this

It looks I'm a bit puzzled...

Let me clarify my position about it.
Kevent as a generic event handling mechanism should not knwo about how
events were added. It was designed to be quite flexible, so one could
add events from essentially any possible situation.
One of the most common situations is userspace requests - they are added
through set of created syscalls. There can exists tons of quadrillions of
any other interfaces, I even specially created helper function for kernel 
subsystems (existing and new ones) which might want to create events
using own syscalls and parameters. For example network AIO work that way
- it has own syscalls, which parses parameters, creates ukevent
structure and pass them into kevent core, which in turn calls appropriate 
callbacks back to network AIO.

Everyone can add new interfaces in any way he likes, it would quite
silly to created new subsystem which would required strick API and
failed to work with different set of interfaces.

So from my point of view, problem is not in case that 'we need only this
API', but 'why new API is better that old one'.
It is possible to create new API, which will add events from _existing_
syscalls, it is just one function call from given syscall, I completely 
agree with it.
I'm just objecting against removing existing interface in favour of new
one.

People who need POSIX timer API - feel free to call
kevent_user_add_ukevent() from your favorite posix_timer_create().
Who needs signal queueing can do it even in signal() syscall - kevent
callback for that subsystem for example can update process' signal mask
and add kevents.

-- 
	Evgeniy Polyakov
