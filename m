Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUF1TrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUF1TrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUF1TrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:47:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265135AbUF1TrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:47:16 -0400
Date: Mon, 28 Jun 2004 20:47:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Pat Gefre <pfg@sgi.com>, erikj@subway.americas.sgi.com, cw@f00f.org,
       hch@infradead.org, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628204707.D9214@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
	erikj@subway.americas.sgi.com, cw@f00f.org, hch@infradead.org,
	jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0406280719080.581376@subway.americas.sgi.com> <Pine.SGI.3.96.1040628140341.36430F-100000@fsgi900.americas.sgi.com> <20040628121312.75ac9ed7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628121312.75ac9ed7.akpm@osdl.org>; from akpm@osdl.org on Mon, Jun 28, 2004 at 12:13:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 12:13:12PM -0700, Andrew Morton wrote:
> Pat Gefre <pfg@sgi.com> wrote:
> >
> > We think we should stick with the major/minor set we have proposed.  We
> >  don't like hacking the 8250 code, dynamic allocation doesn't work (once
> >  that works we will update our driver to use it), registering for our
> >  own major/minor may not work (if we DO get one we will update the
> >  driver to reflect it) but in the meantime we need to get something in
> >  the community that works.
> 
> "we don't like" isn't a very strong argument ;)
> 
> It does sound to me like some work is needed in the generic serial layer to
> teach it to get its sticky paws off the ttyS0 major/minor if there is no
> corresponding hardware.

It isn't that simple.  As I've already pointed out, there is no provision
to do a "maybe hardware exists, maybe it doesn't, lets claim individual
ttys based upon that decision".

It's a restriction of the way the TTY layer is setup to work with the
rest of the kernel, especially the character device layer.

We have these objects called TTY drivers.  They claim a range of TTY
devices, which are attached to a major number, starting at a minimum
minor number, and extending for a certain number of minor numbers.
This marks the complete range of minor numbers as being in use.  This
occurs when a serial driver is registered _well_ before any hardware
is touched.

Separate from that, we register TTY devices for each tty line, maybe
depending on whether hardware exists.  This occurs substantially later
than when the major/minor range is reserved.

> AFAICT nobody has scoped out exactly what has to be done for a clean
> solution there - it may not be very complex.  So could we please
> explore that a little further?

Seriously, the scale of changes required to make this work without
hacks is nontrivial.  If it were trivial, I'd have done it long ago,
since then I wouldn't need /dev/ttyAM, /dev/ttySA, /dev/ttyFB etc
on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
