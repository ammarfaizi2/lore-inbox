Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281487AbRKPTCt>; Fri, 16 Nov 2001 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRKPTCk>; Fri, 16 Nov 2001 14:02:40 -0500
Received: from smtp02.web.de ([217.72.192.151]:10786 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S281487AbRKPTC3>;
	Fri, 16 Nov 2001 14:02:29 -0500
Date: Fri, 16 Nov 2001 20:04:30 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] strtok --> strsep in framebuffer drivers, last pieces (really!)
Message-Id: <20011116200430.40edfa7e.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this seems to be the really last patch regarding `strtok in framebuffer
drivers'. It removes another compiler warning, converts the last three
strtok()s to strsep()s and in two cases adds `skip empty tokens'-code.
Please, apply.

René



diff -Nur linux-2.4.15-pre5/drivers/video/atafb.c linux-2.4.15-pre5-rs/drivers/video/atafb.c
--- linux-2.4.15-pre5/drivers/video/atafb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.15-pre5-rs/drivers/video/atafb.c	Fri Nov 16 20:21:39 2001
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -Nur linux-2.4.15-pre5/drivers/video/aty/atyfb_base.c linux-2.4.15-pre5-rs/drivers/video/aty/atyfb_base.c
--- linux-2.4.15-pre5/drivers/video/aty/atyfb_base.c	Thu Nov  8 22:51:16 2001
+++ linux-2.4.15-pre5-rs/drivers/video/aty/atyfb_base.c	Fri Nov 16 20:10:21 2001
@@ -2522,6 +2522,8 @@
 	return 0;
 
     while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -Nur linux-2.4.15-pre5/drivers/video/aty128fb.c linux-2.4.15-pre5-rs/drivers/video/aty128fb.c
--- linux-2.4.15-pre5/drivers/video/aty128fb.c	Fri Nov 16 18:43:02 2001
+++ linux-2.4.15-pre5-rs/drivers/video/aty128fb.c	Fri Nov 16 20:13:10 2001
@@ -1620,7 +1620,9 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+	    continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -Nur linux-2.4.15-pre5/drivers/video/clgenfb.c linux-2.4.15-pre5-rs/drivers/video/clgenfb.c
--- linux-2.4.15-pre5/drivers/video/clgenfb.c	Thu Nov  8 22:51:16 2001
+++ linux-2.4.15-pre5-rs/drivers/video/clgenfb.c	Fri Nov 16 20:19:51 2001
@@ -2823,8 +2823,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -Nur linux-2.4.15-pre5/drivers/video/sis/sis_main.c linux-2.4.15-pre5-rs/drivers/video/sis/sis_main.c
--- linux-2.4.15-pre5/drivers/video/sis/sis_main.c	Fri Nov 16 18:43:03 2001
+++ linux-2.4.15-pre5-rs/drivers/video/sis/sis_main.c	Fri Nov 16 20:19:04 2001
@@ -2257,8 +2257,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
 
