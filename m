Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754457AbWKHIrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbWKHIrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbWKHIrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:47:19 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34756 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754456AbWKHIrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:47:18 -0500
Date: Wed, 8 Nov 2006 11:45:54 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 3/5] kevent: poll/select() notifications.
Message-ID: <20061108084554.GD2447@2ka.mipt.ru>
References: <11629182482792@2ka.mipt.ru> <Pine.LNX.4.64.0611071449410.17731@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071449410.17731@alien.or.mcafeemobile.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 08 Nov 2006 11:46:17 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 02:53:33PM -0800, Davide Libenzi (davidel@xmailserver.org) wrote:
> On Tue, 7 Nov 2006, Evgeniy Polyakov wrote:
> 
> > +static int kevent_poll_wait_callback(wait_queue_t *wait,
> > +		unsigned mode, int sync, void *key)
> > +{
> > +	struct kevent_poll_wait_container *cont =
> > +		container_of(wait, struct kevent_poll_wait_container, wait);
> > +	struct kevent *k = cont->k;
> > +	struct file *file = k->st->origin;
> > +	u32 revents;
> > +
> > +	revents = file->f_op->poll(file, NULL);
> > +
> > +	kevent_storage_ready(k->st, NULL, revents);
> > +
> > +	return 0;
> > +}
> 
> Are you sure you can safely call file->f_op->poll() from inside a callback 
> based wakeup? The low level driver may be calling the wakeup with one of 
> its locks held, and during the file->f_op->poll may be trying to acquire 
> the same lock. I remember there was a discussion about this, and assuming 
> the above not true, made epoll code more complex (and slower, since an 
> extra O(R) loop was needed to fetch events).

Indeed, I have not paid too much attention to poll/select notifications in 
kevent actually. As far as I recall it should be called on behalf of process 
doing kevent_get_event(). I will check and fix if that is not correct.
Thanks Davide.
 
> - Davide
> 

-- 
	Evgeniy Polyakov
