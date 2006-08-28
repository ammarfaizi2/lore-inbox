Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWH1UJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWH1UJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWH1UJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:09:31 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:17935 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751408AbWH1UJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:09:30 -0400
Date: Mon, 28 Aug 2006 21:09:18 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Rogier Wolff'" <R.E.Wolff@BitWizard.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'linux-os (Dick Johnson)'" <linux-os@analogic.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>,
       "'David Woodhouse'" <dwmw2@infradead.org>, linux-serial@vger.kernel.org,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
Message-ID: <20060828200918.GA959@flint.arm.linux.org.uk>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	'Rogier Wolff' <R.E.Wolff@BitWizard.nl>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	"'linux-os (Dick Johnson)'" <linux-os@analogic.com>,
	'Krzysztof Halasa' <khc@pm.waw.pl>,
	'David Woodhouse' <dwmw2@infradead.org>,
	linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>
References: <20060827065210.GA6932@bitwizard.nl> <000901c6caac$478bfca0$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c6caac$478bfca0$294b82ce@stuartm>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 10:14:30AM -0400, Stuart MacDonald wrote:
> From: On Behalf Of Rogier Wolff
> > Note that IMHO, we should have started hiding this mess from /drivers/
> > a long time ago. The tty layer should convert the B_9600 thingies to
> > "9600", the integer, and then call the set_termios function. The
> > driver should be prohibited from looking at how the the baud rate came
> > to be 9600, and attempt to approach the requested baud rate as good as
> > possible. It might return a flag somewhere: Not exact. In the example
> > above, the resulting baud rate is about 1.4 baud off: 9598.6. This is
> > not a problem in very many cases.
> > 
> > Once this is in place, you lose a lot of "figure out the baud rate
> > integer from the B_xxx settings" code in all the drivers, as well as
> > that we get to provide a new interface to userspace without having to
> > change ALL drivers at the same time. This decouples the drivers from
> > the kernel<->userspace interface.
> 
> I'll second the motion. :-)

You might do, but it's incompatible with the POSIX standard.  As I
explained to Rogier (he took it off list) there's no need for "inexact"
flags.

If we pass a baud rate via tcsetattr() (or ioctl), you should set what
ever settings you can.  If you can set _no_ settings, you return an
error.  If you can set at least one setting, you do not return an error,
and you only set those settings you can do.

When you subsequently read the settings via tcgetattr(), POSIX requires
that the returned information be what the port is _actually_ doing.

So, this means that if you can only do 9599 baud and not 9600 baud,
maybe you should be returning 9599 baud.

On the same subject, if you don't support RTS/CTS flow control, and
userland requests CRTSCTS, you shouldn't be allowing CRTSCTS to be set.
And indeed, if you don't allow that in the kernel today, stty will
correctly issue a warning that it was "unable to perform all requested
operations".

So, while I whole heartedly agree with passing baud rates numerically,
I do not think we need any of this inexact flagging nonsense provided
we implement something as userland programs expect - iow, the POSIX
behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
