Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbTCPRgh>; Sun, 16 Mar 2003 12:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbTCPRgh>; Sun, 16 Mar 2003 12:36:37 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:34052 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262713AbTCPRge>; Sun, 16 Mar 2003 12:36:34 -0500
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
From: James Bottomley <James.Bottomley@steeleye.com>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20030316011550.GK1592@yuzuki.cinet.co.jp>
References: <20030316001622.GA1061@yuzuki.cinet.co.jp> 
	<20030316011550.GK1592@yuzuki.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Mar 2003 11:47:16 -0600
Message-Id: <1047836839.9267.29.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 19:15, Osamu Tomita wrote:
> This is the patch to support NEC PC-9800 subarchitecture
> against 2.5.64-ac4. (11/11)
> 
> SCSI host adapter support.
>  - BIOS parameter change for PC98.
>  - Add pc980155 driver for old PC98.
>  - wd33c93.c update error handler for eh_*.
>  - wd33c93.h register to int for PIO mode.

I suppose the first thing to point out is that it would be helpful if
you could send this to linux-scsi@vger.kernel.org.  Although most SCSI
people also read linux-kernel, it is easy to lose things in the noise.

> diff -Nru linux/drivers/scsi/sd.c linux98/drivers/scsi/sd.c
> --- linux/drivers/scsi/sd.c	2003-03-05 12:29:32.000000000 +0900
> +++ linux98/drivers/scsi/sd.c	2003-03-08 11:13:28.000000000 +0900
> @@ -485,6 +485,15 @@
>  	else
>  		scsicam_bios_param(bdev, sdkp->capacity, diskinfo);
>  
> +#ifdef CONFIG_X86_PC9800
> +	{
> +		extern int pc98_bios_param(struct scsi_device *,
> +					   struct block_device *,
> +					   sector_t, int *);
> +		pc98_bios_param(sdp, bdev, sdkp->capacity, diskinfo);
> +	}
> +#endif
> +
>  	if (put_user(diskinfo[0], &loc->heads))
>  		return -EFAULT;
>  	if (put_user(diskinfo[1], &loc->sectors))

You already have the pc98_bios_param as part of your local driver.  Why
do you need this in addition?

[...]
>  static inline uchar
>  read_aux_stat(const wd33c93_regs regs)
>  {
> -	return inb(*regs.SASR);
> +	return inb(regs.SASR);
>  }
>  
>  static inline void
>  write_wd33c93(const wd33c93_regs regs, uchar reg_num, uchar value)
>  {
> -      outb(reg_num, *regs.SASR);
> -      outb(value, *regs.SCMD);
> +      outb(reg_num, regs.SASR);
> +      outb(value, regs.SCMD);
>  }
>  
[...]
>     /* This is what the 3393 chip looks like to us */
>  typedef struct {
> +#ifdef CONFIG_WD33C93_PIO
> +   unsigned int   SASR;
> +   unsigned int   SCMD;
> +#else
>     volatile unsigned char  *SASR;
>     volatile unsigned char  *SCMD;
> +#endif
>  } wd33c93_regs;
>  

This really doesn't look right.  For non PIO (which is all drivers apart
from yours), they expect to dereference SASR to get the port number (as
an unsigned char).  If you remove the dereference, don't they all break?

Perhaps the better thing to do is to make your driver use an unsigned
int *, so the dereference works in all cases.

James

