Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318303AbSGWVZt>; Tue, 23 Jul 2002 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318305AbSGWVZs>; Tue, 23 Jul 2002 17:25:48 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:17681 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S318303AbSGWVZs>; Tue, 23 Jul 2002 17:25:48 -0400
Date: Tue, 23 Jul 2002 17:24:45 -0400
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: Sven Koch <haegar@sdinet.de>
Cc: George France <france@handhelds.org>, Martin Brulisauer <martin@uceb.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5.26 - arch/alpha
Message-ID: <20020723172445.A2988@linux04.mro.cpqcorp.net>
References: <02072315005002.31958@shadowfax.middleearth> <Pine.LNX.4.44.0207232103120.16191-100000@space.comunit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207232103120.16191-100000@space.comunit.de>; from haegar@sdinet.de on Tue, Jul 23, 2002 at 09:08:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:08:26PM +0200, Sven Koch wrote:
> 
> I am using Stock 2.4.19-rc2 with the following simple patch on an xl-300
> with milo:
> (without it, it breaks while initalizing the ncr-scsi-controller)
> 
> --- linux/arch/alpha/kernel/core_cia.c.orig	Sun Oct 21 19:30:58 2001
> +++ linux/arch/alpha/kernel/core_cia.c	Fri Jul 19 16:11:46 2002
> @@ -382,10 +382,10 @@
>  	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
>  		ppte[i] = pte;
> 
> -	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
> -	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
> +	*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
> +	*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
>  				    & 0xfff00000;
> -	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
> +	*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
>  }
> 
>  static void __init

Yes, this will help on XLT-300.

What this patch does is revert the code to an older version which uses
PCI DMA window #3 for the scatter/gather operations, thus avoiding the
use of window #1 for that operation.

On older machines like the XLT-300 and EB164, their core logic, CIA
Rev 1, appears to have a bug in that PCI DMA windows #1 and #2 cannot
be used for scatter/gather. Boxes based on CIA rev 2, and PYXIS, do
not have the same problem.

The patches I attached to an earlier posting essentially do this for
the rev 1 CIA machines, but leave active the code for dual-address
cycle (DAC) support for the CIA rev 2  and PYXIS based machines.

 --Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            HPTC - LINUX support
Hewlett-Packard Company - MRO1-2/K15       (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@hp.com
-----------------------------------------------------------------------------
