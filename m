Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRKFLf6>; Tue, 6 Nov 2001 06:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279079AbRKFLfs>; Tue, 6 Nov 2001 06:35:48 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:6296 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S279064AbRKFLfk>;
	Tue, 6 Nov 2001 06:35:40 -0500
Date: Tue, 6 Nov 2001 12:34:27 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
Message-ID: <20011106123427.A11351@hazard.jcu.cz>
In-Reply-To: <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105112900.C5919@hazard.jcu.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

On Mon, Nov 05, 2001 at 11:29:00AM +0100, Jan Marek wrote:
> > 
> > Try moving the block of code which requests the IRQ down
> > so that it comes after the call to cardbus_register().
> 
> yes. I tried move the block, what are you wrote about... Bu the
> last messages, what I got from notebook when I modprobe'd
> yenta_socket is:
> 
> Yenta IRQ list 04b8, PCI irq11
> Socket status: 30000010
> 
> (this messages is generated in function cardbus_register()).
> 
> And kernel freeze as before...

I tryed to trace of function request_irq():

I found, that problem is in this code:

--- function setup_irq() from file arch/i386/kernel/irq.c

/* this was setup_x86_irq but it seems pretty generic */
int setup_irq(unsigned int irq, struct irqaction * new)
{
	int shared = 0;
	unsigned long flags;
	struct irqaction *old, **p;
	irq_desc_t *desc = irq_desc + irq;

	/*
	 * Some drivers like serial.c use request_irq() heavily,
	 * so we have to be careful not to interfere with a
	 * running system.
	 */
	if (new->flags & SA_SAMPLE_RANDOM) {
		/*
		 * This function might sleep, we want to call it first,
		 * outside of the atomic block.
		 * Yes, this might clear the entropy pool if the wrong
		 * driver is attempted to be loaded, without actually
		 * installing a new handler, but is this really a problem,
		 * only the sysadmin is able to do this.
		 */
		rand_initialize_irq(irq);
	}

	/*
	 * The following block of code has to be executed atomically
	 */
	spin_lock_irqsave(&desc->lock,flags);
	printk("setup_irq: spin_lock_irqsave()\n");
	p = &desc->action;
	if ((old = *p) != NULL) {
		/* Can't share interrupts unless both agree to */
		if (!(old->flags & new->flags & SA_SHIRQ)) {
			spin_unlock_irqrestore(&desc->lock,flags);
			return -EBUSY;
		}

		/* add new interrupt at end of irq queue */
		do {
			p = &old->next;
			old = *p;
		} while (old);
		shared = 1;
	}

	*p = new;

	if (!shared) {
		desc->depth = 0;
		desc->status &= ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
		desc->handler->startup(irq);
		printk("request_irq: desc->handler->startup(irq)\n");
	}
	spin_unlock_irqrestore(&desc->lock,flags);
	printk("request_irq: spin_unlock_irqrestore()\n");

	register_irq_proc(irq);
	printk("request_irq: register_irq_proc()\n");
	return 0;
}
--- end of listing

The last message I got from kernel is: 
request_irq: desc->handler->startup(irq)

Then problem is in the spin_unlock_irqrestore()???

Any ideas, recomendations, suggestions?

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
