Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbSJGMAn>; Mon, 7 Oct 2002 08:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbSJGMAn>; Mon, 7 Oct 2002 08:00:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:65409 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262997AbSJGMAc>;
	Mon, 7 Oct 2002 08:00:32 -0400
Date: Mon, 7 Oct 2002 14:06:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Skip Ford <skip.ford@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021007140603.A627@ucw.cz>
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <20021001155428.GA19122@win.tue.nl> <20021001175537.A13220@ucw.cz> <20021001162955.GA19132@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001162955.GA19132@win.tue.nl>; from aebr@win.tue.nl on Tue, Oct 01, 2002 at 06:29:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:29:55PM +0200, Andries Brouwer wrote:
> On Tue, Oct 01, 2002 at 05:55:37PM +0200, Vojtech Pavlik wrote:
> 
> > Ok. Where is the most recent version of [gs]etkeycodes?
> 
> In kbd-1.06. It is from May 2001, and I have been planning kbd-1.07
> for a while but there were no urgent changes, just more fonts and
> keymaps and the like. When you are done it is a good occasion for
> kbd-1.07.
> 
> Andries
> 
> Begin3
> Title:          Keyboard and console utilities for Linux
> Version:        1.06
> Entered-date:   2001-05-19
> Description:    loadkeys dumpkeys setfont chvt openvt kbd.FAQ A20 etc.
> Keywords:       keyboard mapping console font unicode
> Author:         several
> Maintained-by:  Andries E. Brouwer (aeb@cwi.nl)
> Primary-site:   ftp://ftp.win.tue.nl/pub/linux-local/utils/kbd
>                 773433 kbd-1.06.tar.gz
> Alternate-site: ftp://ftp.*.kernel.org/pub/linux/utils/kbd
> Alternate-site: ftp://sunsite.unc.edu/pub/Linux/system/keyboards
> Alternate site: ftp://ftp.cwi.nl/pub/aeb/kbd
> Copying-policy: GPL
> End

Ok, here is a patch that should make it work correctly on all existing
kernels.

You may want to check that loadkeys supports keycodes over 127 (and for
future, over 255), too. I updated only getkeycodes/setkeycodes.

diff -urN kbd-1.06/src/getkeycodes.c kbd-1.06-new/src/getkeycodes.c
--- kbd-1.06/src/getkeycodes.c	Fri Oct  8 21:45:54 1999
+++ kbd-1.06-new/src/getkeycodes.c	Mon Oct  7 12:38:47 2002
@@ -21,8 +21,9 @@
 
 int
 main(int argc, char **argv) {
-    int fd, sc;
+    int fd, sc = 0;
     struct kbkeycode a;
+    int old_kernel = 0;
 
     set_progname(argv[0]);
 
@@ -36,30 +37,47 @@
     if (argc != 1)
       usage();
     fd = getfd();
+
+    a.scancode = 0; /* Old kernels don't support */
+    a.keycode = 0;  /* scancodes below SC_LIM. */
+    if (ioctl(fd,KDGETKEYCODE,&a))
+        old_kernel = 1;
+
     printf(_("Plain scancodes xx (hex) versus keycodes (dec)\n"));
-    printf(_("0 is an error; for 1-88 (0x01-0x58) scancode equals keycode\n"));
 
-    for(sc=88; sc<256; sc++) {
-	if (sc == 128)
-	  printf(_("\n\nEscaped scancodes e0 xx (hex)\n"));
+    if (old_kernel) {
+        printf(_("0 is an error; for 1-88 (0x01-0x58) scancode equals keycode\n"));
+	sc = 0x89;
+    }
+
+    while (1) {
+	if (old_kernel) {
+	  if (sc == 128)
+            printf(_("\n\nEscaped scancodes e0 xx (hex)\n"));
+	  if (sc == 256) {
+            printf("\n");
+            return 0;
+          }
+        }	
 	if (sc % 8 == 0) {
-	    if (sc < 128)
-	      printf("\n 0x%02x: ", sc);
-	    else
-	      printf("\ne0 %02x: ", sc-128);
-	}
-
-	if (sc <= 88) {
-	    printf(" %3d", sc);
-	    continue;
+            if (old_kernel) {
+	      if (sc < 128)
+	        printf("\n 0x%02x: ", sc);
+	      else
+	        printf("\ne0 %02x: ", sc-128);
+	    } else
+		printf("\n 0x%04x: ", sc); 
 	}
-
 	a.scancode = sc;
 	a.keycode = 0;
 	if (ioctl(fd,KDGETKEYCODE,&a)) {
-	    if (errno == EINVAL)
+	    if (errno == EINVAL) {
+		if (!old_kernel) {
+			printf("\n");
+			return 0;
+		}
 	      printf("   -");
-	    else {
+	    } else {
 		perror("KDGETKEYCODE");
 		fprintf(stderr, _("failed to get keycode for scancode 0x%x\n"),
 			sc);
@@ -67,6 +85,8 @@
 	    }
 	} else
 	  printf(" %3d", a.keycode);
+
+	sc++;
     }
     printf("\n");
     return 0;
diff -urN kbd-1.06/src/setkeycodes.c kbd-1.06-new/src/setkeycodes.c
--- kbd-1.06/src/setkeycodes.c	Fri Oct  8 21:42:02 1999
+++ kbd-1.06-new/src/setkeycodes.c	Mon Oct  7 12:40:08 2002
@@ -27,7 +27,7 @@
 int
 main(int argc, char **argv) {
     char *ep;
-    int fd, sc;
+    int fd, sc, old_kernel = 0;
     struct kbkeycode a;
 
     set_progname(argv[0]);
@@ -43,17 +43,20 @@
       usage(_("even number of arguments expected"));
     fd = getfd();
 
+    a.scancode = 0; /* Old kernels don't support */
+    a.keycode = 0;  /* scancodes below SC_LIM. */
+    if (ioctl(fd,KDGETKEYCODE,&a))
+	old_kernel = 1;
+
     while (argc > 2) {
 	a.keycode = atoi(argv[2]);
 	a.scancode = sc = strtol(argv[1], &ep, 16);
 	if (*ep)
 	  usage(_("error reading scancode"));
-	if (a.scancode > 127) {
+	if ((a.scancode & ~0xff) == 0xe000) {
 	    a.scancode -= 0xe000;
-	    a.scancode += 128;
+            a.scancode += old_kernel ? 128 : 256;
 	}
-	if (a.scancode > 255 || a.keycode > 127)
-	  usage(_("code outside bounds"));
 	if (ioctl(fd,KDSETKEYCODE,&a)) {
 	    perror("KDSETKEYCODE");
 	    fprintf(stderr, _("failed to set scancode %x to keycode %d\n"),


-- 
Vojtech Pavlik
SuSE Labs
