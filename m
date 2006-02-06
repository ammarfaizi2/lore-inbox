Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWBFJrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWBFJrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWBFJru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:47:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1292 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750898AbWBFJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:47:49 -0500
Date: Mon, 6 Feb 2006 09:47:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060206094740.GA9388@flint.arm.linux.org.uk>
Mail-Followup-To: Glen Turner <glen.turner@aarnet.edu.au>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <m3lkwse3nz.fsf@defiant.localdomain> <20060203221346.GA10700@flint.arm.linux.org.uk> <m3mzh7ds45.fsf@defiant.localdomain> <20060204232005.GC24887@flint.arm.linux.org.uk> <43E56D14.80808@aarnet.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E56D14.80808@aarnet.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 01:42:20PM +1030, Glen Turner wrote:
> I think the open issues are:
> 
>  1. kernel messages causing modems to hang up during
>     the initial training period of the connection.

I think the correct solution is as suggested - a new option to enable
DCD monitoring, which when specified and DCD is not asserted we avoid
transmitting any kernel messages.  The side effect of this is that
any kernel messages avoided will be lost, and that point needs to be
made clear.  However, they will still be accessible via dmesg /
syslog.

>  2. slow kernel boot times with 'r' option.

The 'r' option is there to provide a reasonably reliable form of flow
control for kernel messages, so that kernel messages can reach the
receiver intact.  Strictly, if 'r' is specified and CTS is deasserted,
we should not transmit _anything_ until CTS is asserted, but that
would mean effectively pausing the kernel indefinitely, so there's
a limit on how long we wait for CTS.

I think we're agreed (differently wired serial cables) as to why using
the 'r' option to also monitor DSR would be a bad idea.

A possible solution to this problem may be to have the additional
option as you have suggested.  Whether it should be the same option
as (1) above or not is debatable.

The advantage of the CRLF patch I posted previously is that we can now
do a lot of the above in common code, which will fix a lot of serial
drivers at the same time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
