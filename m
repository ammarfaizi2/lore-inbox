Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276718AbRJHAcE>; Sun, 7 Oct 2001 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276719AbRJHAbq>; Sun, 7 Oct 2001 20:31:46 -0400
Received: from [195.223.140.107] ([195.223.140.107]:48633 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276718AbRJHAbk>;
	Sun, 7 Oct 2001 20:31:40 -0400
Date: Mon, 8 Oct 2001 02:31:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011008023118.L726@athlon.random>
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca> <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Oct 03, 2001 at 06:51:55PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I hope not to reiterate the obvious, I didn't read every single email
  of this thread ]

> > > In a generic computing environment i want to spend cycles doing useful
> > > work, not polling. Even the quick kpolld hack [which i dropped, so please
> > > dont regard it as a 'competitor' patch] i consider superior to this, as i
> > > can renice kpolld to reduce polling. (plus kpolld sucks up available idle
> > > cycles as well.) Unless i royally misunderstand it, i cannot stop the
> > > above code from wasting my cycles, and if that is true i do not want to
> > > see it in the kernel proper in this form.
> 
> On Wed, 3 Oct 2001, jamal wrote:
> > The interupt just flags "i, netdev, have work to do"; [...]
On Wed, Oct 03, 2001 at 06:51:55PM +0200, Ingo Molnar wrote:
> (and the only thing i pointed out was that the patch as-is did not limit
> the amount of polling done.)

You're perfectly right that it's not ok for a generic computing
environment to spend lots of cpu in polling, but it is clear that in a
dedicated router/firewall we can just shutdown the NIC interrupt forever via
disable_irq (no matter if the nic supports hw flow control or not, and
in turn no matter if the kid tries to spam the machine with small
packets) and dedicate 1 cpu to the polling-work with ksoftirqd polling
forever the NIC to deliver maximal routing performance or something like
that.  ksoftirqd will ensure fairness with the userspace load as well.
You probably wouldn't get a benefit with tux because you would
potentially lose way too much cpu with true polling and you're traffic
is mostly going from the server to the clients not the othet way around
(plus the clients uses delayed acks etc..), but the world isn't just
tux.

Of course we agree that such a "polling router/firewall" behaviour must
not be the default but it must be enabled on demand by the admin via
sysctl or whatever else userspace API. And I don't see any problem with
that.

Andrea
