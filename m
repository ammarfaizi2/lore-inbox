Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVKTSaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKTSaB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVKTSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:30:00 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:37111 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750900AbVKTSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:30:00 -0500
In-Reply-To: <1129772205.7620.226.camel@gaston>
References: <20051017005855.132266ac.akpm@osdl.org> <1129536482.7620.76.camel@gaston> <6DFB5723-0042-46FE-811F-BF372B068014@mac.com> <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com> <1129760024.7620.219.camel@gaston> <75FE9776-B88F-453E-9616-850097DB0138@mac.com> <1129772205.7620.226.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59EA4A9E-0F86-4D53-8DDD-56F6DDC6E726@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [BUG] PDC20268 crashing during DMA setup on stock Debian 2.6.12-1-powerpc
Date: Sun, 20 Nov 2005 13:29:58 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2005, at 21:36:44, Benjamin Herrenschmidt wrote:

> Kyle Moffett wrote:
>
>> BusMaster-DMA definitely should be enabled on that card.  After a  
>> lot of looking through icky IDE code, I've determined that the  
>> reason for the crash is that if there is a "mate", or another IDE  
>> bus on the same card, then hwif->dma_master is set to hwif->mate- 
>> >dma_base on the secondary channel.  Since DMA explicitly wasn't  
>> enabled on the primary channel, hwif->dma_master on the secondary  
>> is 0 even though dma is enabled, and therefore we hit that BUG().
>>

This is verified by adding printks to the code.  This is exactly  
where it crashes.


>> Therefore it seems that the only issue is ide_get_or_set_dma_base  
>> is returning 0 when it should return a valid DMA base.  In that  
>> function, the only ways that function can even theoretically  
>> return 0 without printing any weird error messages is "if (hwif- 
>> >mmio)" or "if (hwif->mate && hwif->mate->dma_base)".  The latter  
>> can't happen before hwif->mate is set up (since the problem is  
>> while initializing the primary).  Could hwif->mmio be nonzero  
>> somehow? The only drivers that seem to set it are pci/sgiioc4, pci/ 
>> siimage, ppc/pmac, and a couple misc arch drivers.
>>

With heavy printk debugging, I have identified that the hwif->mmio is  
getting set to 2 somewhere (even though the PDC driver never touches  
it).  I added an extra line in the PDC init code to explicitly zero  
hwif->mmio, but I get the same result, so something else is mashing  
on the PDC hwif.


> Maybe there is some fighting going on between ppc/pmac.c and that  
> driver over the hwif's and you end up with mmio inadvertently set ?
>

This is the only possibility that I can think of, but I'm having a  
hard time getting enough lines of pre-BUG output.  Is there any way  
to turn off the BUG() lines and just show the printks before that point?

Cheers,
Kyle Moffett


