Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVHKR5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVHKR5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVHKR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:57:49 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:62355 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932323AbVHKR5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:57:48 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA [PATCH]
Date: Thu, 11 Aug 2005 19:58:42 +0200
User-Agent: KMail/1.8.2
References: <42FB72DE.8000703@aub.nl>
In-Reply-To: <42FB72DE.8000703@aub.nl>
Cc: Bolke de Bruin <bdbruin@aub.nl>, Arjan van de Ven <arjan@infradead.org>,
       linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111958.43067@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bolke de Bruin wrote:

>So the basic question is. Does this controller work on kernel 2.6.5?

Don't think about it. This thing is a mess. I tried to remove the #errors 
(which was rather simple) and replace them by kmalloc(). Of course then 
someone should care about ENOMEM case. One function had no problem at all, the 
huge buffer can be avoided at all. The other one is called from an interrupt 
handler. This thing tries to handle the complete packet transfer in the 
interrupt. Don't use it. It will blow up.

If someone has some spare time this interrupt handler has to be split up. Here 
is a diff of what I've done so far. To apply this one you will have to use my 
two patches sent in the last days first, the subject lines are

[PATCH 2.6.13-rc5] reduce whitespace bloat in drivers/scsi/cpqfcTScontrol.c
[PATCH 2.6.13-rc5] rewrite drivers/scsi/cpqfcTScontrol.c::CpqTsGetSFQEntry

This patch also kills cpqfcTS_reset() function which is never referenced to.
It causes a compile error by using SCSI_RESET_ERROR, which is undefined (now?).

Eike

--- a/drivers/scsi/cpqfcTScontrol.c	2005-08-11 19:04:26.000000000 +0200
+++ b/drivers/scsi/cpqfcTScontrol.c	2005-08-11 19:28:05.000000000 +0200
@@ -556,27 +556,21 @@ static int PeekIMQEntry( PTACHYON fcChip
       // first, we need to find an Inbound Completion message,
       // If we find it, check the incoming frame payload (1st word)
       // for LILP frame
-        if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
-        {
-          TachFCHDR_GCMND* fchs;
-#error This is too much stack
-          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC Frame
-	  ULONG SFQpi = fcChip->IMQ->QEntry[CI].word[0] & 0x0fffL;
-
-	  CpqTsGetSFQEntry( fcChip,
-            SFQpi,        // SFQ producer ndx
-		ulFibreFrame, 0);	// DON'T update chip--this is a "lookahead"
+		if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 ) {
+			TachFCHDR_GCMND *fchs;
 
-	  fchs = (TachFCHDR_GCMND*)&ulFibreFrame;
-          if( fchs->pl[0] == ELS_LILP_FRAME)
-	  {
-            return 1; // found the LILP frame!
-	  }
-	  else
-	  {
-	    // keep looking...
-	  }
-	}
+			/* Reference to the first chunk of this struct in QEntry
+			 * buffer. We can only rely on the first 64 bytes of
+			 * data because consumerIndex may have a wraparound.
+			 * This is no problem, we only want to see the first
+			 * double word of payload, which is within this range.
+			 */
+			fchs = (TachFCHDR_GCMND*) &fcChip->SFQ->QEntry[fcChip->SFQ->consumerIndex];
+
+			if(fchs->pl[0] == ELS_LILP_FRAME) {
+				return 1;
+			}
+		}
       }
       break;
 
@@ -665,8 +659,7 @@ int CpqTsProcessIMQEntry(void *host)
   ULONG x_ID;
   ULONG ulBuff, dwStatus;
   TachFCHDR_GCMND* fchs;
-#error This is too much stack
-  ULONG ulFibreFrame[2048/4];  // max number of DWORDS in incoming Fibre Frame
+  void *ulFibreFrame = kmalloc(2048, GFP_KERNEL); /* max number of DWORDS in incoming Fibre Frame */
   UCHAR ucInboundMessageType;  // Inbound CM, dword 3 "type" field
 
   ENTER("ProcessIMQEntry");
@@ -675,6 +668,9 @@ int CpqTsProcessIMQEntry(void *host)
 				// is a new message waiting for us?
 				// equal indexes means empty que
 
