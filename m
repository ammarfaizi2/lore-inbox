Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbTCJXiy>; Mon, 10 Mar 2003 18:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbTCJXiy>; Mon, 10 Mar 2003 18:38:54 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:18097 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S262296AbTCJXiu>; Mon, 10 Mar 2003 18:38:50 -0500
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Date: Tue, 11 Mar 2003 00:48:43 +0100
User-Agent: KMail/1.5
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308202101.GA26831@kroah.com> <20030310214443.GA13145@kroah.com>
In-Reply-To: <20030310214443.GA13145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303110048.43514.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
> --- a/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
> +++ b/drivers/base/bus.c	Mon Mar 10 13:52:15 2003
> @@ -263,14 +263,25 @@
>  	if (dev->bus->match(dev,drv)) {
>  		dev->driver = drv;
>  		if (drv->probe) {
> -			if ((error = drv->probe(dev))) {

It seems that the semaphore in bus_add_device() makes this unnecessary.

[..]
> diff -Nru a/drivers/base/power.c b/drivers/base/power.c
> --- a/drivers/base/power.c	Mon Mar 10 13:52:15 2003
> +++ b/drivers/base/power.c	Mon Mar 10 13:52:15 2003
> @@ -41,10 +41,17 @@
>  	list_for_each(node,&devices_subsys.kset.list) {
>  		struct device * dev = to_dev(node);
>  		if (dev->driver && dev->driver->suspend) {
> -			pr_debug("suspending device %s\n",dev->name);
> -			error = dev->driver->suspend(dev,state,level);

This change is no good.
Either the semaphore protects you or it doesn't. If it doesn't you can't
even trust the dev pointer, because suspend() can sleep.

	Regards
		Oliver

