Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262014AbSIPMNM>; Mon, 16 Sep 2002 08:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbSIPMNM>; Mon, 16 Sep 2002 08:13:12 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52496 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262014AbSIPMNL>; Mon, 16 Sep 2002 08:13:11 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209161218.g8GCI7301692@devserv.devel.redhat.com>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 16 Sep 2002 08:18:07 -0400 (EDT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020916120022.AD2EA2C06F@lists.samba.org> from "Rusty Russell" at Sep 16, 2002 09:52:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Pause (at least 400ns) in case we just issued a command */
> +	oopser_usec(1);
> +	for (i = 0; i < 1000; i++) {
> +		b = inb(HD_STATUS);
> +		if (!(b & BUSY_STAT)) {
> +			if (b & ERR_STAT) return 0;
> +			if (b & flag) return 1;
> +		}
> +		oopser_usec(1000);

This will stop working on SATA when VDMA goes into newer controllers btw.

> +	/* Bits 24-27, 0x40=LBA, 0x10=slave */
> +	if (!wait_before_command()) return -EIO;
> +	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);

Doesn't work for LBA48

> +	if (!wait_before_command()) return -EIO;
> +	outb(0x40 | (master ? 0 : 0x10) | ((lba >> 24) & 0x0F), HD_CURRENT);

Ditto

> +/* Called with interrupts off */
> +int oopser_read_ide(char dump[512], unsigned int block)
> +{
> +	/* Wait for non-busy: if not, reset anyway */
> +	wait_before_command();
> +	/* Soft reset of drive (set nIEN as well) */
> +	outb(0x0e, HD_CMD);

Be careful here - one or two drives get nIEN backwards, you might just
want to turn off interrupts and be done with it

> +	oopser_usec(1); /* 400ns according to spec */
> +	outb(0x0a, HD_CMD);

You really need to reset and reprogram/retune the controller as well.

I like the infrastructure but the IDE dumper code is wishful thinking
in one or two spots. You don't know f the controller is in DMA modes,
tuned for different things to the drives or legacy free. Im not sure what
to do for legacy free cases but the other bits like LBA48 and retuning
probably can be handled with some small chipset specific hooks

Alan
