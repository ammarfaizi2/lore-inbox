Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbULYXJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbULYXJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 18:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbULYXJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 18:09:15 -0500
Received: from ee.oulu.fi ([130.231.61.23]:22423 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261591AbULYXI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 18:08:58 -0500
Date: Sun, 26 Dec 2004 01:08:56 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: "prem.de.ms" <prem.de.ms@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bcm4400 driver
Message-ID: <20041225230856.GA23382@ee.oulu.fi>
References: <41CDB073.7000202@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <41CDB073.7000202@gmx.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 07:24:51PM +0100, prem.de.ms wrote:
> Merry Christmas everyone,
> 
> I have a question concerning the bcm4400 driver: It is merged in the 
> kernel, but marked as experimental, so it does not work quite well. 
> Broadcom released their Linux drivers for this card under the GPL (see 
> http://www.broadcom.com/drivers/downloaddrivers.php). Is there a 
> specific reason why you don't use these drivers?
Hi

The following patch will make the driver work a lot better:

--- linux-2.6.9/drivers/net/Kconfig~	2004-12-26 00:45:22.692791880 +0200
+++ linux-2.6.9/drivers/net/Kconfig	2004-12-26 00:45:22.693791728 +0200
@@ -1326,8 +1326,8 @@
 	  called apricot.
 
 config B44
-	tristate "Broadcom 4400 ethernet support (EXPERIMENTAL)"
-	depends on NET_PCI && PCI && EXPERIMENTAL
+	tristate "Broadcom 4400 ethernet support"
+	depends on NET_PCI && PCI
 	select MII
 	help
 	  If you have a network (Ethernet) controller of this type, say Y and

Seriously, there are no known outstanding bugs in b44 (if there are, I'd
really like to know. Just sold my b44-based motherboard so don't have the
hardware to test things, though, so no promises about fixes :-) ). Two
remaining issues are missing Wake on LAN support and the use of lots of
GFP_DMA memory (which is unfortunately required to work around a hardware
bug which only shows up with non-standard memory layouts and > 1GB of
memory), which may result in out of memory errors if the module gets loaded
a long time after booting. That was the only way of fixing the bug, alas,
the bcm4400 driver doesn't have a fix mind you and will happily crash & burn
on 4:4 split kernels.

As for bcm4400 yes it does work (as long as you don't hit the hardware bug
:-) ). The problem is that it's not a Linux driver but a "generic" (windows?)
driver with abstraction on top (> 6000 lines of code vs. < 2500 for 
b44) and a glue layer to interface with Linux. 

Not really maintainable in the standard kernel tree where the idea is that
if someone changes some API (lets say PCI) they have to fix all the users of
the API as well. If all drivers look and smell the same the changes are
pretty easy to make and verify. If people have to look at 15 different
vendor abstraction layers and understand what requirements they have, this
is no longer the case.
