Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbUB0QJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUB0QJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:09:27 -0500
Received: from mail.oatmail.org ([198.145.35.3]:7697 "EHLO mail.oatmail.org")
	by vger.kernel.org with ESMTP id S263035AbUB0QJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:09:23 -0500
Message-ID: <403F6BB0.3060404@oatmail.org>
Date: Fri, 27 Feb 2004 08:09:20 -0800
From: Brad Davidson <kiloman@oatmail.org>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: drivers/ide/ppc/pmac.c:1955: `ide_dma_intr` undeclared (first use
 in this function) 2.6.3.bk4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a G3 Pismo laptop, and use the 'Builtin PowerMac IDE support' 
(BLK_DEV_IDE_PMAC) driver for the IDE controller. If I enable 'PowerMac 
IDE DMA support' (BLK_DEV_IDEDMA_PMAC) but NOT 'Generic PCI bus-master 
DMA support' (BLK_DEV_IDEDMA_PCI), I get the following error while building:

drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_read':
drivers/ide/ppc/pmac.c:1955: `ide_dma_intr' undeclared (first use in 
this function)
drivers/ide/ppc/pmac.c:1955: (Each undeclared identifier is reported 
only once
drivers/ide/ppc/pmac.c:1955: for each function it appears in.)
drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_write':
drivers/ide/ppc/pmac.c:1986: `ide_dma_intr' undeclared (first use in 
this function)
drivers/ide/ppc/pmac.c: In function `pmac_ide_setup_dma':
drivers/ide/ppc/pmac.c:2161: `__ide_dma_off_quietly' undeclared (first 
use in this function)
drivers/ide/ppc/pmac.c:2162: `__ide_dma_on' undeclared (first use in 
this function)
drivers/ide/ppc/pmac.c:2171: `__ide_dma_verbose' undeclared (first use 
in this function)
drivers/ide/ppc/pmac.c:2172: `__ide_dma_timeout' undeclared (first use 
in this function)
make[2]: *** [drivers/ide/ppc/pmac.o] Error 1
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

It appears to be reasonable to require BLK_DEV_IDEDMA_PCI to get 
BLK_DEV_IDEDMA_PMAC. This patch adds a dependency on BLK_DEV_IDEDMA_PCI 
to the BLK_DEV_IDEDMA_PMAC Kconfig section. Dependencies on 
BLK_DEV_IDEPCI and PCI may be required as well since you need them to 
get BLK_DEV_IDEDMA_PCI, but I thought that would be redundant so I 
didn't include them in the list.

I seem to remember running in to the same dependency in the 2.4 series, 
I'll test when I get the chance.

This patch is against 2.6.3-bk4, but since it's just a one liner, it 
should apply to whatever is current.

--- linux-2.6.3-bk4/drivers/ide/Kconfig 2004-02-23 02:55:06.000000000 -0800
+++ linux-2.6.3-bk4-bdavidson/drivers/ide/Kconfig       2004-02-27 
07:54:05.019756592 -0800
@@ -816,7 +816,7 @@

  config BLK_DEV_IDEDMA_PMAC
         bool "PowerMac IDE DMA support"
-       depends on BLK_DEV_IDE_PMAC
+       depends on BLK_DEV_IDE_PMAC && BLK_DEV_IDEDMA_PCI
         help
           This option allows the driver for the built-in IDE controller on
           Power Macintoshes and PowerBooks to use DMA (direct memory 
access)

--

I also noticed that BLK_DEV_IDEPCI says:
default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDEDMA_PMAC
which seems circular to me. There may be a good reason for it, but I 
thought I'd bring it up.

-Brad
