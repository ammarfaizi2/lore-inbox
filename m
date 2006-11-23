Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757457AbWKWU1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbWKWU1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757364AbWKWU1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:27:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933877AbWKWU1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:27:08 -0500
Message-ID: <456603E7.9090006@redhat.com>
Date: Thu, 23 Nov 2006 12:26:15 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: Kevent POSIX timers support.
References: <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com> <20061122104416.GD11480@2ka.mipt.ru> <20061123085243.GA11575@2ka.mipt.ru>
In-Reply-To: <20061123085243.GA11575@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> +static int posix_kevent_init(void)
> +{
> +	struct kevent_callbacks tc = {
> +		.callback = &posix_kevent_callback,
> +		.enqueue = &posix_kevent_enqueue,
> +		.dequeue = &posix_kevent_dequeue};

How do we prevent that somebody tries to register a POSIX timer event 
source with kevent_ctl(KEVENT_CTL_ADD)?  This should only be possible 
from sys_timer_create and nowhere else.

Can you add a parameter to kevent_enqueue indicating this is a call from 
inside the kernel and then ignore certain enqueue callbacks?


> @@ -343,23 +439,27 @@ static int posix_timer_fn(struct hrtimer
>  
>  	timr = container_of(timer, struct k_itimer, it.real.timer);
>  	spin_lock_irqsave(&timr->it_lock, flags);
> +	
> +	if (timr->it_sigev_notify & SIGEV_KEVENT) {
> +		kevent_storage_ready(&timr->st, NULL, KEVENT_MASK_ALL);
> +	} else {

We need to pass the data in the sigev_value meember of the struct 
sigevent structure passed to timer_create to the caller.  I don't see it 
being done here nor when the timer is created.  Do I miss something? 
The sigev_value value should be stored in the user/ptr member of struct 
ukevent.


> +		if (event.sigev_notify & SIGEV_KEVENT) {

Don't use a bit.  It makes no sense to combine SIGEV_SIGNAL with 
SIGEV_KEVENT etc.  Only SIGEV_THREAD_ID is a special case.

Just define SIGEV_KEVENT to 3 and replace the tests like the one cited 
above with

   if (timr->it_sigev_notify == SIGEV_KEVENT)

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
