Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbTA1RpV>; Tue, 28 Jan 2003 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTA1RpU>; Tue, 28 Jan 2003 12:45:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29313
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267626AbTA1RpP>; Tue, 28 Jan 2003 12:45:15 -0500
Subject: Re: OOPS in read_cd... what to do?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Henriksson <andreas@fjortis.info>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128125119.GA31590@foo>
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu>
	 <3E355D1F.1080007@didntduck.org>  <20030128125119.GA31590@foo>
Content-Type: multipart/mixed; boundary="=-FlkPV5FgQMbwaznC71yl"
Organization: 
Message-Id: <1043779710.24849.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 18:48:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FlkPV5FgQMbwaznC71yl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> 1. load module.
> 	#modprobe e2100
> 	e2100.c: Presently autoprobing (not recommended) for a single card.
> 	e2100.c:v1.01 7/21/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
> 	 00 00 1D 0A 72 AB, IRQ 15, secandary media, memory @ 0xd0000
> (I can supply io=0x380 to get rid of the warning message, but there will
> be no real difference. I'm not really sure this is the correct value,
> but last time I tried this I did look at the jumpers and used the right
> value, thats when I noticed the oops. A weird thing btw. It didn't
> happen when there also was a ne2000-compatible isa-card used at the same
> time, then it just refused to send any traffic.)
> 
> 2. configure and up the interface, then send traffic using the
> interface.
> (ping some.remote.ip ... pinging myself works fine, but I guess it's
> because the driver isn't involved there)

Try this



--=-FlkPV5FgQMbwaznC71yl
Content-Disposition: inline; filename=a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=a1; charset=UTF-8

--- drivers/net/e2100.c~	2003-01-28 18:38:21.000000000 +0000
+++ drivers/net/e2100.c	2003-01-28 18:38:21.000000000 +0000
@@ -77,7 +77,7 @@
 {
 	/* This is a little weird: set the shared memory window by doing a
 	   read.  The low address bits specify the starting page. */
-	readb(mem_base+start_page);
+	isa_readb(mem_base+start_page);
 	inb(port + E21_MEM_ENABLE);
 	outb(E21_MEM_ON, port + E21_MEM_ENABLE + E21_MEM_ON);
 }
@@ -306,9 +306,9 @@
=20
 #ifdef notdef
 	/* Officially this is what we are doing, but the readl() is faster */
-	memcpy_fromio(hdr, shared_mem, sizeof(struct e8390_pkt_hdr));
+	isa_memcpy_fromio(hdr, shared_mem, sizeof(struct e8390_pkt_hdr));
 #else
-	((unsigned int*)hdr)[0] =3D readl(shared_mem);
+	((unsigned int*)hdr)[0] =3D isa_readl(shared_mem);
 #endif
=20
 	/* Turn off memory access: we would need to reprogram the window anyway. =
*/
@@ -328,7 +328,7 @@
 	mem_on(ioaddr, shared_mem, (ring_offset>>8));
=20
 	/* Packet is always in one chunk -- we can copy + cksum. */
-	eth_io_copy_and_sum(skb, dev->mem_start + (ring_offset & 0xff), count, 0)=
;
+	isa_eth_io_copy_and_sum(skb, dev->mem_start + (ring_offset & 0xff), count=
, 0);
=20
 	mem_off(ioaddr);
 }
@@ -342,10 +342,10 @@
=20
 	/* Set the shared memory window start by doing a read, with the low addre=
ss
 	   bits specifying the starting page. */
-	readb(shared_mem + start_page);
+	isa_readb(shared_mem + start_page);
 	mem_on(ioaddr, shared_mem, start_page);
=20
-	memcpy_toio(shared_mem, buf, count);
+	isa_memcpy_toio(shared_mem, buf, count);
 	mem_off(ioaddr);
 }
=20

--=-FlkPV5FgQMbwaznC71yl--
