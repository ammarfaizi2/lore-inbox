Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAHUPD>; Mon, 8 Jan 2001 15:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRAHUOx>; Mon, 8 Jan 2001 15:14:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9223 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129703AbRAHUOi>; Mon, 8 Jan 2001 15:14:38 -0500
Subject: Re: [patch] 2.4.0: defxx oopses upon insmod if short on memory
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 8 Jan 2001 20:15:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1010108200812.23234Z-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Jan 08, 2001 08:27:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fii1-0005FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2709,7 +2709,10 @@ static void dfx_rcv_init(DFX_board_t *bp
>  			struct sk_buff *newskb;
>  			bp->descr_block_virt->rcv_data[i+j].long_0 = (u32) (PI_RCV_DESCR_M_SOP |
>  				((PI_RCV_DATA_K_SIZE_MAX / PI_ALIGN_K_RCV_DATA_BUFF) << PI_RCV_DESCR_V_SEG_LEN));
> -			newskb = dev_alloc_skb(NEW_SKB_SIZE);
> +			while (!(newskb = dev_alloc_skb(NEW_SKB_SIZE))) {
> +				printk(KERN_WARNING "%s: Could not allocate receive buffer.\n", bp->dev->name);
> +				schedule();
> +			}

Wouldn't it be cleaner to malloc the new buffer and if that fails drop the
just received frame and reuse that skbuff?

schedule definitely isnt going to help

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
