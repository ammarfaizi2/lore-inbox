Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUE3Mnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUE3Mnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUE3Mnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:43:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:56192 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263544AbUE3Mnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:43:31 -0400
Date: Sun, 30 May 2004 14:43:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530124353.GB1496@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 01:40:03PM +0200, Sau Dan Lee wrote:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
>     Vojtech> Q2: What application should be looking at the raw data
>     Vojtech> outside the kernel and why?
>     >>  What application should be looking at the raw data from an
>     >> RS232 port outside the kernel and why?
> 
>     Vojtech> Terminal. Terminals use the data directly.
> 
> Now, what prevents people from  connecting terminals to a computer via
> the PS/2 mouse port?

Their sanity.

Anyway, I don't oppose having the raw data available.

> There are  mice which can be attached  to both the RS232  port AND the
> PS/2 mouse port, needing only  an adaptor.  It should also be possible
> to use  a similar technique  to connect a  terminal to the  PS/2 mouse
> port.  This would be useful when you run out of RS232 ports.

Go ahead and try it. You'll fry your KBD port.

> Your  approach   in  the  input  system  completely   rules  out  this
> possibility.

Not such a big loss.

>     Vojtech> Anyway, the RS232 port is a multi purpose port, where you
>     Vojtech> can attach many different devices to it. For the keyboard
>     Vojtech> port, there is only one option, the keyboard. 
> 
> What a big assumption.  Yes, I admit that I don't know of any hardware
> implementations  that use  the PS/2  (or AT)  keyboard port  for other
> purposes.  Maybe there are POS systems like that?

No. The KBD interface is asymetric, only works on short distances, is
slow, cannot pass arbitrary data through, as it's by default translated
by the keyboard contoller, already assuming it's sending keyboard data,
all in all, it's completely unsuitable for anything else than a
keyboard.

You even cannot connect a mouse over it in the default mode of the port.

>     Vojtech> Of course, unless you create a device that can use it,
>     Vojtech> but in that case you can easily write a kernel driver for
>     Vojtech> it.
> 
> How about  the PS/2 mouse  port?  It's not  just for mice.   There ARE
> implementations using it for other things: touchpad, touchscreen, etc.

All simulate a mouse. Some have somewhat extended protocols, but those
protocols are still bound by mouse packet constraints, because the
controllers tend to do nasty things to the data passing through, like
merging input from multiple devices together into one stream by summing
the packets, etc.

> Your input  driver places that  stupid assumption that there  can't be
> other devices  outside your support list  that may use  the PS/2 mouse
> port, and  you make the  stupid assumption on  HOW the port  should be
> used.  That's within your  imaginations.  You're limiting other people
> to  your own  imaginations.   Worse still,  there  are ALREADY  things
> beyond your imaginations.

No. I'm just saying - if you want something that's not in the kernel
drivers, just write a driver for it. But the driver must be able to
coexist with the other drivers.

Your psaux/userspace serio driver is fine, except it cannot coexist with
the other drivers.

> Not everyone using  Linux is patient enough to  explore the Wonderland
> of kernel hacking.  Many immigrants from 2.4 are highly disappointed
> by the new but incompatible mouse/keyboard behaviours.  Some of them
> returned to their 2.4 homeland because of this.

Life's a change.

Anyway, at least 99% setups just keep working in 2.6.

> Not every new immigrant are that devoted to make the new country good.
> Many simply hop  back to the original country, or  hop to another that
> _may_ suit them better.

That's their freedom to do.

>     >> Raw keyboard data, for instance, can be captured for analyzing
>     >> how people use the keyboard and coming up with a more efficient
>     >> keyboard layout (c.f. Dvorak).  That's already beyond your
>     >> imaginations.
> 
>     Vojtech> The raw data not what you want to use there. You want the
>     Vojtech> keystroke data,
> 
> No.   I want  the  raw bytes.   (That's  also useful  for debugging  a
> hardware,  in  case  people  are  making  or  experimenting  with  new
> hardware.)

Sure. For debugging purposes, yes. But for analyzing the typing
behavior, the abstract data is better.

>     Vojtech>  and for that you can use the /dev/input/event interface,
> 
> But that's polluted  with some (0,0,0) events.  In  some situations, I
> NEED the raw, uninterpreted bytes,  much like people liking to watch a
> film or read  a book in the *original* language  version, not a dubbed
> or translated version.

Polluted. ;) Sorry, they're intentional. They're EV_SYN, SYN_REPORT
events, as you can find in input.h. They inform you that this is the end
of the whole report, which is useful for example for mice, where you
have more than one event (REL_X, REL_Y) per a report. 

The application reading the device is supposed to queue all events up to
the SYN_REPORT event, and then process them, so that a mouse pointer
will move diagonally instead of following the sides of a rectangle,
which would be very annoying.

> 
>     Vojtech> where you get them in a sane format (as opposed to the
>     Vojtech> PS/2 rawmode, which can send up ot 8 bytes for a single
>     Vojtech> keystroke).
> 
> Sane != helpful or more useful.
> 
> I could study the  I-Ching in English, but I would prefer  to do it in
> Chinese.  Now, your  approach is forcing me to do  it in English.  And
> you believe that's a good idea.

In your example, you wanted to study the frequency of keypresses, and
their relations. For that, it's best to ask the kernel to report
keypresses to you.

Should you want to analyze the keyboard protocol, the raw data is the
way to go. But that's been done many times before anyway.

>     Vojtech> Then your statistic analyser will work just fine even on
>     Vojtech> a Sun, Mac, or with an USB keyboard.
> 
> But it will not be able  to handle the specifics.  (That's the problem
> with  generic tools  in  general.  But  you  shouldn't be  restricting
> people to only those tools.  Some people have specific needs, and they
> should not be ignored.)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
