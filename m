Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTHOQQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHOQOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:14:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269900AbTHOQKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:10:03 -0400
Date: Fri, 15 Aug 2003 15:52:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815135214.GB15872@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815124318.GA15478@ucw.cz> <20030815132706.GG15911@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815132706.GG15911@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:27:06PM +0100, Jamie Lokier wrote:

> I think you just have to accept that there are two designs in common
> use, and neither maps in a predictable way on to the other: keyboards
> which send the state (USB), and keyboards which never reveal the state
> (PS/2 with strange mixtures of DOWN+UP, DOWN only, repeating and
> non-repeating keys).

Well, all keyboards but PS/2 are able to report (or keep track) of the
state quite well, and regarding PS/2 only buggy keyboards that deviate
from the basic rules of sanity are a problem.

> Anything else is going to do the wrong thing with the other kind of
> keyboard, until the user does something special, which will be beyond
> many users to configure themselves.

Maybe.

> > > But that would require users to report on precisely which keys are affected
> > > and would give complications where I suppose 2.4 did not have any.
> > > This is the way towards an ever more complicated keyboard driver.
> > > Not what you would want.
> > 
> > I definitely want one single driver being more complicated than the core
> > getting more complicated.
> 
> The point is moot if the set of special keys on PS/2 keyboards is the
> same for all keyboards, though.

It is not. There is only ONE key that is not repeated on normal PS/2
keyboards and that is the Pause key. All other keys (including shift,
etc) are repeated. The Pause key, though, sends both Down and Up events
on the keypress, so it doesn't confuse the software.

> Then nothing special is required of
> the user.  That would be the best, if it is possible.

The best is never possible.

> But if not
> ----------
> 
> How about the PS/2 driver auto-discovers special (no UP event) keys:
> 
>   1. The range of known reliable keys, such as letters, can use software
>      mode (repeat, depends on UP reports) from the beginning.

Ok.

>   2. Set up _every_ other key to be non-repeating in software, with
> 
>      (a) consecutive DOWN events causing a synthetic UP just before
>          the second and subsequent DOWNs.

Won't work on keyboards which send more than one DOWN before an UP.
There are a bunch of these, notably the broken notebook keyboards.

>      (b) a synthetic UP after a timeout in the DOWN state.

That's what I'm planning to implement, with the timeout being the
hardware autorepeat delay. This way the sw autorepeat never kicks in
unless the hardware one does, too. On the PS/2 keyboards only.

>   3. Whenever the keyboard sends an UP, change that key (only that key) to
>      be in software mode like 1.
> 
> After booting, if the user presses "r", it will behave as expected -
> it's covered by 1.
> 
> If the user presses "Fn+F1" or some other unknown key which doesn't
> report UP events, it won't repeat and it will report DOWN then UP
> input events, once each time it is pressed.

Fn+F1 won't most likely generate a keypress event. It'll just change the
contrast via the BIOS or something.

I really believe that keys which generate the same scancode when pressed
and released (as per the report which started the thread) usually happen
because the keyboard is in some non-native mode.

I have keyboards which report the same scancode for both press and
release of several keys (making the keys undistinguishable) unless
switched to scancode set 3.

> If the user presses another unknown key such as "PrevTrack" which does
> report UP events, that will not repeat the first time it is pressed
> and released, but subsequently it will.
> 
> In all cases, the driver errs on the side of not creating more press
> events than it knows is safe.
> 
> -- Jamie

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
