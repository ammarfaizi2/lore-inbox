Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTEUXop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTEUXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:44:45 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:434 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262383AbTEUXon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:44:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 21 May 2003 16:56:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
In-Reply-To: <20030520175922.GA19094@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0305211641190.4369@bigblue.dev.mcafeelabs.com>
References: <20030520010913.3300F2C05E@lists.samba.org>
 <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com>
 <20030520014403.GA14851@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0305200947460.3636@bigblue.dev.mcafeelabs.com>
 <20030520175922.GA19094@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Jamie Lokier wrote:

> > Not really Jamie. See a Futex event is not much different from a network
> > one. When the event shows up, one thread will pick it up (epoll_wait) and
> > will handle it. A futex event will very likely be a green light for some
> > sort of resource usage that whatever thread can pick up and handle.
>
> That is true when a futex represents some item of work to do, or
> readiness such as data coming in or going it.  Then it is quite
> reasonable to think of it like a pollable fd.
>
> But futexes are also used to represent contention for shared
> resources, and the properties needed for this are quite different.
>
> See futex_up_fair() in Rusty's futex-2.2 library.  That depends
> crucially on getting exactly the right number of wakeup tokens passed,
> and in the order the waiters blocked.
>
> To pick an example, consider a dynamic web server which is
> occasionally asked to render complex images, but where most of the
> content is easily generated.  You might have 30 concurrent page
> serving threads, but want to limit the number of threads which are
> generating a particularly complex response to 3 at a time because of
> memory constraints.
>
> You cannot program this as putting things on a work queue and having
> arbitrary threads pick them off, unless you are prepared to represent
> the problem as an explicit state machine, where the intermediate
> states can be represented as a data structure.  If the state is too
> complex for that, which is often a reason for using threads in the
> first place, that is not an option.

Jamie, if you use the one thread per connection model you don't need epoll
at all. The std poll() scale very well with one fd :) If you're using a
N:1 (N connections over one thread/task) you definitely need either a
state machine or something like coroutines. With futex->poll() (under
epoll) you can easily create the object you need to solve your server
problem. You create an object (structure) that contain the futex and a
list of coroutines/state-structures. You drop the pointer to this
structure inside data.ptr of the epoll fd data. When you get an event you
invoke/proceed with a FIFO order. When an object wait on this "mutex" you
drop the calling coroutine/state-structure inside the list tail. All those
ops (getting data from epoll event, removing list head, adding to tail)
are lightning fast. Actually, strictly speaking, you don't even need a
futex to do this with a N:1 model :) But you do need it for a N:M (M > 1) model.



- Davide

