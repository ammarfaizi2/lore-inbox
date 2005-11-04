Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbVKDAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbVKDAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbVKDAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:15:28 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:31418 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030534AbVKDAP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:15:27 -0500
From: David Brownell <david-b@pacbell.net>
To: eemike@gmail.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Date: Thu, 3 Nov 2005 16:15:22 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031615.22630.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some question on SPI subsystem:

> I really get confused on the structure on the whole system. e.g. the
> platform_data and controller_data in board_info.  What are thier
> purposes?

Normally you'd just use platform_data ... which might hold things like
resistance and capacitance settings for that particular board; or details
about which SPI chip variant was present. It gets stored in the struct
device (spi_device->dev) as "platform_data".

Stephen persuaded me to add controller_data too, which is stored in
"struct spi_device".  His PXA SPI controller driver uses that for a
structure holding what I'd call DMA tuning information, plus a function
that tweaks the GPIO used for a chipselect.  Treat it as readonly.

Controller drivers can have two different kinds of state in each
spi_device:  static, and dynamic/runtime.  The names used for them
are IMO very confusing (platform_data and controller_data) since
they don't mean the same as those names do in board_info.  I'd take
a patch to provide better names for those two.  :)


> Also i found that spi_register_board_info is declared as __init, that
> mean i can not register board info as a module, is it because there is
> no 'real' probe on SPI bus?

Combine that lack of probe with the fact that SPI isn't hotpluggable,
and that's pretty much why.  You need a table of SPI devices present
on a given board; that boardinfo should be defined just once, in the
relevant arch/arm/mach-imx/board-*.c file.  The table never changes,
so there'd be no point in code to change it after board init is done.
(Other than wasting some memory!)

You could also use spi_new_device()/spi_unregister_device() if for some
reason you want to define new boardinfo in a module.  You'd need some
out-of-band data to determine what devices are present. 

- Dave

p.s. There's a minor refresh to the SPI code coming up soonish; just
     fine tuning, and catching up to 2.6.14-git which has removed a
     pointless parameter from device_driver.{suspend,resume}() calls.


