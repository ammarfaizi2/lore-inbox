Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWJPN5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJPN5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJPN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:57:51 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:41390 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750746AbWJPN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:57:50 -0400
Subject: Re: [KJ] [PATCH] drivers/serial/dz.c:
	Remove	save_flags()/cli()/restore_flags()
From: Amol Lad <amol@verismonetworks.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <20061016132326.GE22289@parisc-linux.org>
References: <1160983732.19143.420.camel@amol.verismonetworks.com>
	 <20061016132326.GE22289@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 19:31:12 +0530
Message-Id: <1161007272.20400.5.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 07:23 -0600, Matthew Wilcox wrote:
> On Mon, Oct 16, 2006 at 12:58:52PM +0530, Amol Lad wrote:
> > Replaced save_flags()/cli()/restore_flags() pair with spin_lock
> > alternatives.
> > 
> > For this case, I believe spin lock plays no role but I also do not have
> > a better way.
> 
> I think there's a better way.  Here's the full stretch covered by that:
> 
>         save_flags(flags);
>         cli();
> 
> #ifndef CONFIG_SERIAL_DZ_CONSOLE
>         /* reset the chip */
>         dz_reset(&dz_ports[0]);
> #endif
> 
>         /* order matters here... the trick is that flags
>            is updated... in request_irq - to immediatedly obliterate
>            it is unwise. */
>         restore_flags(flags);
> 
> Now, we can obviously move the junk inside the ifdef:
> 
> #ifndef CONFIG_SERIAL_DZ_CONSOLE
>         save_flags(flags);
>         cli();
> 
>         /* reset the chip */
>         dz_reset(&dz_ports[0]);
> 
>         restore_flags(flags);
> #endif
> 
> Now, there's only one other place that dz_reset is called from, and to
> be honest, it looks like it's missing some locking too.  Looking at the
> other uses of spin_lock within this file, we can see that it's used to
> protect the DZ_ ports.
> 
> So I think a better patch would look like this:
> 
> diff --git a/drivers/serial/dz.c b/drivers/serial/dz.c
> index 8a98aae..de7a0b1 100644
> --- a/drivers/serial/dz.c
> +++ b/drivers/serial/dz.c
> @@ -661,6 +661,8 @@ static void __init dz_init_ports(void)
>  
>  static void dz_reset(struct dz_port *dport)
>  {
> +       unsigned long flags;
> +       spin_lock_irqsave((&dport->port.lock, flags);
>         dz_out(dport, DZ_CSR, DZ_CLR);
>  
>         while (dz_in(dport, DZ_CSR) & DZ_CLR);
> @@ -670,6 +672,7 @@ static void dz_reset(struct dz_port *dpo
>  
>         /* enable scanning */
>         dz_out(dport, DZ_CSR, DZ_MSE);
> +       spin_unlock_irqrestore((&dport->port.lock, flags);
>  }
>  
>  #ifdef CONFIG_SERIAL_DZ_CONSOLE
> @@ -783,19 +786,11 @@ int __init dz_init(void)
>  
>         dz_init_ports();
>  
> -       save_flags(flags);
> -       cli();
> -
>  #ifndef CONFIG_SERIAL_DZ_CONSOLE
>         /* reset the chip */
>         dz_reset(&dz_ports[0]);
>  #endif
>  
> -       /* order matters here... the trick is that flags
> -          is updated... in request_irq - to immediatedly obliterate
> -          it is unwise. */
> -       restore_flags(flags);
> -
>         if (request_irq(dz_ports[0].port.irq, dz_interrupt,
>                         IRQF_DISABLED, "DZ", &dz_ports[0]))
>                 panic("Unable to register DZ interrupt");
> 
> But looking at the driver, there's some places we're missing locking.
> 
> In dz_set_mctrl(), we read-modify-write DZ_TCR without holding a lock.
> We also do that in dz_console_setup(), but I suspect we're guaranteed
> by higher levels not to race with anything.
> 
> I suspect it can't hit us in practice (due to the dz driver being for
> hardware that's UP only, but maybe with preemption, it could bite
> us ...), but there's no locking in the interrupt handler.  I think
> dz_transmit_chars() needs locking against dz_console_putchar(), for
> example.
> 
> Anyway, that's enough to be going on with.

Thanks for that insight. Why not just include your this patch initally
and we add more locking later (as it will surely need run time testing)

If you think it's fine then please sign-off the patch.

Thanks again !

