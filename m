Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVLPDfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVLPDfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVLPDfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:35:00 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:16800 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932097AbVLPDe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:34:59 -0500
Date: Thu, 15 Dec 2005 19:34:59 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Greg KH <greg@kroah.com>
Cc: Vitaly Wool <vwool@ru.mvista.com>, David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Message-ID: <20051216033459.GA5460@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215223322.GA8578@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:33:22PM -0800, Greg KH wrote:
> On Fri, Dec 16, 2005 at 01:17:56AM +0300, Vitaly Wool wrote:
> > I haven't heard of USB device registers needing to be written in IRQ 
> > context. I'm not that well familiar with USB, so if you give such an 
> > example, that'd be fine.
> 
> The USB host controller drivers routienly allocate memory in irq context
> as they are being asked to submit a new "packet" from a driver which was
> called in irq context.  Lots of USB drivers also allocate buffers in irq
> context too.
> 
> So, please, drop this line of argument, it will not go any further.

I know almost nothing about SPI, so I could be completely wrong here,
but I think I might have an inkling about the problem Vitaly is trying
to solve.  Note that I haven't actually had to make a design like this
work, so I'm not intimately familiar with the issues, but I have seen
designs that I believe would suffer from the following problem.

Suppose you have a chip (temp sensor for example) controlled via serial
bus (I2C is what I'm familiar with, from what I know this scenario would
apply to SPI too) that *also* drives an interrupt into the CPU.  You
want to be able to share the interrupt, so you need to be able to
turn off the interrupt from IRQ context (when the driver decides that it
is going to handle the interrupt).  But the only way to turn off the
interrupt on the peripheral chip is to send a message via the serial
bus.  Now if the IRQ gets entered while the serial bus is busy servicing
another device, the device driver author is in trouble - she can't
return from the irq handler until she's acked the IRQ and the device is
no longer asserting the interrupt, but she can't ack the IRQ without
sending a command on the serial bus, which she can't do because the bus
is currently in use higher up the call stack.

Now one could argue that this design is broken (requiring a slow serial
bus access to ack an irq means that you end up with very high-latency
interrupt handlers) but it's my impression that such designs are not
unheard of in the embedded world.

You end up having to leave the interrupt masked on return from the
irq_handler routine, ack it at a higher level at some later point, and
then re-enable it.

-andy
