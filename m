Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTAWPeA>; Thu, 23 Jan 2003 10:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTAWPd7>; Thu, 23 Jan 2003 10:33:59 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:41176 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265355AbTAWPd5>;
	Thu, 23 Jan 2003 10:33:57 -0500
Date: Thu, 23 Jan 2003 15:43:04 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030123154304.GA7665@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> >From a mathematical point of view this is a ceil(v)+1, so this is wrong.
> It should be :
> 
> t = (t * HZ + 999) / 1000;
> 
> The +999 already gives you the round up.  Different is if we want to be
> sure to sleep at least that amount of jiffies ( the rounded up ), in that
> case since the timer tick might arrive immediately after we go to sleep by
> making us to lose immediately a jiffie, we need another +1. Anyway I'll do
> the round up. Same for the overflow check.

I wonder if it's appropriate to copy sys_poll(), which has the +1, or
sys_select(), which doesn't!

> > And that the prototypes for ep_poll() and sys_epoll_wait() be changed
> > to take a "long timeout" instead of an "int", just like sys_poll().
> 
> I don't see why. The poll(2) timeout is an int.

poll(2) takes an int, but sys_poll() takes a long.
I think everyone is confused :)

The reason I suggested "long timeout" for ep_poll is because the
multiply in the expression:

	jtimeout = (unsigned long)(timeout*HZ+999)/1000;

can overflow if you don't.  If you stick with the int, you'll need to
write:

	jtimeout = (((unsigned long)timeout)*HZ+999)/1000;

-- Jamie
