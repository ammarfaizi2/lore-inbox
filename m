Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267963AbTBVXKw>; Sat, 22 Feb 2003 18:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbTBVXKw>; Sat, 22 Feb 2003 18:10:52 -0500
Received: from [212.156.4.132] ([212.156.4.132]:64253 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267963AbTBVXKu>;
	Sat, 22 Feb 2003 18:10:50 -0500
Date: Sun, 23 Feb 2003 01:20:50 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/piix returns incomplete data [11/17]
Message-ID: <20030222232050.GJ2996@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/piix.
When the number of consecutive read bytes are smaller than the total
data in piix_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/piix.c	Sat Feb 22 23:00:40 2003
+++ linux-2.5.62/drivers/ide/pci/piix.c	Sat Feb 22 23:37:19 2003
@@ -130,7 +130,7 @@
 static int piix_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	for (i = 0; i < n_piix_devs; i++) {
 		struct pci_dev *dev	= piix_devs[i];
@@ -256,7 +256,11 @@
 		 * FIXME.... Add configuration junk data....blah blah......
 		 */
 	}
-	return p-buffer;	 /* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS) */



