Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267406AbTAWWJz>; Thu, 23 Jan 2003 17:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTAWWJy>; Thu, 23 Jan 2003 17:09:54 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:12761 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267406AbTAWWJx>;
	Thu, 23 Jan 2003 17:09:53 -0500
Date: Thu, 23 Jan 2003 22:18:58 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030123221858.GA8581@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123204056.GC2490@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> Sorry... not 1 in 1001... almost 100% chance of returning of one
> jiffie too many.

It's curious that select() is different from poll() - almost is if
completely different people wrote the code :)

We have to wonder whether it was a design decision.
Perhaps the unix specifications require it (see below).

> In practice, even on a relatively idle system, the process will not
> be able to wake up as frequently as it might be able to expect.

You're right - it's unfortunate that using poll() lets you sleep and
wake up no faster than every _two_ ticks.  That's actually caused by
poll()'s treating zero differently though, not by +1 as such.

There's a strange contradiction between rounding up the waiting time
to the next number of jiffies, and then rounding it down (in a
time-dependent way) by waiting until the next N'th timer interrupt.

If, as someone said, the appropriate unix specification says that
"wait for 10ms" means to wait for _at minimum_ 10ms, then you do need
the +1.

(Davide), IMHO epoll should decide whether it means "at minimum" (in
which case the +1 is a requirement), or it means "at maximum" (in
which case rounding up is wrong).

The current method of rounding up and then effectively down means that
you get an unpredictable mixture of both.

-- Jamie

ps. I would always prefer an absolute wakeup time anyway - it avoids a
race condition too.  What a shame none of the system calls work that way.

pps. To summarise, all the time APIs are a complete mess in unix, and
there's nothing you can do in user space to make up for the b0rken
system call interface.  Except not duplicate past errors in new interfaces :)
