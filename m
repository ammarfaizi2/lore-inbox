Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVFIT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVFIT5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVFIT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 15:57:05 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:31842 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262458AbVFIT4n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 15:56:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qtRIx84QlQgBCad0R5zNAYdB7si3FoZydCgWURnAa5JZHIXXMi4pxXZ2gpy8K4yZe2DnBfuLBv4bVe03Fw9cxvCzlf4RXelqH0nC4MbuyeYTpul5WB1JT8kMe0mEh+6OqXVxluBHh3nweGevxG/MyST4zFlsWjc1RP72h3/5fAw=
Message-ID: <528646bc050609125658565dea@mail.gmail.com>
Date: Thu, 9 Jun 2005 13:56:42 -0600
From: Grant Likely <glikely@gmail.com>
Reply-To: Grant Likely <glikely@gmail.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: MPC52xx: sysfs failure on adding new device driver
Cc: Sylvain Munaut <tnt@246tnt.com>, Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <42A827DC.8000803@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <528646bc05060816514c2d5860@mail.gmail.com>
	 <42A827DC.8000803@246tNt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving this thread from the linuxppc-embedded mailing list because it 

Greg, I've CC'd you as Kumar suggested that you are the most likely
candidate to answer this question.  BTW, I've gotten great value from
your work on LDD, 3rd ed., so Thanks!  :-)

Both the MPC52XX and PowerQuicc microcontroller series of chips have
PSC devices that can be programmed to behave as many different
devices.  (ie. UART, SPI, AC97, Eth, etc).  Currently, the generic
MPC52xx code (arch/ppc/syslib/mpc52xx_devices.c) sets up a
platform_device table that includes all of the PSCs.  Each PSC has the
name "mpc52xx-psc" and the id is set between 0 and 5.

The assumption had been made that multiple device drivers could be
registered with the platform bus and the driver can make the decision
on whether or not to pick up the device when its _probe method is
called.  This assumption is now looking to be wrong.

When I tried to add an "mpc52xx-psc" SPI driver, the device model
seemed happy with multiple drivers registered using the same name, but
sysfs complained when it tried to create the mpc52xx-psc driver
directory (because it was already created by the "mpc52xx-psc" UART
driver.).

So, here's the question:  In the device model, is there any support
for registering multiple drivers for a single type of device?  Sylvain
made the suggestion that device-driver matching could be performed
only upto a special character like '.' so that drivers with different
names could bind to the same type of device.

For example, drivers could be named 'mpc52xx-psc.spi' and
'mpc52xx-psc.uart', and both would match a device named 'mpc52xx-psc'.

Another possiblity could be to have the board setup code (ie.
arch/ppc/platforms/lite5200.c) modify the platform_device table before
it is parsed to change the device name to match the desired driver. 
The problem with this solution is that it becomes difficult to detach
a driver from a device and replace it with another (different
function) driver because the device name would need to change after
the device is registered (I imagine this could wreck havoc on sysfs)

You can read the whole thread (with example patches) at:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-June/018712.html

Cheers,
g.

On 6/9/05, Sylvain Munaut <tnt@246tnt.com> wrote:
> 
> Grant Likely wrote:
> > I'm working on an MPC52xx SPI device driver using one of the PSC.
> > However, when I call driver_register() I get a failure (-17, EEXISTS)
> > with a traceback (posted below).
> >
> > I've tracked it down to failing when trying to create a sysfs entry
> > for the driver.  It fails because sysfs tries to create a directory
> > that already exists (mpc52xx_psc).  The directory was already created
> > when the psc serial port device driver was registered.
> >
> >>From what I can tell, I should be able to register more than one
> > driver for a particular device name (mpc52xx_psc).
> 
> I always assumed that yes.
> But now looking more closely, I'm not sure what I based that assumption
> on ... And if not the case that's indeed a problem because that's what's
> used to support the different function supported by the PSCs.
> 
> > Otherwise I would
> > need to change arch/ppc/syslib/mpc52xx_devices.c to have a different
> > name for each psc.
> 
> No you shouldn't have to touch that. The
> mpc52xx_match_psc_function(idx, "spi") is there to know which driver
> should be used for what PSC and you're using it correctly so it _should_
> work.
> 
> > If I change the sysfs code to ignore the failure
> > to create a directory then the driver seems to register fine.
> 
> A "better" quick-fix would be to change the platform_match
> (drivers/platform.c) to support "sub-fonctions". For example when using
> mpc52xx_psc.spi it only matches what's before the dot (if any) with the
> device name.
> 
> That changes the semantic of the driver names for the platform bus
> however, making the dot a "special" char.
> 
> 
> 
> 
>         Sylvain
>
