Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270171AbTGNGR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270547AbTGNGR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:17:27 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:58240 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270171AbTGNGRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:17:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 23:24:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714055122.GA24031@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307132252310.15022@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
 <20030714025644.GA23110@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com>
 <20030714031614.GD23110@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307132018200.15022@bigblue.dev.mcafeelabs.com>
 <20030714034244.GC23534@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307132044350.15022@bigblue.dev.mcafeelabs.com>
 <20030714055122.GA24031@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > > (d) SO_RCVLOWAT < s
> >
> > This does not apply with non-blocking fds.
>
> Look at the line "if (copied >= target)" in tcp_recvmsg.

Look at this :

	timeo = sock_rcvtimeo(sk, nonblock);

;)


>
> > > (e) there is urgent data with OOBINLINE (I think)
> >
> > You obviously need an EPOLLPRI check in your read handling routine if you
> > app is expecting urgent data.
>
> Normal behaviour is for urgent data to be discarded, I believe.  Now
> if someone sends it to you, you'll end up with the socket stalling
> with pending data in the buffers.  Not saying whether you care, it's
> just a difference of behaviour to be noted and a potential DOS
> (filling socket buffers which app doesn't know to empty).

Yes, with OOBINLINE you need to take care of EPOLLPRI if you want to use
the read(2) trick. The OOB virtually break the read.



> > On Mon, 14 Jul 2003, Jamie Lokier wrote:
> >
> > > (a) fd isn't a socket
> > > (b) fd isn't a TCP socket
> >
> > Jamie, libraries, like for example libevent, are completely generic indeed.
> > They fetch events and they call the associated callback. You obviously
> > know inside your callback which kind of fd you working on.
>
> I disagree - inside a stream parser callback (e.g. XML transcoder) I
> prefer to _not_ know the difference between pipe, file, tty and socket
> that I am reading.

These are streams and you can use the read(2) trick w/out problems. I
don't think you want to mount your XML parser over UDP.



> > > (c) kernel version <= 2.5.75
> >
> > Obviously, POLLRDHUP is not yet inside the kernel :)
>
> Quite.  When you write an app that uses it and the read(2) trick
> you'll see the bug which Eric brought up :)
>
> I'm saying there's a way to write an app which can use the read(2)
> trick, yet which does _not_ hang on older kernels.  Hence is robust.

How, if you do not change the kernel by making it returning an extra flag ?



- Davide

