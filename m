Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbSIVXTT>; Sun, 22 Sep 2002 19:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSIVXTT>; Sun, 22 Sep 2002 19:19:19 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:28553 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S264616AbSIVXTR>; Sun, 22 Sep 2002 19:19:17 -0400
Date: Mon, 23 Sep 2002 00:59:18 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 6/11 sound/oss replace cli()
Message-ID: <20020923005918.B1975@linux-m68k.org>
References: <50EF4A49-CDA2-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <50EF4A49-CDA2-11D6-8873-00039387C942@mac.com>; from pwaechtler@mac.com on Sat, Sep 21, 2002 at 10:40:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 10:40:08PM +0200, Peter Waechtler wrote:
> I left the IRQ handler as is: releasing and requesting an IRQ
> handler on every frame.

Thanks,
Richard

> 
> --- vanilla-2.5.36/sound/oss/dmasound/dmasound_q40.c	Sat Aug 10 
> 00:03:13 2002
> +++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_q40.c	Sat Sep 21 
> 18:53:15 2002
> @@ -459,28 +459,32 @@
>   		  */
>   	         return;
>   	}
> -	save_flags(flags); cli();
> +	spin_lock_irqsave(&dmasound.lock, flags);
>   	Q40PlayNextFrame(1);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore_flags(&dmasound.lock, flags);
>   }
> 
>   static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)
>   {
> +	spin_lock(&dmasound.lock);
>           if (q40_sc>1){
>               *DAC_LEFT=*q40_pp++;
>   	    *DAC_RIGHT=*q40_pp++;
>   	    q40_sc -=2;
>   	    master_outb(1,SAMPLE_CLEAR_REG);
>   	}else Q40Interrupt();
> +	spin_unlock(&dmasound.lock);
>   }
>   static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp)
>   {
> +	spin_lock(&dmasound.lock);
>           if (q40_sc>0){
>               *DAC_LEFT=*q40_pp;
>   	    *DAC_RIGHT=*q40_pp++;
>   	    q40_sc --;
>   	    master_outb(1,SAMPLE_CLEAR_REG);
>   	}else Q40Interrupt();
> +	spin_unlock(&dmasound.lock);
>   }
>   static void Q40Interrupt(void)
>   {
