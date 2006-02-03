Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946009AbWBCWXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946009AbWBCWXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWBCWXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:23:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1946009AbWBCWXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:23:47 -0500
Date: Fri, 3 Feb 2006 22:23:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060203222340.GB10700@flint.arm.linux.org.uk>
Mail-Followup-To: Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <43E38E00.301@aarnet.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E38E00.301@aarnet.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 03:38:16AM +1030, Glen Turner wrote:
> How about the other bugs reported by people who have used
> the Remote-Serial-Console-HOWTO:
> 
>   - writing any text to an idle (DCD not asserted) modem still
>     causes incoming calls to be hung up on.  That's not good
>     as sysadmins can't connect to systems with failing hardware.
> 
>     [Note that modems really need the 'r' option, so it's
>      fine to continue to write with DCD unasserted without
>      the 'r' option.]

What about those who have incomplete null modem cables which might
not connect DCD or DSR, but who want to use hardware flow control?

>   - the huge boot times with the 'r' option and an idle/
>     unconnected modem/terminal server.  This is caused by
>     the CTS timing out per character even when CTS is
>     floating (CTS is not defined unless DSR is asserted).
>     This basically makes the 'r' option impossible to
>     use on production systems.

Not convinced about this claim - see above.

>     Not using the 'r' option
>     with a terminal server brings other problems (notably
>     character loss problems when people paste a large
>     number of characters into the SSH session through
>     the terminal server to the remote host).

If you're talking about the terminal server sending to the Linux console,
that's got absolutely nothing to do with the 'r' option.  The 'r' option
only controls the settings for the kernel-side of the console, which is
strictly output only.  The input side is handled just like any tty, and
the termios settings define how that behaves.

Hence, if you enable CRTSCTS without 'r' then you will have flow control
for the userspace side, and no flow control for the kernel messages.

Thinking about this more, all your issues can be cleared up quite
trivially IMHO.  Consider 'r' to mean "I want my kernel console to
try to not drop any kernel messages" and the CRTSCTS termios flag
to mean "I want flow control for non-kernel input/output".  Hence,
if you don't want the modem to be able to effectively halt the kernel,
but you do want reliable communications for getty/shell etc, don't
specify 'r' but ensure that CRTSCTS gets set.

>   - writing LF CR rather than CR LF unfortunately causes
>     issues with some terminals.

This one I agree with.  The well known sequence is CRLF not LFCR.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
