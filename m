Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTADMFt>; Sat, 4 Jan 2003 07:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTADMFt>; Sat, 4 Jan 2003 07:05:49 -0500
Received: from [81.2.122.30] ([81.2.122.30]:517 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266810AbTADMFr>;
	Sat, 4 Jan 2003 07:05:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301041214.h04CE90f000847@darkstar.example.net>
Subject: Re: please help me understand a line code about pci
To: fretre3618@hotmail.com (fretre lewis)
Date: Sat, 4 Jan 2003 12:14:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F870TlKn4ZHkRQq5xVz0000f680@hotmail.com> from "fretre lewis" at Jan 04, 2003 11:59:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.801.1041682449--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.801.1041682449--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>   I am reading code about pci, and I can't understand some lines in
> pci_check_direct(), in arch/i386/kernel/pci-pc.c
> 
> the PCI spec v2.0 say: ( page32)
> 
> "Anytime a host bridge sees a full DWORD I/O write from the host to
> CONFIG_ADDRESS, the bridge must latch the data into its CONFIG_ADDRESS
> register. On full DWORD I/O reads to CONFIG_ADDRESS,the bridge must return 
> the
> data in CONFIG_ADDRESS. Any other types of accesses to this 
> address(non-DWORD)
> have no effect on CONFIG_ADDRESS and are excuted as normal I/O transaction 
> on PCI bus......"
> 
> CONFIG_ADDRESS = 0xcf8
> CONFIG_data = 0xcfc
> 
> so , I wonder why need "outb (0x01, 0xCFB);" if check configuration type 1 ? 
> and why "outb (0x00, 0xCFB);" if check configuration type 2?

It looks to me like a workaround for broken hardware, but I could be
wrong.

Incidently, wouldn't it be worth printing some debugging info, such as
the values read from 0xCF8 and 0xCFA, when neither configuration type
works?  I've attached an, (untested), patch to do so.

John.

--%--multipart-mixed-boundary-1.801.1041682449--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="temp_patch"

--- pci-pc.c.orig	2003-01-04 12:09:35.000000000 +0000
+++ pci-pc.c	2003-01-04 12:12:37.000000000 +0000
@@ -459,6 +459,8 @@
 {
 	unsigned int tmp;
 	unsigned long flags;
+	unsigned int foo;
+	unsigned int bar;
 
 	__save_flags(flags); __cli();
 
@@ -493,13 +495,17 @@
 		outb (0x00, 0xCFB);
 		outb (0x00, 0xCF8);
 		outb (0x00, 0xCFA);
-		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
+		foo = inb (0xCF8);
+		bar = inb (0xCFA);
+		if (foo == 0x00 && bar == 0x00 &&
 		    pci_sanity_check(&pci_direct_conf2)) {
 			__restore_flags(flags);
 			printk(KERN_INFO "PCI: Using configuration type 2\n");
 			request_region(0xCF8, 4, "PCI conf2");
 			return &pci_direct_conf2;
 		}
+	printk ((KERN_INFO, "PCI: Failed to use configuration type 1 or 2.
+0xCF8:%x 0xCFA:%x\n", foo, bar);
 	}
 
 	__restore_flags(flags);

--%--multipart-mixed-boundary-1.801.1041682449--%--
