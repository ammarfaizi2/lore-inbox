Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbQLHKSh>; Fri, 8 Dec 2000 05:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131749AbQLHKS1>; Fri, 8 Dec 2000 05:18:27 -0500
Received: from smtp2.free.fr ([212.27.32.6]:48906 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S131283AbQLHKSO>;
	Fri, 8 Dec 2000 05:18:14 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18pre25
Message-ID: <976268866.3a30ae4296b71@imp.free.fr>
Date: Fri, 08 Dec 2000 10:47:46 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <E144AfG-0003B2-00@the-village.bc.nu>
In-Reply-To: <E144AfG-0003B2-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I asked people to explain why it was needed. I am still waiting. It is a
> patch that does nothing. I will not put random deep magic into the
> kernel.

Alan, I replied to you a few weeks ago (pre20 times) when you asked me why
I was sending you this patch. (perhaps you didn't receive my email). What I 
observed was that my netraid card had a 0xXXXX8 base address and the patch
aligned that address to 16 bytes :

|Bus  0, device   2, function  1:
|  Unknown class: Intel OEM MegaRAID Controller (rev 5).
|    Medium devsel.  Fast back-to-back capable.  BIST capable.  IRQ 10.  Master
Capable.  Latency=64.  
|    Prefetchable 32 bit memory at 0xf0000000 [0xf0000008].

as you see, the board is found at 0xf0000008, but used aligned to 0xf0000000.

my server currently works with that patch, but I'm sure it won't boot anymore
if I apply this 2.2.18pre25 alone. 

just in case, here it is again.

Cheers,
Willy

--- 18pre/drivers/scsi/megaraid.c       Wed Nov  8 16:02:45 2000
+++ 18pre+megaraid/drivers/scsi/megaraid.c      Fri Nov 10 12:03:05 2000
@@ -1920,10 +1920,14 @@
 
     pciIdx++;
 
-    if (flag & BOARD_QUARTZ)
+    if (flag & BOARD_QUARTZ) {
+       megaBase &= PCI_BASE_ADDRESS_IO_MASK;
        megaBase = (long) ioremap (megaBase, 128);
-    else
+    }
+    else {
+       megaBase &= PCI_BASE_ADDRESS_MEM_MASK;
        megaBase += 0x10;
+    }
 
     /* Initialize SCSI Host structure */
     host = scsi_register (pHostTmpl, sizeof (mega_host_config));

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
