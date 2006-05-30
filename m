Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWE3Kc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWE3Kc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWE3Kc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:32:58 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:59147 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S932232AbWE3Kc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:32:57 -0400
In-Reply-To: <1148984870.20582.15.camel@localhost.localdomain>
Subject: Re: RT_PREEMPT problem with cascaded irqchip
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Sven-Thorsten Dietrich <sven@mvista.com>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF7D277146.13CDBC6A-ONC125717E.0039350C-C125717E.0039F142@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Tue, 30 May 2006 12:26:48 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/30/2006
 12:26:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, here is the file arch/arm/mach-at91rm9200/gpio.c with my
modified gpio_irq_handler.

/*
 * linux/arch/arm/mach-at91rm9200/gpio.c
 *
 * Copyright (C) 2005 HP Labs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/kernel_stat.h>

#include <asm/io.h>
#include <asm/mach/irq.h>
#include <asm/arch/hardware.h>
#include <asm/arch/gpio.h>

static const u32 pio_controller_offset[4] = {
      AT91_PIOA,
      AT91_PIOB,
      AT91_PIOC,
      AT91_PIOD,
};

static inline void __iomem *pin_to_controller(unsigned pin)
{
      void __iomem *sys_base = (void __iomem *) AT91_VA_BASE_SYS;

      pin -= PIN_BASE;
      pin /= 32;
      if (likely(pin < BGA_GPIO_BANKS))
            return sys_base + pio_controller_offset[pin];

      return NULL;
}

static inline unsigned pin_to_mask(unsigned pin)
{
      pin -= PIN_BASE;
      return 1 << (pin % 32);
}


/*--------------------------------------------------------------------------*/

/* Not all hardware capabilities are exposed through these calls; they
 * only encapsulate the most common features and modes.  (So if you
 * want to change signals in groups, do it directly.)
 *
 * Bootloaders will usually handle some of the pin multiplexing setup.
 * The intent is certainly that by the time Linux is fully booted, all
 * pins should have been fully initialized.  These setup calls should
 * only be used by board setup routines, or possibly in driver probe().
 *
 * For bootloaders doing all that setup, these calls could be inlined
 * as NOPs so Linux won't duplicate any setup code
 */


/*
 * mux the pin to the "A" internal peripheral role.
 */
int __init_or_module at91_set_A_periph(unsigned pin, int use_pullup)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;

      __raw_writel(mask, pio + PIO_IDR);
      __raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
      __raw_writel(mask, pio + PIO_ASR);
      __raw_writel(mask, pio + PIO_PDR);
      return 0;
}
EXPORT_SYMBOL(at91_set_A_periph);


/*
 * mux the pin to the "B" internal peripheral role.
 */
int __init_or_module at91_set_B_periph(unsigned pin, int use_pullup)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;

      __raw_writel(mask, pio + PIO_IDR);
      __raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
      __raw_writel(mask, pio + PIO_BSR);
      __raw_writel(mask, pio + PIO_PDR);
      return 0;
}
EXPORT_SYMBOL(at91_set_B_periph);


/*
 * mux the pin to the gpio controller (instead of "A" or "B" peripheral),
and
 * configure it for an input.
 */
int __init_or_module at91_set_gpio_input(unsigned pin, int use_pullup)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;

      __raw_writel(mask, pio + PIO_IDR);
      __raw_writel(mask, pio + (use_pullup ? PIO_PUER : PIO_PUDR));
      __raw_writel(mask, pio + PIO_ODR);
      __raw_writel(mask, pio + PIO_PER);
      return 0;
}
EXPORT_SYMBOL(at91_set_gpio_input);


/*
 * mux the pin to the gpio controller (instead of "A" or "B" peripheral),
 * and configure it for an output.
 */
int __init_or_module at91_set_gpio_output(unsigned pin, int value)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;

      __raw_writel(mask, pio + PIO_IDR);
      __raw_writel(mask, pio + PIO_PUDR);
      __raw_writel(mask, pio + (value ? PIO_SODR : PIO_CODR));
      __raw_writel(mask, pio + PIO_OER);
      __raw_writel(mask, pio + PIO_PER);
      return 0;
}
EXPORT_SYMBOL(at91_set_gpio_output);


/*
 * enable/disable the glitch filter; mostly used with IRQ handling.
 */
int __init_or_module at91_set_deglitch(unsigned pin, int is_on)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;
      __raw_writel(mask, pio + (is_on ? PIO_IFER : PIO_IFDR));
      return 0;
}
EXPORT_SYMBOL(at91_set_deglitch);

/*
 * enable/disable the multi-driver; This is only valid for output and
 * allows the output pin to run as an open collector output.
 */
int __init_or_module at91_set_multi_drive(unsigned pin, int is_on)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;

      __raw_writel(mask, pio + (is_on ? PIO_MDER : PIO_MDDR));
      return 0;
}
EXPORT_SYMBOL(at91_set_multi_drive);

