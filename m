Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267941AbTBVWga>; Sat, 22 Feb 2003 17:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267942AbTBVWg3>; Sat, 22 Feb 2003 17:36:29 -0500
Received: from [212.156.4.132] ([212.156.4.132]:11507 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267941AbTBVWg2>;
	Sat, 22 Feb 2003 17:36:28 -0500
Date: Sun, 23 Feb 2003 00:46:42 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/amd74xx returns incomplete data [3/17]
Message-ID: <20030222224642.GB2996@ttnet.net.tr>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org
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

This patch fixes the incomplete data return problem of /proc/ide/amd74xx.
When the number of consecutive read bytes are smaller than the total
data in amd74xx_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/amd74xx.c	Sat Feb 22 23:01:04 2003
+++ linux-2.5.62/drivers/ide/pci/amd74xx.c	Sat Feb 22 23:19:56 2003
@@ -98,6 +98,7 @@
 	unsigned int v, u, i;
 	unsigned short c, w;
 	unsigned char t;
+	int len;
 	char *p = buffer;
 
 	amd_print("----------AMD BusMastering IDE Configuration----------------");
@@ -167,7 +168,11 @@
 	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
 	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
-	return p - buffer;	/* hoping it is less than 4K... */
+	/* hoping p - buffer is less than 4K... */
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 
 #endif



