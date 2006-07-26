Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWGZIzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWGZIzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWGZIzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:55:42 -0400
Received: from dea.vocord.ru ([217.67.177.50]:14222 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1030413AbWGZIzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:55:41 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>
Subject: [0/4] kevent: generic event processing subsystem.
In-Reply-To: <20060726062817.GA20636@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 26 Jul 2006 13:18:14 +0400
Message-Id: <11539054941027@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kevent subsystem incorporates several AIO/kqueue design notes and ideas.
Kevent can be used both for edge and level notifications. It supports
socket notifications (accept, send, recv), network AIO (aio_send(),
aio_recv() and aio_sendfile()), inode notifications (create/remove),
generic poll()/select() notifications and timer notifications.

There are several object in the kevent system:
storage - each source of events (socket, inode, timer, aio, anything) has
	structure kevent_storage incorporated into it, which is basically a list
	of registered interests for this source of events.
user - it is abstraction which holds all requested kevents. It is
	similar to FreeBSD's kqueue.
kevent - set of interests for given source of events or storage.

When kevent is queued into storage, it will live there until removed by
kevent_dequeue(). When some activity is noticed in given storage, it
scans it's kevent_storage->list for kevents which match activity event.
If kevents are found and they are not already in the
kevent_user->ready_list, they will be added there at the end.

ioctl(WAIT) (or appropriate syscall) will wait until either requested
number of kevents are ready or timeout elapsed or at least one kevent is
ready, it's behaviour depends on parameters.

It is possible to have one-shot kevents, which are automatically removed
when are ready.

Any event can be added/removed/modified by ioctl or special controlling
syscall.

Network AIO is based on kevent and works as usual kevent storage on top
of inode.
When new socket is created it is associated with that inode and when
some activity is detected appropriate notifications are generated and
kevent_naio_callback() is called.
When new kevent is being registered, network AIO ->enqueue() callback
simply marks itself like usual socket event watcher. It also locks
physical userspace pages in memory and stores appropriate pointers in
private kevent structure. I have not created additional DMA memory
allocation methods, like Ulrich described in his article, so I handle it
inside NAIO which has some overhead (I posted get_user_pages()
sclability graph some time ago).
Network AIO callback gets pointers to userspace pages and tries to copy
data from receiving skb queue into them using protocol specific
callback. This callback is very similar to ->recvmsg(), so they could
share a lot in future (as far as I recall it worked only with hardware
capable to do checksumming, I'm a bit lazy).

Both network and aio implementation work on top of hooks inside
appropriate state machines, but not as repeated call design (curect AIO) 
or special thread (SGI AIO). AIO work was stopped, since I was unable to 
achieve the same speed as synchronous read 
(maximum speeds were 2Gb/sec vs. 2.1 GB/sec for aio and sync IO accordingly
when reading data from the cache).
Network aio_sendfile() works lazily - it asynchronously populates pages
into the VFS cache (which can be used for various tricks with adaptive
readahead) and then uses usual ->sendfile() callback.

I have not created an interface for userspace events (like Solaris), 
since right now I do not see it's usefullness, but if there is
requirements for that it is quite easy with kevents.

Patches currently include ifdefs and kevent can be disabled in config,
when things are settled that can be removed.

1. kevent homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

2. network aio homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=naio

3. LWN.net published a very good article about kevent.
http://lwn.net/Articles/172844/

Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

