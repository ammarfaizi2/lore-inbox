Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWHCPWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWHCPWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWHCPWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:22:37 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:32211 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964776AbWHCPWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:22:36 -0400
Date: Thu, 3 Aug 2006 19:21:42 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take3 1/4] kevent: Core files.
Message-ID: <20060803152142.GB14774@2ka.mipt.ru>
References: <11545983603399@2ka.mipt.ru> <200608031640.34513.dada1@cosmosbay.com> <20060803145553.GA12915@2ka.mipt.ru> <200608031711.59261.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200608031711.59261.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:21:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 05:11:58PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Thursday 03 August 2006 16:55, Evgeniy Polyakov wrote:
> > On Thu, Aug 03, 2006 at 04:40:34PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
> wrote:
> > > > +	mutex_lock(&u->ctl_mutex);
> > > > +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> > > > +		if (copy_to_user(buf + num*sizeof(struct ukevent),
> > > > +					&k->event, sizeof(struct ukevent))) {
> > > > +			cerr = -EINVAL;
> > > > +			break;
> > > > +		}
> > >
> > > It seems quite wrong to hold ctl_mutex while doing a copy_to_user() (of
> > > possibly a large amount of data) : A thread can sleep on a page fault and
> > > other threads cannot make progress.
> >
> > I would not call that wrong - system prevents some threads from removing
> > kevents which are counted to be transfered to the userspace, i.e. when
> > dequeuing was awakened and it had seen some events it is possible, that
> > when it will dequeue them part will be removed by other thread, so I
> > prevent this.
> 
> Hum, "wrong" was maybe not the good word.... but kqueue_dequeue_ready() uses a 
> spinlock (ready_lock) to protect ready_list. One particular struct kevent is 
> given to one thread, one at a time.

I mean that wait_event logic will see that there are requested number of
events, and when it starts to get them, it is possible that there will
be no events at all. 

> If you look at fs/eventpoll.c, you can see how carefull is ep_send_events() so 
> that multiple threads can in the same time transfer different items to user 
> memory.

It is done under the same logic under ep->sem semaphore, which is being
held for del and read operations.
Or do you mean to have rw semahore instead of mutex here?

> In a model where several threads are servicing events collected by a single 
> point (epoll, or kevent), this is important to not block all threads because 
> of a single thread waiting a swapin (trigered by copy_to_user() )
 
> Eric

-- 
	Evgeniy Polyakov
