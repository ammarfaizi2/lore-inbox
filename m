Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUHVXBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUHVXBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUHVXBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:01:49 -0400
Received: from home.powernetonline.com ([66.84.210.20]:62647 "EHLO
	home.uspower.net") by vger.kernel.org with ESMTP id S267695AbUHVXBe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:01:34 -0400
Date: Sun, 22 Aug 2004 23:02:47 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: platform bus, usage?
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
References: <41290606.10101@drzeus.cx>
In-Reply-To: <41290606.10101@drzeus.cx> (from drzeus-list@drzeus.cx on Sun
	Aug 22 15:45:58 2004)
X-Mailer: Balsa 2.2.3
Message-Id: <1093215767l.8554l.0l@hydra>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/04 15:45:58, Pierre Ossman wrote:
> I'm in the process of writing a driver for a SD/MMC card reader.  
> Since this is the first driver I'm writing I'm having some  
> difficulties fitting it into the linux driver model. I've read all  
> the documentation I can find to no avail.
> 
> The device is attached to the LPC bus and cannot be found using PNP.  
> From what I can gather this driver should therefore be organised  
> under the platform bus. I can't figure out how to do this though.  
> I've created the device structure, with platform_bus_type at .bus.  
> I've called device_register with the structure. Now how to I create a  
> device object and attach this to the bus? With PCI I guess this  
> handles itself using the PCI id:s.
> 
> At the moment I just let the driver play by itself. But that doesn't  
> seem to be using the driver model properly.
> 
> Any pointers would be helpful. Documentation, functions, example  
> drivers, anything.

First example that comes to mind is the pxafb framebuffer device.  The  
framebuffer device_driver is implemented in drivers/video/pxafb.c.  The  
actual devices are implemented in various files in arch/arm/mach-pxa,  
for example, take a look at arch/arm/mach-pxa/generic.c

It is a little confusing, becuase the driver just uses a normal  
device_driver structure, but for the actual device, you need to create  
and register a platform_device structure.

So the driver has something like this
static struct device_driver pxafb_driver = {
	.name		= "pxa2xx-fb",
	.bus		= &platform_bus_type,
	.probe		= pxafb_probe,
#ifdef CONFIG_PM
	.suspend	= pxafb_suspend,
	.resume		= pxafb_resume,
#endif
};

registered with a normal driver_register.

the actual device looks like
static struct platform_device pxafb_device = {
	.name		= "pxa2xx-fb",
	.id		= -1,
	.dev		= {
 		.platform_data	= &pxa_fb_info,
		.dma_mask	= &fb_dma_mask,
		.coherent_dma_mask = 0xffffffff,
	},
	.num_resources	= ARRAY_SIZE(pxafb_resources),
	.resource	= pxafb_resources,
};
and it is registered with platform_add_devices.

Notice the two names are the same.  Devices and drivers on the platform  
bus are matched by name. (see platform_match function in drivers/base/ 
platform.c)

Hope that helps,
John

