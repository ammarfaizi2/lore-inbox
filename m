Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272602AbRIFU5r>; Thu, 6 Sep 2001 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272597AbRIFU5i>; Thu, 6 Sep 2001 16:57:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15516 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272594AbRIFU52>; Thu, 6 Sep 2001 16:57:28 -0400
Message-ID: <3B97E348.9E3E7A18@vnet.ibm.com>
Date: Thu, 06 Sep 2001 15:57:44 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pci_read_bridge_bases bug and sign extend problems
Content-Type: multipart/mixed;
 boundary="------------F2262F738A397EE76CBBF549"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F2262F738A397EE76CBBF549
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In 2.4.9-ac7 I've found the following two problems in
pci_read_bridge_bases().  First, the code is testing "base" for the
PCI_IO_RANGE_TYPE_32 when it should be testing "io_base_lo" (base is
already shifted up 8 bits).  The tests on the mem bases are ok.

Second, the code does some shifting which is not safe when sizeof(long)
< sizeof(int) (i.e. 64 bit).  As I understand it (and observe) in the
assignment like "base = (mem_base_lo << 16)" the u16 mem_base_lo gets
promoted to int before the assignment.  The resulting signed int gets
sign extended to fit into the unsigned long base.  The solution is to
cast the u16's to unsigned long.

Finally, it seems odd that resource[1] here is handled differently than
resource[2].  I'm not a pci wizard, though, so I may be missing
something.  But recently this code has been patched to handle io range
types better and it seems resource[1] was missed.  I don't include
anything in the patch for this, though.

Patch attached (relative to 2.4.9-ac7 though ac9 appears the same).
-- 
-todd
--------------F2262F738A397EE76CBBF549
Content-Type: text/plain; charset=us-ascii;
 name="pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.patch"

--- drivers/pci/pci.c	27 Aug 2001 19:06:08 -0000	1.8
+++ drivers/pci/pci.c	6 Sep 2001 19:23:57 -0000
@@ -967,10 +967,10 @@
 	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
-	base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
-	limit = (io_limit_lo & PCI_IO_RANGE_MASK) << 8;
+	base = (unsigned long)(io_base_lo & PCI_IO_RANGE_MASK) << 8;
+	limit = (unsigned long)(io_limit_lo & PCI_IO_RANGE_MASK) << 8;
 
-	if ((base & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
+	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
 		u16 io_base_hi, io_limit_hi;
 		pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
 		pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
@@ -995,8 +995,8 @@
 	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	base = (unsigned long)(mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	limit = (unsigned long)(mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	if (base && base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
@@ -1011,16 +1011,16 @@
 	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
+	base = (unsigned long)(mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
+	limit = (unsigned long)(mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
 
 	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
 		u32 mem_base_hi, mem_limit_hi;
 		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
 		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
 #if BITS_PER_LONG == 64
-		base |= ((long) mem_base_hi) << 32;
-		limit |= ((long) mem_limit_hi) << 32;
+		base |= ((unsigned long) mem_base_hi) << 32;
+		limit |= ((unsigned long) mem_limit_hi) << 32;
 #else
 		if (mem_base_hi || mem_limit_hi) {
 			printk(KERN_ERR "PCI: Unable to handle 64-bit address space for %s\n", child->name);

--------------F2262F738A397EE76CBBF549--

