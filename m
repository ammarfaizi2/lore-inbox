Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280622AbRKBJb2>; Fri, 2 Nov 2001 04:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKBJbS>; Fri, 2 Nov 2001 04:31:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1550 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280622AbRKBJbO>; Fri, 2 Nov 2001 04:31:14 -0500
Message-ID: <3BE266B4.85E3162@zip.com.au>
Date: Fri, 02 Nov 2001 01:26:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Marek <jmarek@jcu.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem in yenta.c, 2nd edition
In-Reply-To: <20011102093935.H20754@hazard.jcu.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Marek wrote:
> 
> Hallo l-k,
> 
> the first: I'm very sorry for old post about PCMCIA: function
> yenta_config_init() is called the first time from yenta_open()
> and not from yenta_init(), as I think... It was my error...
> 
> I explored yenta.c through printk() function and I found the last
> point, where kernel freeze: This point is here:
> 

Presumably the controller is permanently requesting an
interrupt.  So as soon as you enable the IRQ, you lock
up, taking infinite interrupts.

It's always seemed a bit fishy how we enable the IRQ before
initialising the socket controller.

Try moving the block of code which requests the IRQ down
so that it comes after the call to cardbus_register().

> --- function yenta_open_bh() from drivers/pcmcia/yenta.c
> /*
>  * 'Bottom half' for the yenta_open routine. Allocate the interrupt line
>  *  and register the socket with the upper layers.
>  */
> static void yenta_open_bh(void * data)
> {
>         pci_socket_t * socket = (pci_socket_t *) data;
> 
>         /* It's OK to overwrite this now */
>         socket->tq_task.routine = yenta_bh;
>         printk("yenta_open_bh: socket->tq_task.routine\n");
>

>From here
 
>         if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, (SA_SHIRQ | SA_INTERRUPT), socket->dev->name, socket)) {
>                 /* No IRQ or request_irq failed. Poll */
>                 printk("yenta_open_bh: in the if block\n");
>                 socket->cb_irq = 0; /* But zero is a valid IRQ number. */
>                 socket->poll_timer.function = yenta_interrupt_wrapper;
>                 socket->poll_timer.data = (unsigned long)socket;
>                 socket->poll_timer.expires = jiffies + HZ;
>                 printk("yenta_open_bh: before add_timer\n");
>                 add_timer(&socket->poll_timer);
>                 printk("yenta_open_bh: add_timer\n");
>         }

to here
 
>         printk("yenta_open_bh: after if(!socket->cb_irq...\n");
>         /* Figure out what the dang thing can do for the PCMCIA layer... */
>         yenta_get_socket_capabilities(socket, isa_interrupts);
>         printk("yenta_open_bh: after yenta_get_socket_capabilities\n");
>         printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
> 
>         /* Register it with the pcmcia layer.. */
>         cardbus_register(socket);
>         printk("yenta_open_bh: cardbus_register()\n");

move it down to here.
 
>         MOD_DEC_USE_COUNT;
> }


-
