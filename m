Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267942AbTBVWuA>; Sat, 22 Feb 2003 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTBVWuA>; Sat, 22 Feb 2003 17:50:00 -0500
Received: from [212.156.4.132] ([212.156.4.132]:38903 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267942AbTBVWt6>;
	Sat, 22 Feb 2003 17:49:58 -0500
Date: Sun, 23 Feb 2003 01:00:09 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/hpt34x returns incomplete data [6/17]
Message-ID: <20030222230009.GE2996@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/hpt34x.
When the number of consecutive read bytes are smaller than the total
data in hpt34x_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/hpt34x.c	Sat Feb 22 23:00:40 2003
+++ linux-2.5.62/drivers/ide/pci/hpt34x.c	Sat Feb 22 23:31:17 2003
@@ -58,7 +58,7 @@
 static int hpt34x_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
-	int i;
+	int i, len;
 
 	p += sprintf(p, "\n                             "
 			"HPT34X Chipset.\n");
@@ -96,7 +96,11 @@
 	}
 	p += sprintf(p, "\n");
 
-	return p-buffer;	/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */



