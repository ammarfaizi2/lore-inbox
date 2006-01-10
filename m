Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWAJC4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWAJC4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWAJC4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:56:17 -0500
Received: from xenotime.net ([66.160.160.81]:1930 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750916AbWAJC4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:56:16 -0500
Date: Mon, 9 Jan 2006 18:56:11 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arnaud Giersch <arnaud.giersch@free.fr>
Cc: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][repost] parport: add parallel port support for SGI O2
Message-Id: <20060109185611.14202427.rdunlap@xenotime.net>
In-Reply-To: <87ace5jfgj.fsf@groumpf.homeip.net>
References: <87ace5jfgj.fsf@groumpf.homeip.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2006 21:47:56 +0100 Arnaud Giersch wrote:

> Add support for the built-in parallel port on SGI O2 (a.k.a. IP32).
> Define a new configuration option: PARPORT_IP32.  The module is named
> parport_ip32.
> 
> Hardware support for SPP, EPP and ECP modes along with DMA support
> when available are currently implemented.
> 
> Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
> ---
> 
> diff -Naurp linux-2.6.15.orig/drivers/parport/parport_ip32.c linux-2.6.15/drivers/parport/parport_ip32.c
> --- linux-2.6.15.orig/drivers/parport/parport_ip32.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.15/drivers/parport/parport_ip32.c	2006-01-09 20:41:03.000000000 +0100
> @@ -0,0 +1,2313 @@

Thanks for all of that kernel-doc (really).

I scanned over the driver.  It seems to be in pretty good shape,
but I have to wonder about the use of "volatile" and the
barriers [wmb() and barrier()].  Are those really needed?

Oh, and a really large inline function plus lots of smaller
ones.

Plus some comments below.

> +/**
> + * parport_ip32_setup_context - setup next DMA context
> + * @limit:	maximum data size for the context
> + *
> + * The alignment constraints must be verified in caller function, and the
> + * parameter @limit must be set accordingly.
> + */
> +static inline void parport_ip32_dma_setup_context(unsigned int limit)
> +{
> +	if (down_trylock(&parport_ip32_dma.lock)) {
> +		/* Come back later please.  The MACE keeps sending interrupts
> +		 * when a context is invalid, so there is no problem with this
> +		 * early return. */
> +		return;
> +	}
> +	if (parport_ip32_dma.left > 0) {
> +		volatile u64 __iomem *ctxreg = (parport_ip32_dma.ctx == 0)?
> +			&mace->perif.ctrl.parport.context_a:
> +			&mace->perif.ctrl.parport.context_b;
> +		u64 count;
> +		u64 ctxval;
> +		if (parport_ip32_dma.left <= limit) {
> +			count = parport_ip32_dma.left;
> +			ctxval = MACEPAR_CONTEXT_LASTFLAG;
> +		} else {
> +			count = limit;
> +			ctxval = 0;
> +		}
> +
> +		pr_trace(NULL,
> +			 "(%u): 0x%04x:0x%04x, %u -> %u%s",
> +			 limit,
> +			 (unsigned int)parport_ip32_dma.buf,
> +			 (unsigned int)parport_ip32_dma.next,
> +			 (unsigned int)count,
> +			 parport_ip32_dma.ctx, ctxval? "*": "");
> +
> +		ctxval |= parport_ip32_dma.next &
> +			MACEPAR_CONTEXT_BASEADDR_MASK;
> +		ctxval |= ((count - 1) << MACEPAR_CONTEXT_DATALEN_SHIFT) &
> +			MACEPAR_CONTEXT_DATALEN_MASK;
> +		writeq(ctxval, ctxreg);
> +		wmb();
> +		parport_ip32_dma.next += count;
> +		parport_ip32_dma.left -= count;
> +		parport_ip32_dma.ctx ^= 1U;
> +	}
> +	/* If there is nothing more to send, disable IRQs to avoid to
> +	 * face an IRQ storm which can lock the machine.  Disable them
> +	 * only once. */
> +	if (parport_ip32_dma.left == 0
> +	    && !down_trylock(&parport_ip32_dma.noirq)) {
> +		pr_debug(PPIP32 "IRQ off (ctx)\n");
> +		disable_irq_nosync(MACEISA_PAR_CTXA_IRQ);
> +		disable_irq_nosync(MACEISA_PAR_CTXB_IRQ);
> +	}
> +	/* Make sure that parport_ip32_dma is actually written */
> +	barrier();
> +	up(&parport_ip32_dma.lock);
> +}


