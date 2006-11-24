Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934526AbWKXJxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934526AbWKXJxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934531AbWKXJxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:53:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:28034 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934526AbWKXJxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:53:07 -0500
Date: Fri, 24 Nov 2006 12:50:52 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: Kevent POSIX timers support.
Message-ID: <20061124095052.GC13600@2ka.mipt.ru>
References: <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru> <20061123085243.GA11575@2ka.mipt.ru> <456603E7.9090006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456603E7.9090006@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 12:50:55 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:26:15PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >+static int posix_kevent_init(void)
> >+{
> >+	struct kevent_callbacks tc = {
> >+		.callback = &posix_kevent_callback,
> >+		.enqueue = &posix_kevent_enqueue,
> >+		.dequeue = &posix_kevent_dequeue};
> 
> How do we prevent that somebody tries to register a POSIX timer event 
> source with kevent_ctl(KEVENT_CTL_ADD)?  This should only be possible 
> from sys_timer_create and nowhere else.
> 
> Can you add a parameter to kevent_enqueue indicating this is a call from 
> inside the kernel and then ignore certain enqueue callbacks?

I think we need some set of flags for callbacks - where they can be
called, maybe even from which context and so on. So userspace will not
be allowed to create such timers through kevent API.
Will do it for release.
 
> >@@ -343,23 +439,27 @@ static int posix_timer_fn(struct hrtimer
> > 
> > 	timr = container_of(timer, struct k_itimer, it.real.timer);
> > 	spin_lock_irqsave(&timr->it_lock, flags);
> >+	
> >+	if (timr->it_sigev_notify & SIGEV_KEVENT) {
> >+		kevent_storage_ready(&timr->st, NULL, KEVENT_MASK_ALL);
> >+	} else {
> 
> We need to pass the data in the sigev_value meember of the struct 
> sigevent structure passed to timer_create to the caller.  I don't see it 
> being done here nor when the timer is created.  Do I miss something? 
> The sigev_value value should be stored in the user/ptr member of struct 
> ukevent.

sigev_value was stored in k_itimer structure, I just do not know where
to put it in the ukevent provided to userspace - it can be placed in
pointer value if you like.

> >+		if (event.sigev_notify & SIGEV_KEVENT) {
> 
> Don't use a bit.  It makes no sense to combine SIGEV_SIGNAL with 
> SIGEV_KEVENT etc.  Only SIGEV_THREAD_ID is a special case.
> 
> Just define SIGEV_KEVENT to 3 and replace the tests like the one cited 
> above with
> 
>   if (timr->it_sigev_notify == SIGEV_KEVENT)

Ok.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
