Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278539AbRJSQpP>; Fri, 19 Oct 2001 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278540AbRJSQpF>; Fri, 19 Oct 2001 12:45:05 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:27552 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S278539AbRJSQpC>; Fri, 19 Oct 2001 12:45:02 -0400
Date: Fri, 19 Oct 2001 12:45:33 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org
Cc: mhw@wittsend.com
Subject: Re: PPP in 2.4.x - Fixed, but a question...
Message-ID: <20011019124533.B3747@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011003214628.A406@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011003214628.A406@alcove.wittsend.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Wed, Oct 03, 2001 at 09:46:28PM -0400, Michael H. Warfield wrote:
> All,

	[...]

> 	Up until recent versions of 2.4, I could not keep the box up
> on a 2.4 kernel for more than a few hours before it would blow an Oops.
> Having bigger fish to fry at the time (and not having a serial console
> configured at the time) I dropped back to 2.2.19 and tried again when
> a later rev would come out.

> 	Recent revs (since about 2.4.6) began getting more stable and
> I finally got a serial console hooked up.  Right now, 2.4.10 will run
> with everything banging away at it for a week or so before blowing
> an Oops.  This last time, I finally got a trace log from my serial
> console and fed it through ksymoops.  That's attached below...

> 	I've also noticed one other thing.  While the serial interfaces
> are up and running full tilt, I periodically get kfree_skb errors printed
> to the console and an occasional VJ compression error.  I've attached that
> fragment of a log as well.

	Ok...  After a little help from another gentleman who eliminated
one problem for me, I discovered that I had a problem in the Computone
Intelliport II driver that I just happen to maintain.  The original author,
and the person who took over the driver from him, were never able to
get the split top-half / bottom-half interrupt handler to work so they
just left it as one big hard interrupt handler.  :-(  This seems to
have caused no problem on the 2.2.x and earlier kernels.  On 2.4.x the
PPP code apparently does not play nice when on a hard interrupt handler
and generates kfree_skb errors and eventually oops.

	I got the top-half / bottom-half interrupt handler split working
after working around a peculiarity in the hardware that didn't allow me
to enable and disable the interrupts on the board when an interrupt was
pending.  I guess that was the gotcha that the others didn't figure out.
Without that workaround the split driver would lock the kernel on a
permanent hard IRQ, which was a royal pain to debug.  Patches for that
problem and some additional clean-ups in my todo queue will be going
to Alan and Linus later this weekend.

	Now for my question...  Is this correct behavior on the part of
the PPP code or are others likely to stumble over this.  Should this have
NEVER worked at all and only worked by accident in 2.2.x or was something
introduced in 2.4.x which made a wrong assumption and introduced some
bad behavior?  I'm not totally sure the PPP code can or should make the
assumption that it can never be called from a hard IRQ.  If it can make
that assumption, that's fine, it just isn't obvious.

	With the fix to my driver, my problem seems to be fixed and I'm
not going to worry about the PPP code any further at this point.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

