Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136516AbREAS7F>; Tue, 1 May 2001 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136520AbREAS66>; Tue, 1 May 2001 14:58:58 -0400
Received: from smtp01.web.de ([194.45.170.210]:8457 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S136516AbREAS6n>;
	Tue, 1 May 2001 14:58:43 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rene Scharfe <l.s.r@web.de>
Reply-To: l.s.r@web.de
To: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] strtok -> strsep (The Easy Cases)
Date: Tue, 1 May 2001 20:58:06 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01050120580701.01713@golmepha>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the patch at the bottom does the bulk job of strtok replacement. It's a
very boring patch, containing easy cases, only. It became a bit big, too,
but I trust you can digest it nevertheless. It's made against kernel
version 2.4.4.

What is the benefit of getting rid of strtok? It is for cutting strings
into pieces and it's used in argument parsing code of most file
systems and framebuffers. The problem is: strtok is not reentrant and its
manpage tells you to stop using it. There is a replacement function:
strsep. strsep has the added benefit of returning empty tokens, too. We
don't need strtok, it's a bug - do you need any more reasons for replacing
it? In the longer run I want the kernel to be completely cleaned from
strtok - expect more patches to come.

Please apply this patch to the official version of the kernel.


René




diff -ur linux-2.4.4/arch/m68k/atari/config.c linux-2.4.4-rs/arch/m68k/atari/config.c
--- linux-2.4.4/arch/m68k/atari/config.c	Tue Nov 28 02:57:34 2000
+++ linux-2.4.4-rs/arch/m68k/atari/config.c	Tue May  1 17:03:46 2001
@@ -206,13 +206,15 @@
     char *p;
     int ovsc_shift;
 
-    /* copy string to local array, strtok works destructively... */
+    /* copy string to local array, strsep works destructively... */
     strncpy( switches, str, len );
     switches[len] = 0;
     atari_switches = 0;
 
     /* parse the options */
