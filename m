Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279476AbRJZXVX>; Fri, 26 Oct 2001 19:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279505AbRJZXVI>; Fri, 26 Oct 2001 19:21:08 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:31409 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279476AbRJZXUx>; Fri, 26 Oct 2001 19:20:53 -0400
Message-Id: <m15xGHu-007qdHC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers
Date: Sat, 27 Oct 2001 01:14:24 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110251739440.1118-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110251739440.1118-100000@penguin.transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 26. Oktober 2001 02:41 schrieben Sie:
> I think
> 
>         if ((a = b))
> 
> looks nothing but stupid, while
> 
>         if ((a = b) != 0)
> 
> "explains" the parenthesis..

Agreed. Following patch is against kernel 2.4.14-pre2 and requires none
of my previous patches. What it does:

  * cures all remaining framebuffer and filesystem drivers (including
    shmfs, which lives in drivers/mm) from using strtok()

  * remedies all those warnings regarding the usage of assignments in
    comparisions I introduced earlier

  * contains a real bugfix! ;)

The bug was spotted by Roman Zippel (thanks!): in virgefb.c there is a
'}' missing. My first patch, which went into 2.4.13, did that.
hanks!).

I just hope it's not too big a patch. If so, at least apply the first
chunk (that bugfix), please.

René


diff -ruN linux-2.4.14-pre2/drivers/video/virgefb.c linux-2.4.14-pre2-rs/drivers/video/virgefb.c
--- linux-2.4.14-pre2/drivers/video/virgefb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/virgefb.c	Fri Oct 26 23:33:08 2001
@@ -1085,7 +1085,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
@@ -1099,6 +1101,7 @@
 		}
 		else
 			get_video_mode(this_opt);
