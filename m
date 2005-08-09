Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVHIQGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVHIQGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVHIQGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:06:23 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:47272 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964845AbVHIQGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:06:23 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc5] rewrite drivers/scsi/cpqfcTScontrol.c::CpqTsGetSFQEntry
Date: Tue, 9 Aug 2005 18:06:43 +0200
User-Agent: KMail/1.8.1
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200508051202.07091@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508051202.07091@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091806.45341@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies on top of my previous one that removed the whitespace
bloat.

This patch now fixes the type horror in CpqTsGetSFQEntry():
-the destination buffer is now void* instead of ULONG*
-the offset is now done by a int (former ULONG) variable and not
 adding bytes to the pointer address
-the last argument is not int, not boolean
-the second argument is compared to ULONG but is USHORT. And one (of two)
 callers passes a ULONG casted to USHORT. Use ULONG instead.
-remove some of the comments
-don't use argument names in functions forward declaration: they don't match
 the actual names anyway

While I'm at it, I fixed the coding style of this function. The rest of the
file is is still horror, but this no excuse for not fixing this function.

This shrinks the file by another 500 bytes and should not make any difference
in function.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- 2.6.13-rc6/drivers/scsi/cpqfcTScontrol.c	2005-08-09 17:39:49.000000000 +0200
+++ b/drivers/scsi/cpqfcTScontrol.c	2005-08-09 17:49:41.000000000 +0200
@@ -52,8 +52,7 @@
 //#define IMQ_DEBUG 1
 
 static void fcParseLinkStatusCounters(TACHYON * fcChip);
-static void CpqTsGetSFQEntry(TACHYON * fcChip,
-	      USHORT pi, ULONG * buffr, BOOLEAN UpdateChip);
+static void CpqTsGetSFQEntry(TACHYON *, ULONG, void*, int);
 
 static void
 cpqfc_free_dma_consistent(CPQFCHBA *cpqfcHBAdata)
@@ -562,12 +561,11 @@ static int PeekIMQEntry( PTACHYON fcChip
           TachFCHDR_GCMND* fchs;
 #error This is too much stack
           ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC Frame
-	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] & 0x0fffL);
+	  ULONG SFQpi = (fcChip->IMQ->QEntry[CI].word[0] & 0x0fffL);
 
 	  CpqTsGetSFQEntry( fcChip,
             SFQpi,        // SFQ producer ndx
-	    ulFibreFrame, // contiguous dest. buffer
-	    FALSE);       // DON'T update chip--this is a "lookahead"
+		ulFibreFrame, 0);	// DON'T update chip--this is a "lookahead"
 
 	  fchs = (TachFCHDR_GCMND*)&ulFibreFrame;
           if( fchs->pl[0] == ELS_LILP_FRAME)
@@ -875,8 +873,8 @@ int CpqTsProcessIMQEntry(void *host)
           // clears SFQ entry from Tachyon buffer; copies to contiguous ulBuff
       CpqTsGetSFQEntry(
         fcChip,                  // i.e. this Device Object
-        (USHORT)fcChip->SFQ->producerIndex,  // SFQ producer ndx
-        ulFibreFrame, TRUE);    // contiguous destination buffer, update chip
+		fcChip->SFQ->producerIndex,  // SFQ producer ndx
+		ulFibreFrame, 1);    // contiguous destination buffer, update chip
 
         // analyze the incoming frame outside the INT handler...
         // (i.e., Worker)
@@ -1739,57 +1737,54 @@ int CpqTsDestroyTachLiteQues( void *pHBA
   return iStatus;     // non-zero (failed) if any memory not freed
 }
 
