Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWJKNIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWJKNIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWJKNIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:08:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:20110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751274AbWJKNIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:08:49 -0400
From: Neil Brown <neilb@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Date: Wed, 11 Oct 2006 23:08:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17708.60613.451322.747200@cse.unsw.edu.au>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, rusty@rustcorp.com.au
Subject: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
In-Reply-To: message from Arjan van de Ven on Wednesday October 11
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	<17708.33450.608010.113968@cse.unsw.edu.au>
	<6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	<1160565786.3000.369.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 11, arjan@infradead.org wrote:
> 
> > > blocking_notifier_call_chain is
> > >         down_read(&nh->rwsem);
> > >         ret = notifier_call_chain(&nh->head, val, v);
> > >         up_read(&nh->rwsem);
> > >
> > > and so holds ->rwsem while calling the callback.
> > > So the locking sequence ends up as:
> > >
> > >  down_read(&cpu_chain.rwsem);
> > >  mutex_lock(&workqueue_mutex);
> > >  up_read(&cpu_chain.rwsem);
> > >
> > >  down_read(&cpu_chain.rwsem);
> > >  mutex_unlock(&workqueue_mutex);
> > >  up_read(&workqueue_mutex);
> > >
> > > and lockdep doesn't seem to like this.  It sees workqueue_mutex
> > > claimed while cpu_chain.rwsem is held. and then it sees
> > > cpu_chain.rwsem claimed while workqueue_mutex is held, which looks a
> > > bit like a class ABBA deadlock.
> > > Of course because it is a 'down_read' rather than a 'down', it isn't
> > > really a dead lock.
> 
> ok can you explain to me why "down_read" doesn't make this a deadlock
> while "down" would make it a deadlock? I have trouble following your
> reasoning.....
> 
> (remember that rwsems are strictly fair)

I see your point.

While thread A holds just workqueue_mutex,
thread B takes cpu_chain.rwsem for read then tries to take
workqueue_mutex and blocks.
Now thread C tries to get a write lock on cpu_chain.rwsem and blocks
as well.
Finally thread A moves on to try to get a read lock on cpu_chain.rwsem
and this blocks because thread C is waiting for a write lock.

So A waits on B and C, C waits on B, B waits on A.
Deadlock.

I guess _cpu_down should
	down_read(&cpu_chain.rwsem);
and then call notifier_call_chain multiple times.  I wonder if that
would be safe.

Who do we blame this on?  Are you still the cpu-hot-plug guy Rusty?

NeilBrown
