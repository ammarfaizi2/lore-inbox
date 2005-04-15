Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVDOM5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVDOM5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 08:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDOM5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 08:57:16 -0400
Received: from magic.adaptec.com ([216.52.22.17]:44755 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261817AbVDOM4b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 08:56:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/scsi/dpt*: remove version.h dependencies
Date: Fri, 15 Apr 2005 08:56:25 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B010AAA69@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/scsi/dpt*: remove version.h dependencies
Thread-Index: AcVBVN9R8cSeJz+pSbit9YgHhPgMXAAZVicg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Adrian Bunk" <bunk@stusta.de>,
       "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       <Markus.Lidel@shadowconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can not remove the entries in sys_info.h (osMajorVersion & friends),
this communicates information to the application via the ioctls and the
structure shape is important. Change the code to zero the values, leave
osType set to OS_LINUX.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de] 
Sent: Thursday, April 14, 2005 8:49 PM
To: James Bottomley
Cc: Andrew Morton; SCSI Mailing List; Linux Kernel;
Markus.Lidel@shadowconnect.com; Salyzyn, Mark
Subject: [2.6 patch] drivers/scsi/dpt*: remove version.h dependencies

On Sat, Apr 02, 2005 at 07:49:38AM -0600, James Bottomley wrote:
> On Sun, 2005-03-27 at 16:34 +0200, Adrian Bunk wrote:
> > This patch removes #if's for kernel 2.2 .
> 
> this one looks like it's not quite complete:
> 
> > -#ifndef LINUX_VERSION_CODE
> >  #include <linux/version.h>
> > -#endif
> 
> Once there are no more KERNEL_VERSION dependencies in a file, it's
> inclusion of linux/version.h can be removed also (and that should
> prevent it getting rebuilt every time the kernel version changes).
> 
> So it looks like there's an additional KERNEL_VERSION to remove in
> dpt/dpti_i2o.h version.h includes in dpti_i2o.h and dpt_i2o.c

Is the patch below what you want, or do I misunderstand your comment?

> Then when you have a final patch, could you cc Markus Lidel
> <Markus.Lidel@shadowconnect.com> and  
> 
> Mark_Salyzyn@adaptec.com
> 
> Thanks,
> 
> James

cu
Adrian


<--  snip  -->


This patch removes version.h dependencies.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

 drivers/scsi/dpt/sys_info.h |    4 ----
 drivers/scsi/dpt_i2o.c      |    5 -----
 drivers/scsi/dpti.h         |   12 ------------
 3 files changed, 21 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/dpti.h.old	2005-04-15
01:21:04.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/dpti.h	2005-04-15
01:21:26.000000000 +0200
@@ -20,15 +20,7 @@
 #ifndef _DPT_H
 #define _DPT_H
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,00)
-#define MAX_TO_IOP_MESSAGES   (210)
-#else
 #define MAX_TO_IOP_MESSAGES   (255)
-#endif
 #define MAX_FROM_IOP_MESSAGES (255)
 
 
@@ -321,10 +313,6 @@
 static void adpt_delay(int millisec);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-static struct pci_dev* adpt_pci_find_device(uint vendor, struct
pci_dev* from);
-#endif
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si);
 #endif
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt/sys_info.h.old
2005-04-15 01:23:52.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt/sys_info.h
2005-04-15 01:24:13.000000000 +0200
@@ -146,10 +146,6 @@
    uSHORT       flags;                  /* See bit definitions above */
    uSHORT       conventionalMemSize;    /* in KB */
    uLONG        extendedMemSize;        /* in KB */
-   uLONG        osType;                 /* Same as DPTSIG's definition
*/
-   uCHAR        osMajorVersion;
-   uCHAR        osMinorVersion;         /* The OS version */
-   uCHAR        osRevision;
 #ifdef _SINIX_ADDON
    uCHAR        busType;                /* See defininitions above */
    uSHORT       osSubRevision;
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt_i2o.c.old
2005-04-15 01:21:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/dpt_i2o.c	2005-04-15
01:25:20.000000000 +0200
@@ -34,7 +34,6 @@
 
 #define ADDR32 (0)
 
-#include <linux/version.h>
 #include <linux/module.h>
 
 MODULE_AUTHOR("Deanna Bonds, with _lots_ of help from Mark Salyzyn");
@@ -1824,10 +1823,6 @@
 
 	memset(&si, 0, sizeof(si));
 
-	si.osType = OS_LINUX;
-	si.osMajorVersion = (u8) (LINUX_VERSION_CODE >> 16);
-	si.osMinorVersion = (u8) (LINUX_VERSION_CODE >> 8 & 0x0ff);
-	si.osRevision =     (u8) (LINUX_VERSION_CODE & 0x0ff);
 	si.busType = SI_PCI_BUS;
 	si.processorFamily = DPTI_sig.dsProcessorFamily;
 

