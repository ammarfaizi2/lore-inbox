Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284609AbRLUOus>; Fri, 21 Dec 2001 09:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284601AbRLUOud>; Fri, 21 Dec 2001 09:50:33 -0500
Received: from mout1.freenet.de ([194.97.50.132]:29641 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S284596AbRLUOuM>;
	Fri, 21 Dec 2001 09:50:12 -0500
Message-ID: <3C234C84.6050802@athlon.maya.org>
Date: Fri, 21 Dec 2001 15:51:48 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
In-Reply-To: <Pine.LNX.4.21.0112181509150.4456-100000@freak.distro.conectiva> <3C1F901E.6050800@athlon.maya.org> <20011218195245.GA28160@socrates>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Jeronimo Pellegrini wrote:

> Hi.
> 
> That's a VIA timer bug. The patch that fixes it was inthe kernel some
> time ago, but was removed because the workaround was being triggered
> when it shouldn't, if I remember correctly.
> 
> Here:
> 
> 
> --- linux-2.4.15-pre3/arch/i386/kernel/time.c	Sun Nov 11 21:33:31 2001
> +++ linux-2.4.15-pre3-new/arch/i386/kernel/time.c	Mon Nov 12 14:04:20 2001
> @@ -501,6 +501,19 @@
>  
>  		count = inb_p(0x40);    /* read the latched count */
>  		count |= inb(0x40) << 8;
> +
> +	        /*
> +		 * When using some via chipsets (as the vt82c686a, for example)
> +		 * the system timer counter (i8253) should be reprogrammed in
> +		 * this case, otherwise it may be reset to a wrong value.
> +		 */
> +		if (count > LATCH-1) {
> +			outb_p(0x34, 0x43);
> +		        outb_p(LATCH & 0xff, 0x40);
> +			outb(LATCH >> 8, 0x40);
> +			count = LATCH - 1;
> +		}
> +
>  		spin_unlock(&i8253_lock);
>  
>  		count = ((LATCH-1) - count) * TICK_SIZE;
> 

I tested this patch with 2.4.17rc[1|2] - and I couldn't find any 
problem. The systemtime has always been correct.

Could you please apply this patch to the next kernelversion, maybe 
spezifically for the VIA - chipset or with some other needed changes as 
Jeronimo wrote?


Thanks,
Andreas Hartmann

