Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262608AbSJBVcM>; Wed, 2 Oct 2002 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbSJBVcL>; Wed, 2 Oct 2002 17:32:11 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6916 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262608AbSJBVcI>; Wed, 2 Oct 2002 17:32:08 -0400
Message-Id: <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Date: Thu, 3 Oct 2002 00:26:53 -0200
X-Mailer: KMail [version 1.3.2]
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua> <20021002224059.A18518@fafner.intra.cogenit.fr>
In-Reply-To: <20021002224059.A18518@fafner.intra.cogenit.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2002 18:40, Francois Romieu wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
> > diff -u --recursive linux-2.5.38orig/drivers/net/depca.c
> > linux-2.5.38/drivers/net/depca.c ---
> > linux-2.5.38orig/drivers/net/depca.c	Sun Sep 22 04:25:10 2002 +++
> > linux-2.5.38/drivers/net/depca.c	Wed Oct  2 01:16:57 2002
>
> [...]
>
> > @@ -1999,18 +2000,19 @@
> >      break;
> >
> >    case DEPCA_GET_STATS:              /* Get the driver statistics */
> > -    cli();
> > +
> > +    spin_lock_irqsave(&lp->lock, flags);
> >      ioc->len = sizeof(lp->pktStats);
> >      if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
> >        status = -EFAULT;
> > -    sti();
> > +    spin_unlock_irqrestore(&lp->lock, flags);

Did I say it's my first network patch? :-)

> - copy_to_user() may sleep. Sleeping with spinlock held hurts badly.

Ho to do it properly? Make a copy on stack under lock, release lock,
proceed with copy_to_user? That's 88 bytes at least...

> - on SMP, pktStat can be updated while the copy progresses, see depca_rx().

Should I place these pktStat updates under lp->lock?
--
vda
