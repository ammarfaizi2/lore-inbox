Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbSLSXaD>; Thu, 19 Dec 2002 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbSLSXaD>; Thu, 19 Dec 2002 18:30:03 -0500
Received: from milligan.cwx.net ([216.17.176.90]:18306 "EHLO mail.acmeps.com")
	by vger.kernel.org with ESMTP id <S267622AbSLSX36>;
	Thu, 19 Dec 2002 18:29:58 -0500
Message-ID: <3E025858.4000404@acmeps.com>
Date: Thu, 19 Dec 2002 16:38:00 -0700
From: Michael Milligan <milli@acmeps.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: Broken AGP initialization for i845G chipset [patch]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chipset detection for the new Intel i845G chipset was added into the AGPGART
driver, but it appears to call the wrong initialization routine.  Stock 
compile
causes some bad interaction that messes up the PCI bus such that, in my 
case,
the follow on initialization of the Adaptec SCSI card (PCI) hangs the 
box.  Needless
to say, that's very bad since that's where all the hard drives live. 
SCSI driver
initialization happens right after the AGP initialization... from dmesg 
(after my patch):
(without the patch, it would hang before "scsi0: Adaptec ..." or before 
finding
  any drives)
....
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i845G chipset
agpgart: AGP aperture is 256M @ 0xe0000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 02:0a.0
PCI: Sharing IRQ 9 with 02:0a.1
PCI: Found IRQ 9 for device 02:0a.1
PCI: Sharing IRQ 9 with 02:0a.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
         <Adaptec 3950B Ultra2 SCSI adapter>
         aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
         <Adaptec 3950B Ultra2 SCSI adapter>
         aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

   Vendor: IBM       Model: DNES-309170Y      Rev: SAH0
   Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 30, 16bit)
....

Patch below.  Calls the 845 initialization function instead of the 830MP,
and a small formatting cleanup.  This is verified working.

$ diff -u kernel-source-2.4.20/drivers/char/agp/agpgart_be.c.org 
kernel-source-2.4.20/drivers/char/agp/agpgart_be.c
--- kernel-source-2.4.20/drivers/char/agp/agpgart_be.c.org 2002-11-28 
16:53:12.000000000 -0700
+++ kernel-source-2.4.20/drivers/char/agp/agpgart_be.c  2002-12-08 
20:39:57.000000000 -0700
@@ -4551,12 +4551,12 @@
                 "Intel",
                 "i830M",
                 intel_830mp_setup },
-    { PCI_DEVICE_ID_INTEL_845_G_0,
+       { PCI_DEVICE_ID_INTEL_845_G_0,
                  PCI_VENDOR_ID_INTEL,
                  INTEL_I845_G,
                  "Intel",
                  "i845G",
-                intel_830mp_setup },
+                intel_845_setup },
         { PCI_DEVICE_ID_INTEL_840_0,
                 PCI_VENDOR_ID_INTEL,
                 INTEL_I840,

Please note... kernel version below is that of my development box (where 
kernel was compiled)

-- System Information
Debian Release: testing/unstable
Kernel Version: Linux shadow 2.4.19 #3 SMP Mon Nov 25 20:48:02 MST 2002 
i686 Pentium III (Coppermine) GenuineIntel GNU/Linux

Versions of the packages kernel-source-2.4.20 depends on:
ii  binutils       2.13.90.0.10-1 The GNU assembler, linker and binary 
utiliti
ii  bzip2          1.0.2-1        A high-quality block-sorting file 
compressor
ii  coreutils      4.5.2-1        The GNU core utilities
ii  fileutils      4.5.2-1        GNU file management utilities


Regards,
Mike

-- 
Michael Milligan  --  Free Agent  --  milli@acmeps.com

