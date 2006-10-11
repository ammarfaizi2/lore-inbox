Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWJKQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWJKQkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWJKQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:40:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161122AbWJKQkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:40:08 -0400
Date: Wed, 11 Oct 2006 09:39:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
Subject: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
Message-Id: <20061011093920.32fc2d07.akpm@osdl.org>
In-Reply-To: <17708.60613.451322.747200@cse.unsw.edu.au>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	<17708.33450.608010.113968@cse.unsw.edu.au>
	<6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	<1160565786.3000.369.camel@laptopd505.fenrus.org>
	<17708.60613.451322.747200@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 23:08:21 +1000
Neil Brown <neilb@suse.de> wrote:

> On Wednesday October 11, arjan@infradead.org wrote:
> > 
> > > > blocking_notifier_call_chain is
> > > >         down_read(&nh->rwsem);
> > > >         ret = notifier_call_chain(&nh->head, val, v);
> > > >         up_read(&nh->rwsem);
> > > >
> > > > and so holds ->rwsem while calling the callback.
> > > > So the locking sequence ends up as:
> > > >
> > > >  down_read(&cpu_chain.rwsem);
> > > >  mutex_lock(&workqueue_mutex);
> > > >  up_read(&cpu_chain.rwsem);
> > > >
> > > >  down_read(&cpu_chain.rwsem);
> > > >  mutex_unlock(&workqueue_mutex);
> > > >  up_read(&workqueue_mutex);
> > > >
> > > > and lockdep doesn't seem to like this.  It sees workqueue_mutex
> > > > claimed while cpu_chain.rwsem is held. and then it sees
> > > > cpu_chain.rwsem claimed while workqueue_mutex is held, which looks a
> > > > bit like a class ABBA deadlock.
> > > > Of course because it is a 'down_read' rather than a 'down', it isn't
> > > > really a dead lock.
> > 
> > ok can you explain to me why "down_read" doesn't make this a deadlock
> > while "down" would make it a deadlock? I have trouble following your
> > reasoning.....
> > 
> > (remember that rwsems are strictly fair)
> 
> I see your point.
> 
> While thread A holds just workqueue_mutex,
> thread B takes cpu_chain.rwsem for read then tries to take
> workqueue_mutex and blocks.
> Now thread C tries to get a write lock on cpu_chain.rwsem and blocks
> as well.
> Finally thread A moves on to try to get a read lock on cpu_chain.rwsem
> and this blocks because thread C is waiting for a write lock.
> 
> So A waits on B and C, C waits on B, B waits on A.
> Deadlock.

Except the entire operation is serialised by the the two top-level callers
(cpu_up() and cpu_down()) taking mutex_lock(&cpu_add_remove_lock).  Can
lockdep be taught about that?

> Who do we blame this on?  Are you still the cpu-hot-plug guy Rusty?

It's fun blaming Rusty for stuff, but he can dodge this one with
more-than-usual ease, I'm afraid.
