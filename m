Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTJCSNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTJCSNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:13:43 -0400
Received: from TVT-CaTV-dhcp-45-103.urbanet.ch ([80.238.45.103]:8320 "EHLO
	localhost") by vger.kernel.org with ESMTP id S263806AbTJCSNl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:13:41 -0400
Subject: Re: 2.4.22 ACPI power off via sysrq not working
From: Sylvain Pasche <sylvain_pasche@yahoo.fr>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73u16qybig.fsf@oldwotan.suse.de>
References: <1065168778.1740.10.camel@highscreen.suse.lists.linux.kernel>
	 <p73u16qybig.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1065204819.598.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Oct 2003 20:13:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 03/10/2003 à 10:24, Andi Kleen a écrit :
> Sylvain Pasche <sylvain_pasche@yahoo.fr> writes:

> > If I want to halt the system using sys-rq - o key, I get an oops instead
> > of a power down.

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
> 
> 
> -Andi

Yes, it works perfectly with it, thanks.
Do you forward it to the acpi maintainer ?

Cheers,

Sylvain

