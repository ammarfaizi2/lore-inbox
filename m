Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272919AbTHEWOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272925AbTHEWOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:14:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:17866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272919AbTHEWOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:14:12 -0400
Date: Tue, 5 Aug 2003 15:14:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export touch_nmi_watchdog
In-Reply-To: <20030805211416.GD31598@colin2.muc.de>
Message-ID: <Pine.LNX.4.44.0308051503220.2835-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Aug 2003, Andi Kleen wrote:
>
> > Otherwise this will just keep on expanding. 
> 
> It does expand on i386 exactly because the watchdog is disabled by default.

It's flaky enough that it _shouldn't_ be enabled by default. 

Oh, it's easy for other architectures that don't support the same wide
range of hardware to look down on it, but the thing is, you don't have the
same variability in firmware, interrupt controllers, system buses and
CPU's.

And like it or not, but that "richness" is what makes the x86 so 
successful. 

But my point is that once you find a bug you should not just paper it over 
and make sure that nobody finds it ever again. That's counter-productive. 
It's especially counter-productive if you do it in a way where other 
driver writers may well end up _copying_ the code that hides the bug. Just 
because they don't know any better.

So my argument is that we'd actually be a whole lot better off just adding
something like

	#ifdef CONFIG_WATCHDOG
	#warning This driver does bad things and will not work
	#endif

around the section that you found using the watchdog. Or something like 
this in the init routine for the driver:

	disable_watchdog();

which will disable the watchdog at run-time AND put a huge big bright 
printk() on the screen saying "watchdog is not usable with this driver". 
Again, to make people _aware_ of the problem when they hit it.

That way, next time somebody comes around and decides to nose around in
the driver, maybe they will fix it. Or when somebody else uses the driver
as a basis for their "new and improved" version, they'll take one look at
that, and say "oh, I won't make that mistake this time through".

In other words, we should make it clear that it is a CRIME to need to ping 
the watchdog. Because if you disable enough interrupts to trigger the 
watchdog, you _are_ doing bad things that are potentially visible to the 
user.

So let the user know. Don't just silently say "let's kick the watchdog".

		Linus

