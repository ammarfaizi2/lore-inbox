Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965893AbWKHOvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965893AbWKHOvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965895AbWKHOvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:51:14 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:48772 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S965893AbWKHOvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:51:12 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
Date: Wed, 8 Nov 2006 15:51:13 +0100
User-Agent: KMail/1.9.5
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
References: <1154985aa0591036@2ka.mipt.ru> <20061107141718.f7414b31.akpm@osdl.org> <20061108082147.GA2447@2ka.mipt.ru>
In-Reply-To: <20061108082147.GA2447@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_i7eUF/uHD39geVt"
Message-Id: <200611081551.14671.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_i7eUF/uHD39geVt
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 08 November 2006 09:21, Evgeniy Polyakov wrote:
> On Tue, Nov 07, 2006 at 02:17:18PM -0800, Andrew Morton (akpm@osdl.org) 
wrote:
> > From: Andrew Morton <akpm@osdl.org>
> >
> > If kevent_user_wait() gets -EFAULT on the attempt to copy the first
> > event, it will return 0, which is indistinguishable from "no events
> > pending".
> >
> > It can and should return EFAULT in this case.
>
> Correct, I missed that.
> Thanks Andrew, I will put into my tree, -mm seems to have it already.

I believe eventpoll has a similar problem. Not a big problem, but we can be 
cleaner. Normally, the access_ok() done in sys_epoll_wait() should catch non 
writeable user area, unless another thread play VM game (the thread in 
sys_epoll_wait() can sleep)

[PATCH] eventpoll : In case a fault occurs during copy_to_user(), we should 
report the count of events that were successfully copied into user space, 
instead of EFAULT. That would be consistent with behavior of read/write() 
syscalls for example.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--Boundary-00=_i7eUF/uHD39geVt
Content-Type: text/plain;
  charset="koi8-r";
  name="eventpoll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="eventpoll.patch"

--- linux/fs/eventpoll.c	2006-11-08 15:37:36.000000000 +0100
+++ linux/fs/eventpoll.c	2006-11-08 15:38:31.000000000 +0100
@@ -1447,7 +1447,7 @@
 				       &events[eventcnt].events) ||
 			    __put_user(epi->event.data,
 				       &events[eventcnt].data))
-				return -EFAULT;
+				return eventcnt ? eventcnt : -EFAULT;
 			if (epi->event.events & EPOLLONESHOT)
 				epi->event.events &= EP_PRIVATE_BITS;
 			eventcnt++;

--Boundary-00=_i7eUF/uHD39geVt--
