Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266168AbRGESQ5>; Thu, 5 Jul 2001 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266179AbRGESQs>; Thu, 5 Jul 2001 14:16:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38155 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266168AbRGESQj>; Thu, 5 Jul 2001 14:16:39 -0400
Subject: Re: [PATCH] RE: 2.4.5-ac14 through to 2.4.6-ac1 fdomain.c initialisation for shared IRQ
To: grant@aerodeck.prestel.co.uk
Date: Thu, 5 Jul 2001 19:16:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000201c1057b$f8ff4600$0101a8c0@heron1> from "Grant Fribbens" at Jul 05, 2001 06:57:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IDfu-00034t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have recently had a problem with the fdomain driver initialisation and
> have found the problem to be the way in which it requests the irq. Here is
> my patch that has so far work ok.

I've seen this patch before. It needs at least one change

> -			     do_fdomain_16x0_intr, 0, "fdomain", NULL);
> +      retcode = request_irq( shpnt->irq,
> +			     do_fdomain_16x0_intr, SA_SHIRQ, "fdomain", shpnt);

Only set SA_SHIRQ if PCI - say -

		pdev?SA_SHIRQ:0

The other problem is that the code doesnt have support for handling IRQ
source checking, so if the line it shares with generates interrupts we might
sometimes do the right thing

I have a long outstanding request with adaptec (who bought future domain)
for the info needed to fix this, but obviously its a dead product, from a
bought company and hardly on their priorities.

I suspect the IRQ handler needs to either

A.	Check bit 0 of the status port and return 

B.	Check bit 4 or bit 9 of the interrupt control register

Without docs someone would need to play with the various combinations and
see what happened

