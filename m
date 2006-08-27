Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWH0GwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWH0GwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWH0GwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:52:13 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:55882 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750700AbWH0GwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:52:13 -0400
Date: Sun, 27 Aug 2006 08:52:11 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, David Woodhouse <dwmw2@infradead.org>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
Message-ID: <20060827065210.GA6932@bitwizard.nl>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm> <1156411101.3012.15.camel@pmac.infradead.org> <m3bqqap09a.fsf@defiant.localdomain> <1156441293.3007.184.camel@localhost.localdomain> <m31wr6otlr.fsf@defiant.localdomain> <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com> <1156457501.3007.193.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156457501.3007.193.camel@localhost.localdomain>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 11:11:41PM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-24 am 16:43 -0400, ysgrifennodd linux-os (Dick Johnson):
> > at 75 and increases by powers-of-two. This is because the hardware
> > always had fixed clocks with dividers that divided by powers-of-two.
> > What is the claim for the requirement of strange baud-rates set
> > as an integer of dimension "baud?" Where does this requirement
> > come from and what devices use these?

> A lot of chips will do all sorts of interesting speeds such as
> 31.5Kbit because today the clocks are themselves quite configurable.

More importantly, the base-clocks are getting higher and higher, and
the division is no longer a "power-of-two". Thus 9600 is no longer
2.456MHz / 2^8, but something like 33MHz / 3438. This allows modern
hardware to run much faster baud rates, as well as custom slower baud
rates.

Note that IMHO, we should have started hiding this mess from /drivers/
a long time ago. The tty layer should convert the B_9600 thingies to
"9600", the integer, and then call the set_termios function. The
driver should be prohibited from looking at how the the baud rate came
to be 9600, and attempt to approach the requested baud rate as good as
possible. It might return a flag somewhere: Not exact. In the example
above, the resulting baud rate is about 1.4 baud off: 9598.6. This is
not a problem in very many cases.

Once this is in place, you lose a lot of "figure out the baud rate
integer from the B_xxx settings" code in all the drivers, as well as
that we get to provide a new interface to userspace without having to
change ALL drivers at the same time. This decouples the drivers from
the kernel<->userspace interface.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
