Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279637AbRJXXNJ>; Wed, 24 Oct 2001 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279636AbRJXXNA>; Wed, 24 Oct 2001 19:13:00 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:52623 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279634AbRJXXMz>; Wed, 24 Oct 2001 19:12:55 -0400
Message-Id: <m15wXDA-007qbNC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] strtok --> strsep in framebuffer drivers (part 2)
Date: Thu, 25 Oct 2001 01:22:27 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just noticed two framebuffer drivers with strtok calls that somehow
passed below my radar (cscope). Patch below converts them, too. And it
re-adds "ignore empty tokens" functionalty, which I forgot about the
last time. Please apply.

René 



diff -Nur ../linux-2.4.13-pre6/drivers/video/amifb.c ./drivers/video/amifb.c
--- ../linux-2.4.13-pre6/drivers/video/amifb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/amifb.c	Tue Oct 23 23:04:03 2001
@@ -1193,6 +1193,8 @@
 		return 0;
 
 	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur ../linux-2.4.13-pre6/drivers/video/atafb.c ./drivers/video/atafb.c
--- ../linux-2.4.13-pre6/drivers/video/atafb.c	Fri Sep 14 01:04:43 2001
+++ ./drivers/video/atafb.c	Tue Oct 23 23:00:59 2001
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -Nur ../linux-2.4.13-pre6/drivers/video/aty/atyfb_base.c ./drivers/video/aty/atyfb_base.c
--- ../linux-2.4.13-pre6/drivers/video/aty/atyfb_base.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/aty/atyfb_base.c	Tue Oct 23 23:05:24 2001
@@ -2522,6 +2522,8 @@
 	return 0;
 
     while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -Nur ../linux-2.4.13-pre6/drivers/video/aty128fb.c ./drivers/video/aty128fb.c
--- ../linux-2.4.13-pre6/drivers/video/aty128fb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/aty128fb.c	Tue Oct 23 23:06:17 2001
@@ -1614,6 +1614,8 @@
 	return 0;
 
     while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+	    continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -Nur ../linux-2.4.13-pre6/drivers/video/clgenfb.c ./drivers/video/clgenfb.c
--- ../linux-2.4.13-pre6/drivers/video/clgenfb.c	Wed Oct 10 00:13:02 2001
+++ ./drivers/video/clgenfb.c	Tue Oct 23 22:59:38 2001
@@ -2817,8 +2817,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while (this_opt = strsep (&options, ",")) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -Nur ../linux-2.4.13-pre6/drivers/video/cyberfb.c ./drivers/video/cyberfb.c
--- ../linux-2.4.13-pre6/drivers/video/cyberfb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/cyberfb.c	Tue Oct 23 23:07:42 2001
@@ -1023,6 +1023,8 @@
 	}
 
 	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur ../linux-2.4.13-pre6/drivers/video/radeonfb.c ./drivers/video/radeonfb.c
--- ../linux-2.4.13-pre6/drivers/video/radeonfb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/radeonfb.c	Tue Oct 23 23:09:58 2001
@@ -538,6 +538,8 @@
                 return 0;
  
 	while (this_opt = strsep (&options, ",")) {
+		if (!*this_opt)
+			continue;
                 if (!strncmp (this_opt, "font:", 5)) {
                         char *p;
                         int i;
diff -Nur ../linux-2.4.13-pre6/drivers/video/retz3fb.c ./drivers/video/retz3fb.c
--- ../linux-2.4.13-pre6/drivers/video/retz3fb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/retz3fb.c	Tue Oct 23 23:30:56 2001
@@ -1349,6 +1349,8 @@
 		return 0;
 
 	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c ./drivers/video/riva/fbdev.c
--- ../linux-2.4.13-pre6/drivers/video/riva/fbdev.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/riva/fbdev.c	Tue Oct 23 23:31:33 2001
@@ -2046,6 +2046,8 @@
 		return 0;
 
 	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur ../linux-2.4.13-pre6/drivers/video/tdfxfb.c ./drivers/video/tdfxfb.c
--- ../linux-2.4.13-pre6/drivers/video/tdfxfb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/tdfxfb.c	Tue Oct 23 23:32:35 2001
@@ -2087,6 +2087,8 @@
     return;
 
   while(this_opt = strsep(&options, ",")) {
+    if(!*this_opt)
+      continue;
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
       fb_invert_cmaps();
diff -Nur ../linux-2.4.13-pre6/drivers/video/virgefb.c ./drivers/video/virgefb.c
--- ../linux-2.4.13-pre6/drivers/video/virgefb.c	Tue Oct 23 22:13:43 2001
+++ ./drivers/video/virgefb.c	Tue Oct 23 23:33:40 2001
@@ -1086,6 +1086,8 @@
 		return 0;
 
 	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
