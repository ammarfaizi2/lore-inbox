Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTBTVpv>; Thu, 20 Feb 2003 16:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTBTVpk>; Thu, 20 Feb 2003 16:45:40 -0500
Received: from [212.156.4.130] ([212.156.4.130]:50634 "EHLO fep01.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267013AbTBTVp3>;
	Thu, 20 Feb 2003 16:45:29 -0500
Date: Thu, 20 Feb 2003 23:55:19 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, janekh@cvotech.com
Subject: [PATCH] 2.5.62: /proc/ide/via reads return incomplete data, Bug #374
Message-ID: <20030220215519.GA1181@ttnet.net.tr>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org,
	janekh@cvotech.com
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


This patch fixes the incomplete data return problem of /proc/ide/via and 
addresses Bug #374 of Bugzilla.

When the number of consecutive read bytes are smaller than the total data 
in via_get_info(), the second read() returns 0.

--- linux-2.5.62-vanilla/drivers/ide/pci/via82cxxx.c    Thu Feb 20 18:51:52 2003
+++ linux-2.5.62/drivers/ide/pci/via82cxxx.c    Thu Feb 20 23:09:23 2003
@@ -145,6 +145,7 @@
                 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
        struct pci_dev *dev = bmide_dev;
        unsigned int v, u, i;
+       int len;
        u16 c, w;
        u8 t, x;
        char *p = buffer;
@@ -274,7 +275,10 @@
                speed[i] / 1000, speed[i] / 100 % 10);

        /* hoping it is less than 4K... */
-       return p - buffer;
+       len = (p - buffer) - offset;
+       *addr = buffer + offset;
+
+       return len > count ? count : len;
 }

 #endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */

