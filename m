Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTBWKmV>; Sun, 23 Feb 2003 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbTBWKmV>; Sun, 23 Feb 2003 05:42:21 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:25092 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268001AbTBWKmS>; Sun, 23 Feb 2003 05:42:18 -0500
Date: Sun, 23 Feb 2003 10:52:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI
Message-ID: <20030223105228.A16083@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp> <20030223095528.GQ1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030223095528.GQ1324@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Sun, Feb 23, 2003 at 06:55:28PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int pc98_bios_param(struct block_device *bdev, int *ip)
> +{
> +	/* Note: This function is called from fs/partitions/nec98.c too. */
> +	/* So we creat 'sdp' from 'bdev' here.				 */
> +	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);

this is still not good - you shouldn't expose struct scsi_disk outside
sd.c.  Please change the pc98_bios_param() prototype to that of the
bios_param entry point (direct passing of capacity).

Can you explain what this first_real_host() stuff is for - we need some
way to handle this better.

> +static int io = 0;

no need to initialize to zero - it's in .bss and thus cleared implicitly.

> +inline void pc980155_dma_enable(unsigned int base_io)
> +{
> +	outb(0x01, REG_CWRITE);
> +	WAIT();
> +}
> +
> +inline void pc980155_dma_disable(unsigned int base_io)
> +{
> +	outb(0x02, REG_CWRITE);
> +	WAIT();
> +}

shouldn't these be static?

> +	err2:
> +	free_irq(irq, NULL);
> +	err1:
> +	release_region(base_io, 6);
> +	return 0;

small codingstyle nitpick:  this should be either

err2:
	free_irq(irq, NULL);
err1:
	release_region(base_io, 6);
	return 0;

or:

 err2:
	free_irq(irq, NULL);
 err1:
	release_region(base_io, 6);
	return 0;


> +Scsi_Host_Template driver_template = {

static?

> +#ifndef _SCSI_PC9801_55_H
> +#define _SCSI_PC9801_55_H
> +
> +#include <linux/types.h>
> +#include <linux/kdev_t.h>
> +#include <scsi/scsicam.h>
> +
> +int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
> +int wd33c93_abort(Scsi_Cmnd *);
> +int wd33c93_reset(Scsi_Cmnd *, unsigned int);
> +int scsi_pc980155_detect(Scsi_Host_Template *);
> +int scsi_pc980155_release(struct Scsi_Host *);
> +int pc980155_proc_info(char *, char **, off_t, int, int, int);
> +
> +#ifndef CMD_PER_LUN
> +#define CMD_PER_LUN 2
> +#endif
> +
> +#ifndef CAN_QUEUE
> +#define CAN_QUEUE 16
> +#endif
> +
> +#endif /* _SCSI_PC9801_55_H */

Move that all into the actual c source file.  In addition all those
functions can be static.

> +	BIOS_PARAM_OVERRIDE(sdp, bdev, sdkp->capacity, diskinfo);
> +

the way this is done is ugly.  I'm still not sure how this is done
best.  When do you need the pc98 geometry exactly?  i.e. can it happen
with one of the existing linux scsi drivers?

> +#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
> +#include "pc980155regs.h"
> +#else /* !CONFIG_SCSI_PC980155 */
>  
>  static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
>  {
> @@ -203,6 +206,7 @@
>     *regs.SCMD = cmd;
>     mb();
>  }
> +#endif /* CONFIG_SCSI_PC980155 */

The wd33c93 changes are ugly as hell, but that's not your fault.  I'll
try to rework it to abstract out the different implementations better.
Could you perform some testing for me if I send you updated versions?

