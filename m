Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbUDTQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUDTQZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUDTQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:25:40 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:3597 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263338AbUDTQYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:24:50 -0400
Date: Tue, 20 Apr 2004 17:24:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (second round)
Message-ID: <20040420172447.A27454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040417104527.A16676@infradead.org> <20040420161111.3DCC9DBE4@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040420161111.3DCC9DBE4@gherkin.frus.com>; from rct@gherkin.frus.com on Tue, Apr 20, 2004 at 11:11:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 11:11:11AM -0500, Bob Tracy wrote:
> I'm not sure that nsp_cs does much more than assign a value to the
> "unique_id" member of the scsi_host structure (base port), and I
> probably missed what I was looking for, but I can certainly do as
> much :-).  Is there any way to test whether the driver code can
> support multiple HBAs short of having more than one?

There's not real test.  But a good indication is that you have all
almost no global variables (except some debug switches) and all
I/O address / state / etc in per-host instance data.

> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/ioport.h>
> +#include <linux/proc_fs.h>
> +#include <linux/stat.h>
> +#include <asm/io.h>
> +#include <asm/dma.h>
> +#include <asm/bitops.h>
> +#include <asm/irq.h>
> +#include <linux/major.h>
> +#include <linux/blkdev.h>
> +#include <linux/spinlock.h>

Please try to include all <asm/*> headers after <linux/*>.
You should't need major.h and proc_fs.h at least.

> +#include <pcmcia/version.h>

A proper pcmcia driver shouldn't need this one.

> +/* A useful macro... */
> +#define MIN(a, b)	((a) > (b) ? (b) : (a))

The kernel already has min(), and it even does type-checking.

> +#ifndef NULL
> +#define NULL 0
> +#endif

Shouldn't be needed.

> +/* Function prototypes. */
> +const char *SYM53C500_info(struct Scsi_Host *);
> +int SYM53C500_queue(struct scsi_cmnd *, void (*done)(struct scsi_cmnd *));
> +int SYM53C500_abort(struct scsi_cmnd *);
> +int SYM53C500_device_reset(struct scsi_cmnd *);
> +int SYM53C500_bus_reset(struct scsi_cmnd *);
> +int SYM53C500_host_reset(struct scsi_cmnd *);
> +int SYM53C500_biosparm(struct scsi_device *, struct block_device *, sector_t, int *);
> +int SYM53C500_proc_info(struct Scsi_Host *, char *, char **, off_t, int, int);

Everything in a scsi driver should be static.  Also try to avoid prototypes
for static functions whenever possible by ordering functions by their calling
chain.

> +#ifdef PCMCIA_DEBUG
> +static int pc_debug = PCMCIA_DEBUG;
> +MODULE_PARM(pc_debug, "i");

In 2.6 please use the type-chcking whizz-bang module_param instead of
MODULE_PARAM.

> +/*
> +*  the following will set the monitor border color
> +*  (useful to find where things crash or get stuck)
> +*
> +*  1 = blue
> +*  2 = green
> +*  3 = cyan
> +*  4 = red
> +*  5 = magenta
> +*  6 = yellow
> +*  7 = white
> +*/
> +
> +#if SYM53C500_DEBUG
> +#define rtrc(i) {inb(0x3da);outb(0x31,0x3c0);outb((i),0x3c0);}
> +#else
> +#define rtrc(i) {}
> +#endif

Do you actually use this debug code?  It's rather pc-specific..

> +typedef struct scsi_info_t {
> +	dev_link_t link;
> +	dev_node_t node;
> +	struct Scsi_Host *host;
> +	unsigned short manf_id;
> +} scsi_info_t;

Try to avoid typedefs if possible according to the Linux Kernel coding
style.  And yes, the pcmcia code isn't how it should be done, I know
you only copied it ;-)

> +static int port_base = 0;
> +static int irq_level = -1; /* 0 is 'no irq', so use -1 for 'uninitialized'*/
> +
> +static int fast_pio = USE_FAST_PIO;
> +
> +static struct scsi_cmnd *current_SC;
> +static char info_msg[256];

This is what I mean.  To support more than one card these variables and
some more would have to be in a per-host struct.

> +	scsi_add_host(host, NULL);	/* XXX handle failure */

So handle the failure case :)

> +	struct Scsi_Host *shost = info->host;
> +
> +	DEBUG(0, "SYM53C500_release(0x%p)\n", link);
> +
> +	/*
> +	*  Interrupts getting hosed on card removal.  Try
> +	*  the following code, mostly from qlogicfas.c.
> +	*/
> +	if (shost->irq)
> +		free_irq(shost->irq, shost);
> +	if (shost->dma_channel != 0xff)
> +		free_dma(shost->dma_channel);
> +	if (shost->io_port && shost->n_io_port)
> +		release_region(shost->io_port, shost->n_io_port);
> +
> +	scsi_remove_host(shost);

You need to call scsi_remove_host as the first thing in this function.

> +/*
> +*  SYM53C500_proc_info is basically a stub function for now.  It
> +*  wouldn't exist except for the fact there were /proc entries for
> +*  this driver under 2.4 and earlier kernels, and the author (sole
> +*  user?) expects to see them.

Well, please just kill it.  ->proc_info is deprecated in 2.6.

> +int
> +SYM53C500_device_reset(struct scsi_cmnd *SCpnt)
> +{
> +	return FAILED;
> +}
> +
> +int
> +SYM53C500_bus_reset(struct scsi_cmnd *SCpnt)
> +{
> +	return FAILED;
> +}

You don't need to implement these.  If an EH method isn't implemented
FAILED is the default return value.

> +static irqreturn_t
> +do_SYM53C500_intr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +	struct Scsi_Host *dev = dev_id;
> +
> +	spin_lock_irqsave(dev->host_lock, flags);
> +	SYM53C500_intr(irq, dev_id, regs);
> +	spin_unlock_irqrestore(dev->host_lock, flags);
> +	return IRQ_HANDLED;
> +}

You should probably merged SYM53C500_intr with this one.

> +	if (pio_status & 0x80) {
> +		printk("SYM53C500: Warning: PIO error!\n");
> +		current_SC->SCp.phase = idle;
> +		current_SC->result = DID_ERROR << 16;
> +		current_SC->scsi_done(current_SC);
> +		return;
> +	}
> +
> +	if (status & 0x20) {		/* Parity error */
> +		printk("SYM53C500: Warning: parity error!\n");
> +		current_SC->SCp.phase = idle;
> +		current_SC->result = DID_PARITY << 16;
> +		current_SC->scsi_done(current_SC);
> +		return;
> +	}

This screams for a goto error and the error handler in one place :)

> +	/* Control Register Set 0 */
> +	TC_LSB = (port_base + 0x00);
> +	TC_MSB = (port_base + 0x01);
> +	SCSI_FIFO = (port_base + 0x02);

These variables are _really_ strange.  In a normal Linux driver
the names that are variables here (TC_LSB, etc..) would be defines
to the numberical values you add to port_base and when you're actually
using them you'd use shost->io_port + TC_LSB or whatever as the actual
address.

> +static void __exit
> +exit_sym53c500_cs(void)
> +{
> +	pcmcia_unregister_driver(&sym53c500_cs_driver);
> +
> +	/* XXX: this really needs to move into generic code... */
> +	while (dev_list != NULL)
> +		SYM53C500_detach(dev_list);

It's actually superflous for scsi drivers these days.

