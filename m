Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbTBVXBF>; Sat, 22 Feb 2003 18:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbTBVXBF>; Sat, 22 Feb 2003 18:01:05 -0500
Received: from [212.156.4.132] ([212.156.4.132]:5627 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267951AbTBVXBD>;
	Sat, 22 Feb 2003 18:01:03 -0500
Date: Sun, 23 Feb 2003 01:11:19 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/pdc202xx returns incomplete data [9/17]
Message-ID: <20030222231119.GH2996@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/pdc202xx.
When the number of consecutive read bytes are smaller than the total
data in pdc202xx_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/pdc202xx_old.c	Sat Feb 22 23:00:52 2003
+++ linux-2.5.62/drivers/ide/pci/pdc202xx_old.c	Sat Feb 22 23:35:29 2003
@@ -177,13 +177,17 @@
 static int pdc202xx_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	for (i = 0; i < n_pdc202_devs; i++) {
 		struct pci_dev *dev	= pdc202_devs[i];
 		p = pdc202xx_info(buffer, dev);
 	}
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS) */

