Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUJKEzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUJKEzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUJKEzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:55:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:41659 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268685AbUJKEzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:55:38 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	 <1097466354.3539.14.camel@gaston>
	 <Pine.LNX.4.58.0410102104530.3897@ppc970.osdl.org>
	 <1097468590.3249.2.camel@gaston>
	 <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1097470524.3249.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 14:55:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 14:32, Linus Torvalds wrote:
> On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
> > 
> > But radeonfb ends up suspending the display at a wrong time and you miss
> > half of the output, which makes any kind of debugging near to
> > impossible.
> 
> Agreed.
> 
> But notice? It _works_. It's suspendign too damn eagerly, and it's hard to
> debug, but it's a "safe" solution to the confusion that does exist. Which
> is why I did it.

Well... it doesn't work on paul's laptop, but anyway, ok, let's go for
the struct thing and forget about this for 2.6.9.

Now paul and I are trying to figure out what to put in that struct and
what kind of information actually make any sense. It's not trivial. We
have to deal with several things.

We have the system state (cause of the request if you prefer), that is
"idle" (we mostly don't implement that one yet but it's useful to make
"room" for it, handhelds wants that badly), "suspend to ram" and
"suspend to disk".

But what about user /sysfs originated requests ? (that is random numbers
the user whacks in /sys/devices/...../power) what are their semantics ?

Also, do we carry around a "suggested" D state for what it means ? it's
really an obscure PCI concept. However, as you can see with the hacks
in drivers like radeonfb, we would be happy to be able to tell the
driver wether the chip will be leaved alone, powered off, unclocked,
etc... so the driver can take the right decision vs. what it supports.

That would mean, at least for PCI, a kind of platform hook that provides
that information, and in what form ? a D state ? I would vote for a
simple PCI specific pci_* (no good name comes to mind at the moment)
that would provide the platform suggested D state based on the pci_dev
and the struct we pass.

> And please do realize that I'd love to solve the confusion, and remove the
> hack. It's a hack, I admit it.  But it's better than just saying "be
> confused, be broken, I don't care".

Ok, ok ... well, it's broken with your "fix" for paul's box, but it's
ok, the ppc suspend-to-disk code isn't upstream yet anyway.

> If the hack ends up motivating somebody (hint hint) to solve the problem 
> properly, I'll be really happy. Paul suggested one solution (don't call 
> down to suspend at all - which is also a hack, but I suspect it might be 
> about as good a hack as the current one). I suggested another: using type 
> checking to make sure drivers _aren't_ confused. 

Paul and I would love do the right thing, it's just difficult to define
what the right thing is at this point. Actually, I have a pretty good
idea for a lot but what happens via /sysfs...

> The more the merrier. Care to come up with a solution of your own?
> 
> And no, I'm not interested in the type "let's fix one driver" kind of 
> thing. That's what we've had for the last year or more, and the fact is, 
> my laptop _never_ suspended during that time. So I really think it needs a 
> _proper_ solution.

Agreed.

Ben.


