Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRJYQ2f>; Thu, 25 Oct 2001 12:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJYQ2Y>; Thu, 25 Oct 2001 12:28:24 -0400
Received: from pak200.pakuni.net ([207.91.34.200]:10992 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S274520AbRJYQ2M>; Thu, 25 Oct 2001 12:28:12 -0400
Date: Thu, 25 Oct 2001 11:30:13 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <3BD5AED6.90401C9C@sun.com>
Message-ID: <Pine.LNX.4.31.0110251121490.31833-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Tim Hockin wrote:

> So we've noticed, and taken issue with this behavior.
>
> If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
> get inconsistent behavior when downing them.
>
> * if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
> * if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too

Use ip.

> I assert that this should not happen.  I have a simple patch to fix this
> behavior, but I want to know a few things.
>
> * Is this supposed to happen? Why?
> * Is it correct that both the real interface and the first alias are marked
> as primary (! IFA_F_SECONDARY), while all other aliases are secondary?  It
> seems to me that ALL ALIASES should be secondary.  Is this wrong? Why?

iif - using ip then

ip addr add 10.1.1.1/24 dev eth0

creates 10.1.1.1 as a primary address for the 10.1.1.0/24 address space as
defined. Now:

ip addr add 10.1.1.2/32 dev eth0

10.1.1.2 in this case IS NOT a secondary alias because it is _not_ within
the scope of 10.1.1.0/24 by definition (it is in the scope of 10.1.1.2/32
by definition).

Now try:

ip addr add 10.1.1.3/24 dev eth0

and 10.1.1.3 is a secondary alias by definition as it is within the scope
of 10.1.1.0/24

Better yet:

ip addr add 10.1.1.4/25 dev eth0

This defines a third scope on dev eth0 and now:

ip addr add 10.1.1.5/25 dev eth0

defines 10.1.1.5 as a seconday within 10.1.1.0/25

So to summarize we now have:

Three (3) Primary addresses:
	10.1.1.1   for scope 10.1.1.0/24
	10.1.1.2   for scope 10.1.1.2/32
	10.1.1.4   for scope 10.1.1.0/25

Two (2) Secondary addresses:
	10.1.1.3   for scope 10.1.1.0/24
	10.1.1.5   for scope 10.1.1.0/25

Now let us see what the interactions are:

ip addr del 10.1.1.1/24 dev eth0

Will wipe out both 10.1.1.1 and 10.1.1.3

Make sense now?  BTW - don't use ifconfig and coloned addresses (which are
deprecated) as you will merely confuse yourself. Remeber that ifconfig =
InterFace CONFIGure  which has everything to do with Interfaces and very
little to do with IP addresses... ;-}

> Can anyone fill me in?

RPDB documentation is your freind.

> Thanks
> Tim
> --
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Cobalt Server Appliances
> thockin@sun.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

