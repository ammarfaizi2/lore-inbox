Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWEBUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWEBUEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWEBUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:04:21 -0400
Received: from mail0.lsil.com ([147.145.40.20]:55532 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751276AbWEBUET convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:04:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] megaraid_{mm,mbox}: updated fix-a-bug-in-reset-handler
Date: Tue, 2 May 2006 14:04:06 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD27@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_{mm,mbox}: updated fix-a-bug-in-reset-handler
Thread-Index: AcZjKf/e2rtA90KyRxG/d2S7JbpwswK+Rq1Q
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Ju, Seokmann" <Seokmann.Ju@engenio.com>, "Andrew Morton" <akpm@osdl.org>,
       <andre@linux-ide.org>, <James.Bottomley@SteelEye.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 02 May 2006 20:04:06.0627 (UTC) FILETIME=[913D6B30:01C66E23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Is this patch accepted?
If not, can you please provide comment.

Thank you,

> -----Original Message-----
> From: Ju, Seokmann 
> Sent: Tuesday, April 18, 2006 4:52 PM
> To: 'Andrew Morton'; andre@linux-ide.org; James.Bottomley@SteelEye.com
> Cc: Ju, Seokmann; linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org
> Subject: [PATCH 1/1] megaraid_{mm,mbox}: updated 
> fix-a-bug-in-reset-handler
> 
> Hi,
> 
> This patch has created against 2.6.17-rc1-mm3.
> 
> The patch contains changes addressing following concerns 
> brought by previous megaraid_mmmbox-fix-a-bug-in-reset-handler.patch.
> 
> 1.Andrew Morton:
> 	> +			scb->status = -EFAULT;
> 
> 	What is the significance of -EFAULT here?  Seems inappropriate?
> 2. Andrew Morton:
> 	And if that mbox is in main memory, the duration of 
> this spin will vary by
> 	a factor of many tens across all the different machines 
> on which this
> 	driver must operate.
> 
> 	Careful use of ndelay() or udelay() would fix that.
> 
> Thank you,
> 
> Seokmann
> 
> Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
> ---
> diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c 
> new/drivers/scsi/megaraid/megaraid_mbox.c
> --- old/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-18 
> 17:17:06.288025720 -0400
> +++ new/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-13 
> 16:46:53.000000000 -0400
> @@ -2278,6 +2278,7 @@
>  	unsigned long		flags;
>  	uint8_t			c;
>  	int			status;
> +	uioc_t			*kioc;
>  
>  
>  	if (!adapter) return;
> @@ -2320,6 +2321,9 @@
>  			// remove from local clist
>  			list_del_init(&scb->list);
>  
> +			kioc			= (uioc_t *)scb->gp;
> +			kioc->status		= 0;
> +
>  			megaraid_mbox_mm_done(adapter, scb);
>  
>  			continue;
> @@ -2636,6 +2640,7 @@
>  	int		recovery_window;
>  	int		recovering;
>  	int		i;
> +	uioc_t		*kioc;
>  
>  	adapter		= SCP2ADAPTER(scp);
>  	raid_dev	= ADAP2RAIDDEV(adapter);
> @@ -2662,7 +2667,10 @@
>  			"megaraid: IOCTL packet with %d[%d:%d] 
> being reset\n",
>  			scb->sno, scb->dev_channel, scb->dev_target));
>  
> -			scb->status = -EFAULT;
> +			scb->status = -1;
> +
> +			kioc			= (uioc_t *)scb->gp;
> +			kioc->status		= -EFAULT;
>  
>  			megaraid_mbox_mm_done(adapter, scb);
>  		} else {
> @@ -2933,12 +2941,13 @@
>  	wmb();
>  	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
>  
> -	for (i = 0; i < 0xFFFFFF; i++) {
> +	for (i = 0; i < MBOX_SYNC_WAIT_CNT; i++) {
>  		if (mbox->numstatus != 0xFF) break;
>  		rmb();
> +		udelay(MBOX_SYNC_DELAY_200);
>  	}
>  
> -	if (i == 0xFFFFFF) {
> +	if (i == MBOX_SYNC_WAIT_CNT) {
>  		// We may need to re-calibrate the counter
>  		con_log(CL_ANN, (KERN_CRIT
>  			"megaraid: fast sync command timed out\n"));
> @@ -3717,7 +3726,6 @@
>  	unsigned long		flags;
>  
>  	kioc			= (uioc_t *)scb->gp;
> -	kioc->status		= 0;
>  	mbox64			= (mbox64_t *)(unsigned 
> long)kioc->cmdbuf;
>  	mbox64->mbox32.status	= scb->status;
>  	raw_mbox		= (uint8_t *)&mbox64->mbox32;
> diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h 
> new/drivers/scsi/megaraid/megaraid_mbox.h
> --- old/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-18 
> 17:17:06.289025568 -0400
> +++ new/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-13 
> 16:05:30.000000000 -0400
> @@ -100,6 +100,9 @@
>  #define MBOX_BUSY_WAIT		10	// max usec to 
> wait for busy mailbox
>  #define MBOX_RESET_WAIT		180	// wait these 
> many seconds in reset
>  #define MBOX_RESET_EXT_WAIT	120	// extended wait reset
> +#define MBOX_SYNC_WAIT_CNT	0xFFFF	// wait loop index for 
> synchronous mode
> +
> +#define MBOX_SYNC_DELAY_200	200	// 200 micro-seconds
>  
>  /*
>   * maximum transfer that can happen through the firmware 
> commands issued
> ---
> 
