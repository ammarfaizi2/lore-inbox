Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTEMHjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTEMHjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:39:41 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:10112
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263383AbTEMHjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:39:39 -0400
Date: Tue, 13 May 2003 03:43:07 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
In-Reply-To: <200305122159.18843.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.50.0305130340420.5420-100000@montezuma.mastecende.com>
References: <200305111647.32113.daniel.ritz@gmx.ch>
 <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
 <200305122159.18843.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Daniel Ritz wrote:

> ok, i tried that one, but no luck. still nobody cares. so it's that one:
>   if (int_status == 0xff) { /* card may be ejected */
>         DEBUG(3, "%s: interrupt %d for dead card\n", dev->name, irq);
>         handled = 0;
>         goto leave;
>     }
> 
> but it's not ejected, only a modpobe -r...

We shutdown the device so a lot of things aren't defined at this stage. 
Lets make that handled = 1, we're bound to have 1 or 2 of these interrupts 
creeping in.

Index: linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c,v
retrieving revision 1.19
diff -u -p -B -r1.19 xirc2ps_cs.c
--- linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	8 May 2003 05:16:27 -0000	1.19
+++ linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	13 May 2003 06:50:22 -0000
@@ -1312,7 +1312,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
 				  */
 
     if (!netif_device_present(dev))
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 
     ioaddr = dev->base_addr;
     if (lp->mohawk) { /* must disable the interrupt */
@@ -1330,7 +1330,6 @@ xirc2ps_interrupt(int irq, void *dev_id,
   loop_entry:
     if (int_status == 0xff) { /* card may be ejected */
 	DEBUG(3, "%s: interrupt %d for dead card\n", dev->name, irq);
-	handled = 0;
 	goto leave;
     }
     eth_status = GetByte(XIRCREG_ESR);

-- 
function.linuxpower.ca
