Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162028AbWKVKql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162028AbWKVKql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162037AbWKVKql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:46:41 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58556 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1162028AbWKVKqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:46:39 -0500
Date: Wed, 22 Nov 2006 13:44:16 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122104416.GD11480@2ka.mipt.ru>
References: <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <20061121184605.GA7787@2ka.mipt.ru> <4563FE71.4040807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4563FE71.4040807@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 13:44:19 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 11:38:25PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >I've checked the code.
> >Since it will be a union, it is impossible to use _sigev_thread and it
> >becomes just SIGEV_SIGNAL case with different delivery mechanism.
> >Is it what you want?
> 
> struct sigevent is defined like this:
> 
> typedef struct sigevent {
>         sigval_t sigev_value;
>         int sigev_signo;
>         int sigev_notify;
>         union {
>                 int _pad[SIGEV_PAD_SIZE];
>                  int _tid;
> 
>                 struct {
>                         void (*_function)(sigval_t);
>                         void *_attribute;       /* really pthread_attr_t */
>                 } _sigev_thread;
>         } _sigev_un;
> } sigevent_t;
> 
> 
> For the SIGEV_KEVENT case:
> 
>   sigev_notify is set to SIGEV_KEVENT (obviously)
> 
>   sigev_value can be used for the void* data passed along with the
>   signal, just like in the case of a signal delivery
> 
> Now you need a way to specify the kevent descriptor.  Just add
> 
>   int _kevent;
> 
> inside the union and if you want
> 
>   #define sigev_kevent_descr _sigev_un._kevent
> 
> That should be all.

That what I implemented.
But in this case it will be impossible to have SIGEV_THREAD and SIGEV_KEVENT
at the same time, it will be just the same as SIGEV_SIGNAL but with
different delivery mechanism. Is is what you expect for that?

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
