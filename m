Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRK3UzY>; Fri, 30 Nov 2001 15:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283737AbRK3UzQ>; Fri, 30 Nov 2001 15:55:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:14531 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281027AbRK3UzK>;
	Fri, 30 Nov 2001 15:55:10 -0500
Date: Fri, 30 Nov 2001 12:55:04 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir245_vlsi_mir.diff
Message-ID: <20011130125504.B3938@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir245_vlsi_mir.diff :
-------------------
        <Patch from Martin Diehl>
	o [CORRECT] When MIR is requested, enable MIR on the chip, not FIR

diff -u -p linux/drivers/net/irda/vlsi_ir.d3.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.d3.c	Wed Nov 28 10:13:52 2001
+++ linux/drivers/net/irda/vlsi_ir.c	Wed Nov 28 10:14:03 2001
@@ -2,7 +2,7 @@
  *
  *	vlsi_ir.c:	VLSI82C147 PCI IrDA controller driver for Linux
  *
- *	Version:	0.3, Sep 30, 2001
+ *	Version:	0.3a, Nov 10, 2001
  *
  *	Copyright (c) 2001 Martin Diehl
  *
@@ -490,7 +490,7 @@ static int vlsi_set_baud(struct net_devi
 	if (mode == IFF_FIR)
 		config ^= IRENABLE_FIR_ON;
 	else if (mode == IFF_MIR)
-		config ^= (IRENABLE_FIR_ON|IRENABLE_CRC16_ON);
+		config ^= (IRENABLE_MIR_ON|IRENABLE_CRC16_ON);
 	else
 		config ^= IRENABLE_SIR_ON;
 
@@ -877,6 +877,7 @@ static int vlsi_open(struct net_device *
 	idev->irlap = irlap_open(ndev,&idev->qos,hwname);
 
 	netif_start_queue(ndev);
+	outw(0, ndev->base_addr+VLSI_PIO_PROMPT);	/* kick hw state machine */
 
 	printk(KERN_INFO "%s: device %s operational using (%d,%d) tx,rx-ring\n",
 		__FUNCTION__, ndev->name, ringsize[0], ringsize[1]);
@@ -1200,7 +1201,6 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 	int			alloc_size;
 
 
-	vlsi_reg_debug(0x3000, "vlsi initial state");
 	if (pci_enable_device(pdev))
 		goto out;
 
