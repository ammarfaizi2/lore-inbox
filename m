Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132432AbQKDGPe>; Sat, 4 Nov 2000 01:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132459AbQKDGPY>; Sat, 4 Nov 2000 01:15:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53514 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132432AbQKDGPS>;
	Sat, 4 Nov 2000 01:15:18 -0500
Message-ID: <3A03A915.DA71BEAC@mandrakesoft.com>
Date: Sat, 04 Nov 2000 01:13:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Håvard Garnes <hhg@iname.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Oops when loading 3c509-module in test10
In-Reply-To: <3A01BF94.B139AA34@iname.com>
Content-Type: multipart/mixed;
 boundary="------------9F953E6509A060278DB5EF55"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F953E6509A060278DB5EF55
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Håvard Garnes wrote:
> 
> This occurs when the 3c509-module is being loaded at startup, and in
> /proc/modules it is listed as (initialising). It it worth mentioning
> that I have two 3c509-cards in my computer. This worked in test8.

Oops.  This is one of the newer (and better) ISA modules, which actually
does allocate its device structure correctly.

Please apply this patch...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
--------------9F953E6509A060278DB5EF55
Content-Type: text/plain; charset=us-ascii;
 name="3c509.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c509.patch"

Index: linux_2_4/drivers/net/3c509.c
diff -u linux_2_4/drivers/net/3c509.c:1.1.1.5 linux_2_4/drivers/net/3c509.c:1.1.1.3
--- linux_2_4/drivers/net/3c509.c:1.1.1.5	Tue Oct 31 13:21:47 2000
+++ linux_2_4/drivers/net/3c509.c	Sun Oct 22 13:29:58 2000
@@ -434,6 +436,13 @@
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
  found:
+	if (dev == NULL) {
+		dev = init_etherdev(dev, sizeof(struct el3_private));
+		if (dev == NULL) {
+			release_region(ioaddr, EL3_IO_EXTENT);
+			return -ENOMEM;
+		}
+	}
 	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
 	dev->base_addr = ioaddr;
 	dev->irq = irq;

--------------9F953E6509A060278DB5EF55--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