/*--------------------------------------------------------------------------*/


/*
 * assuming the pin is muxed as a gpio output, set its value.
 */
int at91_set_gpio_value(unsigned pin, int value)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (!pio)
            return -EINVAL;
      __raw_writel(mask, pio + (value ? PIO_SODR : PIO_CODR));
      return 0;
}
EXPORT_SYMBOL(at91_set_gpio_value);


/*
 * read the pin's value (works even if it's not muxed as a gpio).
 */
int at91_get_gpio_value(unsigned pin)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);
      u32         pdsr;

      if (!pio)
            return -EINVAL;
      pdsr = __raw_readl(pio + PIO_PDSR);
      return (pdsr & mask) != 0;
}
EXPORT_SYMBOL(at91_get_gpio_value);

/*--------------------------------------------------------------------------*/


/* Several AIC controller irqs are dispatched through this GPIO handler.
 * To use any AT91_PIN_* as an externally triggered IRQ, first call
 * at91_set_gpio_input() then maybe enable its glitch filter.
 * Then just request_irq() with the pin ID; it works like any ARM IRQ
 * handler, though it always triggers on rising and falling edges.
 *
 * Alternatively, certain pins may be used directly as IRQ0..IRQ6 after
 * configuring them with at91_set_a_periph() or at91_set_b_periph().
 * IRQ0..IRQ6 should be configurable, e.g. level vs edge triggering.
 */

static void gpio_irq_mask(unsigned pin)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (pio)
            __raw_writel(mask, pio + PIO_IDR);
}

static void gpio_irq_unmask(unsigned pin)
{
      void __iomem      *pio = pin_to_controller(pin);
      unsigned    mask = pin_to_mask(pin);

      if (pio)
            __raw_writel(mask, pio + PIO_IER);
}

static int gpio_irq_type(unsigned pin, unsigned type)
{
      return (type == IRQT_BOTHEDGE) ? 0 : -EINVAL;
}

static struct irqchip gpio_irqchip = {
      .mask       = gpio_irq_mask,
      .unmask           = gpio_irq_unmask,
      .set_type   = gpio_irq_type,
};

static void gpio_irq_handler(unsigned irq, struct irqdesc *desc, struct
pt_regs *regs)
{
        desc->chip->mask(irq);
        desc->chip->unmask(irq);
}

static DEFINE_IRQ_CHAINED_TYPE(gpio_irq_handler);

/* call this from board-specific init_irq */
void __init at91_gpio_irq_setup(unsigned banks)
{
      unsigned    pioc, pin, id;

      if (banks > 4)
            banks = 4;
      for (pioc = 0, pin = PIN_BASE, id = AT91_ID_PIOA;
                  pioc < banks;
                  pioc++, id++) {
            void __iomem      *controller;
            unsigned    i;

            controller = (void __iomem *) AT91_VA_BASE_SYS +
pio_controller_offset[pioc];
            __raw_writel(~0, controller + PIO_IDR);

            set_irq_data(id, (void *) pin);
            set_irq_chipdata(id, (void __force *) controller);

            for (i = 0; i < 32; i++, pin++) {
                  set_irq_chip(pin, &gpio_irqchip);
                        printk(KERN_ERR "GPIO SET_IRQ_CHIP\n");
                  set_irq_handler(pin, do_simple_IRQ);
                  set_irq_flags(pin, IRQF_VALID);
            }

            set_irq_chained_handler(id, gpio_irq_handler);

            /* enable the PIO peripheral clock */
            at91_sys_write(AT91_PMC_PCER, 1 << id);
      }
      pr_info("AT91: %d gpio irqs in %d banks\n", pin - PIN_BASE, banks);
}



                                                                           
             Thomas Gleixner                                               
             <tglx@linutronix.                                             
             de>                                                        To 
             Sent by:                  Yann.LEPROVOST@wavecom.fr           
             linux-kernel-owne                                          cc 
             r@vger.kernel.org         Sven-Thorsten Dietrich              
                                       <sven@mvista.com>, Daniel Walker    
                                       <dwalker@mvista.com>,               
             30/05/2006 12:27          linux-kernel@vger.kernel.org,       
                                       linux-kernel-owner@vger.kernel.org, 
                                       Ingo Molnar <mingo@elte.hu>, Steven 
             Please respond to         Rostedt <rostedt@goodmis.org>,      
             tglx@linutronix.d         Esben Nielsen <simlo@phys.au.dk>    
                     e                                             Subject 
                                       Re: RT_PREEMPT problem with         
                                       cascaded irqchip                    
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Tue, 2006-05-30 at 12:00 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Hi folks,
>
> However, when calling desc->chip->mask, the function at91rm9200_mask_irq
is
> called instead of gpio_mask_irq !

Well, propably the chip setting of the gpio interrupts is not correct.
Can you show me the code please ?

             tglx


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


