Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSH0T3w>; Tue, 27 Aug 2002 15:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSH0T3w>; Tue, 27 Aug 2002 15:29:52 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:29422 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S314278AbSH0T3u>; Tue, 27 Aug 2002 15:29:50 -0400
Date: Tue, 27 Aug 2002 12:34:01 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, dhinds@zen.stanford.edu
Subject: Re: [Fwd: [PATCH] reduce size of bridge regions for yenta.c]
Message-ID: <20020827123401.A28519@lucon.org>
References: <3D6874A0.5B110F6@zip.com.au> <20020825075729.A14924@lucon.org> <3D6907BA.5020603@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6907BA.5020603@colorfullife.com>; from manfred@colorfullife.com on Sun, Aug 25, 2002 at 06:37:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 25, 2002 at 06:37:14PM +0200, Manfred Spraul wrote:
> 
> yenta.c doesn't contain error handling, and that should be fixed.
> 

This is what I have been using.


H.J.

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-yenta-resource.patch"

--- linux/drivers/pcmcia/yenta.c.resource	Sat Aug 10 20:30:35 2002
+++ linux/drivers/pcmcia/yenta.c	Fri Aug 16 09:34:32 2002
@@ -739,17 +739,27 @@ static void yenta_allocate_res(pci_socke
 		return;
 	}
 
-	align = size = 4*1024*1024;
-	min = PCIBIOS_MIN_MEM; max = ~0U;
 	if (type & IORESOURCE_IO) {
 		align = 1024;
 		size = 256;
 		min = 0x4000;
 		max = 0xffff;
 	}
+	else {
+		align = size = 4*1024*1024;
+		min = PCIBIOS_MIN_MEM;
+		max = ~0U;
+	}
 		
-	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0)
+
+	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0) {
+		printk (KERN_NOTICE "PCI: CardBus bridge (%04x:%04x, %04x:%04x): Failed to allocate %s resource: %d bytes!\n",
+			socket->dev->vendor, socket->dev->device,
+			socket->dev->subsystem_vendor,
+			socket->dev->subsystem_device,
+			(type & IORESOURCE_IO) ? "I/O" : "memory", size);
 		return;
+	}
 
 	config_writel(socket, offset, res->start);
 	config_writel(socket, offset+4, res->end);

--cWoXeonUoKmBZSoM--
