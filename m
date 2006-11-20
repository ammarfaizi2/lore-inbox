Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934241AbWKTPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934241AbWKTPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934244AbWKTPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:38:58 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:35722 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S934241AbWKTPi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:38:56 -0500
Message-ID: <4561CBF9.CA21F786@ru.mvista.com>
Date: Mon, 20 Nov 2006 18:38:33 +0300
From: yadviga <yadviga@ru.mvista.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] large pci adress space in pci/probe.c for linux-2.6.18
Content-Type: multipart/mixed;
 boundary="------------C705D10DB448F6CFC16C1452"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C705D10DB448F6CFC16C1452
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

This is a request from Cisco to update pci address space for 64-bit mips
Cavium Octeon.

The size returned by a 4GB or greater sized BAR register returns zero
which made the algorithm in pci_read_bases() hit a continue instead of
continuing to read the upper 32-bits of the address space. I needed to
add the code to check if it was a 64-bit memory space by checking the
relevant lower bits, in which case the lower 32-bits of the size are
0xffffffff by the way they calculate size. As far as I can tell this has
still not been fixed in the latest release of Linux which is 2.6.18. I
guess no one has
encountered such a large BAR register yet.




--------------C705D10DB448F6CFC16C1452
Content-Type: text/plain; charset=koi8-r;
 name="pci_probe_2.6.18.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_probe_2.6.18.2.patch"

--- linux/drivers/pci/probe.c	Sat Nov  4 04:33:58 2006
+++ linux-2.6.18.2/drivers/pci/probe.c	Fri Nov 17 19:13:31 2006
@@ -165,8 +165,18 @@
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
 			sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
-			if (!sz)
-				continue;
+			if (!sz) {
+				/* if BAR space is over 4GB we need to make sure that
+				   we don't bail out if the size is zero */
+				if ((l &
+				    (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+				    == (PCI_BASE_ADDRESS_SPACE_MEMORY |
+				    PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+					    sz = 0xffffffff;
+				} else {
+					continue;
+				}
+			}
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
 		} else {

--------------C705D10DB448F6CFC16C1452--

