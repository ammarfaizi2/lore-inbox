Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVHDEkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVHDEkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVHDEkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:40:20 -0400
Received: from bgerelbas01.asiapac.hp.net ([15.219.201.134]:55276 "EHLO
	bgerelbas01.ind.hp.com") by vger.kernel.org with ESMTP
	id S261705AbVHDEkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:40:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Date: Thu, 4 Aug 2005 10:09:51 +0530
Message-ID: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Thread-Index: AcWYro19sSsj2BDZR/uaCFJyiI2V5g==
From: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 04 Aug 2005 04:39:52.0660 (UTC) FILETIME=[8E275140:01C598AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 of 2

This patch fixes the "#error this is too much stack" in 2.6 kernel.
Using kmalloc to allocate memory to ulFibreFrame.

Please consider this for inclusion

Signed-off-by: Ramanamurthy Saripalli <saripalli@hp.com>

 cpqfcTScontrol.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)
------------------------------------------------------------------------
-------
diff -burpN old/drivers/scsi/cpqfcTScontrol.c
new/drivers/scsi/cpqfcTScontrol.c
--- old/drivers/scsi/cpqfcTScontrol.c	2005-07-12 22:52:29.000000000
+0530
+++ new/drivers/scsi/cpqfcTScontrol.c	2005-07-18 22:19:54.229947176
+0530
@@ -606,22 +606,25 @@ static int PeekIMQEntry( PTACHYON fcChip
         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
         { 
           TachFCHDR_GCMND* fchs;
-#error This is too much stack
-          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC
Frame
+          ULONG *ulFibreFrame;  // max DWORDS in incoming FC Frame
 	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] &
0x0fffL);
 
+	  ulFibreFrame = kmalloc((2048/4), GFP_KERNEL);
+	
 	  CpqTsGetSFQEntry( fcChip,
             SFQpi,        // SFQ producer ndx         
 	    ulFibreFrame, // contiguous dest. buffer
 	    FALSE);       // DON'T update chip--this is a "lookahead"
           
-	  fchs = (TachFCHDR_GCMND*)&ulFibreFrame;
+	  fchs = (TachFCHDR_GCMND*)ulFibreFrame;
           if( fchs->pl[0] == ELS_LILP_FRAME)
 	  {
+	    kfree(ulFibreFrame);	
             return 1; // found the LILP frame!
 	  }
 	  else
 	  {
+	    kfree(ulFibreFrame);	
 	    // keep looking...
 	  }
 	}  
@@ -718,12 +721,12 @@ int CpqTsProcessIMQEntry(void *host)
   ULONG x_ID;
   ULONG ulBuff, dwStatus;
   TachFCHDR_GCMND* fchs;
-#error This is too much stack
-  ULONG ulFibreFrame[2048/4];  // max number of DWORDS in incoming
Fibre Frame
+  ULONG *ulFibreFrame;  // max number of DWORDS in incoming Fibre Frame
   UCHAR ucInboundMessageType;  // Inbound CM, dword 3 "type" field
 
   ENTER("ProcessIMQEntry");
    
+  ulFibreFrame = kmalloc((2048/4), GFP_KERNEL); 	 
 
 				// check TachLite's IMQ producer index -
 				// is a new message waiting for us?
@@ -1627,6 +1630,7 @@ int CpqTsProcessIMQEntry(void *host)
 
   LEAVE("ProcessIMQEntry");
   
+  kfree(ulFibreFrame);	 
   return iStatus;
 }
 
