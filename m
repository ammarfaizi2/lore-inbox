Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTH1PN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTH1PN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:13:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:37030 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264033AbTH1PNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:13:55 -0400
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is
	a 2.6/2.7 show-stopper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <200308281646.16203.bzolnier@elka.pw.edu.pl>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 16:13:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-28 at 15:46, Bartlomiej Zolnierkiewicz wrote:
> Some background first: we need ide-default driver (set as a device driver
> for all driver-less ide devices) mainly because we allow changing devices
> settings through /proc/ide/hdX/settings and some of them (current_speed,
> pio_mode) are processed via request queue (we are currently preallocating
> gendisk and queue structs for all possible ide devices).  The next problem
> is that ide-default doesn't register itself with ide and driverfs.
> If it does it will "steal" devices meaned to be used by other drivers.

Its also used to avoid special cases elsewhere.

> If we want dynamic hwifs/devices, moving gendisks/queues allocation
> to device drivers and ide integration with driverfs we need to:
> 
> (a) kill /proc/ide/hdX/settings for driver-less devices and kill ide-default

ide_default avoids a ton of driver specific special case code outside
of /proc/ide/foo/settings too. It isnt that simple, and I added it
originally to fix hundreds of weird little bugs and races. You also need
it for handling hotplug of devices.

I don't however think it needs to be any brighter than it is now. Driver
ordering isnt important, Linus was pretty emphatic that he a) didn't
care and b) wouldnt take patches to do any kind of rigid ordering when I
asked him (and for hotplug its pretty obvious why)

As far as I can see you either

1. Set up the queues and /proc when you create a hwif

or

2. Provide a generic function for each driver to call that does this
and/or undoes it. Since each driver needs the same code (default
included).


