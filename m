Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTBVWWq>; Sat, 22 Feb 2003 17:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267938AbTBVWWq>; Sat, 22 Feb 2003 17:22:46 -0500
Received: from [212.156.4.132] ([212.156.4.132]:22766 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267935AbTBVWWp>;
	Sat, 22 Feb 2003 17:22:45 -0500
Date: Sun, 23 Feb 2003 00:32:49 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/aec62xx returns incomplete data [1/17]
Message-ID: <20030222223249.GA2912@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/aec62xx.
When the number of consecutive read bytes are smaller than the total
data in aec62xx_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/aec62xx.c	Sat Feb 22 23:00:40 2003
+++ linux-2.5.62/drivers/ide/pci/aec62xx.c	Sat Feb 22 23:08:36 2003
@@ -38,6 +38,7 @@
 	char *chipset_nums[] = {"error", "error", "error", "error",
 				"error", "error", "850UF",   "860",
 				 "860R",   "865",  "865R", "error"  };
+	int len;
 	int i;
 
 	for (i = 0; i < n_aec_devs; i++) {
@@ -170,7 +171,11 @@
 #endif /* DEBUG_AEC_REGS */
 		}
 	}
-	return p-buffer;/* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif	/* defined(DISPLAY_AEC62xx_TIMINGS) && defined(CONFIG_PROC_FS) */