+	}
 
 	DPRINTK("default mode: xres=%d, yres=%d, bpp=%d\n",virgefb_default.xres,
                                                            virgefb_default.yres,
diff -ruN linux-2.4.14-pre2/drivers/video/acornfb.c linux-2.4.14-pre2-rs/drivers/video/acornfb.c
--- linux-2.4.14-pre2/drivers/video/acornfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/acornfb.c	Fri Oct 26 23:26:34 2001
@@ -1528,7 +1528,7 @@
 
 	acornfb_init_fbinfo();
 
-	while (opt = strsep(&options, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
 		if (!*opt)
 			continue;
 
diff -ruN linux-2.4.14-pre2/drivers/video/amifb.c linux-2.4.14-pre2-rs/drivers/video/amifb.c
--- linux-2.4.14-pre2/drivers/video/amifb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/amifb.c	Fri Oct 26 23:26:34 2001
@@ -1192,7 +1192,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
diff -ruN linux-2.4.14-pre2/drivers/video/atafb.c linux-2.4.14-pre2-rs/drivers/video/atafb.c
--- linux-2.4.14-pre2/drivers/video/atafb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.14-pre2-rs/drivers/video/atafb.c	Fri Oct 26 23:26:34 2001
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -ruN linux-2.4.14-pre2/drivers/video/aty/atyfb_base.c linux-2.4.14-pre2-rs/drivers/video/aty/atyfb_base.c
--- linux-2.4.14-pre2/drivers/video/aty/atyfb_base.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/aty/atyfb_base.c	Fri Oct 26 23:26:34 2001
@@ -2521,7 +2521,9 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -ruN linux-2.4.14-pre2/drivers/video/aty128fb.c linux-2.4.14-pre2-rs/drivers/video/aty128fb.c
--- linux-2.4.14-pre2/drivers/video/aty128fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/aty128fb.c	Fri Oct 26 23:26:34 2001
@@ -1613,7 +1613,9 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+	    continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -ruN linux-2.4.14-pre2/drivers/video/clgenfb.c linux-2.4.14-pre2-rs/drivers/video/clgenfb.c
--- linux-2.4.14-pre2/drivers/video/clgenfb.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/drivers/video/clgenfb.c	Fri Oct 26 23:26:34 2001
@@ -2823,8 +2823,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -ruN linux-2.4.14-pre2/drivers/video/controlfb.c linux-2.4.14-pre2-rs/drivers/video/controlfb.c
--- linux-2.4.14-pre2/drivers/video/controlfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/controlfb.c	Fri Oct 26 23:26:34 2001
@@ -1423,7 +1423,7 @@
 	if (!options || !*options)
 		return;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.14-pre2/drivers/video/cyberfb.c linux-2.4.14-pre2-rs/drivers/video/cyberfb.c
--- linux-2.4.14-pre2/drivers/video/cyberfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/cyberfb.c	Fri Oct 26 23:26:34 2001
@@ -1022,7 +1022,9 @@
 		return 0;
 	}
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -ruN linux-2.4.14-pre2/drivers/video/fm2fb.c linux-2.4.14-pre2-rs/drivers/video/fm2fb.c
--- linux-2.4.14-pre2/drivers/video/fm2fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/fm2fb.c	Fri Oct 26 23:26:34 2001
@@ -430,7 +430,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!strncmp(this_opt, "pal", 3))
 	    fm2fb_mode = FM2FB_MODE_PAL;
 	else if (!strncmp(this_opt, "ntsc", 4))
diff -ruN linux-2.4.14-pre2/drivers/video/hgafb.c linux-2.4.14-pre2-rs/drivers/video/hgafb.c
--- linux-2.4.14-pre2/drivers/video/hgafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/hgafb.c	Fri Oct 26 23:26:34 2001
@@ -795,7 +795,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
diff -ruN linux-2.4.14-pre2/drivers/video/igafb.c linux-2.4.14-pre2-rs/drivers/video/igafb.c
--- linux-2.4.14-pre2/drivers/video/igafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/igafb.c	Fri Oct 26 23:26:34 2001
@@ -773,7 +773,7 @@
     if (!options || !*options)
         return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
         if (!strncmp(this_opt, "font:", 5)) {
                 char *p;
                 int i;
diff -ruN linux-2.4.14-pre2/drivers/video/imsttfb.c linux-2.4.14-pre2-rs/drivers/video/imsttfb.c
--- linux-2.4.14-pre2/drivers/video/imsttfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/imsttfb.c	Fri Oct 26 23:26:34 2001
@@ -1977,7 +1977,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.14-pre2/drivers/video/macfb.c linux-2.4.14-pre2-rs/drivers/video/macfb.c
--- linux-2.4.14-pre2/drivers/video/macfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/macfb.c	Fri Oct 26 23:26:34 2001
@@ -848,7 +848,7 @@
 	if (!options || !*options)
 		return;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ruN linux-2.4.14-pre2/drivers/video/matrox/matroxfb_base.c linux-2.4.14-pre2-rs/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.14-pre2/drivers/video/matrox/matroxfb_base.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/matrox/matroxfb_base.c	Fri Oct 26 23:26:34 2001
@@ -2355,7 +2355,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		dprintk("matroxfb_setup: option %s\n", this_opt);
diff -ruN linux-2.4.14-pre2/drivers/video/platinumfb.c linux-2.4.14-pre2-rs/drivers/video/platinumfb.c
--- linux-2.4.14-pre2/drivers/video/platinumfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/platinumfb.c	Fri Oct 26 23:26:34 2001
@@ -841,7 +841,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.14-pre2/drivers/video/radeonfb.c linux-2.4.14-pre2-rs/drivers/video/radeonfb.c
--- linux-2.4.14-pre2/drivers/video/radeonfb.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/drivers/video/radeonfb.c	Fri Oct 26 23:26:34 2001
@@ -642,7 +642,9 @@
         if (!options || !*options)
                 return 0;
  
-	while (this_opt = strsep (&options, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
                 if (!strncmp (this_opt, "font:", 5)) {
                         char *p;
                         int i;
diff -ruN linux-2.4.14-pre2/drivers/video/retz3fb.c linux-2.4.14-pre2-rs/drivers/video/retz3fb.c
--- linux-2.4.14-pre2/drivers/video/retz3fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/retz3fb.c	Fri Oct 26 23:26:34 2001
@@ -1348,7 +1348,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
diff -ruN linux-2.4.14-pre2/drivers/video/riva/fbdev.c linux-2.4.14-pre2-rs/drivers/video/riva/fbdev.c
--- linux-2.4.14-pre2/drivers/video/riva/fbdev.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/riva/fbdev.c	Fri Oct 26 23:26:34 2001
@@ -2045,7 +2045,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.14-pre2/drivers/video/sa1100fb.c linux-2.4.14-pre2-rs/drivers/video/sa1100fb.c
--- linux-2.4.14-pre2/drivers/video/sa1100fb.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/drivers/video/sa1100fb.c	Fri Oct 26 23:26:34 2001
@@ -2369,7 +2369,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 
 		if (!strncmp(this_opt, "bpp:", 4))
 			current_par.max_bpp =
diff -ruN linux-2.4.14-pre2/drivers/video/sgivwfb.c linux-2.4.14-pre2-rs/drivers/video/sgivwfb.c
--- linux-2.4.14-pre2/drivers/video/sgivwfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/sgivwfb.c	Fri Oct 26 23:26:34 2001
@@ -862,7 +862,7 @@
   if (!options || !*options)
     return 0;
 
-  while (this_opt = strsep(&options, ",")) {
+  while ((this_opt = strsep(&options, ",")) != NULL) {
     if (!strncmp(this_opt, "font:", 5))
       strcpy(fb_info.fontname, this_opt+5);
   }
diff -ruN linux-2.4.14-pre2/drivers/video/sis/sis_main.c linux-2.4.14-pre2-rs/drivers/video/sis/sis_main.c
--- linux-2.4.14-pre2/drivers/video/sis/sis_main.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/drivers/video/sis/sis_main.c	Fri Oct 26 23:26:34 2001
@@ -1725,7 +1725,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
 
diff -ruN linux-2.4.14-pre2/drivers/video/sstfb.c linux-2.4.14-pre2-rs/drivers/video/sstfb.c
--- linux-2.4.14-pre2/drivers/video/sstfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/sstfb.c	Fri Oct 26 23:26:34 2001
@@ -1697,7 +1697,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		f_ddprintk("option %s\n", this_opt);
diff -ruN linux-2.4.14-pre2/drivers/video/tdfxfb.c linux-2.4.14-pre2-rs/drivers/video/tdfxfb.c
--- linux-2.4.14-pre2/drivers/video/tdfxfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/tdfxfb.c	Fri Oct 26 23:26:34 2001
@@ -2086,7 +2086,9 @@
   if(!options || !*options)
     return;
 
-  while(this_opt = strsep(&options, ",")) {
+  while((this_opt = strsep(&options, ",")) != NULL) {
+    if(!*this_opt)
+      continue;
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
       fb_invert_cmaps();
diff -ruN linux-2.4.14-pre2/drivers/video/tgafb.c linux-2.4.14-pre2-rs/drivers/video/tgafb.c
--- linux-2.4.14-pre2/drivers/video/tgafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/tgafb.c	Fri Oct 26 23:26:34 2001
@@ -889,7 +889,7 @@
     int i;
     
     if (options && *options) {
-    	while (this_opt = strsep(&options, ",")) {
+    	while ((this_opt = strsep(&options, ",")) != NULL) {
        	    if (!*this_opt) { continue; }
         
 	    if (!strncmp(this_opt, "font:", 5)) {
diff -ruN linux-2.4.14-pre2/drivers/video/valkyriefb.c linux-2.4.14-pre2-rs/drivers/video/valkyriefb.c
--- linux-2.4.14-pre2/drivers/video/valkyriefb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/valkyriefb.c	Fri Oct 26 23:26:34 2001
@@ -801,7 +801,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.14-pre2/drivers/video/vesafb.c linux-2.4.14-pre2-rs/drivers/video/vesafb.c
--- linux-2.4.14-pre2/drivers/video/vesafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/vesafb.c	Fri Oct 26 23:26:34 2001
@@ -457,7 +457,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ruN linux-2.4.14-pre2/drivers/video/vfb.c linux-2.4.14-pre2-rs/drivers/video/vfb.c
--- linux-2.4.14-pre2/drivers/video/vfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/vfb.c	Fri Oct 26 23:26:34 2001
@@ -382,7 +382,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!strncmp(this_opt, "font:", 5))
 	    strcpy(fb_info.fontname, this_opt+5);
     }
diff -ruN linux-2.4.14-pre2/drivers/video/vga16fb.c linux-2.4.14-pre2-rs/drivers/video/vga16fb.c
--- linux-2.4.14-pre2/drivers/video/vga16fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/vga16fb.c	Fri Oct 26 23:26:34 2001
@@ -692,7 +692,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (!strncmp(this_opt, "font:", 5))
diff -ruN linux-2.4.14-pre2/fs/adfs/super.c linux-2.4.14-pre2-rs/fs/adfs/super.c
--- linux-2.4.14-pre2/fs/adfs/super.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/fs/adfs/super.c	Fri Oct 26 23:26:34 2001
@@ -171,7 +171,9 @@
 	if (!options)
 		return 0;
 
-	for (opt = strtok(options, ","); opt != NULL; opt = strtok(NULL, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
 		value = strchr(opt, '=');
 		if (value)
 			*value++ = '\0';
diff -ruN linux-2.4.14-pre2/fs/affs/super.c linux-2.4.14-pre2-rs/fs/affs/super.c
--- linux-2.4.14-pre2/fs/affs/super.c	Tue Sep 11 17:19:35 2001
+++ linux-2.4.14-pre2-rs/fs/affs/super.c	Fri Oct 26 23:26:34 2001
@@ -109,7 +109,9 @@
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		f = 0;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
diff -ruN linux-2.4.14-pre2/fs/autofs/inode.c linux-2.4.14-pre2-rs/fs/autofs/inode.c
--- linux-2.4.14-pre2/fs/autofs/inode.c	Thu Jun 14 23:16:58 2001
+++ linux-2.4.14-pre2-rs/fs/autofs/inode.c	Fri Oct 26 23:26:34 2001
@@ -60,7 +60,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ruN linux-2.4.14-pre2/fs/autofs4/inode.c linux-2.4.14-pre2-rs/fs/autofs4/inode.c
--- linux-2.4.14-pre2/fs/autofs4/inode.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.14-pre2-rs/fs/autofs4/inode.c	Fri Oct 26 23:26:34 2001
@@ -112,7 +112,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ruN linux-2.4.14-pre2/fs/devpts/inode.c linux-2.4.14-pre2-rs/fs/devpts/inode.c
--- linux-2.4.14-pre2/fs/devpts/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.14-pre2-rs/fs/devpts/inode.c	Fri Oct 26 23:26:34 2001
@@ -66,10 +66,11 @@
 	umode_t mode = 0600;
 	char *this_char, *value;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	if (!options)
+		goto default_settings;
+	while (( this_char = strsep(&options,",") ) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
@@ -98,6 +99,7 @@
 		else
 			return 1;
 	}
+default_settings:
 	sbi->setuid  = setuid;
 	sbi->setgid  = setgid;
 	sbi->uid     = uid;
diff -ruN linux-2.4.14-pre2/fs/ext2/super.c linux-2.4.14-pre2-rs/fs/ext2/super.c
--- linux-2.4.14-pre2/fs/ext2/super.c	Thu Oct  4 07:57:36 2001
+++ linux-2.4.14-pre2-rs/fs/ext2/super.c	Fri Oct 26 23:26:34 2001
@@ -166,9 +166,9 @@
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
+	while ((this_char = strsep (&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "bsddf"))
diff -ruN linux-2.4.14-pre2/fs/fat/inode.c linux-2.4.14-pre2-rs/fs/fat/inode.c
--- linux-2.4.14-pre2/fs/fat/inode.c	Fri Oct 26 23:07:22 2001
+++ linux-2.4.14-pre2-rs/fs/fat/inode.c	Fri Oct 26 23:26:34 2001
@@ -210,7 +210,7 @@
 			 char *cvf_format, char *cvf_options)
 {
 	char *this_char,*value,save,*savep;
-	char *p;
+	char *p,*options_p = options;
 	int ret = 1, len;
 
 	opts->name_check = 'n';
@@ -230,8 +230,7 @@
 		goto out;
 	save = 0;
 	savep = NULL;
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options_p, ",")) != NULL) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.14-pre2/fs/hfs/super.c linux-2.4.14-pre2-rs/fs/hfs/super.c
--- linux-2.4.14-pre2/fs/hfs/super.c	Wed Apr 18 08:16:39 2001
+++ linux-2.4.14-pre2-rs/fs/hfs/super.c	Fri Oct 26 23:26:34 2001
@@ -181,8 +181,9 @@
 	if (!options) {
 		goto done;
 	}
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		}
diff -ruN linux-2.4.14-pre2/fs/hpfs/super.c linux-2.4.14-pre2-rs/fs/hpfs/super.c
--- linux-2.4.14-pre2/fs/hpfs/super.c	Tue Jun 12 04:15:27 2001
+++ linux-2.4.14-pre2-rs/fs/hpfs/super.c	Fri Oct 26 23:26:34 2001
@@ -176,7 +176,9 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
+	while ((p = strsep(&opts, ",")) != NULL) {
+		if (!*p)
+			continue;
 		if ((rhs = strchr(p, '=')) != 0)
 			*rhs++ = '\0';
 		if (!strcmp(p, "help")) return 2;
diff -ruN linux-2.4.14-pre2/fs/isofs/inode.c linux-2.4.14-pre2-rs/fs/isofs/inode.c
--- linux-2.4.14-pre2/fs/isofs/inode.c	Fri Oct 26 23:25:26 2001
+++ linux-2.4.14-pre2-rs/fs/isofs/inode.c	Fri Oct 26 23:26:34 2001
@@ -294,7 +294,9 @@
 	popt->session=-1;
 	popt->sbsector=-1;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 	        if (strncmp(this_char,"norock",6) == 0) {
 		  popt->rock = 'n';
 		  continue;
diff -ruN linux-2.4.14-pre2/fs/nfs/nfsroot.c linux-2.4.14-pre2-rs/fs/nfs/nfsroot.c
--- linux-2.4.14-pre2/fs/nfs/nfsroot.c	Fri Jul 20 06:47:16 2001
+++ linux-2.4.14-pre2-rs/fs/nfs/nfsroot.c	Fri Oct 26 23:26:34 2001
@@ -202,8 +202,9 @@
 
 	if ((options = strchr(name, ','))) {
 		*options++ = 0;
-		cp = strtok(options, ",");
-		while (cp) {
+		while ((cp = strsep(&options, ",")) != NULL) {
+			if (!*cp)
+				continue;
 			if ((val = strchr(cp, '='))) {
 				struct nfs_int_opts *opts = root_int_opts;
 				*val++ = '\0';
@@ -220,7 +221,6 @@
 					nfs_data.flags |= opts->or_mask;
 				}
 			}
-			cp = strtok(NULL, ",");
 		}
 	}
 	if (name[0] && strcmp(name, "default")) {
diff -ruN linux-2.4.14-pre2/fs/ntfs/fs.c linux-2.4.14-pre2-rs/fs/ntfs/fs.c
--- linux-2.4.14-pre2/fs/ntfs/fs.c	Fri Oct 26 23:07:22 2001
+++ linux-2.4.14-pre2-rs/fs/ntfs/fs.c	Fri Oct 26 23:26:34 2001
@@ -365,10 +365,13 @@
 	int use_utf8 = -1;	/* If no NLS specified and loading the default
 				   NLS failed use utf8. */
 	int mft_zone_mul = -1;	/* 1 */
+	char *options = opt;
 
 	if (!opt)
 		goto done;
-	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
 		if ((value = strchr(opt, '=')) != NULL)
 			*value ++= '\0';
 		if (strcmp(opt, "uid") == 0) {
diff -ruN linux-2.4.14-pre2/fs/proc/inode.c linux-2.4.14-pre2-rs/fs/proc/inode.c
--- linux-2.4.14-pre2/fs/proc/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.14-pre2-rs/fs/proc/inode.c	Fri Oct 26 23:26:34 2001
@@ -106,7 +106,9 @@
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
diff -ruN linux-2.4.14-pre2/fs/reiserfs/super.c linux-2.4.14-pre2-rs/fs/reiserfs/super.c
--- linux-2.4.14-pre2/fs/reiserfs/super.c	Fri Oct 26 23:07:22 2001
+++ linux-2.4.14-pre2-rs/fs/reiserfs/super.c	Fri Oct 26 23:26:34 2001
@@ -144,7 +144,9 @@
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    for (this_char = strtok (options, ","); this_char != NULL; this_char = strtok (NULL, ",")) {
+    while ((this_char = strsep (&options, ",")) != NULL) {
+	if (!*this_char)
+	    continue;
 	if ((value = strchr (this_char, '=')) != NULL)
 	    *value++ = 0;
 	if (!strcmp (this_char, "notail")) {
diff -ruN linux-2.4.14-pre2/fs/udf/super.c linux-2.4.14-pre2-rs/fs/udf/super.c
--- linux-2.4.14-pre2/fs/udf/super.c	Fri Oct 26 23:07:23 2001
+++ linux-2.4.14-pre2-rs/fs/udf/super.c	Fri Oct 26 23:26:34 2001
@@ -218,8 +218,10 @@
 	if (!options)
 		return 1;
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ","))
+	while ((opt = strsep(&options, ",")) != NULL)
 	{
+		if (!*opt)
+			continue;
 		/* Make "opt=val" into two strings */
 		val = strchr(opt, '=');
 		if (val)
diff -ruN linux-2.4.14-pre2/fs/ufs/super.c linux-2.4.14-pre2-rs/fs/ufs/super.c
--- linux-2.4.14-pre2/fs/ufs/super.c	Wed May 16 19:31:27 2001
+++ linux-2.4.14-pre2-rs/fs/ufs/super.c	Fri Oct 26 23:26:34 2001
@@ -257,10 +257,9 @@
 	if (!options)
 		return 1;
 		
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
-	     
+	while ((this_char = strsep (&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
diff -ruN linux-2.4.14-pre2/fs/vfat/namei.c linux-2.4.14-pre2-rs/fs/vfat/namei.c
--- linux-2.4.14-pre2/fs/vfat/namei.c	Fri Oct 26 23:07:23 2001
+++ linux-2.4.14-pre2-rs/fs/vfat/namei.c	Fri Oct 26 23:26:34 2001
@@ -104,6 +104,7 @@
 {
 	char *this_char,*value,save,*savep;
 	int ret, val;
+	char *options_p = options;
 
 	opts->unicode_xlate = opts->posixfs = 0;
 	opts->numtail = 1;
@@ -120,7 +121,7 @@
 	save = 0;
 	savep = NULL;
 	ret = 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options_p, ",")) != NULL) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.14-pre2/mm/shmem.c linux-2.4.14-pre2-rs/mm/shmem.c
--- linux-2.4.14-pre2/mm/shmem.c	Fri Oct 26 23:25:28 2001
+++ linux-2.4.14-pre2-rs/mm/shmem.c	Fri Oct 26 23:26:34 2001
@@ -1230,10 +1230,11 @@
 {
 	char *this_char, *value, *rest;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	if (!options)
+		return 0;
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		} else {
