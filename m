Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280975AbSAXIiE>; Thu, 24 Jan 2002 03:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbSAXIhy>; Thu, 24 Jan 2002 03:37:54 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:41858 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S280975AbSAXIhq>; Thu, 24 Jan 2002 03:37:46 -0500
Message-ID: <005201c1a4b2$8667fb60$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Justin A" <justin@bouncybouncy.net>, "Andrew Morton" <akpm@zip.com.au>
Cc: "Urban Widmark" <urban@teststation.com>,
        "Andy Carlson" <naclos@swbell.net>, <linux-kernel@vger.kernel.org>,
        "Stephan von Krawczynski" <skraw@ithnet.com>
In-Reply-To: <004101c1a3f9$dea1bb90$0201a8c0@HOMER> <Pine.LNX.4.33.0201231255180.6354-100000@cola.teststation.com> <3C4F20A5.F88EA471@zip.com.au> <20020123234138.GA12264@bouncybouncy.net>
Subject: Re: via-rhine timeouts
Date: Thu, 24 Jan 2002 09:38:40 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004F_01C1A4BA.E7DE6A70"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_004F_01C1A4BA.E7DE6A70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

----- Original Message -----
From: "Justin A" <justin@bouncybouncy.net>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: "Urban Widmark" <urban@teststation.com>; "Martin Eriksson"
<nitrax@giron.wox.org>; "Andy Carlson" <naclos@swbell.net>;
<linux-kernel@vger.kernel.org>; "Stephan von Krawczynski" <skraw@ithnet.com>
Sent: Thursday, January 24, 2002 12:41 AM
Subject: Re: via-rhine timeouts


> I don't think thats the full problem, I just noticed I had been getting
> errors too with the via driver, but it's been working fine otherwise:
>
> (heres all of them, don't know what was going on at all the times, but I
> was browsing the web for a bit at 9:50)
>
> Jan 23 00:56:56 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
<snip>
>
> the status makes sense from what I can tell, I could never figure out
> what 782d was.
> ifconfig reports:
> TX packets:657170 errors:52 dropped:0 overruns:0 carrier:52
>
> Is it possible that the problem is with the hub and via-rhine resetting
> the card repetedly just makes it worse?

Hmm, if I'm not wrong, it seems that the linuxfet driver is doing some
strange hack on txstatus 0x0800 and 0x0100. Instead of waiting for
netdev_error to handle things it does its own stuff:

np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
writel(virt_to_bus(&np->tx_ring[entry]), ioaddr + TxRingPtr);
/* Turn on Tx On*/
writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd);
/* Stats counted in Tx-done handler, just restart Tx. */
writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);

What differs from the normal error handler is the "CmdTxOn" command I guess.
But I am also seeing that they have removed any entry from "if (intr_status
& IntrTxAbort) {" in "netdev_error". Might 0x0100 be the new secret abort
code?

What if you tried (or at least reviewed) this patch: (also attached, as OE
foggs opp whitespace)

--- via-rhine.c.orig Fri Dec 21 18:41:54 2001
+++ via-rhine.c Thu Jan 24 09:30:42 2002
@@ -1264,7 +1264,7 @@

   /* Abnormal error summary/uncommon events handlers. */
   if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |
-         IntrStatsMax | IntrTxAbort | IntrTxUnderrun))
+         IntrStatsMax | IntrTxAbort | IntrTxUnderrun | 0x0100))
    via_rhine_error(dev, intr_status);

   if (--boguscnt < 0) {
@@ -1481,8 +1481,14 @@
    printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "
        "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);
  }
+ if (intr_status & 0x0100) {
+  /* VIA hack */
+  writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd);
+  /* Restart Tx */
+  writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+ }
  if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
-        IntrTxAbort | IntrTxAborted))) {
+        IntrTxAbort | IntrTxAborted | 0x0100))) {
   if (debug > 1)
    printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
       dev->name, intr_status);


 _____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden

- ABIT BP6(RU) - 2xCeleron 400 - 128MB/PC100/C2 Acer
- Maxtor 10/5400/U33 HPT P/M - Seagate 6/5400/DMA2 HPT S/M
- 2xDE-530TX - 1xTulip - Linux 2.4.17+ide+preempt

------=_NextPart_000_004F_01C1A4BA.E7DE6A70
Content-Type: application/octet-stream;
	name="via-rhine.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="via-rhine.patch"

--- via-rhine.c.orig	Fri Dec 21 18:41:54 2001=0A=
+++ via-rhine.c	Thu Jan 24 09:30:42 2002=0A=
@@ -1264,7 +1264,7 @@=0A=
 =0A=
 		/* Abnormal error summary/uncommon events handlers. */=0A=
 		if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |=0A=
-						   IntrStatsMax | IntrTxAbort | IntrTxUnderrun))=0A=
+						   IntrStatsMax | IntrTxAbort | IntrTxUnderrun | 0x0100))=0A=
 			via_rhine_error(dev, intr_status);=0A=
 =0A=
 		if (--boguscnt < 0) {=0A=
@@ -1481,8 +1481,14 @@=0A=
 			printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "=0A=
 				   "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);=0A=
 	}=0A=
+	if (intr_status & 0x0100) {=0A=
+		/* VIA hack */=0A=
+		writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd);=0A=
+		/* Restart Tx */=0A=
+		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);=0A=
+	}=0A=
 	if ((intr_status & ~( IntrLinkChange | IntrStatsMax |=0A=
-						  IntrTxAbort | IntrTxAborted))) {=0A=
+						  IntrTxAbort | IntrTxAborted | 0x0100))) {=0A=
 		if (debug > 1)=0A=
 			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",=0A=
 			   dev->name, intr_status);=0A=

------=_NextPart_000_004F_01C1A4BA.E7DE6A70--

