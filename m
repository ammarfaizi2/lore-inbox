Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbTBMOYv>; Thu, 13 Feb 2003 09:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268052AbTBMOYv>; Thu, 13 Feb 2003 09:24:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54789 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268047AbTBMOYu>; Thu, 13 Feb 2003 09:24:50 -0500
Date: Thu, 13 Feb 2003 14:34:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loosing chars on serial console in 2.4
Message-ID: <20030213143438.B21478@flint.arm.linux.org.uk>
Mail-Followup-To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <IGEFJKJNHJDCBKALBJLLAEDPFKAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <IGEFJKJNHJDCBKALBJLLAEDPFKAA.joakim.tjernlund@lumentis.se>; from joakim.tjernlund@lumentis.se on Thu, Feb 13, 2003 at 03:03:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 03:03:35PM +0100, Joakim Tjernlund wrote:
> If I paste text into my serial console, some chars aren't echoed back. I
> also loose some chars when doing reboot and init starts to print messages.
> 
> This is due to that almost no user of opost() bothers to check its return
> value. The patch below fixes the problem, but it is ugly and possibly buggy. 
> I don't know how to fix this properly.

I suspect the real solution would be to add an "echo" queue to the tty
layer.  However, that's probably not a trivial change.

Although the problems with low latency tty's are now fixed in the patch
below (opost can be called from IRQ context), there is one concern
remaining that someone (not me) needs to consider.  What are the
locking implications of schedling here.

Bear in mind that the tty layer relies on the BKL, which is dropped when
we explicitly reschedule.

I'd suggest that the existing "dropping echo characters" behaviour is
probably better than the possible instability that could result here,
especially for 2.4.

I'll leave the final decision up to someone else, since I'm not actively
involved with tty stuff in 2.4.  Does someone else want to comment?

> HW: custom 860 board at 115200 baud, using the standard
> arch/ppc/8xx_io/uart.c driver.
> 
> --- drivers/char/n_tty.c	1 Nov 2002 13:43:27 -0000	1.1.1.1
> +++ drivers/char/n_tty.c	13 Feb 2003 13:45:33 -0000
> @@ -186,8 +186,14 @@
>  static int opost(unsigned char c, struct tty_struct *tty)
>  {
>  	int	space, spaces;
> +#if 1
> +	unsigned long tmo = jiffies + HZ/10;
>  
> +	while(!(space = tty->driver.write_room(tty)) && !in_interrupt() && !time_after(jiffies, tmo))
> +		cond_resched();
> +#else
>  	space = tty->driver.write_room(tty);
> +#endif
>  	if (!space)
>  		return -1;
>  

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