+  if (!ulFibreFrame)
+	return -ENOMEM;
+
   if( fcChip->IMQ->producerIndex != fcChip->IMQ->consumerIndex )
   {                             // need to process message
 
@@ -881,7 +877,7 @@ int CpqTsProcessIMQEntry(void *host)
 
       if( ucInboundMessageType == 1 )
       {
-        fchs = (TachFCHDR_GCMND*)ulFibreFrame; // cast to examine IB frame
+        fchs = ulFibreFrame; // cast to examine IB frame
         // don't fill up our Q with garbage - only accept FCP-CMND
         // or XRDY frames
         if( (fchs->d_id & 0xFF000000) == 0x06000000 ) // CMND
@@ -1432,7 +1428,7 @@ int CpqTsProcessIMQEntry(void *host)
             // to analyze data transfer (successful?), then send a response
             // frame for this exchange
 
-          ulFibreFrame[0] = x_ID; // copy for later reference
+		*((ULONG*) ulFibreFrame) = x_ID; // copy for later reference
 
           // if this was a TWE, we have to send satus response
           if( Exchanges->fcExchange[ x_ID].type == SCSI_TWE )
@@ -1500,6 +1496,7 @@ int CpqTsProcessIMQEntry(void *host)
 
   LEAVE("ProcessIMQEntry");
 
+  kfree(ulFibreFrame);
   return iStatus;
 }
 
--- a/drivers/scsi/cpqfcTSstructs.h	2005-08-11 19:30:55.000000000 +0200
+++ b/drivers/scsi/cpqfcTSstructs.h	2005-08-11 19:31:31.000000000 +0200
@@ -813,7 +813,6 @@ typedef struct
   void (*UnFreezeTachyon)(void*, int );
   int (*InitializeTachyon)(void*, int, int );
   int (*InitializeFrameManager)(void*, int );
-  int (*ProcessIMQEntry)(void*);
   int (*ReadWriteWWN)(void*, int ReadWrite);
   int (*ReadWriteNVRAM)(void*, void*, int ReadWrite);
 
--- a/drivers/scsi/cpqfcTSinit.c	2005-08-11 19:29:22.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-11 19:46:07.000000000 +0200
@@ -215,7 +215,6 @@ static void Cpqfc_initHBAdata(CPQFCHBA *
   cpqfcHBAdata->fcChip.DestroyTachyonQues = CpqTsDestroyTachLiteQues;
   cpqfcHBAdata->fcChip.InitializeTachyon = CpqTsInitializeTachLite;  
   cpqfcHBAdata->fcChip.LaserControl = CpqTsLaserControl;  
-  cpqfcHBAdata->fcChip.ProcessIMQEntry = CpqTsProcessIMQEntry;
   cpqfcHBAdata->fcChip.InitializeFrameManager = CpqTsInitializeFrameManager;
   cpqfcHBAdata->fcChip.ReadWriteWWN = CpqTsReadWriteWWN;
   cpqfcHBAdata->fcChip.ReadWriteNVRAM = CpqTsReadWriteNVRAM;
@@ -1693,16 +1692,6 @@ int cpqfcTS_eh_device_reset(Scsi_Cmnd *C
   return retval;
 }
 
-	
-int cpqfcTS_reset(Scsi_Cmnd *Cmnd, unsigned int reset_flags)
-{
-
-  ENTER("cpqfcTS_reset");
-
-  LEAVE("cpqfcTS_reset");
-  return SCSI_RESET_ERROR;      /* Bus Reset Not supported */
-}
-
 /* This function determines the bios parameters for a given
    harddisk. These tend to be numbers that are made up by the
    host adapter.  Parameters:
@@ -1763,6 +1752,7 @@ irqreturn_t cpqfcTS_intr_handler( int ir
     {
       while( (++InfLoopBrk < INFINITE_IMQ_BREAK) && (MoreMessages ==1) ) 
       {
+#error handle CpqTsProcessIMQEntry returning -ENOMEM
         MoreMessages = CpqTsProcessIMQEntry( HostAdapter); // ret 0 when done
       }
       if( InfLoopBrk >= INFINITE_IMQ_BREAK )
