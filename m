Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTJGA2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTJGA2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:28:01 -0400
Received: from intra.cyclades.com ([64.186.161.6]:2744 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261768AbTJGA17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:27:59 -0400
Date: Mon, 6 Oct 2003 21:30:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andi Kleen <ak@suse.de>
Cc: Sylvain Pasche <sylvain_pasche@yahoo.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 ACPI power off via sysrq not working
In-Reply-To: <p73u16qybig.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0310062129360.1556-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Oct 2003, Andi Kleen wrote:

> Sylvain Pasche <sylvain_pasche@yahoo.fr> writes:
> 
> > Hi, 
> > 
> > If I want to halt the system using sys-rq - o key, I get an oops instead
> > of a power down.
> > Inside pm.c:159, there is:
> > 	
> > 	if (in_interrupt())
> > 		BUG();
> > 
> > But if we look at the trace, we are in the interrupt of the keyboard
> > handler.
> > One fix would be to comment out the BUG line, but there's certainly "a
> > better way to do it".
> 
> Use this patch.
> 
> diff -u linux/drivers/acpi/system.c-o linux/drivers/acpi/system.c
> --- linux/drivers/acpi/system.c-o	2003-09-07 16:20:44.000000000 +0200
> +++ linux/drivers/acpi/system.c	2003-09-08 21:04:46.000000000 +0200
> @@ -1192,11 +1192,21 @@
>  
>  #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
>  
> +static int po_cb_active; 
> +
> +static void acpi_po_tramp(void *x)
> +{ 
> +	acpi_power_off();	
> +} 
> +
>  /* Simple wrapper calling power down function. */
>  static void acpi_sysrq_power_off(int key, struct pt_regs *pt_regs,
>  	struct kbd_struct *kbd, struct tty_struct *tty)
> -{
> -	acpi_power_off();
> +{	
> +	static struct tq_struct tq = { .routine = acpi_po_tramp };
> +	if (po_cb_active++)
> +		return;
> +	schedule_task(&tq); 
>  }
>  
>  struct sysrq_key_op sysrq_acpi_poweroff_op = {

Fix applied to 2.4 mainline.

