Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWDMFAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWDMFAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 01:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWDMFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 01:00:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964784AbWDMFAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 01:00:31 -0400
Date: Wed, 12 Apr 2006 22:00:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: Seokmann.Ju@engenio.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Message-Id: <20060412220011.2ddd6f63.akpm@osdl.org>
In-Reply-To: <890BF3111FB9484E9526987D912B261901BCC2@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261901BCC2@NAMAIL3.ad.lsil.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:
>
> This patch has fix for a bug in the 'megaraid_reset_handler()'.
> 
>  When abort failed, the driver gets reset handleer called. In the reset
>  handler, driver calls 'scsi_done()' callback for same SCSI command
>  packet (struct scsi_cmnd) multiple times if there are multiple SCSI
>  command packet in the pend_list. More over, if there are entry in the
>  pend_lsit with IOCTL packet associated, the driver returns it to wrong
>  free_list so that, in turn, the driver could end up with 'NULL pointer
>  dereference..' during I/O command building with incorrect resource.
> 
>  Also, the patch contains several minor/cosmetic changes besides this.
>
> ..
>
> @@ -2655,32 +2655,48 @@
>  	// Also, reset all the commands currently owned by the driver
>  	spin_lock_irqsave(PENDING_LIST_LOCK(adapter), flags);
>  	list_for_each_entry_safe(scb, tmp, &adapter->pend_list, list) {
> -
>  		list_del_init(&scb->list);	// from pending list
>  
> -		con_log(CL_ANN, (KERN_WARNING
> -			"megaraid: %ld:%d[%d:%d], reset from pending list\n",
> -				scp->serial_number, scb->sno,
> -				scb->dev_channel, scb->dev_target));
> +		if (scb->sno >= MBOX_MAX_SCSI_CMDS) {
> +			con_log(CL_ANN, (KERN_WARNING 
> +			"megaraid: IOCTL packet with %d[%d:%d] being reset\n",
> +			scb->sno, scb->dev_channel, scb->dev_target));
>  
> -		scp->result = (DID_RESET << 16);
> -		scp->scsi_done(scp);
> +			scb->status = -EFAULT;

What is the significance of -EFAULT here?  Seems inappropriate?

> @@ -2918,12 +2933,12 @@
>  	wmb();
>  	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
>  
> -	for (i = 0; i < 0xFFFFF; i++) {
> +	for (i = 0; i < 0xFFFFFF; i++) {
>  		if (mbox->numstatus != 0xFF) break;
>  		rmb();
>  	}

Oh my.  That's an awfully long interrupts-off spin.  1.7e7 operations with
an NMI watchdog timeout of five seconds - I'm surprised it doesn't trigger.

Is that reading from a PCI register there?   Or main memory?

I'm somewhat surprised that the compiler never "optimises" this into a
lockup, actually.  That's what `volatile' is for.

Is it not possible to do this with an interrupt?

A `cpu_relax()' in that loop would help cool things down a bit.


