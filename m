Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbULGOyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbULGOyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULGOyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:54:24 -0500
Received: from embeddededge.com ([209.113.146.155]:53774 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261819AbULGOyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:54:15 -0500
In-Reply-To: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
References: <48C50EC3-480D-11D9-8A5A-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CC280DE6-485F-11D9-AEAC-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Second Attempt: Driver model usage on embedded processors
Date: Tue, 7 Dec 2004 09:53:46 -0500
To: Kumar Gala <kumar.gala@freescale.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7, 2004, at 12:03 AM, Kumar Gala wrote:

> The intent was that I would use the platform_data pointer to pass 
> board specific information to the driver.  We would have board 
> specific code which would fill in the information.  The question I 
> have is how to handle the device variant information which is really 
> static?

Why don't you just use the feature_call() model like we currently
use for PowerPC on the PMac?  Isolate those places in the driver
that need that information and call the function with a 
selector/information
request (and varargs) to get it.  This seems much more flexible
because we don't have to ensure the data structure contains all possible
information for all platforms, we don't have to invent a list of
functions to call that just return that information, and worse, have
to go back and update everyone when we realize we forgot a
piece of necessary information for one particular implementation.

There can be a standard list of information requests, it can easily
be extended for boards that may need to do some special processing
either to enable or retrieve such information, and the driver can
determine an appropriate course of action if the function returns a
status that it can't handle the request.

> The issue I've got with #2 is that some of these devices (and therefor 
> drivers) will end up existing on various parts from Freescale that 
> might have an ARM core or PPC core.

If the configuration options are truly static, we can do just like we 
do today
with processor cores that share similar peripherals.  Just #define 
those things
that are constants and compile them into the driver.  These could be 
address
offsets, functional support (like RMON), and so on.  There are examples
of these drivers that work fine today and could work even better with 
minor
touch ups of the configuration options.  You have already #define'd this
stuff in the board/processor configuration files.  Why put them into a 
static
data structure and then find some complex method to access it?  These
are embedded systems, after all, that want to minimize overhead.

For those things that are dynamic or based upon a particular set of
drivers selected (either as loadable modules or static linked), you can
use the feature_call() (or whatever we want to name it).  For example,
a driver could:

feature_call(SOC_FTR, Fast_Ethernet1, INIT_IO_PINS);

to configure the IO pins associated with the device, then it could:

feature_call(SOC_FTR, Fast_Ethernet1, GET_CLKS, &txclk, &rxclk);

to get the routing for the transmit and receive clocks, and finally:

feature_call(SOC_FTR, Fast_Ethernet1, GET_PHY_IRQ, &phy_irq);

to get the external interrupt number associated with the PHY.

If the feature_call() returns a status that the request couldn't be 
processed,
the driver can choose a default course of action.  This could be to
simply bail out with an error, or it could choose some common and
reasonable default configuration.  In the case of a PHY interrupt,
it could simply enter a polled mode if an interrupt is not provided.

Using the call out function doesn't place any restrictions on the driver
data structure formats.  The board can choose how it wishes to represent
the data, which it could fetch from flash, from a command line argument,
from some start up configuration, whatever it wishes.  It can also 
perform
any board specific operation necessary to enable/activate the 
peripheral.
For example, as part of INIT_IO_PINS, it could also configure some board
control register if there is external routing of signals through a 
logic device
or to enable power to the PHY.  It also allows "extending" the driver if
some board/processor needs an additional set up or control that others
don't.  The board/processors that don't need that function can simply
return from the call doing nothing, so no harm done (and requiring no
software updates to existing board ports), while this new 
board/processor
gets the needed function call.

Thanks.


	-- Dan

