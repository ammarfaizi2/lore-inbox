Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWGRWGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWGRWGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWGRWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:06:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:59362 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932208AbWGRWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QSj1h38LqeHxfqwd2b42xiWuob+j+YKgLZ2Ds2PFkI+K8HfPLX0XKUkF2uiYd1PNTGq9vtrxLtKjywhYiINgh23LrZOjvHe+oMAt1eXjcperFjDDlAZQrVndOVoN+5fQYYy4J15sWIZM7U/nNongZhw4ACCftlOmnbCI19prB4w=
Message-ID: <7f45d9390607181506x177f1ff4r32daebd3070da01c@mail.gmail.com>
Date: Tue, 18 Jul 2006 16:06:52 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: "uClinux development list" <uClinux-dev@uclinux.org>,
       LKML <linux-kernel@vger.kernel.org>, "Nicolas Pitre" <nico@cam.org>
Subject: smc91x does not use netdev=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, Shaun Jackman <sjackman@gmail.com> wrote:
> I've compiled the smc91x driver into my kernel (CONFIG_SMC91X=y), but
> the boot process complains `IP-Config: No network devices available.'
> I tried using the netdev kernel parameter to start the smc91x driver
> (netdev=1,0x300,eth0 and ether=1,0x300,eth0), but I don't see any
> output on the console from the smc91x driver. The driver doesn't
> appear to be starting. How do I start the smc91x driver? I'm compiling
> linux.2.6.14.7-hsc0 for ARM nommu (Atmel AT91).
>
> Thanks,
> Shaun

The smc91x driver doesn't seem to pull its parameters from the netdev=
parameter. Instead, a `platform_bus' is used, which requires a call to
`platform_add_devices' -- an example of this below. Could the smc91x
driver be modified to pulls its parameters from netdev=?

Cheers,
Shaun

#include <linux/device.h>

static struct resource smc91x_resources[] = {
	[0] = {
		.name	= "smc91x-regs",
		.start	= 0x300,
		.end	= 0x30f,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= 17,
		.end	= 17,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device smc91x_device = {
	.name		= "smc91x",
	.id		= -1,
	.num_resources	= ARRAY_SIZE(smc91x_resources),
	.resource	= smc91x_resources,
};

static struct platform_device *devices[] __initdata = {
	&smc91x_device,
};

void __init pathport_init(void)
{
	platform_add_devices(devices, ARRAY_SIZE(devices));
}
