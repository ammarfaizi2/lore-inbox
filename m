Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTA2ECX>; Tue, 28 Jan 2003 23:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTA2ECX>; Tue, 28 Jan 2003 23:02:23 -0500
Received: from arnold.dormnet.his.se ([193.10.185.236]:9998 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP
	id <S262780AbTA2ECW>; Tue, 28 Jan 2003 23:02:22 -0500
Date: Wed, 29 Jan 2003 05:07:56 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: linux-kernel@vger.kernel.org
Subject: Cabletron E2100 (e2100.c) Oops...
Message-ID: <20030129040756.GA5372@foo>
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu> <3E355D1F.1080007@didntduck.org> <20030128125119.GA31590@foo> <1043779710.24849.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1043779710.24849.8.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 06:48:31PM +0000, Alan Cox wrote:
> 
> Try this

[patch removed]

(Ignore my last posting, brain obviously stopped working)

It worked (almost)... I had to slap a couple of int-casts on the changes
to get it to compile. No more Oops.

One problem still remains... I still can't send any traffic. :-/
"NETDEV WATCH DOG: eth2: transmit timed out"

Half way there I guess....

Here is a diff with the int-casts. Tested, doesn't oops, but doesn't
make the driver work properly eighter.

Regards,
Andreas Henriksson

--- drivers/net/e2100.c.org	Tue Jan 28 22:04:47 2003
+++ drivers/net/e2100.c	Wed Jan 29 04:31:26 2003
@@ -77,7 +77,7 @@
 {
 	/* This is a little weird: set the shared memory window by doing a
 	   read.  The low address bits specify the starting page. */
-	readb(mem_base+start_page);
+	isa_readb((int)(mem_base+start_page));
 	inb(port + E21_MEM_ENABLE);
 	outb(E21_MEM_ON, port + E21_MEM_ENABLE + E21_MEM_ON);
 }
@@ -306,9 +306,9 @@
 
 #ifdef notdef
 	/* Officially this is what we are doing, but the readl() is faster */
-	memcpy_fromio(hdr, shared_mem, sizeof(struct e8390_pkt_hdr));
+	isa_memcpy_fromio(hdr, (int)shared_mem, sizeof(struct e8390_pkt_hdr));
 #else
-	((unsigned int*)hdr)[0] = readl(shared_mem);
+	((unsigned int*)hdr)[0] = isa_readl((int)shared_mem);
 #endif
 
 	/* Turn off memory access: we would need to reprogram the window anyway. */
@@ -328,7 +328,7 @@
 	mem_on(ioaddr, shared_mem, (ring_offset>>8));
 
 	/* Packet is always in one chunk -- we can copy + cksum. */
-	eth_io_copy_and_sum(skb, dev->mem_start + (ring_offset & 0xff), count, 0);
+	isa_eth_io_copy_and_sum(skb, dev->mem_start + (ring_offset & 0xff), count, 0);
 
 	mem_off(ioaddr);
 }
@@ -342,10 +342,10 @@
 
 	/* Set the shared memory window start by doing a read, with the low address
 	   bits specifying the starting page. */
-	readb(shared_mem + start_page);
+	isa_readb((int)(shared_mem + start_page));
 	mem_on(ioaddr, shared_mem, start_page);
 
-	memcpy_toio(shared_mem, buf, count);
+	isa_memcpy_toio((int)shared_mem, buf, count);
 	mem_off(ioaddr);
 }
 
