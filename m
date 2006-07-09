Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWGINYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWGINYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbWGINYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:24:34 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31386 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030496AbWGINYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:24:31 -0400
Date: Sun, 9 Jul 2006 17:24:29 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [RFC 0/4] kevent: generic kernel event processing subsystem.
Message-ID: <20060709132426.GA29435@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 09 Jul 2006 17:24:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developers.

I'm pleased to announce in linux-kernel@ mail list kevent subsystem 
which incorporates several AIO/kqueue design notes and ideas.
Kevent can be used both for edge and level notifications. It supports
socket notifications, network AIO (aio_send(), aio_recv() and
aio_sendfile()), inode notifications (create/remove),
generic poll()/select() notifications and timer notifications.

Short implementation details.
storage - each source of events (socket, inode, timer, aio) 
has structure kevent_storage incorporated into it, which is 
basically a list of registered interests for this source of events.
user - it is abstraction which holds all requested kevents. 
It is similar to FreeBSD's kqueue.

kevent - set of interests for given source of events or storage.

Each kevent now is queued into three lists:

    * kevent_user->kevent_list - list of all registered kevents.
    * kevent_user->ready_list - list of ready kevents.
    * kevent_storage->list - list of all interests for given kevent_storage.

When kevent is queued into storage, it will live there until 
removed by kevent_dequeue(). When some activity is noticed in 
given storage, it scans it's kevent_storage->list for kevents 
which match activity event. If kevents are found and they are 
not already in the kevent_user->ready_list, they will be added 
there at the end.

It is possible wait until either requested number of kevents are 
ready or timeout elapsed or at least one kevent is ready, 
it's behaviour depends on parameters.

Any event can be added/removed/modified by ioctl or one control syscall.

It was tested against FreeBSD kqueue and Linux epoll and showed
very noticeble performance win.

Network asynchronous IO operations were tested against Linux synchronous
socket code and showed noticeble performance win.

I would like to hear some comments about the overall design,
implementation and plans about it's usefullness for generic kernel.
Kevent patches were discussed several times already (project was created 
quite long time ago), and there were present no major negative feedback
except some high-level API changes. The latest discussion can be found 
at [4].

Design notes, patches, userspace application and perfomance tests can be
found at project's homepages.

1. Kevent subsystem.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

2. Network AIO.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=naio

3. LWN article about kevent.
http://lwn.net/Articles/172844/

4. The latest discussion in netdev@ mail list.
http://thread.gmane.org/gmane.linux.network/37595/focus=37673

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

-- 
	Evgeniy Polyakov
