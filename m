Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDAWUd>; Sun, 1 Apr 2001 18:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDAWUX>; Sun, 1 Apr 2001 18:20:23 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:47225 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132571AbRDAWUM>; Sun, 1 Apr 2001 18:20:12 -0400
Date: Sun, 1 Apr 2001 17:18:50 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3y9tl4l3c.fsf@intrepid.pm.waw.pl>
Message-ID: <Pine.LNX.3.96.1010401165413.28121X-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Apr 2001, Krzysztof Halasa wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> > I'm not suggesting you modify ethtool for your needs :)   But ethtool
> > perfectly illustrates the technique of using a single socket ioctl
> > (SIOCETHTOOL) to extend a set of standard, domain-specific ioctls
> > (ETHTOOL_xxx) to Linux networking drivers.
> 
> I know. The problem is I don't see here any advantages over many SIOCxxx
> command codes, while there are disadvantages.
> Simple things are IMHO better, and ioctl was designed to handle many
> simple commands (instead of one complex).
> 
> Am I missing something?

IMHO we should get away from adding hardware-type-specific ioctls
from the generic SIOCxxx list.

Sure it is easy to dump a bunch of new ioctls into sockios.h.
But having "one big header that covers all hardware types and ioctl
situations" does not seem like the right solution to me.

First of all, you as the HDLC subsystem maintainer have a lot more
control over what goes into include/linux/hdlc.h than
include/linux/sockios.h.  New SIOCxxxx ioctls should not be added on a
whim, but after examination of the issues involved.  Making a mistake
and adding a bad/pointless SIOCxxxx ioctl means you are stuck with it
for a long time.  The same applies to ioctls in hdlc.h of course -- but
the key distinction is that you are 100% sure of the issues involved
because changes are localized to your own domain.

Further, each change to sockios.h affects a LOT of code, both in
and outside the kernel.  Localizing your changes also localizes the
effects of bad namespace and ioctl choices (and bugs, though in this
case that would be rare).

Finally, I have this (perhaps crazy) idea that we should move in the
direction of removing ALL hardware-related ioctls from sockios.h, making
SIOCxxxx the domain of generic network device ioctls.

Comments welcome.  IMHO domain-specific ioctls are a better direction
than the current make-sockios.h-huge-with-new-ioctls approach.

Regards,

	Jeff


P.S.  It would be awesome if you would consider CC'ing
netdev@oss.sgi.com.  Some developers who might have valuable input
do not subscribe to linux-kernel, or are not able to read all of the
net-related linux-kernel messages.


