Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130604AbRBBXfh>; Fri, 2 Feb 2001 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130609AbRBBXf1>; Fri, 2 Feb 2001 18:35:27 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:4106 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130604AbRBBXfV>; Fri, 2 Feb 2001 18:35:21 -0500
Date: Fri, 2 Feb 2001 15:35:08 -0800
Message-Id: <200102022335.f12NZ8F11589@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Ivan Passos <lists@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: weird eepro100 msgs
In-Reply-To: <Pine.LNX.4.10.10102021500450.3255-100000@main.cyclades.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001 15:01:05 -0800 (PST), Ivan Passos <lists@cyclades.com> wrote:

> Sometimes when I reboot the system, as soon as the eepro100 module is
> loaded, I start to get these msgs on the screen:
> 
> eth0: card reports no resources.
> eth0: card reports no RX buffers.
> eth0: card reports no resources.
> eth0: card reports no RX buffers.
> eth0: card reports no resources.
> eth0: card reports no RX buffers.
> (...)

Does the following patch, taken from 2.4.1, help?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
------------------------
--- linux-2.2.18/drivers/net/eepro100-old.c	Fri Feb  2 15:30:23 2001
+++ linux-2.2.18/drivers/net/eepro100.c	Fri Feb  2 15:33:19 2001
@@ -751,6 +751,7 @@
 	   This takes less than 10usec and will easily finish before the next
 	   action. */
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -839,6 +840,7 @@
 #endif  /* kernel_bloat */
 
 	outl(PortReset, ioaddr + SCBPort);
+	inl(ioaddr + SCBPort);
 	/* Honor PortReset timing. */
 	udelay(10);
 
@@ -1062,6 +1064,9 @@
 	/* Set the segment registers to '0'. */
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outl(0, ioaddr + SCBPointer);
+	/* impose a delay to avoid a bug */
+	inl(ioaddr + SCBPointer);
+	udelay(10);
 	outb(RxAddrLoad, ioaddr + SCBCmd);
 	wait_for_cmd_done(ioaddr + SCBCmd);
 	outb(CUCmdBase, ioaddr + SCBCmd);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
