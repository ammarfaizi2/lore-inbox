Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWE3OvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWE3OvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWE3OvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:51:07 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:50952 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S932305AbWE3OvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:51:06 -0400
In-Reply-To: <1148988165.20582.19.camel@localhost.localdomain>
Subject: Re: RT_PREEMPT problem with cascaded irqchip
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Sven-Thorsten Dietrich <sven@mvista.com>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF1D43115C.4017CA7A-ONC125717E.004F8944-C125717E.0051942C@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Tue, 30 May 2006 16:44:58 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/30/2006
 04:45:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, in fact the issue doesn't come neither from the mask/unmask procedure
nor from the set_irq calls.
Correct gpio mask/unmask are called before the gpio_irq_handler.

However, there is an issue in gpio_irq_handler (specific to generic_irq and
AT91RM9200, i think) concerning desc->chip->chip_data.
The following change has to be applied :

 --    pio = (void __force __iomem *) desc->chip->chip_data;
++   pio = (void __force __iomem *) desc->chip_data;

Moreover, I think that the call to redirect_hardirq have to be insered in
gpio_irq_handler but I don't know how to do that.

Regards

Yann Leprovost



                                                                           
             Thomas Gleixner                                               
             <tglx@linutronix.                                             
             de>                                                        To 
             Sent by:                  Yann.LEPROVOST@wavecom.fr           
             linux-kernel-owne                                          cc 
             r@vger.kernel.org         Daniel Walker <dwalker@mvista.com>, 
                                       linux-kernel@vger.kernel.org,       
                                       linux-kernel-owner@vger.kernel.org, 
             30/05/2006 13:22          Ingo Molnar <mingo@elte.hu>, Steven 
                                       Rostedt <rostedt@goodmis.org>,      
                                       Esben Nielsen <simlo@phys.au.dk>,   
             Please respond to         Sven-Thorsten Dietrich              
             tglx@linutronix.d         <sven@mvista.com>                   
                     e                                             Subject 
                                       Re: RT_PREEMPT problem with         
                                       cascaded irqchip                    
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Tue, 2006-05-30 at 12:26 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Of course, here is the file arch/arm/mach-at91rm9200/gpio.c with my
> modified gpio_irq_handler.

>             for (i = 0; i < 32; i++, pin++) {
>                   set_irq_chip(pin, &gpio_irqchip);
>                         printk(KERN_ERR "GPIO SET_IRQ_CHIP\n");
>                   set_irq_handler(pin, do_simple_IRQ);

-----------------------------------------^^^^^^^^^^^^^^^

Care to look into the implementation of this ? As the name says, its
simple. It does no ack/mask whatever. Use the level resp. the edge
handler instead.

             tglx




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


