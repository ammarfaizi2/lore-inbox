Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbSKEREQ>; Tue, 5 Nov 2002 12:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSKEREQ>; Tue, 5 Nov 2002 12:04:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:31893 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264942AbSKEREO>; Tue, 5 Nov 2002 12:04:14 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105113020.A5210@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu>
	<20021103143216.A27147@neurosis.mit.edu>
	<1036355418.30679.28.camel@irongate.swansea.linux.org.uk> 
	<20021105113020.A5210@neurosis.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 17:32:53 +0000
Message-Id: <1036517573.4791.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 16:30, Jim Paris wrote:
> This works well.
> 
> -jim
> 
> diff -urN linux-2.4.18/arch/i386/kernel/time.c linux-2.4.18-jim/arch/i386/kernel/time.c
> --- linux-2.4.18/arch/i386/kernel/time.c	Fri Mar 15 18:28:53 2002
> +++ linux-2.4.18-jim/arch/i386/kernel/time.c	Tue Nov  5 11:22:02 2002
> @@ -501,6 +501,16 @@
>  
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

Add a printk to address the fact we want to know about this and I think
thats enough to meet George's objection ?
