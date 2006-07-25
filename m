Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWGYG0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWGYG0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWGYG0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:26:43 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34227 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751446AbWGYG0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:26:42 -0400
Date: Tue, 25 Jul 2006 10:26:29 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060725062625.GA29242@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060724.231708.01289489.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 25 Jul 2006 10:26:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 11:17:08PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Sun, 9 Jul 2006 17:24:46 +0400
> 
> > This patch includes core kevent files:
> >  - userspace controlling
> >  - kernelspace interfaces
> >  - initialisation
> >  - notification state machines
> > 
> > It might also inlclude parts from other subsystem (like network related
> > syscalls so it is possible that it will not compile without other
> > patches applied).
> > 
> > Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> I like this work a lot, as I've stated before.  The data structures
> look like they will scale well and it takes care of all the limitations
> that networking in particular seems to have in this area.
> 
> I have to say that the user API is not the nicest in the world.  Yet,
> at the same time, I cannot think of a better one :)

Hi David. I see you have a day of backlog mails processing :)

> Please, remove some grot such as this:
> 
> > +	if (kevent_cache)
> > +		k = kmem_cache_alloc(kevent_cache, mask);
> > +	else
> > +		k = kzalloc(sizeof(struct kevent), mask);
>  ...
> > +	if (kevent_cache)
> > +		kmem_cache_free(kevent_cache, k);
> > +	else
> > +		kfree(k);
> 
> Instead, make this:
> 
> > +	kevent_cache = kmem_cache_create("kevent_cache", 
> > +			sizeof(struct kevent), 0, 0, NULL, NULL);
> > +	if (!kevent_cache)
> > +		err = -ENOMEM;
> 
> panic().  This is consistent with how other core subsystems handle
> SLAB cache creation failures.

Ok.

> I also think that if we accept this work, it should be first class
> citizen with no config options and no ifdefs scattered all over.
> Either this is how we do network AIO or it is not.
> 
> I've looked only briefly at Ulrich Drepper's AIO proposal in his OLS
> slides, although the DMA bits do not initially strike me as such a hot
> idea.  I haven't wrapped my brain much around this new stuff, so I'm
> not going to touch on it much more just yet.

Yes, his idea of dma alloc is extremely good.
I manage it with quite big overhead in kevent unfortunately.
All other topics are fully covered with kevent (except nice userspace
API of course :) )

> The practical advantage kevent has over any new proposal is that 1)
> implementation exists :) and 2) several types of test applications and
> performance measurements have been made against it which usually
> flushes out the worst design issues.

I will clean code up and resubmit today.
Thank you.

-- 
	Evgeniy Polyakov
