Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWJKLXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWJKLXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWJKLXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:23:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54928 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030289AbWJKLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:23:53 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	 <6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	 <17708.33450.608010.113968@cse.unsw.edu.au>
	 <6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 13:23:06 +0200
Message-Id: <1160565786.3000.369.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > blocking_notifier_call_chain is
> >         down_read(&nh->rwsem);
> >         ret = notifier_call_chain(&nh->head, val, v);
> >         up_read(&nh->rwsem);
> >
> > and so holds ->rwsem while calling the callback.
> > So the locking sequence ends up as:
> >
> >  down_read(&cpu_chain.rwsem);
> >  mutex_lock(&workqueue_mutex);
> >  up_read(&cpu_chain.rwsem);
> >
> >  down_read(&cpu_chain.rwsem);
> >  mutex_unlock(&workqueue_mutex);
> >  up_read(&workqueue_mutex);
> >
> > and lockdep doesn't seem to like this.  It sees workqueue_mutex
> > claimed while cpu_chain.rwsem is held. and then it sees
> > cpu_chain.rwsem claimed while workqueue_mutex is held, which looks a
> > bit like a class ABBA deadlock.
> > Of course because it is a 'down_read' rather than a 'down', it isn't
> > really a dead lock.

ok can you explain to me why "down_read" doesn't make this a deadlock
while "down" would make it a deadlock? I have trouble following your
reasoning.....

(remember that rwsems are strictly fair)


