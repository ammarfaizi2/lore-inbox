Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVHPJOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVHPJOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVHPJOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:14:08 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:34502 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965157AbVHPJOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:14:02 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] remove superfluos ioctls from cpqfcTS
Date: Tue, 16 Aug 2005 11:14:38 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161112.47120@bilbo.math.uni-mannheim.de> <200508161113.45940@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161113.45940@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161114.39675@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ioctls to get PCI information and driver version. These information 
can be found via lspci or dmesg. Also remove two typedefs already commented 
out.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/scsi/cpqfcTSioctl.h	2005-08-07 20:18:56.000000000 +0200
+++ b/drivers/scsi/cpqfcTSioctl.h	2005-08-14 16:39:04.000000000 +0200
@@ -4,47 +4,6 @@
 
 #define CCPQFCTS_IOC_MAGIC 'Z'
 
-typedef struct 
-{
-  __u8 bus;
-  __u8 dev_fn;
-  __u32 board_id;
-} cpqfc_pci_info_struct;
-
-typedef __u32 DriverVer_type;
-/*
-typedef union
-{
-  struct  // Peripheral Unit Device
-  { 
-    __u8 Bus:6;
-    __u8 Mode:2;  // b00
-    __u8 Dev;
-  } PeripDev;
-  struct  // Volume Set Address
-  { 
-    __u8 DevMSB:6;
-    __u8 Mode:2;  // b01
-    __u8 DevLSB;
-  } LogDev;
-  struct  // Logical Unit Device (SCSI-3, SCC-2 defined)
-  { 
-    __u8 Targ:6;
-    __u8 Mode:2;  // b10
-    __u8 Dev:5;
-    __u8 Bus:3;
-
-  } LogUnit;
-} SCSI3Addr_struct;
-
-
-typedef struct
-{
-  SCSI3Addr_struct FCP_Nexus;
-  __u8 cdb[16];
-} PassThru_Command_struct;
-*/
-
 /* this is nearly duplicated in idashare.h */
 typedef struct {
   int	lc;    		/* Controller number */
@@ -73,9 +32,6 @@
 #define VENDOR_READ_OPCODE			0x26
 #define VENDOR_WRITE_OPCODE			0x27
 
-#define CPQFCTS_GETPCIINFO _IOR( CCPQFCTS_IOC_MAGIC, 1, cpqfc_pci_info_struct)
-#define CPQFCTS_GETDRIVVER _IOR( CCPQFCTS_IOC_MAGIC, 9, DriverVer_type)
-
 #define CPQFCTS_SCSI_PASSTHRU _IOWR( CCPQFCTS_IOC_MAGIC,11, VENDOR_IOCTL_REQ)
 
 /* We would rather have equivalent generic, low-level driver agnostic 
@@ -91,4 +47,3 @@
 /* Used to invoke Target Defice Reset for Fibre Channel */
 // #define CPQFC_IOCTL_FC_TDR 0x5388
 #define CPQFC_IOCTL_FC_TDR _IO( CCPQFCTS_IOC_MAGIC, 15)
-
--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 15:05:57.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 16:13:17.000000000 +0200
@@ -659,40 +659,6 @@ int cpqfcTS_ioctl( struct scsi_device *S
         return result;
       }
 
-      case CPQFCTS_GETPCIINFO:
-      {
-	cpqfc_pci_info_struct pciinfo;
-	
-	if( !arg)
-	  return -EINVAL;
-
-         	
-	
-        pciinfo.bus = cpqfcHBAdata->PciDev->bus->number;
-        pciinfo.dev_fn = cpqfcHBAdata->PciDev->devfn;
-	pciinfo.board_id = cpqfcHBAdata->PciDev->device |
-			  (cpqfcHBAdata->PciDev->vendor <<16);
-	
-        if(copy_to_user( arg, &pciinfo, sizeof(cpqfc_pci_info_struct)))
-		return( -EFAULT);
-        return 0;
-      }
-
-      case CPQFCTS_GETDRIVVER:
-      {
-	DriverVer_type DriverVer =
-		CPQFCTS_DRIVER_VER( VER_MAJOR,VER_MINOR,VER_SUBMINOR);
-	
-	if( !arg)
-	  return -EINVAL;
-
-        if(copy_to_user( arg, &DriverVer, sizeof(DriverVer)))
-		return( -EFAULT);
-        return 0;
-      }
-
-
-
       case CPQFC_IOCTL_FC_TARGET_ADDRESS:
 	// can we find an FC device mapping to this SCSI target?
 /* 	DumCmnd.channel = ScsiDev->channel; */		// For searching
