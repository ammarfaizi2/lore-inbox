Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSKSPRS>; Tue, 19 Nov 2002 10:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266240AbSKSPRS>; Tue, 19 Nov 2002 10:17:18 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:33669 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265863AbSKSPRR>;
	Tue, 19 Nov 2002 10:17:17 -0500
Date: Tue, 19 Nov 2002 15:24:36 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Grant Taylor <gtaylor+lkml_ihdeh111902@picante.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119152436.GA6663@bjl1.asuk.net>
References: <200211190549.gAJ5nGmU007542@habanero.picante.com> <20021119062205.GC17927@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119062205.GC17927@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Tue, Nov 19, 2002 at 12:49:16AM -0500, Grant Taylor wrote:
> > For example, sometimes TCP reads return EAGAIN when in fact they have
> > data.  This seems to stem from the case where the signal is found
> > before the first segment copy (from tcp.c circa 1425, there's even a
> > handy FIXME note there).  If you use epoll and get an EAGAIN, you have
> > no idea if it was a signal or a real empty socket unless you are also
> > very careful to notice when you got a signal during the read.
> 
> I hope this isn't a stupid question: Why doesn't the code you speak of
> return EINTR instead of EAGAIN?

Mark's right, it should be EINTR.  EAGAIN shouldn't break any
single-thread user state machines using poll/select, as a non-blocking
read is always allowed to return EAGAIN for any transient reason.

I'm not sure if EAGAIN can cause a poll() wakeup event to be missed.
If so, that would be a TCP bug that breaks epoll, and it would also
break some user state machines using poll/select, when there are
multiple processes waiting on a socket.

-- Jamie
