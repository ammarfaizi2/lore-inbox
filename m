Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWHCPMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWHCPMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWHCPME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:12:04 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:10651 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932566AbWHCPMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:12:03 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take3 1/4] kevent: Core files.
Date: Thu, 3 Aug 2006 17:11:58 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
References: <11545983603399@2ka.mipt.ru> <200608031640.34513.dada1@cosmosbay.com> <20060803145553.GA12915@2ka.mipt.ru>
In-Reply-To: <20060803145553.GA12915@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608031711.59261.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 16:55, Evgeniy Polyakov wrote:
> On Thu, Aug 03, 2006 at 04:40:34PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
wrote:
> > > +	mutex_lock(&u->ctl_mutex);
> > > +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> > > +		if (copy_to_user(buf + num*sizeof(struct ukevent),
> > > +					&k->event, sizeof(struct ukevent))) {
> > > +			cerr = -EINVAL;
> > > +			break;
> > > +		}
> >
> > It seems quite wrong to hold ctl_mutex while doing a copy_to_user() (of
> > possibly a large amount of data) : A thread can sleep on a page fault and
> > other threads cannot make progress.
>
> I would not call that wrong - system prevents some threads from removing
> kevents which are counted to be transfered to the userspace, i.e. when
> dequeuing was awakened and it had seen some events it is possible, that
> when it will dequeue them part will be removed by other thread, so I
> prevent this.

Hum, "wrong" was maybe not the good word.... but kqueue_dequeue_ready() uses a 
spinlock (ready_lock) to protect ready_list. One particular struct kevent is 
given to one thread, one at a time.

If you look at fs/eventpoll.c, you can see how carefull is ep_send_events() so 
that multiple threads can in the same time transfer different items to user 
memory.

In a model where several threads are servicing events collected by a single 
point (epoll, or kevent), this is important to not block all threads because 
of a single thread waiting a swapin (trigered by copy_to_user() )

Eric
