Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319443AbSILFod>; Thu, 12 Sep 2002 01:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319444AbSILFod>; Thu, 12 Sep 2002 01:44:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13752 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319443AbSILFob>;
	Thu, 12 Sep 2002 01:44:31 -0400
Date: Thu, 12 Sep 2002 07:49:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] q40kbd.c fixes
Message-ID: <20020912074915.A18918@ucw.cz>
References: <20020911162206.A3861@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020911162206.A3861@linux-m68k.org>; from rz@linux-m68k.org on Wed, Sep 11, 2002 at 04:22:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 04:22:07PM +0200, Richard Zidlicky wrote:

> Hi,
> 
> a few small fixes, works nicely.
> 
> Richard

Thanks; applied.

> 
> --- linux-m68k-2.5.x/drivers/input/serio/q40kbd.c	Sat Jul 27 21:09:46 2002
> +++ linux-m68k-2.5.x-my/drivers/input/serio/q40kbd.c	Wed Sep 11 16:40:08 2002
> @@ -47,12 +47,24 @@
>  MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
>  MODULE_LICENSE("GPL");
>  
> +
> +static int q40kbd_open(struct serio *port)
> +{
> +	return 0;
> +}
> +static void q40kbd_close(struct serio *port)
> +{
> +	return 0;
> +}
> +
>  static struct serio q40kbd_port =
>  {
>  	.type	= SERIO_8042,
> +	.name	= "Q40 kbd port",
> +	.phys	= "Q40",
>  	.write	= NULL,
> -	.name	= "Q40 PS/2 kbd port",
> -	.phys	= "isa0060/serio0",
> +	.open	= q40kbd_open,
> +	.close	= q40kbd_close,
>  };
>  
>  static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> @@ -70,13 +82,10 @@
>  {
>  	int maxread = 100;
>  
> -	/* Get the keyboard controller registers (incomplete decode) */
> -	request_region(0x60, 16, "q40kbd");
> -
>  	/* allocate the IRQ */
>  	request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL);
>  
> -	/* flush any pending input. */
> +	/* flush any pending input */
>  	while (maxread-- && (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
>  		master_inb(KEYCODE_REG);
>  	
> @@ -84,15 +93,17 @@
>  	master_outb(-1,KEYBOARD_UNLOCK_REG);
>  	master_outb(1,KEY_IRQ_ENABLE_REG);
>  
> -	register_serio_port(&q40kbd_port);
> -	printk(KERN_INFO "serio: Q40 PS/2 kbd port irq %d\n", Q40_IRQ_KEYBOARD);
> +	serio_register_port(&q40kbd_port);
> +	printk(KERN_INFO "serio: Q40 kbd registered\n");
>  }
>  
>  void __exit q40kbd_exit(void)
>  {
> -	unregister_serio_port(&q40kbd_port);
> +	master_outb(0,KEY_IRQ_ENABLE_REG);
> +	master_outb(-1,KEYBOARD_UNLOCK_REG);
> +
> +	serio_unregister_port(&q40kbd_port);
>  	free_irq(Q40_IRQ_KEYBOARD, NULL);
> -	release_region(0x60, 16);	
>  }
>  
>  module_init(q40kbd_init);

-- 
Vojtech Pavlik
SuSE Labs
