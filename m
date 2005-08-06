Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVHFAY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVHFAY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVHFAYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:24:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10897 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262091AbVHFAYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:24:10 -0400
Subject: Re: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
In-Reply-To: <20050805212808.GV8074@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
	 <1123252591.18332.45.camel@localhost.localdomain>
	 <20050805200156.GF7425@waste.org>
	 <1123275420.18332.81.camel@localhost.localdomain>
	 <20050805212808.GV8074@waste.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 20:23:55 -0400
Message-Id: <1123287835.18332.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 14:28 -0700, Matt Mackall wrote:
> 
> Netpoll generally must assume it won't get a second chance, as it's
> being called by things like oops() and panic() and used by things like
> kgdb. If netpoll fails, the box is dead anyway.
> 

But it is also being called by every printk in the kernel. What happens
when the printk that causes this lock up is not a panic but just some
info print.  One would use netconsole when they turn on more verbose
printing, to keep the output fast, right?  So if the system gets a
little memory tight, but not to the point of failing, this will cause a
lock up and no one would know why. 

If you need to really get the data out, then the design should be
changed.  Have some return value showing the failure, check for
oops_in_progress or whatever, and try again after turning interrupts
back on, and getting to a point where the system can free up memory
(write to swap, etc).  Just a busy loop without ever getting a skb is
just bad.

> > > The netpoll philosophy is to assume that its traffic is an absolute
> > > priority - it is better to potentially hang trying to deliver a panic
> > > message than to give up and crash silently.
> > 
> > So even a long timeout would not do?  So you don't even get a message to
> > the console?
> 
> In general, there's no way to measure time here. And if we're
> using netconsole, what makes you think there's any other console?

Why assume that there isn't another console?  The screen may be used
with netconsole, you just lose whatever has been scrolled too far.

> 
> > > > Also, as Andi told me, the printk here would probably not show up
> > > > anyway if this happens with netconsole.
> > > 
> > > That's fine. But in fact, it does show up occassionally - I've seen
> > > it.
> > 
> > Then maybe what Andi told me is not true ;-)
> > 
> > Oh, and did your machine crash when you saw it?  Have you seen it with
> > the e1000 driver?
> 
> No and no. Most of my own testing is done with tg3.
> 

If you saw the message and the system didn't crash, then that's proof
that if the driver is not working properly, you would have lock up the
system, and the system was _not_ in a state that it _had_ to get the
message out.

-- Steve