> +/**
> + * parport_ip32_dma_get_residue - get residue from last DMA transfer
> + *
> + * Returns the number of byte remaining from last DMA transfer.
~~~~~~~~~~~~~~~~~~~~~~~~~~~ bytes

> + */
> +static inline size_t parport_ip32_dma_get_residue(void)
> +{
> +	return parport_ip32_dma.left;
> +}

> +/*--- Interrupt handlers and associates --------------------------------*/

> +/**
> + * parport_ip32_interrupt - interrupt handler

Needs function parameters in kernel-doc.

> + *
> + * Caught interrupts are forwarded to the upper parport layer if IRQ_mode is
> + * %PARPORT_IP32_IRQ_FWD.
> + */
> +static irqreturn_t parport_ip32_interrupt(int irq, void *dev_id,
> +					  struct pt_regs *regs)
> +{
> +	struct parport * const p = dev_id;
> +	struct parport_ip32_private * const priv = p->physport->private_data;
> +	enum parport_ip32_irq_mode irq_mode = priv->irq_mode;
> +	barrier();		/* ensures that priv->irq_mode is read */
> +	switch (irq_mode) {
> +	case PARPORT_IP32_IRQ_FWD:
> +		parport_generic_irq(irq, p, regs);
> +		break;
> +	case PARPORT_IP32_IRQ_HERE:
> +		parport_ip32_wakeup(p);
> +		break;
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +/*--- Basic functions needed for parport -------------------------------*/

> +/**
> + * parport_ip32_init_state - for core parport code

Missing params in kernel-doc.

> + */
> +static inline void parport_ip32_init_state(struct pardevice *dev,
> +					   struct parport_state *s)
> +{
> +	s->u.ip32.dcr = DCR_SELECT | DCR_nINIT;
> +	s->u.ip32.ecr = ECR_MODE_PS2 | ECR_nERRINTR | ECR_SERVINTR;
> +}
> +
> +/**
> + * parport_ip32_save_state - for core parport code

Missing params in kernel-doc (or just don't make it look like
kernel-doc).

> + */
> +static inline void parport_ip32_save_state(struct parport *p,
> +					   struct parport_state *s)
> +{
> +	s->u.ip32.dcr = __parport_ip32_read_control(p);
> +	s->u.ip32.ecr = parport_ip32_read_econtrol(p);
> +}
> +
> +/**
> + * parport_ip32_restore_state - for core parport code

Ditto.

> + */
> +static inline void parport_ip32_restore_state(struct parport *p,
> +					      struct parport_state *s)
> +{
> +	parport_ip32_set_mode(p, s->u.ip32.ecr & ECR_MODE_MASK);
> +	parport_ip32_write_econtrol(p, s->u.ip32.ecr);
> +	__parport_ip32_write_control(p, s->u.ip32.dcr);
> +}
> +
> +/*--- EPP mode functions -----------------------------------------------*/
> +

Why are a lot of the short EPP functions not inline?


> +/*--- ECP mode functions (FIFO) ----------------------------------------*/
> +
> +/**
> + * parport_ip32_fifo_write_block_pio - write a block of data (PIO mode)
> + * @p:		pointer to &struct parport
> + * @buf:	buffer of data to write
> + * @len:	length of buffer @buf
> + *
> + * Uses PIO to write the contents of the buffer @buf into the parallel port
> + * FIFO.  Returns the number of bytes that were actually written.  It can work
> + * with or without the help of interrupts.  The parallel port must be
> + * correctly initialized before calling parport_ip32_fifo_write_block_pio().
> + */
> +static size_t parport_ip32_fifo_write_block_pio(struct parport *p,
> +						const void *buf, size_t len)
> +{
> +	struct parport_ip32_private * const priv = p->physport->private_data;
> +	const u8 *bufp = buf;
> +	size_t left = len;
> +
> +	priv->irq_mode = PARPORT_IP32_IRQ_HERE;
> +
> +	while (left > 0) {
> +		unsigned int count;
> +
> +		count = (p->irq == PARPORT_IRQ_NONE)?
> +			parport_ip32_fwp_wait_polling(p):
> +			parport_ip32_fwp_wait_interrupt(p);
> +		if (count == 0) {
> +			/* Transmission should be stopped */
> +			break;
> +		}
> +		if (count > left) {
> +			count = left;
> +		}

Style:  one-line if's don't use braces.

> +		if (count == 1) {
> +			parport_ip32_out(*bufp, priv->regs.fifo);
> +			bufp++, left--;
> +		} else {
> +			parport_ip32_out_rep(priv->regs.fifo, bufp, count);
> +			bufp += count, left -= count;
> +		}
> +	}
> +
> +	priv->irq_mode = PARPORT_IP32_IRQ_FWD;
> +
> +	return (len - left);

Style:  no parens on return unless needed.

> +}
> +
> +
> +
> +
> +/**
> + * parport_ip32_get_fifo_residue - reset FIFO
> + * @p:		pointer to &struct parport
> + * @mode:	current operation mode (ECR_MODE_PPF or ECR_MODE_ECP)
> + *
> + * This function resets FIFO, and returns the number of bytes remaining in it.
> + */
> +static unsigned int parport_ip32_get_fifo_residue(struct parport *p,
> +						  unsigned int mode)
> +{
> +	struct parport_ip32_private * const priv = p->physport->private_data;
> +	unsigned int residue;
> +	unsigned int cnfga;
> +
> +	/* FIXME - We are missing one byte if the printer is off-line.  I
> +	 * don't know how to detect this.  It looks that the full bit is not
> +	 * always reliable.  For the moment, the problem is avoided in most
> +	 * cases by testing for BUSY in parport_ip32_compat_write_data().
> +	 */
> +	if (parport_ip32_read_econtrol(p) & ECR_F_EMPTY) {
> +		residue = 0;

Style:  no braces (above).

> +	} else {
> +		printk(KERN_DEBUG PPIP32 "%s: FIFO is stuck\n", p->name);
> +
> +		/* Stop all transfers.
> +		 *
> +		 * Microsoft's document instructs to drive DCR_STROBE to 0,
> +		 * but it doesn't work (at least in Compatibility mode, not
> +		 * tested in ECP mode).  Switching directly to Test mode (as
> +		 * in parport_pc) is not an option: it does confuse the port,
> +		 * ECP service interrupts are no more working after that.  A
> +		 * hard reset is then needed to revert to a sane state.
> +		 *
> +		 * Let's hope that the FIFO is really stuck and that the
> +		 * peripheral doesn't wake up now.
> +		 */
> +		parport_ip32_frob_control(p, DCR_STROBE, 0);
> +
> +		/* Fill up FIFO */
> +		for (residue = priv->fifo_depth; residue > 0; residue--) {
> +			if (parport_ip32_read_econtrol(p) & ECR_F_FULL)
> +				break;
> +			parport_ip32_out(0x00, priv->regs.fifo);
> +		}
> +	}
> +	if (residue) {
> +		pr_debug1(PPIP32 "%s: %d PWord%s left in FIFO\n",
> +			  p->name, residue,
> +			  (residue == 1)? " was": "s were");
> +	}
> +
> +	/* Now reset the FIFO */
> +	parport_ip32_set_mode(p, ECR_MODE_PS2);
> +
> +	/* Host recovery for ECP mode */
> +	if (mode == ECR_MODE_ECP) {
> +		parport_ip32_data_reverse(p);
> +		parport_ip32_frob_control(p, DCR_nINIT, 0);
> +		if (parport_wait_peripheral(p, DSR_PERROR, 0)) {
> +			pr_debug1(PPIP32 "%s: PEerror timeout 1 in %s\n",
> +				  p->name, __func__);
> +		}
> +		parport_ip32_frob_control(p, DCR_STROBE, DCR_STROBE);
> +		parport_ip32_frob_control(p, DCR_nINIT, DCR_nINIT);
> +		if (parport_wait_peripheral(p, DSR_PERROR, DSR_PERROR)) {
> +			pr_debug1(PPIP32 "%s: PEerror timeout 2 in %s\n",
> +				  p->name, __func__);
> +		}
> +	}
> +
> +	/* Adjust residue if needed */
> +	parport_ip32_set_mode(p, ECR_MODE_CFG);
> +	cnfga = parport_ip32_in(priv->regs.cnfgA);
> +	if (!(cnfga & CNFGA_nBYTEINTRANS)) {
> +		pr_debug1(PPIP32 "%s: cnfgA contains 0x%02x\n",
> +			  p->name, cnfga);
> +		pr_debug1(PPIP32 "%s: Accounting for extra byte\n",
> +			  p->name);
> +		residue++;
> +	}
> +
> +	/* Don't care about partial PWords since we do not support
> +	 * PWord != 1 byte. */
> +
> +	/* Back to forward PS2 mode. */
> +	parport_ip32_set_mode(p, ECR_MODE_PS2);
> +	parport_ip32_data_forward(p);
> +
> +	return residue;
> +}
> +
> +/*--- Default parport operations ---------------------------------------*/
> +
> +static __initdata struct parport_operations parport_ip32_ops = {

Are you sure that it's safe for this to be __initdata?

> +	.write_data		= parport_ip32_write_data,
> +	.read_data		= parport_ip32_read_data,
> +
> +	.write_control		= parport_ip32_write_control,
> +	.read_control		= parport_ip32_read_control,
> +	.frob_control		= parport_ip32_frob_control,
> +
> +	.read_status		= parport_ip32_read_status,
> +
> +	.enable_irq		= parport_ip32_enable_irq,
> +	.disable_irq		= parport_ip32_disable_irq,
> +
> +	.data_forward		= parport_ip32_data_forward,
> +	.data_reverse		= parport_ip32_data_reverse,
> +
> +	.init_state		= parport_ip32_init_state,
> +	.save_state		= parport_ip32_save_state,
> +	.restore_state		= parport_ip32_restore_state,
> +
> +	.epp_write_data		= parport_ieee1284_epp_write_data,
> +	.epp_read_data		= parport_ieee1284_epp_read_data,
> +	.epp_write_addr		= parport_ieee1284_epp_write_addr,
> +	.epp_read_addr		= parport_ieee1284_epp_read_addr,
> +
> +	.ecp_write_data		= parport_ieee1284_ecp_write_data,
> +	.ecp_read_data		= parport_ieee1284_ecp_read_data,
> +	.ecp_write_addr		= parport_ieee1284_ecp_write_addr,
> +
> +	.compat_write_data	= parport_ieee1284_write_compat,
> +	.nibble_read_data	= parport_ieee1284_read_nibble,
> +	.byte_read_data		= parport_ieee1284_read_byte,
> +
> +	.owner			= THIS_MODULE,
> +};
> +
> +/*--- Initialization code ----------------------------------------------*/
> +
> +/**
> + * parport_ip32_probe_port - probe and register IP32 built-in parallel port
> + *
> + * Returns the new allocated &parport structure.  On error, an error code is
> + * encoded in return value with the ERR_PTR function.
> + */
> +static __init struct parport *parport_ip32_probe_port(void)
> +{
> +	struct parport_ip32_regs regs;
> +	struct parport_ip32_private *priv = NULL;
> +	struct parport_operations *ops = NULL;
> +	struct parport *p = NULL;
> +	int err;
> +
> +	parport_ip32_make_isa_registers(&regs, &mace->isa.parallel,
> +					&mace->isa.ecp1284, 8 /* regshift */);
> +
> +	ops = kmalloc(sizeof(struct parport_operations), GFP_KERNEL);
> +	priv = kmalloc(sizeof(struct parport_ip32_private), GFP_KERNEL);
> +	p = parport_register_port(0, PARPORT_IRQ_NONE, PARPORT_DMA_NONE, ops);
> +	if (ops == NULL || priv == NULL || p == NULL) {
> +		err = -ENOMEM;
> +		goto fail;
> +	}
> +	p->base = MACE_BASE + offsetof(struct sgi_mace, isa.parallel);
> +	p->base_hi = MACE_BASE + offsetof(struct sgi_mace, isa.ecp1284);
> +	p->private_data = priv;
> +
> +	*ops = parport_ip32_ops;
> +	*priv = (struct parport_ip32_private){
> +		.regs			= regs,
> +		.dcr_writable		= DCR_DIR | DCR_SELECT | DCR_nINIT |
> +					  DCR_AUTOFD | DCR_STROBE,
> +		.irq_mode		= PARPORT_IP32_IRQ_FWD,
> +	};
> +	init_completion(&priv->irq_complete);
> +
> +	/* Probe port. */
> +	if (!parport_ip32_ecp_supported(p)) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +	parport_ip32_dump_state (p, "begin init", 0);
> +
> +	/* We found what looks like a working ECR register.  Simply assume
> +	 * that all modes are correctly supported.  Enable basic modes. */
> +	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
> +	p->modes |= PARPORT_MODE_TRISTATE;
> +
> +	if (!parport_ip32_fifo_supported(p)) {
> +		printk(KERN_WARNING PPIP32
> +		       "%s: error: FIFO disabled\n", p->name);
> +		/* Disable hardware modes depending on a working FIFO. */
> +		features &= ~PARPORT_IP32_ENABLE_SPP;
> +		features &= ~PARPORT_IP32_ENABLE_ECP;
> +		/* DMA is not needed if FIFO is not supported.  */
> +		features &= ~PARPORT_IP32_ENABLE_DMA;
> +	}
> +
> +	/* Request IRQ */
> +	if (features & PARPORT_IP32_ENABLE_IRQ) {
> +		int irq = MACEISA_PARALLEL_IRQ;
> +		if (request_irq(irq, parport_ip32_interrupt, 0, p->name, p)) {
> +			printk(KERN_WARNING PPIP32
> +			       "%s: error: IRQ disabled\n", p->name);
> +			/* DMA cannot work without interrupts. */
> +			features &= ~PARPORT_IP32_ENABLE_DMA;
> +		} else {
> +			pr_probe(p, "Interrupt support enabled\n");
> +			p->irq = irq;
> +			priv->dcr_writable |= DCR_IRQ;
> +		}
> +	}
> +
> +	/* Allocate DMA resources */
> +	if (features & PARPORT_IP32_ENABLE_DMA) {
> +		if (parport_ip32_dma_register()) {
> +			printk(KERN_WARNING PPIP32
> +			       "%s: error: DMA disabled\n", p->name);

Style:  no braces wanted here.

> +		} else {
> +			pr_probe(p, "DMA support enabled\n");
> +			p->dma = 0; /* arbitrary value != PARPORT_DMA_NONE */
> +			p->modes |= PARPORT_MODE_DMA;
> +		}
> +	}
> +
> +	if (features & PARPORT_IP32_ENABLE_SPP) {
> +		/* Enable compatibility FIFO mode */
> +		p->ops->compat_write_data = parport_ip32_compat_write_data;
> +		p->modes |= PARPORT_MODE_COMPAT;
> +		pr_probe(p, "Hardware support for SPP mode enabled\n");
> +	}
> +	if (features & PARPORT_IP32_ENABLE_EPP) {
> +		/* Set up access functions to use EPP hardware. */
> +		p->ops->epp_read_data = parport_ip32_epp_read_data;
> +		p->ops->epp_write_data = parport_ip32_epp_write_data;
> +		p->ops->epp_read_addr = parport_ip32_epp_read_addr;
> +		p->ops->epp_write_addr = parport_ip32_epp_write_addr;
> +		p->modes |= PARPORT_MODE_EPP;
> +		pr_probe(p, "Hardware support for EPP mode enabled\n");
> +	}
> +	if (features & PARPORT_IP32_ENABLE_ECP) {
> +		/* Enable ECP FIFO mode */
> +		p->ops->ecp_write_data = parport_ip32_ecp_write_data;
> +		/* FIXME - not implemented */
> +/*		p->ops->ecp_read_data  = parport_ip32_ecp_read_data; */
> +/*		p->ops->ecp_write_addr = parport_ip32_ecp_write_addr; */
> +		p->modes |= PARPORT_MODE_ECP;
> +		pr_probe(p, "Hardware support for ECP mode enabled\n");
> +	}
> +
> +	/* Initialize the port with sensible values */
> +	parport_ip32_set_mode(p, ECR_MODE_PS2);
> +	parport_ip32_write_control(p, DCR_SELECT | DCR_nINIT);
> +	parport_ip32_data_forward(p);
> +	parport_ip32_disable_irq(p);
> +	parport_ip32_write_data(p, 0x00);
> +	parport_ip32_dump_state (p, "end init", 0);
> +
> +	/* Print out what we found */
> +	printk(KERN_INFO "%s: SGI IP32 at 0x%lx (0x%lx)",
> +	       p->name, p->base, p->base_hi);
> +	if (p->irq != PARPORT_IRQ_NONE) {
> +		printk(", irq %d", p->irq);
> +	}
> +	printk(" [");
> +#define printmode(x)	if (p->modes & PARPORT_MODE_##x)		\
> +				printk("%s%s", f++? ",": "", #x)
> +	{
> +		unsigned int f = 0;
> +		printmode(PCSPP);
> +		printmode(TRISTATE);
> +		printmode(COMPAT);
> +		printmode(EPP);
> +		printmode(ECP);
> +		printmode(DMA);
> +	}
> +#undef printmode
> +	printk("]\n");
> +
> +	parport_announce_port(p);
> +	return p;
> +
> +fail:
> +	if (p) {
> +		parport_put_port(p);
> +	}
> +	kfree(priv);
> +	kfree(ops);
> +	return ERR_PTR(err);
> +}
> +
> +
> +/**
> + * parport_ip32_init - module initialization function
> + */
> +static int __init parport_ip32_init(void)
> +{
> +	pr_info(PPIP32 "SGI IP32 built-in parallel port driver v0.4\n");
> +	pr_debug1(PPIP32 "Compiled on %s, %s\n", __DATE__, __TIME__);
> +	this_port = parport_ip32_probe_port();
> +	return IS_ERR(this_port)? PTR_ERR(this_port): 0;

Please use spaces before and after '?' and ':'.

> +}


---
~Randy
