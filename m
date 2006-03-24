Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWCXT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWCXT73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:59:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751377AbWCXT72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:59:28 -0500
Date: Fri, 24 Mar 2006 19:59:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060324195917.GA32098@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org> <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com> <20060323144922.GA25849@flint.arm.linux.org.uk> <Pine.LNX.4.64.0603241140350.16802@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603241140350.16802@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 12:28:27PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 23 Mar 2006, Russell King wrote:
> 
> > Okay, so the default is now 'm', but the legal values are still only 'n'
> > and 'm'.  I can only select 'm' or 'n', and this is what I end up with in
> > the config file.  Now, if I remove the prompt text:
> > 
> > config SYM_D
> >         tristate
> >         depends on SYM_M && SYM_Y
> >         default y
> > 
> > and hey presto, suddenly 'y' becomes a legal value.
> > 
> > CONFIG_SYM_Y=y
> > CONFIG_SYM_M=m
> > CONFIG_SYM_D=y
> > 
> > So it would seem to be a Kconfig bug.
> 
> No, it's not a bug, that's really the correct behaviour. It has its roots 
> in the cml1 converter, where statements like this:
> 
> if [ "$CONFIG_FOO" = "y" ]; then
>   define_tristate CONFIG_BAR y
> fi
> 
> would become:
> 
> config BAR
> 	default y
> 	depends on FOO=y

Okay, so going to the exact problem case, the behaviour we require is:

SERIAL_8250	PCI	EMBEDDED	gives SERIAL_8250_PCI
	n	X	X		n
	X	n	X		n
	m	y	n		m
	y	y	n		y
	m	y	y		user selects 'm' or 'n'
	y	y	y		user selects 'y', 'm' or 'n'

the correct way to tell Kconfig to give us that is:

+config SERIAL_8250_PCI
+       tristate "8250/16550 PCI device support" if EMBEDDED
+       depends on SERIAL_8250 && PCI
+       default SERIAL_8250
+       help
+         This builds standard PCI serial support. You may be able to
+         disable this feature if you only need legacy serial support.
+         Saves about 9K.

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
