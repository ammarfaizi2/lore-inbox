Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWHABDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWHABDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWHABDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:03:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51102
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751538AbWHABDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:03:10 -0400
Date: Mon, 31 Jul 2006 18:02:26 -0700 (PDT)
Message-Id: <20060731.180226.131918297.davem@davemloft.net>
To: zach.brown@oracle.com
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44C91192.4090303@oracle.com>
References: <20060709132446.GB29435@2ka.mipt.ru>
	<20060724.231708.01289489.davem@davemloft.net>
	<44C91192.4090303@oracle.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zach Brown <zach.brown@oracle.com>
Date: Thu, 27 Jul 2006 12:18:42 -0700

[ I kept this thread around in my inbox because I wanted to give it
  some deep thought, so sorry for replying to old bits... ]

> So as the kernel generates events in the ring it only produces an event
> if the ownership field says that userspace has consumed it and in doing
> so it sets the ownership field to tell userspace that an event is
> waiting.  userspace and the kernel now each follow their index around
> the ring as the ownership field lets them produce or consume the event
> at their index.  Can someone tell me if the cache coherence costs of
> this are extreme?  I'm hoping they're not.

No need for an owner field, we can use something like a VJ
netchannel datastructure for this.  Kernel only writes to
producer index and user only writes to consumer index.

> So, great, glibc can now find pending events very quickly if they're
> waiting in the ring and can fall back to the collection syscall if it
> wants to wait and the ring is empty.  If it consumes events via the
> syscall it increases its ring index by the number the syscall returned.

I do not think if we do a ring buffer that events should be obtainable
via a syscall at all.  Rather, I think this system call should be
purely "sleep until ring is not empty".

This is actually reasonably simple stuff to implement as Evgeniy
has tried to explain.

Events in kevent live on a ready list when they have triggered.
Existence on a list determined the state, and I think this design
btw invalidates some of the arguments against using netlink that
Ulrich mentions in his paper.  If netlink socket queuing fails,
well then kevent stays on ready list and that is all until the
kevent can be successfully published to the user.

I am not advocating netlink at all for this, as the ring buffer idea
is much better.

The ring buffer size, as Evgeniy also tried to describe, is bounded
purely by the number of registered events.  So event loop of
application might look something like this:

	struct ukevent cur_event;
	struct timeval timeo;

	setup_timeout(&timeo);
	for (;;) {
		int err;
		while(!(err = ukevent_dequeue(evt_fd, evt_ring,
					      &cur_event, &timeo))) {
			struct my_event_object *o =
				event_to_object(&cur_event);
			o->dispatch(o, &cur_event);
			setup_timeout(&timeo);
		}
		if (err == -ETIMEDOUT)
			timeout_processing();
		else
			event_error_processing(err);
	}

ukevent_dequeue() is perhaps some GLIBC implemented routine which does
something like:

	int err;

	for (;;) {
		if (!evt_ring_empty(evt_ring)) {
			struct ukevent *p = evt_ring_consume(evt_ring);
			memcpy(event_p, p, sizeof(struct ukevent));
			return 0;
		}
		err = kevent_wait(evt_fd, timeo_p);
		if (err < 0)
			break;
	}
	return err;

It's just some stupid ideas... we could also choose to expose the ring
buffer layout directly to the user event loop and let it perform the
dequeue operation and kevent_wait() calls directly.  I don't see why
not to allow that.
