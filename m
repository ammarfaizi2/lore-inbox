Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318025AbSHHWHN>; Thu, 8 Aug 2002 18:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSHHWHN>; Thu, 8 Aug 2002 18:07:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8166 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318025AbSHHWHL>;
	Thu, 8 Aug 2002 18:07:11 -0400
Message-ID: <3D52EBB2.1070202@us.ibm.com>
Date: Thu, 08 Aug 2002 15:07:46 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
CC: Martin Bligh <mjbligh@us.ibm.com>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [patch] PCI configuration fix for NUMA-Q
Content-Type: multipart/mixed;
 boundary="------------040503020604060304030101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503020604060304030101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	The PCI code for NUMA-Q machines has been broken for a while...  The kernel 
currently can't find PCI busses on quad's other than the first.  This patch 
fixes that problem.  Please apply.

Cheers!

-Matt

--------------040503020604060304030101
Content-Type: text/plain;
 name="numaq_pci_fix-2530.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numaq_pci_fix-2530.patch"

diff -Nur linux-2.5.15-vanilla/arch/i386/pci/direct.c linux-2.5.15-patched/arch/i386/pci/direct.c
--- linux-2.5.15-vanilla/arch/i386/pci/direct.c	Thu May  9 15:22:49 2002
+++ linux-2.5.15-patched/arch/i386/pci/direct.c	Thu Aug  8 10:27:11 2002
@@ -6,6 +6,10 @@
 #include <linux/init.h>
 #include "pci.h"
 
+/* Ensure the correct pci_conf1_{read|write} functions are compiled in */
+#ifndef CONFIG_MULTIQUAD
+
+
 /*
  * Functions for accessing PCI configuration space with type 1 accesses
  */
@@ -72,6 +76,11 @@
 
 #undef PCI_CONF1_ADDRESS
 
+#else /* CONFIG_MULTIQUAD */
+extern int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value);
+extern int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value);
+#endif /* !CONFIG_MULTIQUAD */
+
 static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
 {
 	int result; 
diff -Nur linux-2.5.15-vanilla/arch/i386/pci/numa.c linux-2.5.15-patched/arch/i386/pci/numa.c
--- linux-2.5.15-vanilla/arch/i386/pci/numa.c	Thu May  9 15:22:46 2002
+++ linux-2.5.15-patched/arch/i386/pci/numa.c	Thu Aug  8 10:52:24 2002
@@ -1,19 +1,23 @@
 /*
  * numa.c - Low-level PCI access for NUMA-Q machines
  */
+
 #include <linux/pci.h>
 #include <linux/init.h>
-
 #include "pci.h"
 
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
+/*
+ * Functions for accessing PCI configuration space with type 1 accesses on NUMA-Q
+ */
+
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -41,7 +45,7 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 

--------------040503020604060304030101--

