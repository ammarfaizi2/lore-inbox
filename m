Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbSJBUff>; Wed, 2 Oct 2002 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262572AbSJBUff>; Wed, 2 Oct 2002 16:35:35 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:54506 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262569AbSJBUfe>;
	Wed, 2 Oct 2002 16:35:34 -0400
Date: Wed, 2 Oct 2002 22:40:59 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Message-ID: <20021002224059.A18518@fafner.intra.cogenit.fr>
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Oct 02, 2002 at 10:58:50PM -0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
> diff -u --recursive linux-2.5.38orig/drivers/net/depca.c linux-2.5.38/drivers/net/depca.c
> --- linux-2.5.38orig/drivers/net/depca.c	Sun Sep 22 04:25:10 2002
> +++ linux-2.5.38/drivers/net/depca.c	Wed Oct  2 01:16:57 2002
[...]
> @@ -1999,18 +2000,19 @@
>      break;
> 
>    case DEPCA_GET_STATS:              /* Get the driver statistics */
> -    cli();
> +
> +    spin_lock_irqsave(&lp->lock, flags);
>      ioc->len = sizeof(lp->pktStats);
>      if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
>        status = -EFAULT;
> -    sti();
> +    spin_unlock_irqrestore(&lp->lock, flags);

- copy_to_user() may sleep. Sleeping with spinlock held hurts badly.
- on SMP, pktStat can be updated while the copy progresses, see depca_rx().

-- 
Ueimor
