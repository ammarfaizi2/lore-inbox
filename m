Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWJYFla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWJYFla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 01:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161358AbWJYFla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 01:41:30 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:17543 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1161357AbWJYFl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 01:41:29 -0400
In-Reply-To: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
References: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37995C30-BB76-417A-B499-DC0DA6418139@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Scott Wood <scottwood@freescale.com>,
       "linux-kernel@vger.kernel.org mailing list" 
	<linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] IPIC: Don't call set_irq_handler with desc->lock held.
Date: Wed, 25 Oct 2006 00:41:31 -0500
To: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.752.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 23, 2006, at 11:35 AM, Scott Wood wrote:

> This patch causes ipic_set_irq_type to set the handler directly rather
> than call set_irq_handler, which causes spinlock recursion because
> the lock is already held when ipic_set_irq_type is called.
>
> I'm also not convinced that ipic_set_irq_type should be changing the
> handler at all.  There seem to be several controllers that don't and
> several that do.  Those that do would break what appears to be a  
> common
> usage of calling set_irq_chip_and_handler followed by set_irq_type,  
> if a
> non-standard handler were to be used.  OTOH, irq_create_of_mapping()
> doesn't set the handler, but only calls set_irq_type().
>
> This patch gets things working in the spinlock-debugging-enabled case,
> but I'm curious as to where the handler setting is ideally supposed  
> to be
> done.  I don't see any documentation on set_irq_type() that clarifies
> what the semantics are supposed to be.

Guys, Scott pointed this problem out on a PPC interrupt controller,  
and wanted to raise it in a larger forum since it appears to exist on  
at least one ARM interrupt controller I looked at (ixp4xx).  What is  
the proper solution to handle this.

The callers of set_type() I found all grab desc->lock.

- kumar

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/ipic.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index bc4d4a7..746f78c 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -473,9 +473,9 @@ static int ipic_set_irq_type(unsigned in
>  	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
>  	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
>  		desc->status |= IRQ_LEVEL;
> -		set_irq_handler(virq, handle_level_irq);
> +		desc->handle_irq = handle_level_irq;
>  	} else {
> -		set_irq_handler(virq, handle_edge_irq);
> +		desc->handle_irq = handle_edge_irq;
>  	}
>
>  	/* only EXT IRQ senses are programmable on ipic
> -- 
> 1.4.2.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

