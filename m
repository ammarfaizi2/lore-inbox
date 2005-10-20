Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbVJTBjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbVJTBjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 21:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbVJTBjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 21:39:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:9190 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751690AbVJTBjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 21:39:52 -0400
Subject: Re: [BUG] PDC20268 crashing during DMA setup on stock Debian
	2.6.12-1-powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <75FE9776-B88F-453E-9616-850097DB0138@mac.com>
References: <20051017005855.132266ac.akpm@osdl.org>
	 <1129536482.7620.76.camel@gaston>
	 <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
	 <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
	 <1129760024.7620.219.camel@gaston>
	 <75FE9776-B88F-453E-9616-850097DB0138@mac.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 11:36:44 +1000
Message-Id: <1129772205.7620.226.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BusMaster-DMA definitely should be enabled on that card.  After a lot  
> of looking through icky IDE code, I've determined that the reason for  
> the crash is that if there is a "mate", or another IDE bus on the  
> same card, then hwif->dma_master is set to hwif->mate->dma_base on  
> the secondary channel.  Since DMA explicitly wasn't enabled on the  
> primary channel, hwif->dma_master on the secondary is 0 even though  
> dma is enabled, and therefore we hit that BUG().
> 
> Therefore it seems that the only issue is ide_get_or_set_dma_base is  
> returning 0 when it should return a valid DMA base.  In that  
> function, the only ways that function can even theoretically return 0  
> without printing any weird error messages is "if (hwif->mmio)" or "if  
> (hwif->mate && hwif->mate->dma_base)".  The latter can't happen  
> before hwif->mate is set up (since the problem is while initializing  
> the primary).  Could hwif->mmio be nonzero somehow?  The only drivers  
> that seem to set it are pci/sgiioc4, pci/siimage, ppc/pmac, and a  
> couple misc arch drivers.
> 
> I see a couple theoretical possibilities:
>    * hwif->mate and hwif->mate->dma_base are set for the primary  
> while still initializing it (before any secondary is set up.
>    * hwif->mmio is set somehow even though it shouldn't be, is the  
> value ever pre-initialized to 0?

Maybe there is some fighting going on between ppc/pmac.c and that driver
over the hwif's and you end up with mmio inadvertently set ?

> > Again, best is you pour printk's all over setup-pci.c and ide-dma.c  
> > to figure out what's going on...
> 
> I wish I could but the machine is remote and in-production, so it's  
> hard to have time to do much with it.  I'm trying as best I can to  
> walk through the sources by hand, specifically with regards to  
> changes between the two.  I'm hoping I can come up with a good enough  
> guess by Thanksgiving, so that when I have a week near the server to  
> test things out I can make significant progress.


