Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTDYQ0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTDYQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:26:08 -0400
Received: from pheriche.sun.com ([192.18.98.34]:14249 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id S263277AbTDYQ0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:26:07 -0400
Message-ID: <3EA964D1.3070908@sun.com>
Date: Fri, 25 Apr 2003 09:39:45 -0700
From: Duncan Laurie <duncan@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: problem with Serverworks CSB5 IDE
References: <3EA85C5C.7060402@sun.com> <20030423212713.GD21689@puck.ch> <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk> <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch> <20030424080023.GG21689@puck.ch> <3EA85C5C.7060402@sun.com> <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> The revision id is read when we init_chipset_svwks, which comes from the
> PCI setup. If the chip is in legacy mode we call init chipset early on
> regardless. If it is in native mode it gets called too and we ignore
> its view of the IRQ (since thats now PCI defined).
> 

Yeah I saw that after I hit send, but for serverworks the init_chipset
is not always called because it can fall into a corner case when in native
mode because the PCI interrupt pin register is hardwired to zero (don't
ask me why...) so it follows a codepath in do_ide_setup_pci_device()
where init_chipset isn't called.

This patch adds the function call, which fixes the svwks_revision
variable and the missing /proc/ide/svwks:

--- setup-pci.c~        2003-04-25 09:20:31.000000000 -0700
+++ setup-pci.c 2003-04-25 09:24:27.000000000 -0700
@@ -609,7 +609,7 @@
                 if (noisy)
                         printk(KERN_WARNING "%s: bad irq (%d): will probe later\n",
                                 d->name, pciirq);
-               pciirq = 0;
+               pciirq = (d->init_chipset) ? d->init_chipset(dev, d->name) : 0;
         } else {
                 if (d->init_chipset)
                         d->init_chipset(dev, d->name);

> 
>> 		/* Check the OSB4 DMA33 enable bit */
>> 		return ((reg & 0x00004000) == 0x00004000) ? 1 : 0;
>> 	} else if (svwks_revision < SVWKS_CSB5_REVISION_NEW) {
>>-		return 1;
>>+		return 2;
> 
> 
> Why this change ?
> 
> 

Because the max supported mode for CSB5 < rev 0x92 is udma 4 (=2),
not udma 2 (=1).

-duncan

