Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270534AbTGNFhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270535AbTGNFhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:37:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16789 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270534AbTGNFhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:37:22 -0400
Date: Mon, 14 Jul 2003 06:51:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714055122.GA24031@mail.jlokier.co.uk>
References: <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714025644.GA23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com> <20030714031614.GD23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132018200.15022@bigblue.dev.mcafeelabs.com> <20030714034244.GC23534@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132044350.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307132044350.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh!  I realised why we're mis-communicating.

I started in the assumption that you're using POLLRDHUP to trigger a
second read, but you're using it in a different way (makes sense given
the name!)

You're assuming that a short read is always the last one with data,
that's the read() trick, and detecting EOF is really a wholly separate
problem.

Ah..

First let's get the misc bits out of the way.

Davide Libenzi wrote:
> > (d) SO_RCVLOWAT < s
> 
> This does not apply with non-blocking fds.

Look at the line "if (copied >= target)" in tcp_recvmsg.

> > (e) there is urgent data with OOBINLINE (I think)
> 
> You obviously need an EPOLLPRI check in your read handling routine if you
> app is expecting urgent data.

Normal behaviour is for urgent data to be discarded, I believe.  Now
if someone sends it to you, you'll end up with the socket stalling
with pending data in the buffers.  Not saying whether you care, it's
just a difference of behaviour to be noted and a potential DOS
(filling socket buffers which app doesn't know to empty).

Now on to the important stuff.

> On Mon, 14 Jul 2003, Jamie Lokier wrote:
> 
> > (a) fd isn't a socket
> > (b) fd isn't a TCP socket
> 
> Jamie, libraries, like for example libevent, are completely generic indeed.
> They fetch events and they call the associated callback. You obviously
> know inside your callback which kind of fd you working on.

I disagree - inside a stream parser callback (e.g. XML transcoder) I
prefer to _not_ know the difference between pipe, file, tty and socket
that I am reading.

> So you use the reading function that best fit the fd type. Obviously
> the read(2) trick only works for stream type fds.

Stream fds provided you don't hit the unusual cases.

Point taken.  Now I'm saying there's an interface which is no more or
less complicated, but _doesn't_ require you to treat different kinds
of fds differently.  So I can write code which uses the read() trick
universally without having to pass that extra parameter,
EOF_SETS_RDHUP, to the event callback :)

> > (c) kernel version <= 2.5.75
> 
> Obviously, POLLRDHUP is not yet inside the kernel :)

Quite.  When you write an app that uses it and the read(2) trick
you'll see the bug which Eric brought up :)

I'm saying there's a way to write an app which can use the read(2)
trick, yet which does _not_ hang on older kernels.  Hence is robust.

My overall philosophy on this:

    The less object A needs to know about object B, the better, right?

Right? :)

-- Jamie
