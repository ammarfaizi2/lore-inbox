Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271609AbRHZXBQ>; Sun, 26 Aug 2001 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271573AbRHZXBH>; Sun, 26 Aug 2001 19:01:07 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:52410 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S271612AbRHZXAy>; Sun, 26 Aug 2001 19:00:54 -0400
Date: Mon, 27 Aug 2001 00:58:46 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] yenta resource allocation fix
Message-ID: <20010827005846.B10483@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the problem of the yenta_socket driver not allocating IO port
windows if they weren't already.  This caused no ports to be available
to a inserted CardBus card which in turn made the tulip driver complain
since it can't run without IO ports.

I'm no expert on the PCI/CardBus bridge stuff, but let's see:  The OR
operation on the range end register with 0xfff seems pretty bogus to me.
Also the "if (start && ..." was always true since start included the 32
bit IO flag.  What my patch does is to mask out the IO flags on both
start and end if the resource is indeed an IO resource, which seems
correct to me.

Now everything works for me.  If I had known the fix was so easy I would
never have bothered with pcmcia-cs.  Well, there is a problem that it
only picks up every second card insertion, so I have to
insert/remove/insert for my card to be recognized, but then it works.


diff -ruN linux-2.4.orig/drivers/pcmcia/yenta.c linux-2.4/drivers/pcmcia/yenta.c
--- linux-2.4.orig/drivers/pcmcia/yenta.c	Fri Jul 27 02:21:28 2001
+++ linux-2.4/drivers/pcmcia/yenta.c	Sun Aug 26 23:26:17 2001
@@ -701,8 +701,14 @@
 	struct resource *root, *res;
 	u32 start, end;
 	u32 align, size, min, max;
+	u32 mask;
 	unsigned offset;
 
+	if (type & IORESOURCE_IO)
+		mask = PCI_CB_IO_RANGE_MASK;
+	else
+		mask = ~0U;
+
 	offset = 0x1c + 8*nr;
 	bus = socket->dev->subordinate;
 	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
@@ -715,8 +721,8 @@
 	if (!root)
 		return;
 
-	start = config_readl(socket, offset);
-	end = config_readl(socket, offset+4) | 0xfff;
+	start = config_readl(socket, offset) & mask;
+	end = config_readl(socket, offset+4) & mask;
 	if (start && end > start) {
 		res->start = start;
 		res->end = end;

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
