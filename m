Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSG1VBZ>; Sun, 28 Jul 2002 17:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSG1VBY>; Sun, 28 Jul 2002 17:01:24 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56825 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S317327AbSG1VBX>;
	Sun, 28 Jul 2002 17:01:23 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB91E7056D8@fmsmsx38.fm.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: text screen corruption - bug in console vga code
Date: Sun, 28 Jul 2002 14:04:39 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed text mode console screen corruption on some architecture.
The symptom was on a text console, when edit a large file with vi, pressing
"down" arrow key to scroll would cause the corruption.

It turns out that the culprit was the kernel console vga code where scrup()
is illegally using mempcy() function when src/dest memory areas overlaps.
This bug showed up when we optimized memcpy to use advanced optimization
technique.  

This patch make use of memmove() which handles overlapping areas gracefully.
Would the maintainer please push this into the base?


--- drivers/char/console.c.orig	Wed Jul 24 14:47:20 2002
+++ drivers/char/console.c	Wed Jul 24 14:47:55 2002
@@ -259,7 +259,7 @@
 		return;
 	d = (unsigned short *) (origin+video_size_row*t);
 	s = (unsigned short *) (origin+video_size_row*(t+nr));
-	scr_memcpyw(d, s, (b-t-nr) * video_size_row);
+	scr_memmovew(d, s, (b-t-nr) * video_size_row);
 	scr_memsetw(d + (b-t-nr) * video_num_columns, video_erase_char,
video_size_row*nr);
 }

