Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTBVXGJ>; Sat, 22 Feb 2003 18:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267960AbTBVXGJ>; Sat, 22 Feb 2003 18:06:09 -0500
Received: from [212.156.4.132] ([212.156.4.132]:37628 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267959AbTBVXGH>;
	Sat, 22 Feb 2003 18:06:07 -0500
Date: Sun, 23 Feb 2003 01:16:22 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/pdcadma returns incomplete data [10/17]
Message-ID: <20030222231622.GI2996@ttnet.net.tr>
Mail-Followup-To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the incomplete data return problem of /proc/ide/pdcadma.
When the number of consecutive read bytes are smaller than the total
data in pdcadma_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/pdcadma.c	Sun Feb 23 00:08:33 2003
+++ linux-2.5.62/drivers/ide/pci/pdcadma.c	Sat Feb 22 23:36:32 2003
@@ -39,7 +39,7 @@
 static int pdcadma_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	for (i = 0; i < n_pdc_devs; i++) {
 		struct pci_dev *dev	= pdc_devs[i];
@@ -51,7 +51,11 @@
 		p += sprintf(p, "PIO\n");
 
 	}
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS) */

