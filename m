Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGGPnT>; Sun, 7 Jul 2002 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSGGPnS>; Sun, 7 Jul 2002 11:43:18 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:34316 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316070AbSGGPnS>; Sun, 7 Jul 2002 11:43:18 -0400
Date: Sun, 7 Jul 2002 16:45:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dead keyboard in lk 2.5.25
Message-ID: <20020707164554.B15933@flint.arm.linux.org.uk>
References: <3D284E20.D5D00F99@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D284E20.D5D00F99@torque.net>; from dougg@torque.net on Sun, Jul 07, 2002 at 10:20:16AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 10:20:16AM -0400, Douglas Gilbert wrote:
> --- linux/drivers/input/serio/i8042.c	Sat Jul  6 08:57:35 2002
> +++ linux/drivers/input/serio/i8042.c2525fix	Sun Jul  7 09:52:50 2002
> @@ -269,8 +269,11 @@
>   */
>  
>  	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
> -		printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
> -		return -1;
> +		free_irq(values->irq, NULL);
> +		if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
> +			printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
> +			return -1;
> +		}
>  	}
>  
>  /*

Hmm, interesting concept.  "If someone else is using my resource, I'll
free it for them, and re-claim it".  It sounds very much like a hack
rather than a fix to me.

I'd guess the real solution would be to stop pc_keyb being initialised
when you're trying to use i8042.c.  Vojtech?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

