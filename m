Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWDKPcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWDKPcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWDKPcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:32:21 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:12173 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750926AbWDKPcV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:32:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cciss: bug fix for crash when running hpacucli
Date: Tue, 11 Apr 2006 10:31:28 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10BF32A62@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss: bug fix for crash when running hpacucli
Thread-Index: AcZdIzhLGiOC5TBOR/OSMYA2BcHuhQAWalXw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Stephen Cameron" <smcameron@yahoo.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 11 Apr 2006 15:31:29.0826 (UTC) FILETIME=[0126E820:01C65D7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stephen Cameron [mailto:smcameron@yahoo.com] 
> Sent: Monday, April 10, 2006 11:49 PM
> To: linux-kernel@vger.kernel.org; Miller, Mike (OS Dev); akpm@osdl.org
> Subject: Re: cciss: bug fix for crash when running hpacucli
> 
> Andrew Morton wrote:
> 
> > "Mike Miller (OS Dev)" <m...@beardog.cca.cpqcorp.net> wrote:
> >
> >> This patch fixes a crash when running hpacucli with 
> multiple logical 
> >> volumes  on a cciss controller. We were not properly 
> initializing the 
> >> disk->queue  and causing a fault.
> >
> >Please confirm that this is safe&appropriate for backporting 
> into 2.6.16.x? 

I created and tested the patch on 2.6.16.2.

mikem


> 
> I think it should be ok, so long as those kernels contain 
> Jens's softirq changes, and I think they do, iirc.
> 
> The problem was an ioctl that the hpacucli program uses to 
> tell the driver to re-query the controller about what logical 
> drives are configured (after it say, adds or deletes logical 
> drives) didn't bother to set up the queue in this ioctl with 
> the softirq function as it does in cciss_init_one (the latter 
> being called at init time).  
> 
> The business end of the patch is this hunk, which mimics code 
> in cciss.c:cciss_init_one():
> 
>  @@ -1249,6 +1296,8 @@ static void cciss_update_drive_info(int
> 
>                 blk_queue_max_sectors(disk->queue, 512);
> 
> +               blk_queue_softirq_done(disk->queue, 
> cciss_softirq_done);
> +
>                 disk->queue->queuedata = hba[ctlr];
> 
>                 blk_queue_hardsect_size(disk->queue, 
> 
> The rest of it is just moving functions around to satisfy the 
> compiler about function prototypes.
> 
> Well, maybe that doesn't answer your question if you were 
> wanting stronger verification, such as actual testing with 
> those kernels.
> If the function cciss_init_one contains a call to 
> blk_queue_softirq_done, but cciss_update_drive_info does not 
> contain such a call, then it's a safe bet this patch or 
> something very like it is needed.  
> cciss_update_drive_info needs to do the same thing per new 
> drive as cciss_init_one does.
> 
> -- steve
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection 
> around http://mail.yahoo.com 
> 
