Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCKTV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCKTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCKTUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:20:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261434AbVCKTQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:16:11 -0500
Subject: Re: User mode drivers: part 1, interrupt handling (patch for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110568448.15927.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Mar 2005 19:14:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-11 at 03:36, Peter Chubb wrote:
> +static irqreturn_t irq_proc_irq_handler(int irq, void *vidp, struct pt_regs *regs)
> +{
> + 	struct irq_proc *idp = (struct irq_proc *)vidp;
> + 
> + 	BUG_ON(idp->irq != irq);
> + 	disable_irq_nosync(irq);
> + 	atomic_inc(&idp->count);
> + 	wake_up(&idp->q);
> + 	return IRQ_HANDLED;

You just deadlocked the machine in many configurations. You can't use
disable_irq for this trick you have to tell the kernel how to handle it.
I posted a proposal for this sometime ago because X has some uses for
it. The idea being you'd pass a struct that describes

1.	What tells you an IRQ occurred on this device
2.	How to clear it
3.	How to enable/disable it.

Something like

	struct {
		u8 type;		/* 8, 16, 32  I/O or MMIO */
		u8 bar;			/* PCI bar to use */
		u32 offset;		/* Into bar */
		u32 mask;		/* Bits to touch/compare */
		u32 value;		/* Value to check against/set */
	}


