Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754300AbWKISwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbWKISwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754358AbWKISwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:52:06 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:11756 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1753608AbWKISwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:52:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 9 Nov 2006 10:51:56 -0800 (PST)
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
Subject: Re: [take24 3/6] kevent: poll/select() notifications.
In-Reply-To: <11630606373650@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0611091047120.25481@alien.or.mcafeemobile.com>
References: <11630606373650@2ka.mipt.ru>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006, Evgeniy Polyakov wrote:

> +static int kevent_poll_callback(struct kevent *k)
> +{
> +	if (k->event.req_flags & KEVENT_REQ_LAST_CHECK) {
> +		return 1;
> +	} else {
> +		struct file *file = k->st->origin;
> +		unsigned int revents = file->f_op->poll(file, NULL);
> +
> +		k->event.ret_data[0] = revents & k->event.event;
> +		
> +		return (revents & k->event.event);
> +	}
> +}

You need to be careful that file->f_op->poll is not called inside the 
spin_lock_irqsave/spin_lock_irqrestore pair, since (even this came up 
during epoll developemtn days) file->f_op->poll might do a simple 
spin_lock_irq/spin_unlock_irq. This unfortunate constrain forced epoll to 
have a suboptimal double O(R) loop to handle LT events.



- Davide