-// The SFQ is an array with SFQ_LEN length, each element (QEntry)
-// with eight 32-bit words.  TachLite places incoming FC frames (i.e.
-// a valid FC frame with our AL_PA ) in contiguous SFQ entries
-// and sends a completion message telling the host where the frame is
-// in the que.
-// This function copies the current (or oldest not-yet-processed) QEntry to
-// a caller's contiguous buffer and updates the Tachyon chip's consumer index
-//
-// NOTE:
-//   An FC frame may consume one or many SFQ entries.  We know the total
-//   length from the completion message.  The caller passes a buffer large
-//   enough for the complete message (max 2k).
-
-static void CpqTsGetSFQEntry(
-         PTACHYON fcChip,
-         USHORT producerNdx,
-         ULONG *ulDestPtr,            // contiguous destination buffer
-	 BOOLEAN UpdateChip)
+/**
+ * CpqTsGetSFQEntry
+ * @dest: contiguous destination buffer
+ *
+ *The SFQ is an array with SFQ_LEN length, each element (QEntry)
+ * with eight 32-bit words.  TachLite places incoming FC frames (i.e.
+ * a valid FC frame with our AL_PA ) in contiguous SFQ entries
+ * and sends a completion message telling the host where the frame is
+ * in the queue.
+ * This function copies the current (or oldest not-yet-processed) QEntry to
+ * a caller's contiguous buffer and updates the Tachyon chip's consumer index
+ *
+ * NOTE:
+ *   An FC frame may consume one or many SFQ entries.  We know the total
+ *   length from the completion message.  The caller passes a buffer large
+ *   enough for the complete message (max 2k).
+ */
+static void
+CpqTsGetSFQEntry(PTACHYON fcChip, ULONG producerNdx, void *ulDestPtr,
+	int UpdateChip)
 {
-  ULONG total_bytes=0;
-  ULONG consumerIndex = fcChip->SFQ->consumerIndex;
-
-				// check passed copy of SFQ producer index -
-				// is a new message waiting for us?
-				// equal indexes means SFS is copied
+	int total_bytes = 0;
+	ULONG consumerIndex = fcChip->SFQ->consumerIndex;
 
-  while( producerNdx != consumerIndex )
-  {                             // need to process message
-    total_bytes += 64;   // maintain count to prevent writing past buffer
-                   // don't allow copies over Fibre Channel defined length!
-    if( total_bytes <= 2048 )
-    {
-      memcpy(ulDestPtr,
-              &fcChip->SFQ->QEntry[consumerIndex],
-              64 );  // each SFQ entry is 64 bytes
-      ulDestPtr += 16;   // advance pointer to next 64 byte block
-    }
-		         // Tachyon is producing,
-                         // and we are consuming
-
-    if( ++consumerIndex >= SFQ_LEN)// check for rollover
-      consumerIndex = 0L;        // reset it
-  }
+	/* check passed copy of SFQ producer index -
+	 * is a new message waiting for us?
+	 * equal indexes means SFS is copied */
+
+	while (producerNdx != consumerIndex) {
+		/* need to process message */
+		if(total_bytes < 2048) {
+			memcpy(ulDestPtr + total_bytes,
+				&fcChip->SFQ->QEntry[consumerIndex], 64);
+		}
+		/* each SFQ entry is 64 bytes */
+		total_bytes += 64;
+
+		/* check for rollover */
+		if(++consumerIndex >= SFQ_LEN)
+			consumerIndex = 0;
+	}
 
-  // if specified, update the Tachlite chip ConsumerIndex...
-  if( UpdateChip )
-  {
-    fcChip->SFQ->consumerIndex = consumerIndex;
-    writel( fcChip->SFQ->consumerIndex,
-      fcChip->Registers.SFQconsumerIndex.address);
-  }
+	/* if specified, update the Tachlite chip ConsumerIndex */
+	if(UpdateChip) {
+		fcChip->SFQ->consumerIndex = consumerIndex;
+		writel(fcChip->SFQ->consumerIndex,
+			fcChip->Registers.SFQconsumerIndex.address);
+	}
 }
 
 // TachLite routinely freezes it's core ques - Outbound FIFO, Inbound FIFO,
