Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQL1I3m>; Thu, 28 Dec 2000 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQL1I3c>; Thu, 28 Dec 2000 03:29:32 -0500
Received: from smtp2.free.fr ([212.27.32.6]:47121 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S129391AbQL1I3T>;
	Thu, 28 Dec 2000 03:29:19 -0500
To: alan@lxorguk.ukuu.org.uk
Subject: [patch] megaraid in 2.2.18 : correctly identify NetRaid cards
Message-ID: <977990332.3a4af2bc18914@imp.free.fr>
Date: Thu, 28 Dec 2000 08:58:52 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 195.6.58.78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

As previously discussed, I've slighlty arranged the version identification
code in the 2.2.18 megaraid driver so that it correcly sees bios and firmware
versions on a netraid. Without the patch, I only get smileys and hieroglyphs
because the version is interpreted as a string which it is not, on the netraid.

On the netraid I have here, the fourth byte in the version is always 0x20, which
I used to identify the version coding because on a megaraid, I have a number
here instead. I'd like people who also have a netraid to test if this is enough
to catch their bios and firmware releases too.

Here comes the small patch. Please note that I extended the version length to
8 bytes to conform to the syntax the bios uses : letter.2digits.2digits
The old undefined code under #ifdef HP has been removed since it was buggy
anyway (char >> 8 always gives 0 ...)

Regards,
Willy

--- linux/drivers/scsi/megaraid.h-orig	Wed Dec 27 16:08:26 2000
+++ linux/drivers/scsi/megaraid.h	Wed Dec 27 16:08:00 2000
@@ -639,8 +639,8 @@
     u32 nWriteBlocks[FC_MAX_LOGICAL_DRIVES];
     u32 nInterrupts;
     /* Host adapter parameters */
-    u8 fwVer[7];
-    u8 biosVer[7];
+    u8 fwVer[8];
+    u8 biosVer[8];
 
     struct Scsi_Host *host;
 
--- linux/drivers/scsi/megaraid.c-orig	Wed Dec 27 13:22:27 2000
+++ linux/drivers/scsi/megaraid.c	Wed Dec 27 16:02:27 2000
@@ -1767,27 +1767,25 @@
   if (megaCfg->host->can_queue >= MAX_COMMANDS) {
     megaCfg->host->can_queue = MAX_COMMANDS-1;
   }
+  if ((megaCfg->productInfo.FwVer[3] == 0x20) &&
+      (megaCfg->productInfo.BiosVer[3] == 0x20)) {
+	/* use HP firmware and bios version encoding */
+	  sprintf (megaCfg->fwVer, "%c.%02x.%02x",
+		   megaCfg->productInfo.FwVer[2],
+		   megaCfg->productInfo.FwVer[1],
+		   megaCfg->productInfo.FwVer[0]);
+	  sprintf (megaCfg->biosVer, "%c.%02x.%02x",
+		   megaCfg->productInfo.BiosVer[2],
+		   megaCfg->productInfo.BiosVer[1],
+		   megaCfg->productInfo.BiosVer[0]);
+  }
+  else {
+	  memcpy (megaCfg->fwVer, (char *)megaCfg->productInfo.FwVer, 4);
+	  megaCfg->fwVer[4] = 0;
 
-#ifdef HP			/* use HP firmware and bios version encoding */
-  sprintf (megaCfg->fwVer, "%c%d%d.%d%d",
-	   megaCfg->productInfo.FwVer[2],
-	   megaCfg->productInfo.FwVer[1] >> 8,
-	   megaCfg->productInfo.FwVer[1] & 0x0f,
-	   megaCfg->productInfo.FwVer[2] >> 8,
-	   megaCfg->productInfo.FwVer[2] & 0x0f);
-  sprintf (megaCfg->biosVer, "%c%d%d.%d%d",
-	   megaCfg->productInfo.BiosVer[2],
-	   megaCfg->productInfo.BiosVer[1] >> 8,
-	   megaCfg->productInfo.BiosVer[1] & 0x0f,
-	   megaCfg->productInfo.BiosVer[2] >> 8,
-	   megaCfg->productInfo.BiosVer[2] & 0x0f);
-#else
-  memcpy (megaCfg->fwVer, (char *)megaCfg->productInfo.FwVer, 4);
-  megaCfg->fwVer[4] = 0;
-
-  memcpy (megaCfg->biosVer, (char *)megaCfg->productInfo.BiosVer, 4);
-  megaCfg->biosVer[4] = 0;
-#endif
+	  memcpy (megaCfg->biosVer, (char *)megaCfg->productInfo.BiosVer, 4);
+	  megaCfg->biosVer[4] = 0;
+  }
 
   printk ("megaraid: [%s:%s] detected %d logical drives" CRLFSTR,
           megaCfg->fwVer,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
