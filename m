Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280602AbRKBItY>; Fri, 2 Nov 2001 03:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280603AbRKBItO>; Fri, 2 Nov 2001 03:49:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31661 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S280602AbRKBIs6>;
	Fri, 2 Nov 2001 03:48:58 -0500
Date: Fri, 2 Nov 2001 09:39:35 +0100
From: Jan Marek <jmarek@jcu.cz>
To: linux-kernel@vger.kernel.org
Subject: Problem in yenta.c, 2nd edition
Message-ID: <20011102093935.H20754@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

the first: I'm very sorry for old post about PCMCIA: function
yenta_config_init() is called the first time from yenta_open()
and not from yenta_init(), as I think... It was my error...

I explored yenta.c through printk() function and I found the last
point, where kernel freeze: This point is here:

--- function yenta_open_bh() from drivers/pcmcia/yenta.c
/*
 * 'Bottom half' for the yenta_open routine. Allocate the interrupt line
 *  and register the socket with the upper layers.
 */
static void yenta_open_bh(void * data)
{
	pci_socket_t * socket = (pci_socket_t *) data;

	/* It's OK to overwrite this now */
	socket->tq_task.routine = yenta_bh;
	printk("yenta_open_bh: socket->tq_task.routine\n");

	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, (SA_SHIRQ | SA_INTERRUPT), socket->dev->name, socket)) {
		/* No IRQ or request_irq failed. Poll */
		printk("yenta_open_bh: in the if block\n");
		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
		socket->poll_timer.function = yenta_interrupt_wrapper;
		socket->poll_timer.data = (unsigned long)socket;
		socket->poll_timer.expires = jiffies + HZ;
		printk("yenta_open_bh: before add_timer\n");
		add_timer(&socket->poll_timer);
		printk("yenta_open_bh: add_timer\n");
	}

	printk("yenta_open_bh: after if(!socket->cb_irq...\n");
	/* Figure out what the dang thing can do for the PCMCIA layer... */
	yenta_get_socket_capabilities(socket, isa_interrupts);
	printk("yenta_open_bh: after yenta_get_socket_capabilities\n");
	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));

	/* Register it with the pcmcia layer.. */
	cardbus_register(socket);
	printk("yenta_open_bh: cardbus_register()\n");

	MOD_DEC_USE_COUNT; 
}
--- end of function

Last message from kernel is:
yenta_open_bh: socket->tq_task.routine

Then I mean, that problem is in the calling of request_irq(). As
you see, I tried call this function with flags (SA_SHIRQ |
SA_INTERRUPT), but this is not the right way too...

I wrote, that my Compaq has IRQ 11 shared between PCMCIA
controller and VGA card...

Please, can you cc any follow-ups to me? Thank you very much...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
