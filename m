Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264514AbRFKNLC>; Mon, 11 Jun 2001 09:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264488AbRFKNKv>; Mon, 11 Jun 2001 09:10:51 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:23946 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264476AbRFKNKp>; Mon, 11 Jun 2001 09:10:45 -0400
Message-ID: <3B24C185.824EBBE0@uow.edu.au>
Date: Mon, 11 Jun 2001 23:03:01 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Russell King <rmk@arm.linux.org.uk>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com>,
			<20010610093838.A13074@flint.arm.linux.org.uk>
			<Pine.LNX.4.33.0106101201490.9384-100000@toomuch.toronto.redhat.com>
			<20010610173419.B13164@flint.arm.linux.org.uk>
			<3B23A4BB.7B4567A3@mandrakesoft.com> <15140.5762.589629.252904@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Jeff Garzik writes:
>  > > [note I've not found anything in 2.4.5 where netif_carrier_ok prevents
>  > > the net layers queueing packets for an interface, and forwarding them
>  > > on for transmission].
>  >
>  > we want netif_carrier_{on,off} to emit netlink messages.  I don't know
>  > how DaveM would feel about such getting implemented in 2.4.x though,
>  > even if well tested.
> 
> If someone sent me patches which did this (and minded the
> restrictions, if any, this adds to the execution contexts in
> which the carrier on/off stuff can be invoked) I would consider
> the patch seriously for 2.4.x

It'd need to be callable from interrupt context - otherwise
each device/driver which has link status change interrupts
will need to implement some form of interrupt->process context
trick.

On the DHCP/DNS issue which Ben raised - MII-based NICs can take up
to 3.5 seconds before they start sending packets, *after* their
open() has returned success.  This is within the letter of the law
(ethernet can drop packets) but it'd be nicer to userspace if we
were to not return from the open until the interface was actually
usable.

Jamal has a patch somewhere which does the netlink status
notification.  If he cares to share it I'll take a look.

-
