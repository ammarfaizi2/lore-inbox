Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbSK2Ral>; Fri, 29 Nov 2002 12:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSK2Ral>; Fri, 29 Nov 2002 12:30:41 -0500
Received: from p50817D06.dip.t-dialin.net ([80.129.125.6]:20391 "HELO
	linux.tuxnetwork.de") by vger.kernel.org with SMTP
	id <S267115AbSK2Raj>; Fri, 29 Nov 2002 12:30:39 -0500
Message-ID: <3DE7A5F4.5030503@gentoo.org>
Date: Fri, 29 Nov 2002 18:37:56 +0100
From: Bjoern Brauel <bjb@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021123
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: patch: linux-2.4.20 alpha broken cia(rev1) fix
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020702010204080000030006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020702010204080000030006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch fixes the initialization for CIA revision 1 chips 
that can be found on most Alcor machines. As it is impossible to boot 
such a box together with the Qlogic ISP SCSI controller without this 
patch I believe it is important to include it in the official kernel.

  cheers .. Bjoern

--------------020702010204080000030006
Content-Type: text/plain;
 name="linux-2.4.20-alpha-broken-cia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20-alpha-broken-cia.patch"

--- linux-2.4.20/arch/alpha/kernel/core_cia.c	2002-11-29 17:09:02.000000000 +0000
+++ linux-2.4.20-bjb/arch/alpha/kernel/core_cia.c	2002-11-29 17:09:10.000000000 +0000
@@ -370,7 +370,7 @@
 }
 
 static inline void
-cia_prepare_tbia_workaround(void)
+cia_prepare_tbia_workaround(int cia_rev, int is_pyxis)
 {
 	unsigned long *ppte, pte;
 	long i;
@@ -382,10 +382,21 @@
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;
 
-	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
-	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
-				    & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	if (is_pyxis || cia_rev != 1) {
+	/* We can use W1 for SG on PYXIS/CIA rev 2. */
+		*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+			& 0xfff00000;
+		*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	} else {
+	/* CIA rev 1 can't use W1 or W2 for SG, apparently,
+	     so use W3, which we made sure is not used for DAC. */
+		*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+			& 0xfff00000;
+		*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
+	}
+
 }
 
 static void __init
@@ -715,8 +726,14 @@
 	   are compared against W_DAC.  We can, however, directly map 4GB,
 	   which is better than before.  However, due to assumptions made
 	   elsewhere, we should not claim that we support DAC unless that
-	   4GB covers all of physical memory.  */
-	if (is_pyxis || max_low_pfn > (0x100000000 >> PAGE_SHIFT)) {
+	   4GB covers all of physical memory.
+
+	   Also, don't do DAC on CIA rev 1, it has other problems and is
+	   unlikely to have more than 2GB of memory anyway, so direct is
+	   fine.
+	*/
+	if (cia_rev == 1 || is_pyxis ||
+	    max_low_pfn > (0x100000000 >> PAGE_SHIFT)) {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0;
 	} else {
 		*(vip)CIA_IOC_PCI_W3_BASE = 0x00000000 | 1 | 8;
@@ -728,7 +745,7 @@
 	}
 
 	/* Prepare workaround for apparently broken tbia. */
-	cia_prepare_tbia_workaround();
+	cia_prepare_tbia_workaround(cia_rev, is_pyxis);
 }
 
 void __init

--------------020702010204080000030006--

