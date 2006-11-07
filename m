Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752901AbWKGWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbWKGWxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbWKGWxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:53:41 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:47059 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1752901AbWKGWxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:53:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 7 Nov 2006 14:53:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 3/5] kevent: poll/select() notifications.
In-Reply-To: <11629182482792@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0611071449410.17731@alien.or.mcafeemobile.com>
References: <11629182482792@2ka.mipt.ru>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Evgeniy Polyakov wrote:

> +static int kevent_poll_wait_callback(wait_queue_t *wait,
> +		unsigned mode, int sync, void *key)
> +{
> +	struct kevent_poll_wait_container *cont =
> +		container_of(wait, struct kevent_poll_wait_container, wait);
> +	struct kevent *k = cont->k;
> +	struct file *file = k->st->origin;
> +	u32 revents;
> +
> +	revents = file->f_op->poll(file, NULL);
> +
> +	kevent_storage_ready(k->st, NULL, revents);
> +
> +	return 0;
> +}

Are you sure you can safely call file->f_op->poll() from inside a callback 
based wakeup? The low level driver may be calling the wakeup with one of 
its locks held, and during the file->f_op->poll may be trying to acquire 
the same lock. I remember there was a discussion about this, and assuming 
the above not true, made epoll code more complex (and slower, since an 
extra O(R) loop was needed to fetch events).



- Davide


