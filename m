Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267938AbTBVWbI>; Sat, 22 Feb 2003 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBVWbI>; Sat, 22 Feb 2003 17:31:08 -0500
Received: from [212.156.4.132] ([212.156.4.132]:27121 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267938AbTBVWbI>;
	Sat, 22 Feb 2003 17:31:08 -0500
Date: Sun, 23 Feb 2003 00:41:08 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/ali returns incomplete data [2/17]
Message-ID: <20030222224108.GA2996@ttnet.net.tr>
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

This patch fixes the incomplete data return problem of /proc/ide/ali.
When the number of consecutive read bytes are smaller than the total
data in ali_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/alim15x3.c	Tue Dec 24 07:20:01 2002
+++ linux-2.5.62/drivers/ide/pci/alim15x3.c	Sat Feb 22 23:17:15 2003
@@ -96,6 +96,7 @@
 {
 	u32 bibma;
 	u8 reg53h, reg5xh, reg5yh, reg5xh1, reg5yh1, c0, c1, rev, tmp;
+	int len;
 	char *q, *p = buffer;
 
 	/* fetch rev. */
@@ -270,7 +271,11 @@
 		udmaT[reg5yh & 0x07],
 		udmaT[(reg5yh & 0x70) >> 4] );
 
-	return p-buffer; /* => must be less than 4k! */
+	/* p - buffer must be less than 4k! */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
