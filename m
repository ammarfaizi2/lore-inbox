Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286073AbRLTEef>; Wed, 19 Dec 2001 23:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286071AbRLTEeZ>; Wed, 19 Dec 2001 23:34:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20457 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S286073AbRLTEeT>;
	Wed, 19 Dec 2001 23:34:19 -0500
Message-Id: <200112200428.fBK4SNq29583@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MAX_MP_BUSSES increase
Date: Wed, 19 Dec 2001 20:28:22 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into a bit of a problem with a forthcoming system.  The BIOS 
reserves so many PCI bus numbers for hotplug when maxed out PCI expansion 
box(es) are present that some arrays (mp_bus_id_to_node[], 
mp_bus_id_to_pci_bus[], etc) overflow, splattering important variables.

They've been predicting the time when 256 PCI busses are not enough for some 
time now.  We've nearly hit that point.  Meanwhile, here's a patch to boost 
MAX_MP_BUSSES from 32 to the max, plus one more for ISA.

Some folks might think that this is excessive, but the BIOS is adding 50 bus 
records to the tables just for a quad computer and one fully loaded PCI 
expansion box.  (You can buy extra PCI slots in units of 6.)  The thing is 
supposed to support 3 expansion boxes soon.  The NUMA version of this, coming 
out next year, has the potential to be even more extreme:  4 quads with 3 
expansion boxes each == a whole lot of PCI slots, each of which needs its own 
PCI bus number in case someone hotplugs in a quad ethernet card or some other 
combo board with its own PCI bridge chip.

Marcello and Linus, please apply.

--- linux-2.4.16/include/asm-i386/mpspec.h	Thu Nov 22 11:46:18 2001
+++ jamesc-2.4.16/include/asm-i386/mpspec.h	Tue Dec 18 13:45:49 2001
@@ -184,13 +185,10 @@
  *	7	2 CPU MCA+PCI
  */
 
-#ifdef CONFIG_MULTIQUAD
-#define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_MULTIQUAD */
-#define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_MULTIQUAD */
+#define MAX_MP_BUSSES 257	/* Need max PCI busses for hotplug + 1 for ISA. */
+				/* Four intrs per PCI slot. */
+#define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
 
-#define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com (kmail)  |   cleverdj@us.ibm.com (Lotus Notes)

