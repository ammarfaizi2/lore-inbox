Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271614AbRIBMz6>; Sun, 2 Sep 2001 08:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271617AbRIBMzs>; Sun, 2 Sep 2001 08:55:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271614AbRIBMzi>; Sun, 2 Sep 2001 08:55:38 -0400
Subject: Re: [PATCH] 2.4.9-ac5: drivers/sound/trident.c
To: fdavis@si.rr.com
Date: Sun, 2 Sep 2001 13:59:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3B91A7A0.4020904@si.rr.com> from "Frank Davis" at Sep 01, 2001 11:29:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dWqg-00083L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(&card->lock, flags);
>  	portDat = cyber_inidx(CYBER_PORT_AUDIO, CYBER_IDX_AUDIO_ENABLE);
>  	/* enable, if it was disabled */
>  	if( (portDat & CYBER_BMSK_AUENZ) != CYBER_BMSK_AUENZ_ENABLE ) {
> @@ -729,7 +730,7 @@
>  		cyber_outidx( CYBER_PORT_AUDIO, 0xb3, 0x06 );
>  		cyber_outidx( CYBER_PORT_AUDIO, 0xbf, 0x00 );
>  	}
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&card->lock, flags);

This one is wrong. What is probably not obvious on first reading is that
the cyber_out* code actually configures the chipset so needs to be locked
against other chipset configurations (current cli/sti based therefore)

> +			spin_lock_irqsave(&card->lock, flags);
>  			dmabuf->swptr = dmabuf->hwptr = 0;
>  			dmabuf->count = dmabuf->total_bytes = 0;
> +			spin_unlock_irqrestore(&card->lock, flags);
>  		}
>  		if (file->f_mode & FMODE_READ) {
>  			stop_adc(state);
>  			synchronize_irq();
>  			dmabuf->ready = 0;
> +			spin_lock_irqsave(&card->lock, flags);
>  			dmabuf->swptr = dmabuf->hwptr = 0;
>  			dmabuf->count = dmabuf->total_bytes = 0;
> +			spin_unlock_irqrestore(&card->lock, flags);
>  		}

Possibly needed yes. We have however stopped the adc before we read it
and we hold the semaphore so I think its ok on this card

