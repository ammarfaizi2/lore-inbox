Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSLHSg1>; Sun, 8 Dec 2002 13:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLHSg1>; Sun, 8 Dec 2002 13:36:27 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:18445 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261456AbSLHSg0>; Sun, 8 Dec 2002 13:36:26 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Simon Ward <simon.ward@cs.man.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1
References: <Pine.LNX.4.44.0212081222370.22353-100000@tl009.cs.man.ac.uk>
	<1039357173.6912.4.camel@irongate.swansea.linux.org.uk>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 09 Dec 2002 03:43:07 +0900
In-Reply-To: <1039357173.6912.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <87hedo8i84.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2002-12-08 at 12:35, Simon Ward wrote:
> > The problem appears to be after (or while) the IDE interfaces are
> > probed. The IDE chipset is (I think) ALI M1543. It's part of the ALI
> > Aladdin V chipset on an Asus P5A-B motherboard anyway, if that means
> > anything to you.
> 
> Looks like your system returned a totally bogus IRQ for the interface.
> Are you enabling ACPI by any chance ?

I'm sorry, my before info of ACPI was wrong. It's not ACPI problem. It
may be problem of ali15x3.c.

Probably his M5229 has 0xff on INTERRUPT_LINE after boot immediately.

Simon, could you send the outputs of `lspci -vx'? And the following
patch fixs this problem?

 drivers/ide/pci/alim15x3.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.4.20-ac1/drivers/ide/pci/alim15x3.c~alim15x3-fix	2002-12-09 03:34:33.000000000 +0900
+++ linux-2.4.20-ac1-hirofumi/drivers/ide/pci/alim15x3.c	2002-12-09 03:35:02.000000000 +0900
@@ -779,8 +779,9 @@ static void __init init_hwif_common_ali1
 static void __init init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
 	u8 ideic, inmir;
-	u8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
+	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
 				      1, 11, 0, 12, 0, 14, 0, 15 };
+	int irq = 0;
 
 	hwif->irq = hwif->channel ? 15 : 14;
 
@@ -801,15 +802,17 @@ static void __init init_hwif_ali15x3 (id
 			 */
 			pci_read_config_byte(isa_dev, 0x44, &inmir);
 			inmir = inmir & 0x0f;
-			hwif->irq = irq_routing_table[inmir];
+			irq = irq_routing_table[inmir];
 		} else if (hwif->channel && !(ideic & 0x01)) {
 			/*
 			 * get SIRQ2 routing table
 			 */
 			pci_read_config_byte(isa_dev, 0x75, &inmir);
 			inmir = inmir & 0x0f;
-			hwif->irq = irq_routing_table[inmir];
+			irq = irq_routing_table[inmir];
 		}
+		if (irq >= 0)
+			hwif->irq = irq;
 	}
 
 	init_hwif_common_ali15x3(hwif);

_
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
