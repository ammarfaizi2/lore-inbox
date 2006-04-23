Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWDWWM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWDWWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 18:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWDWWM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 18:12:56 -0400
Received: from xenotime.net ([66.160.160.81]:662 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932080AbWDWWM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 18:12:56 -0400
Date: Sun, 23 Apr 2006 15:15:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-Id: <20060423151517.e0559748.rdunlap@xenotime.net>
In-Reply-To: <20060423150206.546b7483.akpm@osdl.org>
References: <20060423192251.GD8896@iucha.net>
	<20060423150206.546b7483.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2006 15:02:06 -0700 Andrew Morton wrote:

> From: Andrew Morton <akpm@osdl.org>
> 
> - Add new SA_PROBEIRQ which suppresses the new sharing-mismatch warning. 
>   Some drivers like to use request_irq() to find an unused interrupt slot.
> 
> - Use it in i82365.c
> 
> - Kill unused SA_PROBE.
> 
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/pcmcia/i82365.c     |    7 ++++---
>  include/asm-xtensa/signal.h |    2 +-
>  include/linux/signal.h      |    4 +++-
>  kernel/irq/manage.c         |    6 ++++--
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff -puN include/linux/signal.h~request_irq-remove-warnings-from-irq-probing include/linux/signal.h
> --- devel/include/linux/signal.h~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
> +++ devel-akpm/include/linux/signal.h	2006-04-23 14:56:19.000000000 -0700
> @@ -14,10 +14,12 @@
>   *
>   * SA_INTERRUPT is also used by the irq handling routines.
>   * SA_SHIRQ is for shared interrupt support on PCI and EISA.
> + * SA_PROBEIRQ is set by callers when they expect sharing mismatches to occur
>   */
> -#define SA_PROBE		SA_ONESHOT
>  #define SA_SAMPLE_RANDOM	SA_RESTART
>  #define SA_SHIRQ		0x04000000
> +#define SA_PROBEIRQ		0x08000000

Is SA_PROBE_IRQ something different or a typo (below)?

> +
>  /*
>   * As above, these correspond to the IORESOURCE_IRQ_* defines in
>   * linux/ioport.h to select the interrupt line behaviour.  When
> diff -puN kernel/irq/manage.c~request_irq-remove-warnings-from-irq-probing kernel/irq/manage.c
> --- devel/kernel/irq/manage.c~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
> +++ devel-akpm/kernel/irq/manage.c	2006-04-23 14:57:01.000000000 -0700
> @@ -246,8 +246,10 @@ int setup_irq(unsigned int irq, struct i
>  
>  mismatch:
>  	spin_unlock_irqrestore(&desc->lock, flags);
> -	printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
> -	dump_stack();
> +	if (!(new->flags & SA_PROBE_IRQ)) {
> +		printk(KERN_ERR "%s: irq handler mismatch\n", __FUNCTION__);
> +		dump_stack();
> +	}
>  	return -EBUSY;
>  }
>  
> diff -puN drivers/pcmcia/i82365.c~request_irq-remove-warnings-from-irq-probing drivers/pcmcia/i82365.c
> --- devel/drivers/pcmcia/i82365.c~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:55:13.000000000 -0700
> +++ devel-akpm/drivers/pcmcia/i82365.c	2006-04-23 14:58:14.000000000 -0700
> @@ -509,7 +509,8 @@ static irqreturn_t i365_count_irq(int ir
>  static u_int __init test_irq(u_short sock, int irq)
>  {
>      debug(2, "  testing ISA irq %d\n", irq);
> -    if (request_irq(irq, i365_count_irq, 0, "scan", i365_count_irq) != 0)
> +    if (request_irq(irq, i365_count_irq, SA_PROBEIRQ, "scan",
> +			i365_count_irq) != 0)
>  	return 1;
>      irq_hits = 0; irq_sock = sock;
>      msleep(10);
> @@ -561,7 +562,7 @@ static u_int __init isa_scan(u_short soc
>      } else {
>  	/* Fallback: just find interrupts that aren't in use */
>  	for (i = 0; i < 16; i++)
> -	    if ((mask0 & (1 << i)) && (_check_irq(i, 0) == 0))
> +	    if ((mask0 & (1 << i)) && (_check_irq(i, SA_PROBEIRQ) == 0))
>  		mask1 |= (1 << i);
>  	printk("default");
>  	/* If scan failed, default to polled status */
> @@ -725,7 +726,7 @@ static void __init add_pcic(int ns, int 
>  	u_int cs_mask = mask & ((cs_irq) ? (1<<cs_irq) : ~(1<<12));
>  	for (cs_irq = 15; cs_irq > 0; cs_irq--)
>  	    if ((cs_mask & (1 << cs_irq)) &&
> -		(_check_irq(cs_irq, 0) == 0))
> +		(_check_irq(cs_irq, SA_PROBEIRQ) == 0))
>  		break;
>  	if (cs_irq) {
>  	    grab_irq = 1;
> diff -puN include/asm-xtensa/signal.h~request_irq-remove-warnings-from-irq-probing include/asm-xtensa/signal.h
> --- devel/include/asm-xtensa/signal.h~request_irq-remove-warnings-from-irq-probing	2006-04-23 14:59:43.000000000 -0700
> +++ devel-akpm/include/asm-xtensa/signal.h	2006-04-23 15:00:07.000000000 -0700
> @@ -118,9 +118,9 @@ typedef struct {
>   * SA_INTERRUPT is also used by the irq handling routines.
>   * SA_SHIRQ is for shared interrupt support on PCI and EISA.
>   */
> -#define SA_PROBE		SA_ONESHOT
>  #define SA_SAMPLE_RANDOM	SA_RESTART
>  #define SA_SHIRQ		0x04000000
> +#define SA_PROBEIRQ		0x08000000
>  #endif
>  
>  #define SIG_BLOCK          0	/* for blocking signals */


---
~Randy
