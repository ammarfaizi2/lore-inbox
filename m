Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTBRKo5>; Tue, 18 Feb 2003 05:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBRKo5>; Tue, 18 Feb 2003 05:44:57 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:9995 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267289AbTBRKoz>; Tue, 18 Feb 2003 05:44:55 -0500
Date: Tue, 18 Feb 2003 10:54:55 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (23/26) SCSI
Message-ID: <20030218105455.D11969@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217142123.GW4799@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030217142123.GW4799@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Mon, Feb 17, 2003 at 11:21:23PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 11:21:23PM +0900, Osamu Tomita wrote:
> diff -Nru linux/drivers/scsi/pc980155.c linux98/drivers/scsi/pc980155.c
> --- linux/drivers/scsi/pc980155.c	1970-01-01 09:00:00.000000000 +0900
> +++ linux98/drivers/scsi/pc980155.c	2003-02-17 21:05:25.000000000 +0900
> @@ -0,0 +1,264 @@
> +#include <linux/kernel.h>
> +#include <linux/types.h>

no copyright statement?

> +#include <linux/mm.h>
> +#include <linux/blk.h>
> +#include <linux/sched.h>
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/irq.h>
> +#include <asm/dma.h>
> +#include <linux/module.h>
> +
> +#include "scsi.h"
> +#include "hosts.h"
> +#include "wd33c93.h"
> +#include "pc980155.h"
> +#include "pc980155regs.h"
> +
> +#define DEBUG
> +
> +#include<linux/stat.h>

I doj't think you need this.

> +
> +static inline void __print_debug_info(unsigned int);
> +static inline void __print_debug_info(unsigned int a){}
> +#define print_debug_info() __print_debug_info(base_io);

Please remove unused declarations.

> +
> +#define NR_BASE_IOS 4
> +static int nr_base_ios = NR_BASE_IOS;
> +static unsigned int base_ios[NR_BASE_IOS] = {0xcc0, 0xcd0, 0xce0, 0xcf0};
> +static unsigned int  SASR;
> +static unsigned int  SCMD;
> +static wd33c93_regs regs = {&SASR, &SCMD};
> +
> +static struct Scsi_Host *pc980155_host = NULL;

> +static void pc980155_intr_handle(int irq, void *dev_id, struct pt_regs *regp);
> +
> +inline void pc980155_dma_enable(unsigned int base_io){
> +  outb(0x01, REG_CWRITE);
> +  WAIT();
> +}
> +inline void pc980155_dma_disable(unsigned int base_io){
> +  outb(0x02, REG_CWRITE);
> +  WAIT();
> +}

This whole file wants to be reformatted to follow Documentation/CodingStyle.

> +			continue;
> +		}
> +		if (request_dma(dma, "PC-9801-55")) {
> +			printk(KERN_ERR "PC-9801-55: "
> +				"unable to allocate DMA channel %d\n", dma);
> +			free_irq(irq, NULL);
> +			continue;
> +		}

You seems to sometimes miss some cleanup on failures.  cleanups gotos might
help :)

> +
> +		pc980155_host = scsi_register(tpnt, sizeof(struct WD33C93_hostdata));

This can return NULL and you need to handle that.

> +int pc980155_proc_info(char *buf, char **start, off_t off, int len,
> +			int hostno, int in)
> +{
> +	/* NOT SUPPORTED YET! */
> +
> +	if (in) {
> +		return -EPERM;
> +	}
> +	*start = buf;
> +	return sprintf(buf, "Sorry, not supported yet.\n");
> +}

So if it's not supported don't implement this entry point :)

> +
> +int pc980155_setup(char *str)
> +{
> +next:
> +  if (!strncmp(str, "io:", 3)){
> +    base_ios[0] = simple_strtoul(str+3,NULL,0);
> +    nr_base_ios = 1;
> +    while (*str > ' ' && *str != ',')
> +      str++;
> +    if (*str == ','){
> +      str++;
> +      goto next;
> +    }
> +  }
> +  return 0;

This might be easier to read when rewritten into a while loop..

> +}
> +
> +int scsi_pc980155_release(struct Scsi_Host *pc980155_host)
> +{
> +#ifdef MODULE
> +        pc980155_int_disable(regs);
> +        release_region(pc980155_host->io_port, pc980155_host->n_io_port);
> +        free_irq(pc980155_host->irq, NULL);
> +        free_dma(pc980155_host->dma_channel);
> +        wd33c93_release();
> +#endif

no need for the ifdef module here.

> +    return 1;
> +}
> +
> +__setup("pc980155=", pc980155_setup);
> +
> +Scsi_Host_Template driver_template = SCSI_PC980155;

Please don't use the  SCSI_PC980155 macro - declare the struct members here
directly.

> +int pc98_bios_param(struct block_device *bdev, int *ip)

This should _not_ be in sd.c but the lowlevel driver.

> +static spinlock_t wd_lock = SPIN_LOCK_UNLOCKED;

Where is this used?

