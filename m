Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753286AbWKGUxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbWKGUxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbWKGUxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:53:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753286AbWKGUxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:53:35 -0500
Date: Tue, 7 Nov 2006 12:53:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: James.Bottomley@steeleye.com, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
Message-Id: <20061107125329.6dc4eb53.akpm@osdl.org>
In-Reply-To: <1162816931.22062.132.camel@amol.verismonetworks.com>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006 18:12:11 +0530
Amol Lad <amol@verismonetworks.com> wrote:

> Replaced save_flags()/cli() with spin_lock alternatives
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
> Andrew, 
> Please add this to -mm
> ---
> --- linux-2.6.19-rc4-orig/drivers/scsi/mca_53c9x.c	2006-08-24 02:46:33.000000000 +0530
> +++ linux-2.6.19-rc4/drivers/scsi/mca_53c9x.c	2006-11-06 18:03:22.000000000 +0530
> @@ -341,9 +341,7 @@ static void dma_init_read(struct NCR_ESP
>  {
>  	unsigned long flags;
>  
> -
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(esp->ehost->host_lock, flags);
>  
>  	mca_disable_dma(esp->dma);
>  	mca_set_dma_mode(esp->dma, MCA_DMA_MODE_XFER | MCA_DMA_MODE_16 |
> @@ -352,16 +350,14 @@ static void dma_init_read(struct NCR_ESP
>  	mca_set_dma_count(esp->dma, length / 2); /* !!! */
>  	mca_enable_dma(esp->dma);
>  
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(esp->ehost->host_lock, flags);
>  }
>  
>  static void dma_init_write(struct NCR_ESP *esp, __u32 addr, int length)
>  {
>  	unsigned long flags;
>  
> -
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(esp->ehost->host_lock, flags);
>  
>  	mca_disable_dma(esp->dma);
>  	mca_set_dma_mode(esp->dma, MCA_DMA_MODE_XFER | MCA_DMA_MODE_WRITE |
> @@ -370,7 +366,7 @@ static void dma_init_write(struct NCR_ES
>  	mca_set_dma_count(esp->dma, length / 2); /* !!! */
>  	mca_enable_dma(esp->dma);
>  
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(esp->ehost->host_lock, flags);
>  }
>  
>  static void dma_ints_off(struct NCR_ESP *esp)

hm.  How do we find out if this works?

If it _does_ work then we can now remove the Kconfig BROKEN_ON_SMP dependency
for this driver.

