Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbREEOkJ>; Sat, 5 May 2001 10:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbREEOkA>; Sat, 5 May 2001 10:40:00 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:27227 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132567AbREEOj4>; Sat, 5 May 2001 10:39:56 -0400
Message-ID: <3AF410B3.6B2E7E1B@chello.nl>
Date: Sat, 05 May 2001 16:39:47 +0200
From: Segher Boessenkool <segher@chello.nl>
X-Mailer: Mozilla 4.75C-CCK-MCD {C-UDP; EBM-APPLE} (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: little patches for fbmem.c and offb.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fbmem.c bug made "less /proc/fb" segfault, as it made read()
returned more
bytes than were requested.

The offb.c bug caused /proc/fb output to be incorrect, and potentially
could cause kernel data structure corruption.

Enjoy,

Segher


--->SNIP HERE<---
diff -ur linux-2.2.19/drivers/video/fbmem.c linux-2.2.19-patched/drivers/video/fbmem.c
--- linux-2.2.19/drivers/video/fbmem.c	Sat May  5 15:41:06 2001
+++ linux-2.2.19-patched/drivers/video/fbmem.c	Sat May  5 15:41:06 2001
@@ -251,14 +251,16 @@
 {
 	struct fb_info **fi;
 
-	len = 0;
+	int buflen = 0;
 	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
 		if (*fi)
-			len += sprintf(buf + len, "%d %s\n",
+			buflen += sprintf(buf + buflen, "%d %s\n",
 				       GET_FB_IDX((*fi)->node),
 				       (*fi)->modename);
 	*start = buf + offset;
-	return len > offset ? len - offset : 0;
+
+	buflen = buflen > offset ? buflen - offset : 0;
+	return len < buflen ? len : buflen;
 }
 
 static ssize_t
diff -ur linux-2.2.19/drivers/video/offb.c linux-2.2.19-patched/drivers/video/offb.c
--- linux-2.2.19/drivers/video/offb.c	Sat May  5 16:17:28 2001
+++ linux-2.2.19-patched/drivers/video/offb.c	Sat May  5 16:07:41 2001
@@ -733,7 +733,7 @@
     disp->scrollmode = SCROLL_YREDRAW;
 
     strcpy(info->info.modename, "OFfb ");
-    strncat(info->info.modename, full_name, sizeof(info->info.modename));
+    strncat(info->info.modename, full_name, sizeof(info->info.modename)
- 6);
     info->info.node = -1;
     info->info.fbops = &offb_ops;
     info->info.disp = disp;
--->SNIP HERE<---
