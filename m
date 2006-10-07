Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWJGLBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWJGLBb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWJGLBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:01:31 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:30606 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750821AbWJGLBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:01:31 -0400
From: "Andrea Paterniani" <a.paterniani@swapp-eng.it>
To: "David Brownell" <david-b@pacbell.net>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Date: Sat, 7 Oct 2006 13:01:56 +0200
Message-ID: <FLEPLOLKEPNLMHOILNHPAEODCMAA.a.paterniani@swapp-eng.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200610061635.24216.david-b@pacbell.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ...
> > > ug.  Why not simply open-code
> > >
> > > 	readl(addr + DATA);
> >
> > I found usefull to define macros to use inside code something like
> > 	rd_CONTROL(regs)
> > instead of
> > 	readl(regs + 0x08)
> > since to me the macro sounds more friendly.
> > Should I have to adhere to some standard ?
> >
> The standards are more or less to avoid creating namespace clutter,
> and to make explicit where register access happens.  Defining new
> macros violates the former; not being able to tell where the chip
> registers are accessed (because they're wrapped in macros) violates
> the latter.

What you're saying is clear.
But I'm a little bit confused...what about the lot of definitions that use __REG or __REG2 macros to define registers address
(inside imx-regs.h, pxa-regs.h and so on) ?




> > > The use of loops_per_jiffy seems inappropriate.  That's an IO-space read in
> > > there, which is slow.  This timeout will be very long indeed.
> >
> > Please suggest me what it's more appropriate.
>
> Pick a constant, use it.

How should I choose the value of that costant ?
Please suggest me.



- Andrea



-----Messaggio originale-----
Da: David Brownell [mailto:david-b@pacbell.net]
Inviato: sabato 7 ottobre 2006 1.35
A: Andrea Paterniani
Cc: Andrew Morton; Linux Kernel list
Oggetto: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller
driver


On Tuesday 03 October 2006 9:08 am, Andrea Paterniani wrote:
> Here some questions and answers to your comments, (please consider I'm nearly new to kernel programming).
>
>
>
> > ...
> > ug.  Why not simply open-code
> >
> > 	readl(addr + DATA);
>
> I found usefull to define macros to use inside code something like
> 	rd_CONTROL(regs)
> instead of
> 	readl(regs + 0x08)
> since to me the macro sounds more friendly.
> Should I have to adhere to some standard ?

The standards are more or less to avoid creating namespace clutter,
and to make explicit where register access happens.  Defining new
macros violates the former; not being able to tell where the chip
registers are accessed (because they're wrapped in macros) violates
the latter.


> > The use of loops_per_jiffy seems inappropriate.  That's an IO-space read in
> > there, which is slow.  This timeout will be very long indeed.
>
> Please suggest me what it's more appropriate.

Pick a constant, use it.



> > I see tasklets being scheduled, but no tasklet_disable() or tasklet_kill(),
> > etc.  Is this driver racy against shutdown or rmmod?
>
> Do you mean I should use tasklet_kill() inside spi_imx_remove ?

That's how I read it.  :)


> > > +	drv_data->rd_data_phys = (dma_addr_t)res->start;
> >
> > I don't think it's correct to cast a kernel virtual address straight to a
> > dma_addr_t.
>
> File include/asm-arm/types.h defines
> 	typedef u32 dma_addr_t;
> Also I think that for ARM architecture resource_size_t in practice
> is u32 since CONFIG_RESOURCES_64BIT isn't defined.
> Is this construction correct ? If not what should I do ?

I think it's correct; it's certainly standard for converting physical
addresses to DMA addresses.  (Andrew got that one wrong; resource
addresses are physical, not virtual.)

- Dave

