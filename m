Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRC3PHG>; Fri, 30 Mar 2001 10:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRC3PG5>; Fri, 30 Mar 2001 10:06:57 -0500
Received: from voxbird.isisweb.nl ([212.204.213.66]:22662 "HELO
	voxbird.isisweb.nl") by vger.kernel.org with SMTP
	id <S131472AbRC3PGt>; Fri, 30 Mar 2001 10:06:49 -0500
Message-ID: <3AC4A0A9.EA78984@xs4all.nl>
Date: Fri, 30 Mar 2001 17:05:13 +0200
From: Ime Smits <imesmits@xs4all.nl>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: r.klabunde@berkom.de, info@scitel.de, kkeil@suse.de
Subject: [PATCH] drivers/isdn/hisax/bkm_a8.c, kernel 2.4.2 (Scitel Quadro)
Content-Type: multipart/mixed;
 boundary="------------FB463133C619B422D4888FC4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FB463133C619B422D4888FC4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Please find attached a patch to fix the following problems with the
Scitel Quadro ISDN card in 2.4 kernels which suddenly arised when I
bought
a K7T Pro motherboard.

kernel: HiSax: Scitel port 0xcc00-0xcd00 already in use
kernel: HiSax: Card Scitel Quadro not installed !

Credits go to Roland Klabunde who told me early december:

<quote>
The Scitel [...] resource requirements are as follows:

- 1 shared interrupt for all controllers
- 1 shared port address for all controllers with a range of 128 bytes
- 1 port address for each controller with a range of 64 bytes

[...]

I've currently downloaded the ISDN stuff [...] As mentioned above, the
span is *128* for pci_ioaddr1 and *64* for pci_ioaddr2 to pci_ioaddr5
[...]. What I see from the source is, that one attempts to claim a
range of 256 bytes for pci_ioaddr1 to _5. That may cause the problems
if the range overlaps with other boards. You may try to change the
following calls in bkm_a8.c:

sct_alloc_io(pci_ioaddr1, 256) to sct_alloc_io(pci_ioaddr1, 128)
sct_alloc_io(pci_ioaddr2, 256) to sct_alloc_io(pci_ioaddr1, 64)
sct_alloc_io(pci_ioaddr3, 256) to sct_alloc_io(pci_ioaddr1, 64)
sct_alloc_io(pci_ioaddr4, 256) to sct_alloc_io(pci_ioaddr1, 64)
sct_alloc_io(pci_ioaddr5, 256) to sct_alloc_io(pci_ioaddr1, 64)

Please note the necessary changes in release_io_sct_quadro.
</quote>

Too bad I went on a holiday that time and forgot all about it, untill
today (shame shame shame). Anyway, this patch to 2.4.2
drivers/isdn/hisax/bkm_a8.c fixes the problem and everything runs
fine again.

Ime Smits
--------------FB463133C619B422D4888FC4
Content-Type: text/plain; charset=us-ascii;
 name="bkm_a8.c-2.4.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bkm_a8.c-2.4.2.patch"

--- linux-2.4.2-dist/drivers/isdn/hisax/bkm_a8.c	Wed Nov 29 19:12:29 2000
+++ linux-2.4.2/drivers/isdn/hisax/bkm_a8.c	Fri Mar 30 13:32:21 2001
@@ -205,9 +205,9 @@
 void
 release_io_sct_quadro(struct IsdnCardState *cs)
 {
-	release_region(cs->hw.ax.base & 0xffffffc0, 256);
+	release_region(cs->hw.ax.base & 0xffffffc0, 128);
 	if (cs->subtyp == SCT_1)
-		release_region(cs->hw.ax.plx_adr, 256);
+		release_region(cs->hw.ax.plx_adr, 64);
 }
 
 static void
@@ -403,9 +403,9 @@
 	switch(cs->subtyp) {
 		case 1:
 			cs->hw.ax.base = pci_ioaddr5 + 0x00;
-			if (sct_alloc_io(pci_ioaddr1, 256))
+			if (sct_alloc_io(pci_ioaddr1, 128))
 				return(0);
-			if (sct_alloc_io(pci_ioaddr5, 256))
+			if (sct_alloc_io(pci_ioaddr5, 64))
 				return(0);
 			/* disable all IPAC */
 			writereg(pci_ioaddr5, pci_ioaddr5 + 4,
@@ -419,17 +419,17 @@
 			break;
 		case 2:
 			cs->hw.ax.base = pci_ioaddr4 + 0x08;
-			if (sct_alloc_io(pci_ioaddr4, 256))
+			if (sct_alloc_io(pci_ioaddr4, 64))
 				return(0);
 			break;
 		case 3:
 			cs->hw.ax.base = pci_ioaddr3 + 0x10;
-			if (sct_alloc_io(pci_ioaddr3, 256))
+			if (sct_alloc_io(pci_ioaddr3, 64))
 				return(0);
 			break;
 		case 4:
 			cs->hw.ax.base = pci_ioaddr2 + 0x20;
-			if (sct_alloc_io(pci_ioaddr2, 256))
+			if (sct_alloc_io(pci_ioaddr2, 64))
 				return(0);
 			break;
 	}	

--------------FB463133C619B422D4888FC4--

