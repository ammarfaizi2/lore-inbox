Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131287AbQKIVA1>; Thu, 9 Nov 2000 16:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbQKIVAR>; Thu, 9 Nov 2000 16:00:17 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:20999 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131212AbQKIVAC>; Thu, 9 Nov 2000 16:00:02 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2.18pre20 MEGARAID hang
Date: 9 Nov 2000 20:59:59 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8uf38f$3e9$1@enterprise.cistron.net>
In-Reply-To: <Pine.LNX.4.21.0011091230530.9750-300000@eurus.scripps.edu>
X-Trace: enterprise.cistron.net 973803599 3529 195.64.65.201 (9 Nov 2000 20:59:59 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0011091230530.9750-300000@eurus.scripps.edu>,
Brian Marsden  <marsden@scripps.edu> wrote:
>2.2.18pre20 (still) hangs on boot when it gets to the part where it
>detects the MEGARAID card. 

Hmm, I got a patch from AMI that fixed it for me for 2.2.18pre18.
That patch wasn't applied as-is, though Alan said a megaraid fix was
applied to 2.2.18pre19. I didn't have a chance to test pre19 or pre20
yet, though, since I can only test it on a production machine that
now runs OK with pre18+fix, the test machine lays on someones desk
in a lot of parts at the moment ;)

Anyway. Here's a patch that ``upgrades'' the 2.2.18pre20 megaraid.c
to the 2.2.18pre18 + AMI patch version that I have. Please let
us know if it makes any difference.

[and, if you can, and this patch works, try to remove parts of the
 patch until you find exactly what it is that makes it work]

--- linux-2.2.18pre20/drivers/scsi/megaraid.c	Thu Nov  9 14:35:23 2000
+++ linux-2.2.18pre18-mega/drivers/scsi/megaraid.c	Thu Nov  9 21:49:50 2000
@@ -9,7 +9,7 @@
  *              as published by the Free Software Foundation; either version
  *              2 of the License, or (at your option) any later version.
  *
- * Version : 1b08b
+ * Version : v1.11a
  * 
  * Description: Linux device driver for AMI MegaRAID controller
  *
@@ -179,7 +179,9 @@
  *	I)  Version number changed from 1.10c to 1.11
  *  II)	DCMD_WRITE_CONFIG(0x0D) command in the driver changed from 
  *  	scatter/gather list mode to direct pointer mode.. 
- * 
+ *
+ * Version 1.11a
+ *	Initlization bug fixed
  * BUGS:
  *     Some older 2.1 kernels (eg. 2.1.90) have a bug in pci.c that
  *     fails to detect the controller as a pci device on the system.
@@ -194,7 +196,7 @@
 #define CRLFSTR "\n"
 #define IOCTL_CMD_NEW  0x81
 
-#define MEGARAID_VERSION "v1.11 (Aug 23, 2000)" 
+#define MEGARAID_VERSION "v1.11a (Oct 24, 2000)" 
 #define MEGARAID_IOCTL_VERSION 108
 
 #include <linux/config.h>
@@ -1842,8 +1844,8 @@
   while ((pdev = pci_find_device (pciVendor, pciDev, pdev))) {
 
 #ifdef DELL_MODIFICATION 
-    if (pci_enable_device(pdev))
-    	continue;
+    if (pci_enable_device(pdev))
+    	continue;
 #endif	
     pciBus = pdev->bus->number;
     pciDevFun = pdev->devfn;
@@ -1889,7 +1891,11 @@
 				"megaraid: to protect your data, please upgrade your firmware to version\n"
 				"megaraid: 3.10 or later, available from the Dell Technical Support web\n"
 				"megaraid: site at\n"
+#ifdef DELL_MODIFICATION 
 				"http://support.dell.com/us/en/filelib/download/index.asp?fileid=2940\n");
+#else				
+				"http://support.dell.com/us/en/filelib/download/index.asp?fileid=2489\n");
+#endif				
 			continue;
 			}
 		}
@@ -1914,16 +1920,32 @@
     megaIrq  = pdev->irq;
 #else
 
-    megaBase = pci_resource_start (pdev, 0);
+#ifdef DELL_MODIFICATION  
+    megaBase = pci_resource_start (pdev, 0);
+#else
+    megaBase = pdev->resource[0].start;
+#endif	
     megaIrq  = pdev->irq;
 #endif
 
     pciIdx++;
 
-    if (flag & BOARD_QUARTZ)
-       megaBase = (long) ioremap (megaBase, 128);
-    else
-       megaBase += 0x10;
+#ifdef DELL_MODIFICATION 
+    if (flag & BOARD_QUARTZ)
+       megaBase = (long) ioremap (megaBase, 128);
+    else
+       megaBase += 0x10;
+#else
+    if (flag & BOARD_QUARTZ) {
+
+      megaBase &= PCI_BASE_ADDRESS_MEM_MASK;
+      megaBase = (long) ioremap (megaBase, 128);
+    }
+    else {
+      megaBase &= PCI_BASE_ADDRESS_IO_MASK;
+      megaBase += 0x10;
+    }
+#endif
 
     /* Initialize SCSI Host structure */
     host = scsi_register (pHostTmpl, sizeof (mega_host_config));
@@ -2087,8 +2109,7 @@
 	  remove_proc_entry("config", megaCfg->controller_proc_dir_entry);
 	  remove_proc_entry("mailbox", megaCfg->controller_proc_dir_entry);
           for (i = 0; i < numCtlrs; i++) {
-                char buf[12];
-                memset(buf,0,12);
+                char buf[12] ={0};
 		sprintf(buf,"%d",i);
           	remove_proc_entry(buf,mega_proc_dir_entry);
 	 }
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
