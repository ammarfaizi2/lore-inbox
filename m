Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSILIsS>; Thu, 12 Sep 2002 04:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSILIsS>; Thu, 12 Sep 2002 04:48:18 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:27818 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S314149AbSILIsR>; Thu, 12 Sep 2002 04:48:17 -0400
Date: Thu, 12 Sep 2002 10:26:43 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: pwaechtler@mac.com
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 10/10 sound/oss/dmasound/dmasound_q40.c
Message-ID: <20020912102643.B215@linux-m68k.org>
References: <200209091007.g89A7dOg000967@smtp-relay04-en1.mac.com> <20020911234500.B4476@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020911234500.B4476@linux-m68k.org>; from rz on Wed, Sep 11, 2002 at 11:45:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 09:56:27PM +0200, pwaechtler@mac.com wrote:


> -static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)
> -{
> -        if (q40_sc>1){
> -            *DAC_LEFT=*q40_pp++;
> -	    *DAC_RIGHT=*q40_pp++;
> -	    q40_sc -=2;
> -	    master_outb(1,SAMPLE_CLEAR_REG);
> -	}else Q40Interrupt();
> -}
> -static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp)

> +static void Q40InterruptHandler(int irq, void *dummy, struct pt_regs *fp)
> +{
> +	spin_lock(&dmasound.lock);
> +	if (q40_sc>1){
> +		if (dmasound.soft.stereo){
> +			*DAC_LEFT=*q40_pp++;
> +			*DAC_RIGHT=*q40_pp++;
> +			q40_sc -=2;
> +		} else {
> +			*DAC_LEFT=*q40_pp;
> +			*DAC_RIGHT=*q40_pp++;
> +			q40_sc --;
> +		}
>  	    master_outb(1,SAMPLE_CLEAR_REG);
>  	}else Q40Interrupt();
> +	spin_unlock(&dmasound.lock);
>  }
> +


not so good. The interrupt will happen up to 20000/s so any 
unneeded code in the interrupt handler like the test for stereo
should be avoided.. I will rewrite it in assembler someday.

Richard



