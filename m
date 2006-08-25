Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422917AbWHYXVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917AbWHYXVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbWHYXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:21:33 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422917AbWHYXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:21:32 -0400
Date: Sat, 26 Aug 2006 00:21:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: New serial speed handling: First implementation
Message-ID: <20060825232126.GC725@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1156518953.3007.247.camel@localhost.localdomain> <20060825174131.GA725@flint.arm.linux.org.uk> <1156538697.3007.256.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156538697.3007.256.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 09:44:57PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 18:41 +0100, ysgrifennodd Russell King:
> > On Fri, Aug 25, 2006 at 04:15:53PM +0100, Alan Cox wrote:
> > > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h
> > > --- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-21 14:17:52.000000000 +0100
> > > +++ linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-25 11:23:20.000000000 +0100
> > > @@ -47,6 +47,12 @@
> > >  #define TIOCSBRK	0x5427  /* BSD compatibility */
> > >  #define TIOCCBRK	0x5428  /* BSD compatibility */
> > >  #define TIOCGSID	0x5429  /* Return the session ID of FD */
> > > +
> > > +#define TCGETS2		0x542A
> > > +#define TCSETS2		0x542B
> > > +#define TCSETSW2	0x542C
> > > +#define TCSETSF2	0x542D
> > > +
> > 
> > Wouldn't it be better to use the _IO* macros to define these new ioctls?
> > Ditto for other architectures.
> 
> That really is up to you. For x86/x86-64 it would break the internal
> consistency.

Depends how you look at it - there are already ioctls in x86 which are
defined using this format:

#define TIOCGPTN        _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
#define TIOCSPTLCK      _IOW('T',0x31, int)  /* Lock/unlock Pty */

rather than the legacy way, so maybe someone's already taken the decision
that new ioctls should be using the new format, and this "internal
consistency" has already been broken.

Moreover, these two end up being 0x80045430 and 0x80045431 respectively.
If you break them down into the component parts, they are actually in
the same namespace as all the others in that file, but with the direction
and size properly encoded.

It also means that you will have less chance that the ioctls clash with
something else, like the sound subsystem, eg:

#define TCSETS          0x5402 /* Clashes with SNDCTL_TMR_START sound ioctl */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
