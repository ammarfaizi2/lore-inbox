Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278680AbRJXRyF>; Wed, 24 Oct 2001 13:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278682AbRJXRxq>; Wed, 24 Oct 2001 13:53:46 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:41393 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S278680AbRJXRxe>; Wed, 24 Oct 2001 13:53:34 -0400
Date: Wed, 24 Oct 2001 18:55:12 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, rgooch@atnf.csiro.au
Subject: [PATCH] Simplify serverworks workaround.
Message-ID: <20011024185512.A6207@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, rgooch@atnf.csiro.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Richard,
 Patch below makes the workaround for Serverworks LE chipsets
 a little simpler, and also adds a printk to let people know
 why they can't use Write-combining.

regards,

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/kernel/mtrr.c ../2.5/linux-dj/arch/i386/kernel/mtrr.c
--- linux/arch/i386/kernel/mtrr.c	Fri Oct 12 16:29:57 2001
+++ linux-dj/arch/i386/kernel/mtrr.c	Sat Oct 13 12:08:34 2001
@@ -473,25 +473,16 @@
     unsigned long config, dummy;
     struct pci_dev *dev = NULL;
     
-   /* ServerWorks LE chipsets have problems with  write-combining 
-      Don't allow it and  leave room for other chipsets to be tagged */
+   /* ServerWorks LE chipsets have problems with write-combining 
+      Don't allow it and leave room for other chipsets to be tagged */
 
-    if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
-	switch(dev->vendor) {
-        case PCI_VENDOR_ID_SERVERWORKS:
- 	    switch (dev->device) {
-	    case PCI_DEVICE_ID_SERVERWORKS_LE:
+	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
+		if ((dev->vendor == PCI_VENDOR_ID_SERVERWORKS) &&
+			(dev->device == PCI_DEVICE_ID_SERVERWORKS_LE)) {
+		printk (KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
 		return 0;
-		break;
-	    default:
-		break;
-	    }
-	    break;
-	default:
-	    break;
+		}
 	}
-    }
-
 
     switch ( mtrr_if )
     {


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
