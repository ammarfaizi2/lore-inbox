Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUD1NJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUD1NJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264784AbUD1NJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:09:17 -0400
Received: from aun.it.uu.se ([130.238.12.36]:48091 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264773AbUD1NH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:07:58 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.44197.587250.992871@alkaid.it.uu.se>
Date: Wed, 28 Apr 2004 15:07:49 +0200
To: torvalds@osdl.org
Subject: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
- arch/i386/pci/pcbios.c: use of "+m" constraint
- drivers/char/ftape/: use of cast-as-lvalue
- drivers/char/ftape/: __attribute__((packed)) on something
  containing only bytes

Compiles cleanly and works for me.

This isn't critical, I'll resend after 2.6.6 final if
you don't want to merge it right now.

/Mikael

diff -ruN linux-2.6.6-rc3/arch/i386/pci/pcbios.c linux-2.6.6-rc3.gcc340-fixes/arch/i386/pci/pcbios.c
--- linux-2.6.6-rc3/arch/i386/pci/pcbios.c	2003-09-09 14:22:28.000000000 +0200
+++ linux-2.6.6-rc3.gcc340-fixes/arch/i386/pci/pcbios.c	2004-04-28 12:21:00.000000000 +0200
@@ -431,11 +431,13 @@
 		"1:"
 		: "=a" (ret),
 		  "=b" (map),
-		  "+m" (opt)
+		  "=m" (opt)
 		: "0" (PCIBIOS_GET_ROUTING_OPTIONS),
 		  "1" (0),
 		  "D" ((long) &opt),
-		  "S" (&pci_indirect));
+		  "S" (&pci_indirect),
+		  "m" (opt)
+		: "memory");
 	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
 	if (ret & 0xff00)
 		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
diff -ruN linux-2.6.6-rc3/drivers/char/ftape/lowlevel/ftape-bsm.c linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/lowlevel/ftape-bsm.c
--- linux-2.6.6-rc3/drivers/char/ftape/lowlevel/ftape-bsm.c	2002-02-20 03:10:58.000000000 +0100
+++ linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/lowlevel/ftape-bsm.c	2004-04-28 12:21:00.000000000 +0200
@@ -203,6 +203,7 @@
 	    ft_format_code == fmt_1100ft) {
 		SectorCount *ptr = (SectorCount *)bad_sector_map;
 		unsigned int sector;
+		__u16 *ptr16;
 
 		while((sector = get_sector(ptr++)) != 0) {
 			if ((ft_format_code == fmt_big || 
@@ -218,9 +219,10 @@
 		}
 		/*  Display old ftape's end-of-file marks
 		 */
-		while ((sector = get_unaligned(((__u16*)ptr)++)) != 0) {
+		ptr16 = (__u16*)ptr;
+		while ((sector = get_unaligned(ptr16++)) != 0) {
 			TRACE(ft_t_noise, "Old ftape eof mark: %4d/%2d",
-			      sector, get_unaligned(((__u16*)ptr)++));
+			      sector, get_unaligned(ptr16++));
 		}
 	} else { /* fixed size format */
 		for (i = ft_first_data_segment;
diff -ruN linux-2.6.6-rc3/drivers/char/ftape/lowlevel/ftape-bsm.h linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/lowlevel/ftape-bsm.h
--- linux-2.6.6-rc3/drivers/char/ftape/lowlevel/ftape-bsm.h	2002-02-20 03:10:52.000000000 +0100
+++ linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/lowlevel/ftape-bsm.h	2004-04-28 12:21:00.000000000 +0200
@@ -47,7 +47,7 @@
  */
 typedef struct NewSectorMap {          
 	__u8 bytes[3];
-} SectorCount __attribute__((packed));
+} SectorCount;
 
 
 /*
diff -ruN linux-2.6.6-rc3/drivers/char/ftape/zftape/zftape-eof.c linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/zftape/zftape-eof.c
--- linux-2.6.6-rc3/drivers/char/ftape/zftape/zftape-eof.c	2003-02-24 23:25:37.000000000 +0100
+++ linux-2.6.6-rc3.gcc340-fixes/drivers/char/ftape/zftape/zftape-eof.c	2004-04-28 12:21:00.000000000 +0200
@@ -123,7 +123,7 @@
 	while (ptr + 3 < limit) {
 
 		if (get_unaligned((__u32*)ptr)) {
-			++(__u32*)ptr;
+			ptr += sizeof(__u32);
 		} else {
 			return ptr;
 		}
