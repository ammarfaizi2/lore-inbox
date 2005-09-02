Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVIBHVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVIBHVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 03:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVIBHVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 03:21:32 -0400
Received: from web30303.mail.mud.yahoo.com ([68.142.200.96]:63415 "HELO
	web30303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161011AbVIBHVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 03:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kpP2O9UU/OeNPITolyEqgnjcwmFY8wRpzrpS1Q+n6DSmCDDxkoV1IIh2KiIqAwWNjb8VjqJVkg6Ha+vZtQLF2s79QasJjrdqFVRWzMgkkNYjN1wYgakF4xp1Rgg7pXf+LO3t5exMgpSBViw1o5v2WI+6rlighKuJhIWwHzVP30I=  ;
Message-ID: <20050902072125.23825.qmail@web30303.mail.mud.yahoo.com>
Date: Fri, 2 Sep 2005 08:21:25 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com, basicmark@yahoo.com
In-Reply-To: <20050901191715.A270D85EF0@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > Date: Wed, 31 Aug 2005 08:59:44 +0100 (BST)
> > From: Mark Underwood <basicmark@yahoo.com>
> >
> > --- David Brownell wrote:
> >
> > > The last couple times SPI frameworks came up
> here, some of the feedback
> > > included "make it use the driver model properly;
> don't be like I2C".
> > > 
> > > In hopes that it'll be useful, here's a small
> SPI core with driver model
> > > support driven from board-specific tables
> listing devices.  I expect the
> > > I/O call(s) could stand to change; but at least
> this one starts out right,
> > > based on async I/O.  (There's a synchronous
> call; it's a trivial wrapper.)
> > > 
> > > 	...
> >
> > Well I guess great minds think alike ;-). After
> > looking though my SPI core layer I released that
> it in
> > no way reflected the new driver model (not
> surprising
> > as it was a copy of i2c-core.c) and I would
> probably
> > get laughed off the kernel mailing list if I sent
> it
> > as was ;-).  
> 
> That usually doesn't happen.  You'd just be told
> "make it use the driver
> model properly; don't be like I2C."  Though maybe
> there'd be a fiew
> other criticisms mixed in.  :)
> 
> 
> > I am now writing a new spi-core.c which uses the
> new
> > driver model.
> 
> How about just merging the code I sent?  It's not
> large, and it solves
> that problem.  I don't much care about the I/O model
> issues quite yet,
> though requirements for quick sensor captures
> (RPC-ish) would seem
> different from ones like reading bulk SPI flash
> data.
> 
> 
> > For registering an adapter:
> > 1) Register an adapter that has a cs table showing
> > where devices sit on the adapter.
> 
> But how is the adapter driver itself supposed to
> know that?

It gets passed the cs table as part of its platform
data.

> 
> That's what I addressed with my patch:  the need for
> the config tables
> to be **independent** of controller (and protocol)
> code.  It decouples
> all the board-specific tables from the drivers.
> 
> (Example shown below.)
> 
> The nightmare to avoid is this:  EVERY time someone
> adds a new
> SPI-equipped board, working/debugged/stable drivers
> need to change,
> because the board-specific config data was never
> separated from the
> drivers.  (And we know it can be, as shown in the
> patch I posted...)

Now I've fixed my version I'll have a more detailed
look.

> 
> Ideally adding a new board means adding a source
> file for just that one
> board, with the relevent implementation parameters. 
> Only when hardware
> guys do something funky should any driver need to
> change.
> 

That's what happens in my SPI subsystem. The adapter
driver only knows how the driver the adapter. When a
adapter gets probed it has platform data passed to it
which contains a pointer to the cs table, the number
of entry’s in the cs table and the pointer to a
function to control some GPIO(s) as cs for adapters
that don’t have any built in.

> 
> > 2) This causes spi-core to enumerate the devices
> on
> > the cs table and register them.
> >
> > For un-registering an adapter:
> > 1) Unregister an adapter
> > 2) This causes spi-core to remove all the children
> of
> > the adapter
> 
> Right, that's all exactly as in the patch I posted,
> though I punted
> on the "unregister" path -- an exercise for the
> reader! -- because I
> wanted to focus on (a) the driver model structure,
> like where things
> land in sysfs, and (b) how to keep board-specific
> initialization code
> out of controller and protocol drivers.

OK. If you want I could do the same, that is send the
un/registration and sysfs code before I put the
transfer methods in. I have some dummy devices so you
can see what happens in sysfs.

> 
> - Dave
> 
> 
> --- o26.orig/arch/arm/mach-omap1/board-osk.c
> 2005-08-27 02:11:45.000000000 -0700
> +++ o26/arch/arm/mach-omap1/board-osk.c	2005-08-27
> 18:44:20.000000000 -0700
> @@ -193,6 +193,34 @@ static struct
> omap_board_config_kernel o
>  
>  #ifdef	CONFIG_OMAP_OSK_MISTRAL
>  
> +#include <linux/spi.h>
> +
> +struct ads7864_info {		/* FIXME put in standard
> header */
> +	u16	pen_irq, busy;		/* GPIO lines */
> +	u16	x_ohms, y_ohms;
> +};
> +
> +static struct ads7864_info mistral_ts_info = {
> +	.pen_irq	= OMAP_GPIO_IRQ(4),
> +	.busy		= /* GPIO */ 6,
> +	.x_ohms		= 419,
> +	.y_ohms		= 486,
> +};
> +
> +static const struct spi_board_info
> mistral_boardinfo[] = {
> +{
> +	/* MicroWire CS0 has an ads7846e with touchscreen
> and
> +	 * other sensors.  It's currently glued into some
> OMAP
> +	 * touchscreen support that ignores the driver
> model.
> +	 */
> +	.driver_name	= "ads7846",
> +	.platform_data	= &mistral_ts_info,
> +	.max_speed_hz	= 2000000,
> +	.bus_num	= 2, 		/* spi2 == microwire */

I did think about doing this but the problem is how do
you know bus 2 is the bus you think it is? This would
work for SPI adapters that are platform devices, but
what about hot-plug devices like PCI and USB (we are
thinking of actually making a USB to SPI converter so
customers can try out some of our SPI devices on a PC
:).

Mark

> +	.chip_select	= 0,
> +},
> +};
> +
>  #ifdef	CONFIG_PM
>  static irqreturn_t
>  osk_mistral_wake_interrupt(int irq, void *ignored,
> struct pt_regs *regs)
> @@ -211,6 +239,9 @@ static void __init
> osk_mistral_init(void
>  	 * But this is too early for that...
>  	 */
>  
> +	spi_register_board_info(mistral_boardinfo,
> +			ARRAY_SIZE(mistral_boardinfo));
> +
>  	/* the sideways button (SW1) is for use as a
> "wakeup" button */
>  	omap_cfg_reg(N15_1610_MPUIO2);
>  	if (omap_request_gpio(OMAP_MPUIO(2)) == 0) {
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