-    for( p = strtok( switches, "," ); p; p = strtok( NULL, "," ) ) {
+    while( p = strsep( &switches, "," ) ) {
+	if (!*p)
+		continue;
 	ovsc_shift = 0;
 	if (strncmp( p, "ov_", 3 ) == 0) {
 	    p += 3;
diff -ur linux-2.4.4/drivers/scsi/ibmmca.c linux-2.4.4-rs/drivers/scsi/ibmmca.c
--- linux-2.4.4/drivers/scsi/ibmmca.c	Sat Mar  3 03:38:38 2001
+++ linux-2.4.4-rs/drivers/scsi/ibmmca.c	Tue May  1 17:48:14 2001
@@ -1406,9 +1406,9 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
       j = 0;
-      while (token) {
+      while (token = strsep(&str,",")) {
+	 if (!*token) continue;
 	 if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
 	 if (!strcmp(token,"display")) display_mode |= LED_DISP;
 	 if (!strcmp(token,"adisplay")) display_mode |= LED_ADISP;
@@ -1424,7 +1424,6 @@
 	      scsi_id[id_base++] = simple_strtoul(token,NULL,0);
 	    j++;
 	 }
-	 token = strtok(NULL,",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {
diff -ur linux-2.4.4/drivers/video/acornfb.c linux-2.4.4-rs/drivers/video/acornfb.c
--- linux-2.4.4/drivers/video/acornfb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/acornfb.c	Tue May  1 17:03:46 2001
@@ -1527,7 +1527,7 @@
 
 	acornfb_init_fbinfo();
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ",")) {
+	while (opt = strsep(&options, ",")) {
 		if (!*opt)
 			continue;
 
diff -ur linux-2.4.4/drivers/video/amifb.c linux-2.4.4-rs/drivers/video/amifb.c
--- linux-2.4.4/drivers/video/amifb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/amifb.c	Tue May  1 17:03:46 2001
@@ -1195,7 +1195,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.4/drivers/video/atafb.c linux-2.4.4-rs/drivers/video/atafb.c
--- linux-2.4.4/drivers/video/atafb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/atafb.c	Tue May  1 17:03:46 2001
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -ur linux-2.4.4/drivers/video/aty128fb.c linux-2.4.4-rs/drivers/video/aty128fb.c
--- linux-2.4.4/drivers/video/aty128fb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/aty128fb.c	Tue May  1 17:03:46 2001
@@ -1614,8 +1614,9 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -ur linux-2.4.4/drivers/video/atyfb.c linux-2.4.4-rs/drivers/video/atyfb.c
--- linux-2.4.4/drivers/video/atyfb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/atyfb.c	Tue May  1 17:03:46 2001
@@ -4062,8 +4062,9 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -ur linux-2.4.4/drivers/video/clgenfb.c linux-2.4.4-rs/drivers/video/clgenfb.c
--- linux-2.4.4/drivers/video/clgenfb.c	Wed Mar  7 04:28:33 2001
+++ linux-2.4.4-rs/drivers/video/clgenfb.c	Tue May  1 17:03:46 2001
@@ -2814,8 +2814,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while (this_opt = strsep (&options, ",")) {
 		if (!*this_opt) continue;
 		
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -ur linux-2.4.4/drivers/video/controlfb.c linux-2.4.4-rs/drivers/video/controlfb.c
--- linux-2.4.4/drivers/video/controlfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/controlfb.c	Tue May  1 17:03:46 2001
@@ -1211,8 +1211,9 @@
 	if (!options || !*options)
 		return;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.4/drivers/video/cyberfb.c linux-2.4.4-rs/drivers/video/cyberfb.c
--- linux-2.4.4/drivers/video/cyberfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/cyberfb.c	Tue May  1 17:03:46 2001
@@ -1022,8 +1022,9 @@
 		return 0;
 	}
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.4/drivers/video/fm2fb.c linux-2.4.4-rs/drivers/video/fm2fb.c
--- linux-2.4.4/drivers/video/fm2fb.c	Tue Nov  7 19:59:43 2000
+++ linux-2.4.4-rs/drivers/video/fm2fb.c	Tue May  1 17:03:46 2001
@@ -430,8 +430,9 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "pal", 3))
 	    fm2fb_mode = FM2FB_MODE_PAL;
 	else if (!strncmp(this_opt, "ntsc", 4))
diff -ur linux-2.4.4/drivers/video/hgafb.c linux-2.4.4-rs/drivers/video/hgafb.c
--- linux-2.4.4/drivers/video/hgafb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/hgafb.c	Tue May  1 17:03:46 2001
@@ -794,8 +794,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-			this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
diff -ur linux-2.4.4/drivers/video/igafb.c linux-2.4.4-rs/drivers/video/igafb.c
--- linux-2.4.4/drivers/video/igafb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/igafb.c	Tue May  1 17:03:46 2001
@@ -773,8 +773,9 @@
     if (!options || !*options)
         return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-         this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+		continue;
         if (!strncmp(this_opt, "font:", 5)) {
                 char *p;
                 int i;
diff -ur linux-2.4.4/drivers/video/imsttfb.c linux-2.4.4-rs/drivers/video/imsttfb.c
--- linux-2.4.4/drivers/video/imsttfb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/imsttfb.c	Tue May  1 17:03:46 2001
@@ -1947,8 +1947,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.4/drivers/video/macfb.c linux-2.4.4-rs/drivers/video/macfb.c
--- linux-2.4.4/drivers/video/macfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/macfb.c	Tue May  1 17:03:46 2001
@@ -848,7 +848,7 @@
 	if (!options || !*options)
 		return;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt=strsep(&options,",")) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ur linux-2.4.4/drivers/video/matrox/matroxfb_base.c linux-2.4.4-rs/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.4/drivers/video/matrox/matroxfb_base.c	Sun Feb  4 19:05:30 2001
+++ linux-2.4.4-rs/drivers/video/matrox/matroxfb_base.c	Tue May  1 17:03:46 2001
@@ -2348,7 +2348,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 
 		dprintk("matroxfb_setup: option %s\n", this_opt);
diff -ur linux-2.4.4/drivers/video/platinumfb.c linux-2.4.4-rs/drivers/video/platinumfb.c
--- linux-2.4.4/drivers/video/platinumfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/platinumfb.c	Tue May  1 17:03:46 2001
@@ -841,8 +841,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.4/drivers/video/retz3fb.c linux-2.4.4-rs/drivers/video/retz3fb.c
--- linux-2.4.4/drivers/video/retz3fb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/retz3fb.c	Tue May  1 17:03:46 2001
@@ -1348,8 +1348,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")){
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.4/drivers/video/riva/fbdev.c linux-2.4.4-rs/drivers/video/riva/fbdev.c
--- linux-2.4.4/drivers/video/riva/fbdev.c	Tue Feb 13 22:15:05 2001
+++ linux-2.4.4-rs/drivers/video/riva/fbdev.c	Tue May  1 17:03:46 2001
@@ -2041,8 +2041,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.4/drivers/video/sa1100fb.c linux-2.4.4-rs/drivers/video/sa1100fb.c
--- linux-2.4.4/drivers/video/sa1100fb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/sa1100fb.c	Tue May  1 17:03:46 2001
@@ -1282,8 +1282,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+	  if (!*this_opt)
+	    continue;
 
 	  if (!strncmp(this_opt, "bpp:", 4))
  	    current_par.max_bpp = simple_strtoul(this_opt+4, NULL, 0);
diff -ur linux-2.4.4/drivers/video/sgivwfb.c linux-2.4.4-rs/drivers/video/sgivwfb.c
--- linux-2.4.4/drivers/video/sgivwfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/sgivwfb.c	Tue May  1 17:03:46 2001
@@ -862,8 +862,9 @@
   if (!options || !*options)
     return 0;
 
-  for (this_opt = strtok(options, ","); this_opt;
-       this_opt = strtok(NULL, ",")) {
+  while (this_opt = strsep(&options, ",")) {
+    if (!*this_opt)
+      continue;
     if (!strncmp(this_opt, "font:", 5))
       strcpy(fb_info.fontname, this_opt+5);
   }
diff -ur linux-2.4.4/drivers/video/sis/sis_main.c linux-2.4.4-rs/drivers/video/sis/sis_main.c
--- linux-2.4.4/drivers/video/sis/sis_main.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/sis/sis_main.c	Tue May  1 17:03:46 2001
@@ -1725,8 +1725,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt)
 			continue;
 
diff -ur linux-2.4.4/drivers/video/tdfxfb.c linux-2.4.4-rs/drivers/video/tdfxfb.c
--- linux-2.4.4/drivers/video/tdfxfb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/tdfxfb.c	Tue May  1 17:03:46 2001
@@ -2061,9 +2061,9 @@
   if(!options || !*options)
     return;
 
-  for(this_opt = strtok(options, ","); 
-      this_opt;
-      this_opt = strtok(NULL, ",")) {
+  while (this_opt = strsep(&options, ",")) {
+    if (!*this_opt)
+      continue;
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
       fb_invert_cmaps();
diff -ur linux-2.4.4/drivers/video/tgafb.c linux-2.4.4-rs/drivers/video/tgafb.c
--- linux-2.4.4/drivers/video/tgafb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/tgafb.c	Tue May  1 17:03:46 2001
@@ -888,7 +888,7 @@
     int i;
     
     if (options && *options) {
-    	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
        	    if (!*this_opt) { continue; }
         
 	    if (!strncmp(this_opt, "font:", 5)) {
diff -ur linux-2.4.4/drivers/video/valkyriefb.c linux-2.4.4-rs/drivers/video/valkyriefb.c
--- linux-2.4.4/drivers/video/valkyriefb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/valkyriefb.c	Tue May  1 17:25:31 2001
@@ -801,8 +801,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.4/drivers/video/vesafb.c linux-2.4.4-rs/drivers/video/vesafb.c
--- linux-2.4.4/drivers/video/vesafb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/vesafb.c	Tue May  1 17:03:46 2001
@@ -457,7 +457,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ur linux-2.4.4/drivers/video/vfb.c linux-2.4.4-rs/drivers/video/vfb.c
--- linux-2.4.4/drivers/video/vfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/vfb.c	Tue May  1 17:03:46 2001
@@ -382,8 +382,9 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
+	if (!*this_opt)
+	    continue;
 	if (!strncmp(this_opt, "font:", 5))
 	    strcpy(fb_info.fontname, this_opt+5);
     }
diff -ur linux-2.4.4/drivers/video/vga16fb.c linux-2.4.4-rs/drivers/video/vga16fb.c
--- linux-2.4.4/drivers/video/vga16fb.c	Sat Apr 28 12:23:20 2001
+++ linux-2.4.4-rs/drivers/video/vga16fb.c	Tue May  1 17:03:46 2001
@@ -692,7 +692,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 		
 		if (!strncmp(this_opt, "font:", 5))
diff -ur linux-2.4.4/drivers/video/virgefb.c linux-2.4.4-rs/drivers/video/virgefb.c
--- linux-2.4.4/drivers/video/virgefb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.4-rs/drivers/video/virgefb.c	Tue May  1 17:03:46 2001
@@ -1085,7 +1085,9 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL, ","))
+	while (this_opt = strsep(&options, ",")) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.4/fs/adfs/super.c linux-2.4.4-rs/fs/adfs/super.c
--- linux-2.4.4/fs/adfs/super.c	Sat Apr 28 12:23:21 2001
+++ linux-2.4.4-rs/fs/adfs/super.c	Tue May  1 17:03:46 2001
@@ -171,7 +171,9 @@
 	if (!options)
 		return 0;
 
-	for (opt = strtok(options, ","); opt != NULL; opt = strtok(NULL, ",")) {
+	while (opt = strsep(&options, ",")) {
+		if (!*opt)
+			continue;
 		value = strchr(opt, '=');
 		if (value)
 			*value++ = '\0';
diff -ur linux-2.4.4/fs/affs/super.c linux-2.4.4-rs/fs/affs/super.c
--- linux-2.4.4/fs/affs/super.c	Sat Apr 28 12:23:22 2001
+++ linux-2.4.4-rs/fs/affs/super.c	Tue May  1 17:03:46 2001
@@ -109,7 +109,9 @@
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		f = 0;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
diff -ur linux-2.4.4/fs/autofs/inode.c linux-2.4.4-rs/fs/autofs/inode.c
--- linux-2.4.4/fs/autofs/inode.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-rs/fs/autofs/inode.c	Tue May  1 17:03:46 2001
@@ -60,7 +60,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ur linux-2.4.4/fs/autofs4/inode.c linux-2.4.4-rs/fs/autofs4/inode.c
--- linux-2.4.4/fs/autofs4/inode.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-rs/fs/autofs4/inode.c	Tue May  1 17:03:46 2001
@@ -112,7 +112,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ur linux-2.4.4/fs/ext2/super.c linux-2.4.4-rs/fs/ext2/super.c
--- linux-2.4.4/fs/ext2/super.c	Sat Apr 28 12:23:23 2001
+++ linux-2.4.4-rs/fs/ext2/super.c	Tue May  1 17:03:46 2001
@@ -169,9 +169,9 @@
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
+	while (this_char = strsep(&options, ",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "bsddf"))
diff -ur linux-2.4.4/fs/hfs/super.c linux-2.4.4-rs/fs/hfs/super.c
--- linux-2.4.4/fs/hfs/super.c	Sat Apr 28 12:23:23 2001
+++ linux-2.4.4-rs/fs/hfs/super.c	Tue May  1 17:03:46 2001
@@ -181,8 +181,9 @@
 	if (!options) {
 		goto done;
 	}
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		}
diff -ur linux-2.4.4/fs/hpfs/super.c linux-2.4.4-rs/fs/hpfs/super.c
--- linux-2.4.4/fs/hpfs/super.c	Sat Apr 28 12:23:23 2001
+++ linux-2.4.4-rs/fs/hpfs/super.c	Tue May  1 17:03:46 2001
@@ -176,7 +176,9 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
+	while (p = strsep(&opts, ",")) {
+		if (!*p)
+			continue;
 		if ((rhs = strchr(p, '=')) != 0)
 			*rhs++ = '\0';
 		if (!strcmp(p, "help")) return 2;
diff -ur linux-2.4.4/fs/isofs/inode.c linux-2.4.4-rs/fs/isofs/inode.c
--- linux-2.4.4/fs/isofs/inode.c	Sat Apr 28 12:23:23 2001
+++ linux-2.4.4-rs/fs/isofs/inode.c	Tue May  1 17:03:46 2001
@@ -290,7 +290,9 @@
 	popt->session=-1;
 	popt->sbsector=-1;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 	        if (strncmp(this_char,"norock",6) == 0) {
 		  popt->rock = 'n';
 		  continue;
diff -ur linux-2.4.4/fs/nfs/nfsroot.c linux-2.4.4-rs/fs/nfs/nfsroot.c
--- linux-2.4.4/fs/nfs/nfsroot.c	Mon Sep 25 22:13:53 2000
+++ linux-2.4.4-rs/fs/nfs/nfsroot.c	Tue May  1 17:03:46 2001
@@ -202,8 +202,9 @@
 
 	if ((options = strchr(name, ','))) {
 		*options++ = 0;
-		cp = strtok(options, ",");
-		while (cp) {
+		while (cp = strsep(&options, ",")) {
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
diff -ur linux-2.4.4/fs/proc/inode.c linux-2.4.4-rs/fs/proc/inode.c
--- linux-2.4.4/fs/proc/inode.c	Sat Apr 28 12:23:24 2001
+++ linux-2.4.4-rs/fs/proc/inode.c	Tue May  1 17:03:46 2001
@@ -106,7 +106,9 @@
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
diff -ur linux-2.4.4/fs/reiserfs/super.c linux-2.4.4-rs/fs/reiserfs/super.c
--- linux-2.4.4/fs/reiserfs/super.c	Sat Apr 28 12:23:25 2001
+++ linux-2.4.4-rs/fs/reiserfs/super.c	Tue May  1 17:03:46 2001
@@ -162,7 +162,9 @@
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    for (this_char = strtok (options, ","); this_char != NULL; this_char = strtok (NULL, ",")) {
+    while (this_char = strsep (&options, ",")) {
+	if (!*this_char)
+		continue;
 	if ((value = strchr (this_char, '=')) != NULL)
 	    *value++ = 0;
 	if (!strcmp (this_char, "notail")) {
diff -ur linux-2.4.4/fs/udf/super.c linux-2.4.4-rs/fs/udf/super.c
--- linux-2.4.4/fs/udf/super.c	Sat Apr 28 12:23:25 2001
+++ linux-2.4.4-rs/fs/udf/super.c	Tue May  1 17:03:46 2001
@@ -213,8 +213,10 @@
 	if (!options)
 		return 1;
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ","))
+	while (opt = strsep(&options, ","))
 	{
+		if (!*opt)
+			continue;
 		/* Make "opt=val" into two strings */
 		val = strchr(opt, '=');
 		if (val)
diff -ur linux-2.4.4/fs/ufs/super.c linux-2.4.4-rs/fs/ufs/super.c
--- linux-2.4.4/fs/ufs/super.c	Sat Apr 28 12:23:25 2001
+++ linux-2.4.4-rs/fs/ufs/super.c	Tue May  1 17:03:46 2001
@@ -260,10 +260,9 @@
 	if (!options)
 		return 1;
 		
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
-	     
+	while (this_char = strsep(&options, ",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
