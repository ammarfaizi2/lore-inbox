Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUBZX6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUBZX6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:58:52 -0500
Received: from cr152.neoplus.adsl.tpnet.pl ([80.54.214.152]:9994 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S261316AbUBZX6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:58:32 -0500
Date: Fri, 27 Feb 2004 01:03:25 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: isa_virt_to_bus and co. on alpha (take 2)
Message-ID: <20040227000324.GA17510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Organization: Black Hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Once again (as I previously mentioned in
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/0442.html) the
problem is that on alpha CONFIG_ISA is set (to y), but isa_virt_to_bus,
isa_page_to_bus, isa_bus_to_virt are not defined, which results in the
following unresolved symbols:

*** Warning: "isa_virt_to_bus" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_page_to_bus" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/scsi/wd7000.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/char/tpqic02.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/char/synclink.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/ni65.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/ni65.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/ni52.ko] undefined!
*** Warning: "isa_virt_to_bus" [net/irda/irda.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/cs89x0.ko] undefined!
*** Warning: "isa_bus_to_virt" [drivers/net/3c515.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/3c515.ko] undefined!
*** Warning: "isa_virt_to_bus" [drivers/net/3c505.ko] undefined!

After some investigation (comparing changes in include/asm-i386/io.h,
drivers/scsi/wd7000.c and code in include/asm-alpha/io.h with probably
missing changes) I see that previous proposal was probably incorrect,
and this one should be better...

isa_virt_to_bus and isa_bus_to_virt defines are based on changes for
i386 (where virt_to_bus and bus_to_virt defines have been basically
renamed to isa_virt_to_bus and isa_bus_to_virt - the only difference
is that on alpha virt_to_bus/bus_to_virt and virt_to_phys/phys_to_virt
are not 1:1).

Unlike on i386, on alpha there was no page_to_bus - but I see that it's
something like phys_to_bus(page_to_phys) - so I wrote one basing on
virt_to_bus().

But I'm still not sure - are these changes correct?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-alpha-isa.patch"

--- linux-2.6.3/include/asm-alpha/io.h.orig	2004-02-18 04:59:27.000000000 +0100
+++ linux-2.6.3/include/asm-alpha/io.h	2004-02-25 13:42:10.000000000 +0100
@@ -118,6 +118,15 @@
 	return (long)address <= 0 ? NULL : virt;
 }
 
+#define isa_virt_to_bus virt_to_bus
+#define isa_bus_to_virt bus_to_virt
+static inline unsigned long isa_page_to_bus(struct page *page)
+{
+	unsigned long phys = page_to_phys(page);
+	unsigned long bus = phys + __direct_map_base;
+	return phys <= __direct_map_size ? bus : 0;
+}
+
 #else /* !__KERNEL__ */
 
 /*

--MGYHOYXEY6WxJCY8--
