Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267952AbTBVX3h>; Sat, 22 Feb 2003 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbTBVX3g>; Sat, 22 Feb 2003 18:29:36 -0500
Received: from [212.156.4.132] ([212.156.4.132]:5828 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267952AbTBVX3g>;
	Sat, 22 Feb 2003 18:29:36 -0500
Date: Sun, 23 Feb 2003 01:39:51 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: Lionel.Bouton@inet6.fr
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.62: /proc/ide/sis returns incomplete data [15/17]
Message-ID: <20030222233951.GN2996@ttnet.net.tr>
Mail-Followup-To: Lionel.Bouton@inet6.fr,
	linux-kernel@vger.kernel.org
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

This patch fixes the incomplete data return problem of /proc/ide/sis.
When the number of consecutive read bytes are smaller than the total
data in sis_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/sis5513.c	Sun Feb 23 01:38:02 2003
+++ linux-2.5.62/drivers/ide/pci/sis5513.c	Sun Feb 23 01:36:58 2003
@@ -396,6 +396,7 @@
 static int sis_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
+	int len;
 	u8 reg;
 	u16 reg2, reg3;
 
@@ -466,7 +467,10 @@
 	p = get_masters_info(p);
 	p = get_slaves_info(p);
 
-	return p-buffer;
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	
+	return len > count ? count : len;
 }
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
