Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136216AbRECIRj>; Thu, 3 May 2001 04:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136222AbRECIR3>; Thu, 3 May 2001 04:17:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40046 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136216AbRECIRM>; Thu, 3 May 2001 04:17:12 -0400
To: Fabrice Gautier <gautier@email.enst.fr>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: serial console problems with 2.4.4
In-Reply-To: <20010502130958.38BB.GAUTIER@email.enst.fr> <m1elu7pv0e.fsf@frodo.biederman.org> <20010502201026.CB69.GAUTIER@email.enst.fr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 May 2001 02:15:03 -0600
In-Reply-To: Fabrice Gautier's message of "Wed, 02 May 2001 20:52:36 +0200"
Message-ID: <m166fiq260.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabrice Gautier <gautier@email.enst.fr> writes:

> On 02 May 2001 10:37:21 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > Fabrice Gautier <gautier@email.enst.fr> writes:
> > > So this this probably a sulogin/mingetty problem. They should set the
> > > CREAD flag in your tty c_cflag.
> > > 
> > > the patch for busybox repalced the line
> > > 	tty.c_cflag |= HUPCL|CLOCAL
> > > by
> > > 	tty.c_cflag |= CREAD|HUPCL|CLOCAL
> > > 	
> > > Hope this help.
> > 
> > This part is correct.  
> > 
> > However the kernel sets CREAD by default.  
> 
> Are your sure? Wasn't this the behaviour for 2.4.2  but changed in 2.4.3

init=/bin/bash works fine over a serial console in 2.4.4.  So I am
certain.

I get the impression that something in 2.4.3 fixed CREAD handling, and we
started noticing the buggy user space.

> > sysvinit (and possibly other inits) clears CREAD.
> 
> In my case I was using busybox as init. So there is no sysinit or any other
> init called before this line.

The busy box init is also clearing CREAD (as of 0.51 anyway).

> > I wish I knew where the breakage actually occured.
> 
> Just look at this diff on serial.c between 2.4.2 and 2.4.3:

If it was a real diff between 2.4.2 and 2.4.3 I would agree, however it looks
like your attempt to fix 2.4.3. 

Eric


> --- serial.c	Sat Apr 21 17:22:53 2001
> +++ ../../../linux-2.4.2/drivers/char/serial.c	Sat Feb 17 01:02:36 2001
> @@ -1764,8 +1765,8 @@
>  	/*
>  	 * !!! ignore all characters if CREAD is not set
>  	 */
> -//	if ((cflag & CREAD) == 0)
> -//		info->ignore_status_mask |= UART_LSR_DR;
> +	if ((cflag & CREAD) == 0)
> +		info->ignore_status_mask |= UART_LSR_DR;
>  	save_flags(flags); cli();
>  	if (uart_config[info->state->type].flags & UART_STARTECH) {
>  		serial_outp(info, UART_LCR, 0xBF);
> 

