Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264952AbSKERJd>; Tue, 5 Nov 2002 12:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbSKERHy>; Tue, 5 Nov 2002 12:07:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46088 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264952AbSKERHg>;
	Tue, 5 Nov 2002 12:07:36 -0500
Date: Tue, 5 Nov 2002 18:14:06 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jim Paris <jim@jtan.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105171406.GC879@alpha.home.local>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105113020.A5210@neurosis.mit.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, why not trying to resync, with something like :

   if (count >= LATCH)
	count = (count >> 8) | inb(0x40) << 8;

Cheers,
Willy

>  		count = inb_p(0x40);    /* read the latched count */
>  		count |= inb(0x40) << 8;
> +
> +		/* Any unpaired read will cause the above to swap MSB/LSB
> +		   forever.  Try to detect this and reset the counter. */
> +		if (count > LATCH) {
> +			outb_p(0x34, 0x43);
> +			outb_p(LATCH & 0xff, 0x40);
> +			outb(LATCH >> 8, 0x40);
> +			count = LATCH - 1;
> +		}
> +
>  		spin_unlock(&i8253_lock);
>  
>  		count = ((LATCH-1) - count) * TICK_SIZE;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
