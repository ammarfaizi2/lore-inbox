Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQKQPmb>; Fri, 17 Nov 2000 10:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbQKQPmV>; Fri, 17 Nov 2000 10:42:21 -0500
Received: from columba.EUR.3Com.COM ([161.71.169.13]:19703 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id <S129464AbQKQPmI>; Fri, 17 Nov 2000 10:42:08 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <8025699A.0053EEFF.00@notesmta.eur.3com.com>
Date: Fri, 17 Nov 2000 15:10:53 +0000
Subject: [Patch] oops with cs5530 using ide.2.2.17.all.20000904.patch 
	(probably 2.4 as well)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When using Linux-2.2.17 + ide.2.2.17.all.20000904.patch on a board with the
CS5530, doing the following generates a kernel NULL dereference:

pb-3com# cat /proc/ide/cs5530
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
...

This is caused because the 'bmide_dev' in cs5530.c is NULL. This has been set
wrongly because the 'dev' value used in pci_init_cs5530() is corrupted by the
loop:

     for( dev = pci_devices; dev; dev=dev->next)
     {...}

A fix is to move the setting of the 'bmide_dev' value to before this loop.

A quick look at Linux-2.4.0-test9 shows it probably suffers from the same
problem as well.

Below is a patch against Linux-2.2.17 + ide.2.2.17.all.20000904.patch

--- cs5530.c   Fri Nov 17 10:17:15 2000
+++ cs5530.c   Fri Nov 17 14:45:06 2000
@@ -268,6 +268,14 @@
     unsigned short pcicmd = 0;
     unsigned long flags;

+#if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
+    if (!cs5530_proc) {
+         cs5530_proc = 1;
+         bmide_dev = dev;
+         cs5530_display_info = &cs5530_get_info;
+    }
+#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
+
     for(dev = pci_devices; dev; dev=dev->next) {
          if (dev->vendor == PCI_VENDOR_ID_CYRIX) {
               switch (dev->device) {
@@ -337,14 +345,6 @@
     pci_write_config_byte(master_0, 0x43, 0xc1);

     restore_flags(flags);
-
-#if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
-    if (!cs5530_proc) {
-         cs5530_proc = 1;
-         bmide_dev = dev;
-         cs5530_display_info = &cs5530_get_info;
-    }
-#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */

     return 0;
 }


     Jon




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
