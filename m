Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275931AbTHON1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275938AbTHON1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:27:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:34945 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275931AbTHON1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:27:12 -0400
Date: Fri, 15 Aug 2003 14:27:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815132706.GG15911@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl> <20030815124318.GA15478@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815124318.GA15478@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> I'm not very fond of making special exception for the (hopefully soon to
> be doing) PS/2 genre of keyboards. For USB for example you don't get an
> interrupt and a scancode per keypress. You get the current keyboard
> state. So I prefer to keep the keyboard state in the kernel, too, since
> that is a model that fits more devices. Also not just keyboards.

I think you just have to accept that there are two designs in common
use, and neither maps in a predictable way on to the other: keyboards
which send the state (USB), and keyboards which never reveal the state
(PS/2 with strange mixtures of DOWN+UP, DOWN only, repeating and
non-repeating keys).

Anything else is going to do the wrong thing with the other kind of
keyboard, until the user does something special, which will be beyond
many users to configure themselves.

> > > My proposed solution is to do an input_report_key(pressed) immediately
> > > followed by input_report_key(released) for these keys straight in
> > > atkbd.c. Possibly based on some flag in the scancode->keycode table for
> > > that scancode.
> > 
> > But that would require users to report on precisely which keys are affected
> > and would give complications where I suppose 2.4 did not have any.
> > This is the way towards an ever more complicated keyboard driver.
> > Not what you would want.
> 
> I definitely want one single driver being more complicated than the core
> getting more complicated.

The point is moot if the set of special keys on PS/2 keyboards is the
same for all keyboards, though.  Then nothing special is required of
the user.  That would be the best, if it is possible.

But if not
----------

How about the PS/2 driver auto-discovers special (no UP event) keys:

  1. The range of known reliable keys, such as letters, can use software
     mode (repeat, depends on UP reports) from the beginning.

  2. Set up _every_ other key to be non-repeating in software, with

     (a) consecutive DOWN events causing a synthetic UP just before
         the second and subsequent DOWNs.
     (b) a synthetic UP after a timeout in the DOWN state.

  3. Whenever the keyboard sends an UP, change that key (only that key) to
     be in software mode like 1.

After booting, if the user presses "r", it will behave as expected -
it's covered by 1.

If the user presses "Fn+F1" or some other unknown key which doesn't
report UP events, it won't repeat and it will report DOWN then UP
input events, once each time it is pressed.

If the user presses another unknown key such as "PrevTrack" which does
report UP events, that will not repeat the first time it is pressed
and released, but subsequently it will.

In all cases, the driver errs on the side of not creating more press
events than it knows is safe.

-- Jamie
