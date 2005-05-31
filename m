Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEaVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEaVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVEaVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:03:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:7056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261482AbVEaVC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:02:56 -0400
Date: Tue, 31 May 2005 14:01:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: Re: [PATCH 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform
Message-Id: <20050531140151.791007b3.akpm@osdl.org>
In-Reply-To: <20050531.214805.783383719.takata.hirokazu@renesas.com>
References: <20050531.214805.783383719.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
> This patchset is for supporting a new m32r platform,
> M3A-2170(Mappi-III) evaluation board.
> An M32R chip multiprocessor is equipped on the board.
> http://http://www.linux-m32r.org/eng/platform/platform.html
> 
> ...
>  static void putc(char c)
>  {
> -
>  	while ((*BOOT_SIO0STS & 0x3) != 0x3) ;

cpu_relax()?

>  static void putc(char c)
>  {
> -
>  	while ((*SIO0STS & 0x1) == 0) ;

cpu_relax()?

> +unsigned char _inb(unsigned long port)
> +{
> +	if (port >= LAN_IOSTART && port < LAN_IOEND)
> +		return _ne_inb(PORT2ADDR_NE(port));
> +#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
> +	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
> +		return *(volatile unsigned char *)__port2addr_ata(port);
> +	}
> +#endif
> +#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
> +	else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
> +		unsigned char b;
> +		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
> +		return b;
> +	} else
> +#endif
> +	return *(volatile unsigned char *)PORT2ADDR(port);
> +}

This file contains some very strange stuff.

> +unsigned char _inb_p(unsigned long port)
> +{
> +	unsigned char  v;
> +
> +	if (port >= LAN_IOSTART && port < LAN_IOEND)
> +		v = _ne_inb(PORT2ADDR_NE(port));
> +	else
> +#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
> +	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
> +		return *(volatile unsigned char *)__port2addr_ata(port);
> +	} else
> +#endif
> +#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_CFC)
> +	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
> +		unsigned char b;
> +		pcc_ioread_byte(0, port, &b, sizeof(b), 1, 0);
> +		return b;
> +	} else
> +#endif
> +		v = *(volatile unsigned char *)PORT2ADDR(port);
> +
> +	delay();
> +	return (v);
> +}

Wouldn't it make things more maintainable if (for example) _inb_p() called
_inb() rather than duplicating it?

> @@ -0,0 +1,208 @@
> +/*
> + *  linux/arch/m32r/kernel/setup_mappi3.c
> + *
> + *  Setup routines for Renesas MAPPI-III(M3A-2170) Board
> + *
> + *  Copyright (c) 2001-2005   Hiroyuki Kondo, Hirokazu Takata,
> + *                            Hitoshi Yamamoto, Mamoru Sakugawa
> + */
> +
> ...
> +static struct hw_interrupt_type mappi3_irq_type =
> +{
> +	"MAPPI3-IRQ",
> +	startup_mappi3_irq,
> +	shutdown_mappi3_irq,
> +	enable_mappi3_irq,
> +	disable_mappi3_irq,
> +	mask_and_ack_mappi3,
> +	end_mappi3_irq
> +};

Would be nicer to use

	.name = value,


All of this code will fail to work if (for example) PCMCIA or IDE are
selected for modular build.
