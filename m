Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTHOStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHOSt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:49:26 -0400
Received: from dp.samba.org ([66.70.73.150]:19886 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270730AbTHOSrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:47:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools - input devices id support 
In-reply-to: Your message of "Sat, 09 Aug 2003 01:07:51 +0400."
             <200308090107.51989.arvidjaar@mail.ru> 
Date: Fri, 15 Aug 2003 22:08:27 +1000
Message-Id: <20030815184720.8747A2CE55@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200308090107.51989.arvidjaar@mail.ru> you write:
> On Friday 08 August 2003 21:20, Rusty Russell wrote:
> > I'm confused.  This is the first time I've looked at the input code,
> > so please bear with me.
> >
> > So, you hotplug in a device that has a suspend key, and you want the
> > power.ko module to match it?  Hmm, cool.
> >
> 
> I have never thought about this particular example, but yes, input agent will
> do it even without me knowing it :)) and not only hotplug - you coldplug and 
> boot and have all handlers ready.

This is the only example I can think of: what else would you use the
inputmap file for?

> > How about a mneumonic for each type?  Like so for
> > drivers/input/power.c:
> >
> > 	/* B: bus, V: Vendor, P: Product, R: Version.
> > 	 * E: evbit, K: keybit, A: absbit, M: mscbit, L: ledbit,
> > 	 * S: sndbit, F: ffbit. */
> > 	/*
> 
> I hope you do not seriously suggest something like
> 
> Knone-suspend-a-b-.... for all appr. 100 keys defined?

Not in the proc file, no: that would be silly.  But there's no reason
not to convert it to do the modprobe: sure, it'll be very long, but
that's OK, at least it's clear.  It has the advantage that if anyone
else ever wants to use it, it's nice and simple to understand.

> that is the main difference with PCI (and possible most others). They deal 
> with single-value scalar fields. Input deals with bitfields where each bit 
> counts.

Yes.

> > > This syntax fails even for some PCI entries already
> > > (while using pcimap allows for more elaborate matching)
> >
> > Not in practice, at least so I was assured by Greg.  Do you know of a
> > counter example?
> 
> no. I base my supposition on file2alias code:
> 
>         if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
>             || (subclass_mask != 0 && subclass_mask != 0xFF)
>             || (interface_mask != 0 && interface_mask != 0xFF)) {
>                 fprintf(stderr,
>                         "*** Warning: Can't handle masks in %s:%04X\n",
>                         filename, id->class_mask);
>                 return 0;
>         }
> 
> if it has special case I assume this special case is possible.

Yes, in practice noone does this because it doesn't really make sense:
when someone wants to match on finer granularity, we'll worry about it.

> > I really prefer generating aliases to hold this meta-information where
> > possible, because it's so simple for anyone to use them.
> >
> > > Can you name some current users of module.alias?
> >
> > Well, noone uses it directly: it's an internal detail of modprobe.
> > But it's designed for the hotplug stuff.  I'll eventually get around
> > to converting them if Greg doesn't first, because sooner or later
> > those map files are going to break.
> >
> 
> why should it break? And sorry, but I do not find modules.alias any more 
> simple than current tables.

Because the aliases are added at kernel build time, which means that
all the knowledge about the data structures is inside the kernel
source tree, so they can change.  And because the aliases are text
wildcards, they're easy to extend cleanly, without requiring any tools
to change.  The PCI structure changed in a 2.4.0 test kernel, and
broke the outside tools.  Greg KH still flinches when you ask about it
8)

> please understand - I am not against this syntax. I just fail to see how this
> particular task can be implemented using this syntax.

That's OK, we're having a refreshingly civilized discussion.  If we
can't find a way of doing this using the alias syntax, then we'll keep
the map for input.  But it'd be a shame for you to be the odd one out 8(

> And input agent is really needed for 2.6 it immensly simplifies configuration
> task.

What is input agent?  I have only glanced at the kernel code: could
you explain to me how you would use the inputmap file?

> thank you for taking your time

No, thank *you*.  It's always hard to come up with a new design when
there are so many people doing different things in the kernel.  But
that's what makes it fun...

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
