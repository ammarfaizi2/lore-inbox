Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTAWRKT>; Thu, 23 Jan 2003 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTAWRKT>; Thu, 23 Jan 2003 12:10:19 -0500
Received: from adedition.com ([216.209.85.42]:45839 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265414AbTAWRKS>;
	Thu, 23 Jan 2003 12:10:18 -0500
Date: Thu, 23 Jan 2003 12:27:34 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <jamie@shareable.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030123172734.GA2490@mark.mielke.cc>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123154304.GA7665@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 03:43:04PM +0000, Jamie Lokier wrote:
> Davide Libenzi wrote:
> > >From a mathematical point of view this is a ceil(v)+1, so this is wrong.
> > It should be :
> > t = (t * HZ + 999) / 1000;
> > The +999 already gives you the round up.  Different is if we want to be
> > sure to sleep at least that amount of jiffies ( the rounded up ), in that
> > case since the timer tick might arrive immediately after we go to sleep by
> > making us to lose immediately a jiffie, we need another +1. Anyway I'll do
> > the round up. Same for the overflow check.
> I wonder if it's appropriate to copy sys_poll(), which has the +1, or
> sys_select(), which doesn't!

Or, fix sys_poll(). With the +1, this means that sys_poll() would have
a 1 in 1001 chance per second of returning one jiffie too early.

> > > And that the prototypes for ep_poll() and sys_epoll_wait() be changed
> > > to take a "long timeout" instead of an "int", just like sys_poll().
> > I don't see why. The poll(2) timeout is an int.
> poll(2) takes an int, but sys_poll() takes a long.
> I think everyone is confused :)
> The reason I suggested "long timeout" for ep_poll is because the
> multiply in the expression:
> 	jtimeout = (unsigned long)(timeout*HZ+999)/1000;
> can overflow if you don't.  If you stick with the int, you'll need to
> write:
> 	jtimeout = (((unsigned long)timeout)*HZ+999)/1000;

On a 16 bit platform, perhaps... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

