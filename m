Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263154AbTCLLio>; Wed, 12 Mar 2003 06:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbTCLLio>; Wed, 12 Mar 2003 06:38:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:41404 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263154AbTCLLim>;
	Wed, 12 Mar 2003 06:38:42 -0500
Date: Wed, 12 Mar 2003 12:49:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Osamu Tomita <tomita@cinet.co.jp>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (16/20) SCSI
In-Reply-To: <20030309043403.GQ1231@yuzuki.cinet.co.jp>
Message-ID: <Pine.GSO.4.21.0303121239380.7675-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Osamu Tomita wrote:
> This is the patch to support NEC PC-9800 subarchitecture
> against 2.5.64-ac3. (16/20)
> 
> SCSI host adapter support.
>  - BIOS parameter change for PC98.
>  - Add pc980155 driver for old PC98.
>  - wd33c93.h register address size to int, because PC-9801-55 mapped 0xcc0.
> 
> Regards,
> Osamu Tomita
> 
> diff -Nru linux/drivers/scsi/wd33c93.h linux98/drivers/scsi/wd33c93.h
> --- linux/drivers/scsi/wd33c93.h	2002-10-12 13:21:35.000000000 +0900
> +++ linux98/drivers/scsi/wd33c93.h	2002-10-12 14:18:53.000000000 +0900
> @@ -186,8 +186,13 @@
>  
>     /* This is what the 3393 chip looks like to us */
>  typedef struct {
> +#if defined(CONFIG_SCSI_PC980155) || defined(CONFIG_SCSI_PC980155_MODULE)
> +   volatile unsigned int   *SASR;
> +   volatile unsigned int   *SCMD;

Since you want to do ordinary ISA/PCI I/O on SASR and SCMD, I think you want to
get rid of the pointers and put the plain I/O port numbers there:

    unsigned long SASR;
    unsigned long SCMD;

> +#else
>     volatile unsigned char  *SASR;
>     volatile unsigned char  *SCMD;
> +#endif

M68k and MIPS use pointers because they do MMIO.

Then the following can go away:

> +static unsigned int  SASR;
> +static unsigned int  SCMD;
> +static wd33c93_regs regs = {&SASR, &SCMD};

And you store the I/O ports here:

    static wd33c93_regs regs;

> +	for (i = 0; i < nr_base_ios; i++) {
> +		base_io = base_ios[i];
> +		SASR = REG_ADDRST;
> +		SCMD = REG_CONTRL;

      regs.SASR = REG_ADDRST;
      regs.SCMD = REG_CONTRL;

> +static int pc980155_abort(Scsi_Cmnd *cmd)
> +{
> +	if (wd33c93_abort(cmd) == SCSI_ABORT_SUCCESS)
> +		return SUCCESS;
> +
> +	return FAILED;
> +}

The abort handler is generic. Hence it can be moved to wd33c93.c, so the other
wd33c93 drivers (my main interest :-) can use it.

> +static int pc980155_bus_reset(Scsi_Cmnd *cmd)
> +{
> +	struct WD33C93_hostdata *hostdata
> +		= (struct WD33C93_hostdata *)cmd->device->host->hostdata;
> +
> +	pc980155_int_disable(hostdata->regs);
> +	pc980155_assert_bus_reset(hostdata->regs);
> +	udelay(50);
> +	pc980155_negate_bus_reset(hostdata->regs);
> +	(void) inb(*hostdata->regs.SASR);
> +	(void) read_pc980155(hostdata->regs, WD_SCSI_STATUS);
> +	pc980155_int_enable(hostdata->regs);
> +	wd33c93_reset(cmd, 0);
> +	return SUCCESS;
> +}

Is there a generic (wd33c93) way to do this?

> +static int pc980155_host_reset(Scsi_Cmnd *cmd)
> +{
> +	wd33c93_reset(cmd, 0);
> +	return SUCCESS;
> +}

The host reset handler is generic, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

