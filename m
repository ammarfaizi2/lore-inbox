Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSGXOSt>; Wed, 24 Jul 2002 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317304AbSGXOSs>; Wed, 24 Jul 2002 10:18:48 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:36873 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S317302AbSGXOSo> convert rfc822-to-8bit; Wed, 24 Jul 2002 10:18:44 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Jay.Estabrook@compaq.com: Re: kbuild 2.5.26 - arch/alpha]
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Wed, 24 Jul 2002 10:21:56 -0400
Message-ID: <B1CF4F077FB7064C9A641FBFAE2B58F30135489C@tayexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Jay.Estabrook@compaq.com: Re: kbuild 2.5.26 - arch/alpha]
Thread-Index: AcIyiQu0vMSWcc+iQVWLFqo3yRYa7AAl68eg
From: "France, George (LKG)" <george.france2@hp.com>
To: "Estabrook, Jay" <Jay.Estabrook@hp.com>
Cc: "Martin Brulisauer" <martin@uceb.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jul 2002 14:21:56.0886 (UTC) FILETIME=[77540B60:01C2331D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Jay.

--George

-----Original Message-----
From: Estabrook, Jay 
Sent: Tuesday, July 23, 2002 4:35 PM
To: France, George (LKG)
Cc: Martin Brulisauer; linux-kernel@vger.kernel.org
Subject: [Jay.Estabrook@compaq.com: Re: kbuild 2.5.26 - arch/alpha]


Sigh; I never could get the hang of Tuesdays... ;-}

diff -ur old/arch/alpha/kernel/core_cia.c new/arch/alpha/kernel/core_cia.c
--- old/arch/alpha/kernel/core_cia.c	Sun Oct 21 13:30:58 2001
+++ new/arch/alpha/kernel/core_cia.c	Mon Jun 17 13:39:42 2002
@@ -370,7 +370,7 @@
 }
 
 static inline void
-cia_prepare_tbia_workaround(void)
+cia_prepare_tbia_workaround(int cia_rev, int is_pyxis)
 {
 	unsigned long *ppte, pte;
 	long i;
@@ -382,10 +382,20 @@
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
 		ppte[i] = pte;
 
-	*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
-	*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
-				    & 0xfff00000;
-	*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	if (is_pyxis || cia_rev != 1) {
+		/* We can use W1 for SG on PYXIS/CIA rev 2. */
+		*(vip)CIA_IOC_PCI_W1_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W1_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+					    & 0xfff00000;
+		*(vip)CIA_IOC_PCI_T1_BASE = virt_to_phys(ppte) >> 2;
+	} else {
+		/* CIA rev 1 can't use W1 or W2 for SG, apparently,
+		   so use W3, which we made sure is not used for DAC. */
+		*(vip)CIA_IOC_PCI_W3_BASE = CIA_BROKEN_TBIA_BASE | 3;
+		*(vip)CIA_IOC_PCI_W3_MASK = (CIA_BROKEN_TBIA_SIZE*1024 - 1)
+					    & 0xfff00000;
+		*(vip)CIA_IOC_PCI_T3_BASE = virt_to_phys(ppte) >> 2;
+	}
 }
 
 static void __init
@@ -684,10 +694,10 @@
 	/*
 	 * Set up the PCI to main memory translation windows.
 	 *
-	 * Window 0 is scatter-gather 8MB at 8MB (for isa)
-	 * Window 1 is scatter-gather 1MB at 768MB (for tbia)
+	 * Window 0 is S/G 8MB at 8MB (for isa)
+	 * Window 1 is S/G 1MB at 768MB (for tbia) (unused for CIA rev 1)
 	 * Window 2 is direct access 2GB at 2GB
-	 * Window 3 is DAC access 4GB at 8GB
+	 * Window 3 is DAC access 4GB at 8GB (or S/G for tbia if CIA rev 1)
 	 *
 	 * ??? NetBSD hints that page tables must be aligned to 32K,
 	 * possibly due to a hardware bug.  This is over-aligned
@@ -697,6 +707,7 @@
 
 	hose->sg_pci = NULL;
 	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 32768);
+
 	__direct_map_base = 0x80000000;
 	__direct_map_size = 0x80000000;
 
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
+	    max_low_pfn > (0x100000000UL >> PAGE_SHIFT)) {
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


----- Forwarded message from Jay Estabrook <Jay.Estabrook@compaq.com> -----

Date: Tue, 23 Jul 2002 16:18:09 -0400
From: Jay Estabrook <Jay.Estabrook@compaq.com>
Subject: Re: kbuild 2.5.26 - arch/alpha
To: George France <france@handhelds.org>
Cc: Martin Brulisauer <martin@uceb.org>, linux-kernel@vger.kernel.org

 --Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            HPTC - LINUX support
Hewlett-Packard Company - MRO1-2/K15       (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@hp.com
-----------------------------------------------------------------------------
