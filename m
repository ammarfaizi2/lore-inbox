Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTGIGOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265733AbTGIGOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:14:17 -0400
Received: from pat.uio.no ([129.240.130.16]:63734 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265726AbTGIGOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:14:14 -0400
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org, akpm@osdl.org
Subject: 2.5.74 - sbp2 fails to compile, missing include of <linux/pci.h>?
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Wed, 09 Jul 2003 08:28:48 +0200
Message-ID: <wxxadbo8b8f.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
  without adding the inclusion of <linux/pci.h> in
  drivers/ieee1394/sbp2.c I am unable to build the module (see below
  for a patch):

[x200 /usr/src/linux-2.5.74] # make modules
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/ieee1394/sbp2.o
drivers/ieee1394/sbp2.c: In function `sbp2util_create_command_orb_pool':
drivers/ieee1394/sbp2.c:422: warning: implicit declaration of function
`pci_map_single'
drivers/ieee1394/sbp2.c:424: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
drivers/ieee1394/sbp2.c:424: (Each undeclared identifier is reported only once
drivers/ieee1394/sbp2.c:424: for each function it appears in.)
drivers/ieee1394/sbp2.c: In function `sbp2util_remove_command_orb_pool':
drivers/ieee1394/sbp2.c:454: warning: implicit declaration of function
`pci_unmap_single'
drivers/ieee1394/sbp2.c:456: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
drivers/ieee1394/sbp2.c: In function `sbp2util_free_command_dma':
drivers/ieee1394/sbp2.c:567: warning: implicit declaration of function
`pci_unmap_page'
drivers/ieee1394/sbp2.c:576: warning: implicit declaration of function
`pci_unmap_sg'
drivers/ieee1394/sbp2.c: In function `sbp2_start_device':
drivers/ieee1394/sbp2.c:817: warning: implicit declaration of function
`pci_alloc_consistent'
drivers/ieee1394/sbp2.c:818: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:826: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:834: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:842: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:850: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:858: warning: assignment makes pointer from integer
without a cast
drivers/ieee1394/sbp2.c:862: warning: implicit declaration of function
`pci_free_consistent'
drivers/ieee1394/sbp2.c: In function `sbp2_create_command_orb':
drivers/ieee1394/sbp2.c:1837: warning: implicit declaration of function
`pci_map_page'
drivers/ieee1394/sbp2.c:1850: warning: implicit declaration of function `pci_map_sg'
drivers/ieee1394/sbp2.c: In function `sbp2_link_orb_command':
drivers/ieee1394/sbp2.c:2015: warning: implicit declaration of function
`pci_dma_sync_single'
drivers/ieee1394/sbp2.c:2017: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
drivers/ieee1394/sbp2.c: In function `sbp2_handle_status_write':
drivers/ieee1394/sbp2.c:2447: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
drivers/ieee1394/sbp2.c: In function `sbp2scsi_complete_all_commands':
drivers/ieee1394/sbp2.c:2639: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
drivers/ieee1394/sbp2.c: In function `sbp2scsi_abort':
drivers/ieee1394/sbp2.c:2798: `PCI_DMA_BIDIRECTIONAL' undeclared (first use in
this function)
make[2]: *** [drivers/ieee1394/sbp2.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2

  however, a similar problem exists in drivers/message/i2o/i2o_scsi.c,
  where the module will compile, but complain about missing symbols.
  this problem is also solved by including linux/pci.h.

  I'm unsure if this is a problem that should be solved at a higher
  level somewhere?  otherwise, here are the patches for
  drivers/ieee1394/sbp2.c and for drivers/message/i2o/i2o_scsi.c.  

--- sbp2.c.orig 2003-07-09 08:09:41.334346927 +0200
+++ sbp2.c      2003-07-09 07:39:18.675714299 +0200
@@ -54,6 +54,7 @@
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
 #include <linux/smp_lock.h>
+#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/version.h>
 #include <asm/current.h>

--- i2o_scsi.c.orig     2003-07-09 08:24:10.509751640 +0200
+++ i2o_scsi.c  2003-07-09 07:55:53.926397019 +0200
@@ -49,6 +49,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/prefetch.h>
+#include <linux/pci.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
  
-- 
Terje
