Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTANL4d>; Tue, 14 Jan 2003 06:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTANL4d>; Tue, 14 Jan 2003 06:56:33 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:1961 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP
	id <S262425AbTANL4a>; Tue, 14 Jan 2003 06:56:30 -0500
Message-ID: <3E23FD00.3EE99F2E@ccr.jussieu.fr>
Date: Tue, 14 Jan 2003 13:05:20 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
X-Mailer: Mozilla 4.79 [fr] (X11; U; Linux 2.4.21-pre2.1mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Driegert <bd@cool.de>
Cc: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: [RFC][PATCH] mkiss.[ch]
References: <3E217B22.7040309@cool.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Driegert wrote :
> 
> The following patch does (hopefully):
> 1) change MOD_xxx_USE_COUNT to module calls
> 2) change cli() to use spin_lock
> 
> Can someone check:
> a) ist it right in terms of usage (it's my first try for cleanup)
> b) does it work with the appropriate HW, since im no ham-guy
> 
> Bernd
> 

I tried to apply your patch to mkiss.ch (I am using kernel 2.4.19-16mdk)
but two functions are missing :

try_module_get() and module_put()

Are these only available with 2.5.x kernels or is it possible to
incorporate them in previous kernel versions ?

I suspect your patch is very important because I am using mkiss and it
gives interrupt problems in all 2.4.x kernels I have used, resulting in
system malfunctions after mkiss driver is insmoded : at least bad AX25
frame decoding and ethernet dysfunctions on low speed machines. 

The worst situation lead to system crash with softirq interrupt handler
problems and kernel panic.

I traced the numerous kernel panic I had and they are related to
__wake_up() in sched.c
I agree that this could be caused by cli() in mkiss.c

73 de Bernard, F6BVP

> --- linux-2.5.56/drivers/net/hamradio/mkiss.h   Sun Jan 12 14:22:50 2003
> +++ mkiss.h     Sun Jan 12 14:24:22 2003
> @@ -55,6 +55,7 @@
>   #define CRC_MODE_NONE   0
>   #define CRC_MODE_FLEX   1
>   #define CRC_MODE_SMACK  2
> +       spinlock_t      driver_lock;
>   };
> 
>   #define AX25_MAGIC             0x5316
> --- linux-2.5.56/drivers/net/hamradio/mkiss.c   Mon Nov 18 05:29:57 2002
> +++ mkiss.c     Sun Jan 12 15:55:06 2003
> @@ -253,8 +253,7 @@
>                  return;
>          }
> 
> -       save_flags(flags);
> -       cli();
> +       spin_lock_irqsave(&ax->driver_lock, flags);
> 
>          oxbuff    = ax->xbuff;
>          ax->xbuff = xbuff;
> @@ -285,7 +284,7 @@
>          ax->mtu      = dev->mtu + 73;
>          ax->buffsize = len;
> 
> -       restore_flags(flags);
> +       spin_unlock_irqrestore(&ax->driver_lock, flags);
> 
>          if (oxbuff != NULL)
>                  kfree(oxbuff);
> @@ -676,7 +675,7 @@
>                  tmp_ax->mkiss = ax;
>          }
> 
> -       MOD_INC_USE_COUNT;
> +       try_module_get(THIS_MODULE);
> 
>          /* Done.  We have linked the TTY line to a channel. */
>          return ax->dev->base_addr;
> @@ -696,7 +695,7 @@
>          ax->tty        = NULL;
> 
>          ax_free(ax);
> -       MOD_DEC_USE_COUNT;
> +       module_put(THIS_MODULE);
>   }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-hams" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
