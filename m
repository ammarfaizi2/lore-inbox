Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTEKQJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTEKQJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 12:09:45 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:8323
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261747AbTEKQJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 12:09:43 -0400
Date: Sun, 11 May 2003 12:13:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
In-Reply-To: <200305111647.32113.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
References: <200305111647.32113.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Daniel Ritz wrote:

> hi
> 
> i see that one on shutdown with a xircom ce3 10/100 16bit pcmcia network card,
> driver xirc2ps_cs. the netdevice also never gets free, so the shutdown never
> finishs. 2.5.68 also doesn't work, 2.5.67 does work.

Interesting, eject with one of my PCMCIA (smc91c92) network cards also 
triggers an unhandled interrupt. I think the IRQ_NONE is incorrect here as 
the device really may have an interrupt to service.

Index: linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c,v
retrieving revision 1.19
diff -u -p -B -r1.19 xirc2ps_cs.c
--- linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	8 May 2003 05:16:27 -0000	1.19
+++ linux-2.5-cvs/drivers/net/pcmcia/xirc2ps_cs.c	11 May 2003 15:20:03 -0000
@@ -1312,7 +1312,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
 				  */
 
     if (!netif_device_present(dev))
-	return IRQ_NONE;
+	goto out;
 
     ioaddr = dev->base_addr;
     if (lp->mohawk) { /* must disable the interrupt */
@@ -1515,6 +1515,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
      * force an interrupt with this command:
      *	  PutByte(XIRCREG_CR, EnableIntr|ForceIntr);
      */
+  out:
     return IRQ_RETVAL(handled);
 } /* xirc2ps_interrupt */
 
> unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> unregister_netdevice: waiting for eth0 to become free. Usage count = 2
> unregister_netdevice: waiting for eth0 to become free. Usage count = 2

I can reproduce this, i'll have a look.

-- 
function.linuxpower.ca
