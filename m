Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTBVXg3>; Sat, 22 Feb 2003 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267971AbTBVXg2>; Sat, 22 Feb 2003 18:36:28 -0500
Received: from [212.156.4.132] ([212.156.4.132]:13510 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267970AbTBVXg0>;
	Sat, 22 Feb 2003 18:36:26 -0500
Date: Sun, 23 Feb 2003 01:46:42 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/slc90e66 returns incomplete data [16/17]
Message-ID: <20030222234642.GO2996@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/slc90e66.
When the number of consecutive read bytes are smaller than the total
data in slc90e66_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/slc90e66.c	Sun Feb 23 01:42:21 2003
+++ linux-2.5.62/drivers/ide/pci/slc90e66.c	Sun Feb 23 01:42:49 2003
@@ -34,8 +34,9 @@
 static int slc90e66_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
+	int len;
 	unsigned long bibma = pci_resource_start(bmide_dev, 4);
-        u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
+	u16 reg40 = 0, psitre = 0, reg42 = 0, ssitre = 0;
 	u8  c0 = 0, c1 = 0;
 	u8  reg44 = 0, reg47 = 0, reg48 = 0, reg4a = 0, reg4b = 0;
 
@@ -110,7 +111,11 @@
  *	FIXME.... Add configuration junk data....blah blah......
  */
 
-	return p-buffer;	 /* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS) */
