Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbUKVNDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUKVNDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUKVNDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:03:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262084AbUKVNCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:02:34 -0500
Date: Mon, 22 Nov 2004 14:02:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041122130202.GO10463@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de> <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk> <20041122105157.GB10463@suse.de> <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk> <20041122113150.GF10463@suse.de> <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2004, Alan Chandler wrote:
> Jens Axboe writes: 
> 
> >On Mon, Nov 22 2004, Alan Chandler wrote:
> >>Jens Axboe writes: 
> 
> >>>400ns is the correctl value. Your writing is a little unclear to me -
> >>>did it work or not, with that change alone? 
> >>> 
> >>
> >>To be clear ...  
> >>
> >>
> >>I have modified ide-cd.c with  
> >>
> >>1) ndelay(400) at the head of cdrom_newpc_intr()  
> >>
> >>2) Alan Cox's patch in the place he originally identified for it to go  
> >>
> >>3) Some printk's in cdrom_newpc_intr() after the point where it reads the 
> >>status and IREASON and length registers and just for the purposes of 
> >>diagnostics.  
> >>
> >>With only those changes it now works. 
> >
> >You are not answering my question :-) 
> >
> >Here's is Alans patch as I posted some mails ago. Does it work with that
> >alone?? I'm curious of it is enough. It should not be necessary to incur
> >extra delay in the interrupt handler, if it is invoked from a real irq.
> 
> Sorry, I misunderstood what you meant.  I presume you think that the 
> interrupt may be triggered immediately the command packet has been sent but 
> before 400ns delay had occurred. 
> 
> NO - with Alan's patch alone, this did not work. 
> 
> The delay seesm to be needed in the path between the interrupt occuring and 
> the IDE_STATUS_REG being read. 
> 
> I had seen an note on a web site that said that there was two delays 
> required in the ATA/ATAPI spec - the 400ns which Alan's patch deals with 
> and a shorter delay (one PIO cycle) between busy being cleared and DRQ 
> reaching the correct state where the technique had been to read the 
> ALTSTATUS register.  That was why I had tried that approach but found it 
> not to work. 
> (I have subsequently downloaded a copy of the full spec and haven't been 
> able to find this - but then its just short of 500 pages of dense text:-)). 
> 
> Thinking about it now, I tried the ALTSTATUS delay before applying Alan's 
> patch, so maybe its the some of the two delays that maybe necessary.  If 
> you think its appropriate I will try that again this evening. 

I think the more correct patch is the following. It seems I was wrong in
assuming that the ide_intr() path already waited 400ns for us, I think
this should work for you. Can you test it?

===== drivers/ide/ide-iops.c 1.31 vs edited =====
--- 1.31/drivers/ide/ide-iops.c	2004-11-01 18:06:50 +01:00
+++ edited/drivers/ide/ide-iops.c	2004-11-22 13:59:27 +01:00
@@ -476,10 +476,8 @@
 	if (drive->waiting_for_dma)
 		return hwif->ide_dma_test_irq(drive);
 
-#if 0
 	/* need to guarantee 400ns since last command was issued */
-	udelay(1);
-#endif
+	ndelay(400);
 
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*

-- 
Jens Axboe

