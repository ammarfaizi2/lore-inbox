Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135653AbRD1VnD>; Sat, 28 Apr 2001 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135657AbRD1Vmx>; Sat, 28 Apr 2001 17:42:53 -0400
Received: from mailgate3.cinetic.de ([212.227.116.80]:51486 "EHLO
	mailgate3.cinetic.de") by vger.kernel.org with ESMTP
	id <S135653AbRD1Vmh>; Sat, 28 Apr 2001 17:42:37 -0400
Date: Sat, 28 Apr 2001 23:42:34 +0200
Message-Id: <200104282142.f3SLgXF19558@mailgate3.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: =?iso-8859-1?Q? "Ren=E9=20Scharfe" ?= <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] strtoke -> strsep (amifb, atafb, atyfb)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was unable to find out who the maintainers of those three framebuffer
drivers are (Amiga, Atari, Mach64) and therefore I'm asking here on lkml.

All three of the drivers define a function named strtoke for their private
use which does almost the same as strsep (that in turn lives in
lib/string.c). Both functions cut strings into tokens and both return empty
tokens, too. And both destroy the string in that process.
There are three differences:
  * strsep also forgets about the string pointer (destroys the string even
    more).
  * strtoke does not return the last empty token at the end of the input
    string (if there is any).
  * strtoke remembers the string you called it with the last time.

In all three drivers these differences are irrelevant. My patch makes use
of that and replaces all occurencies of strtoke by strsep and removes the
function definitions. There's no need for duplicate code here, after all.
The patch is against kernel 2.4.4.

Any comments?


Regards,
Rene



--- linux-2.4.4/drivers/video/amifb.c	Sat Apr 28 12:23:20 2001
+++ linux/drivers/video/amifb.c	Sat Apr 28 16:46:44 2001
@@ -1135,7 +1135,6 @@
 static void amifb_interrupt(int irq, void *dev_id, struct pt_regs *fp);
 static u_long chipalloc(u_long size);
 static void chipfree(void);
-static char *strtoke(char *s,const char *ct);
 
 	/*
 	 * Hardware routines
@@ -1225,22 +1226,22 @@
 	 * <H*> horizontal freq. in kHz
 	 */
 
-		if (!(p = strtoke(mcap_spec, ";")) || !*p)
+		if (!(p = strsep(&mcap_spec, ";")) || !*p)
 			goto cap_invalid;
 		vmin = simple_strtoul(p, NULL, 10);
 		if (vmin <= 0)
 			goto cap_invalid;
-		if (!(p = strtoke(NULL, ";")) || !*p)
+		if (!(p = strsep(&mcap_spec, ";")) || !*p)
 			goto cap_invalid;
 		vmax = simple_strtoul(p, NULL, 10);
 		if (vmax <= 0 || vmax <= vmin)
 			goto cap_invalid;
-		if (!(p = strtoke(NULL, ";")) || !*p)
+		if (!(p = strsep(&mcap_spec, ";")) || !*p)
 			goto cap_invalid;
 		hmin = 1000 * simple_strtoul(p, NULL, 10);
 		if (hmin <= 0)
 			goto cap_invalid;
-		if (!(p = strtoke(NULL, "")) || !*p)
+		if (!(p = strsep(&mcap_spec, "")) || !*p)
 			goto cap_invalid;
 		hmax = 1000 * simple_strtoul(p, NULL, 10);
 		if (hmax <= 0 || hmax <= hmin)
@@ -1914,29 +1915,6 @@
 		ami_reinit_copper();
 		do_vmode_full = 0;
 	}
-}
-
-	/*
-	 * A strtok which returns empty strings, too
-	 */
-
-static char __init *strtoke(char *s,const char *ct)
-{
-	char *sbegin, *send;
-	static char *ssave = NULL;
-
-	sbegin  = s ? s : ssave;
-	if (!sbegin)
-		return NULL;
-	if (*sbegin == '\0') {
-		ssave = NULL;
-		return NULL;
-	}
-	send = strpbrk(sbegin, ct);
-	if (send && *send != '\0')
-		*send++ = '\0';
-	ssave = send;
-	return sbegin;
 }
 
 /* --------------------------- Hardware routines --------------------------- */
--- linux-2.4.4/drivers/video/atafb.c	Sat Apr 28 12:23:20 2001
+++ linux/drivers/video/atafb.c	Sat Apr 28 16:51:18 2001
@@ -2860,28 +2860,6 @@
 	return 0;
 }
 
-/* a strtok which returns empty strings, too */
-
-static char * strtoke(char * s,const char * ct)
-{
-  char *sbegin, *send;
-  static char *ssave = NULL;
-  
-  sbegin  = s ? s : ssave;
-  if (!sbegin) {
-	  return NULL;
-  }
-  if (*sbegin == '\0') {
-    ssave = NULL;
-    return NULL;
-  }
-  send = strpbrk(sbegin, ct);
-  if (send && *send != '\0')
-    *send++ = '\0';
-  ssave = send;
-  return sbegin;
-}
-
 int __init atafb_setup( char *options )
 {
     char *this_opt;
@@ -2956,18 +2934,18 @@
 	int xres;
 	char *p;
 
-	if (!(p = strtoke(int_str, ";")) ||!*p) goto int_invalid;
+	if (!(p = strsep(&int_str, ";")) ||!*p) goto int_invalid;
 	xres = simple_strtoul(p, NULL, 10);
-	if (!(p = strtoke(NULL, ";")) || !*p) goto int_invalid;
+	if (!(p = strsep(&int_str, ";")) || !*p) goto int_invalid;
 	sttt_xres=xres;
 	tt_yres=st_yres=simple_strtoul(p, NULL, 10);
-	if ((p=strtoke(NULL, ";")) && *p) {
+	if ((p=strsep(&int_str, ";")) && *p) {
 		sttt_xres_virtual=simple_strtoul(p, NULL, 10);
 	}
-	if ((p=strtoke(NULL, ";")) && *p) {
+	if ((p=strsep(&int_str, ";")) && *p) {
 		sttt_yres_virtual=simple_strtoul(p, NULL, 0);
 	}
-	if ((p=strtoke(NULL, ";")) && *p) {
+	if ((p=strsep(&int_str, ";")) && *p) {
 		ovsc_offset=simple_strtoul(p, NULL, 0);
 	}
 
@@ -2993,20 +2971,20 @@
 	 *
 	 * Even xres_virtual is available, we neither support panning nor hw-scrolling!
 	 */
-	if (!(p = strtoke(ext_str, ";")) ||!*p) goto ext_invalid;
+	if (!(p = strsep(&ext_str, ";")) ||!*p) goto ext_invalid;
 	xres_virtual = xres = simple_strtoul(p, NULL, 10);
 	if (xres <= 0) goto ext_invalid;
 
-	if (!(p = strtoke(NULL, ";")) ||!*p) goto ext_invalid;
+	if (!(p = strsep(&ext_str, ";")) ||!*p) goto ext_invalid;
 	yres = simple_strtoul(p, NULL, 10);
 	if (yres <= 0) goto ext_invalid;
 
-	if (!(p = strtoke(NULL, ";")) ||!*p) goto ext_invalid;
+	if (!(p = strsep(&ext_str, ";")) ||!*p) goto ext_invalid;
 	depth = simple_strtoul(p, NULL, 10);
 	if (depth != 1 && depth != 2 && depth != 4 && depth != 8 &&
 		depth != 16 && depth != 24) goto ext_invalid;
 
-	if (!(p = strtoke(NULL, ";")) ||!*p) goto ext_invalid;
+	if (!(p = strsep(&ext_str, ";")) ||!*p) goto ext_invalid;
 	if (*p == 'i')
 		planes = FB_TYPE_INTERLEAVED_PLANES;
 	else if (*p == 'p')
@@ -3019,19 +2997,19 @@
 		goto ext_invalid;
 
 
-	if (!(p = strtoke(NULL, ";")) ||!*p) goto ext_invalid;
+	if (!(p = strsep(&ext_str, ";")) ||!*p) goto ext_invalid;
 	addr = simple_strtoul(p, NULL, 0);
 
-	if (!(p = strtoke(NULL, ";")) ||!*p)
+	if (!(p = strsep(&ext_str, ";")) ||!*p)
 		len = xres*yres*depth/8;
 	else
 		len = simple_strtoul(p, NULL, 0);
 
-	if ((p = strtoke(NULL, ";")) && *p) {
+	if ((p = strsep(&ext_str, ";")) && *p) {
 		external_vgaiobase=simple_strtoul(p, NULL, 0);
 	}
 
-	if ((p = strtoke(NULL, ";")) && *p) {
+	if ((p = strsep(&ext_str, ";")) && *p) {
 		external_bitspercol = simple_strtoul(p, NULL, 0);
 		if (external_bitspercol > 8)
 			external_bitspercol = 8;
@@ -3039,14 +3017,14 @@
 			external_bitspercol = 1;
 	}
 	
-	if ((p = strtoke(NULL, ";")) && *p) {
+	if ((p = strsep(&ext_str, ";")) && *p) {
 		if (!strcmp(p, "vga"))
 			external_card_type = IS_VGA;
 		if (!strcmp(p, "mv300"))
 			external_card_type = IS_MV300;
 	}
 
-	if ((p = strtoke(NULL, ";")) && *p) {
+	if ((p = strsep(&ext_str, ";")) && *p) {
 		xres_virtual = simple_strtoul(p, NULL, 10);
 		if (xres_virtual < xres)
 			xres_virtual = xres;
@@ -3089,16 +3067,16 @@
 	 * <V*> vertical freq. in Hz
 	 * <H*> horizontal freq. in kHz
 	 */
-	if (!(p = strtoke(mcap_spec, ";")) || !*p) goto cap_invalid;
+	if (!(p = strsep(&mcap_spec, ";")) || !*p) goto cap_invalid;
 	vmin = simple_strtoul(p, NULL, 10);
 	if (vmin <= 0) goto cap_invalid;
-	if (!(p = strtoke(NULL, ";")) || !*p) goto cap_invalid;
+	if (!(p = strsep(&mcap_spec, ";")) || !*p) goto cap_invalid;
 	vmax = simple_strtoul(p, NULL, 10);
 	if (vmax <= 0 || vmax <= vmin) goto cap_invalid;
-	if (!(p = strtoke(NULL, ";")) || !*p) goto cap_invalid;
+	if (!(p = strsep(&mcap_spec, ";")) || !*p) goto cap_invalid;
 	hmin = 1000 * simple_strtoul(p, NULL, 10);
 	if (hmin <= 0) goto cap_invalid;
-	if (!(p = strtoke(NULL, "")) || !*p) goto cap_invalid;
+	if (!(p = strsep(&mcap_spec, "")) || !*p) goto cap_invalid;
 	hmax = 1000 * simple_strtoul(p, NULL, 10);
 	if (hmax <= 0 || hmax <= hmin) goto cap_invalid;
 
@@ -3117,11 +3095,11 @@
 		char *p;
 		int xres, yres, depth, temp;
 
-		if (!(p = strtoke(user_mode, ";")) || !*p) goto user_invalid;
+		if (!(p = strsep(&user_mode, ";")) || !*p) goto user_invalid;
 		xres = simple_strtoul(p, NULL, 10);
-		if (!(p = strtoke(NULL, ";")) || !*p) goto user_invalid;
+		if (!(p = strsep(&user_mode, ";")) || !*p) goto user_invalid;
 		yres = simple_strtoul(p, NULL, 10);
-		if (!(p = strtoke(NULL, "")) || !*p) goto user_invalid;
+		if (!(p = strsep(&user_mode, "")) || !*p) goto user_invalid;
 		depth = simple_strtoul(p, NULL, 10);
 		if ((temp=get_video_mode("user0"))) {
 			default_par=temp;
--- linux-2.4.4/drivers/video/atyfb.c	Sat Apr 28 12:23:20 2001
+++ linux/drivers/video/atyfb.c	Sat Apr 28 16:53:35 2001
@@ -388,7 +388,6 @@
 static struct aty_cursor *aty_init_cursor(struct fb_info_aty *fb);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
-static char *strtoke(char *s, const char *ct);
 #endif
 
 static void reset_engine(const struct fb_info_aty *info);
@@ -4137,13 +4137,13 @@
 
     printk("store_video_par() '%s' \n", video_str);
 
-    if (!(p = strtoke(video_str, ";")) || !*p)
+    if (!(p = strsep(&video_str, ";")) || !*p)
 	goto mach64_invalid;
     vmembase = simple_strtoul(p, NULL, 0);
-    if (!(p = strtoke(NULL, ";")) || !*p)
+    if (!(p = strsep(&video_str, ";")) || !*p)
 	goto mach64_invalid;
     size = simple_strtoul(p, NULL, 0);
-    if (!(p = strtoke(NULL, ";")) || !*p)
+    if (!(p = strsep(&video_str, ";")) || !*p)
 	goto mach64_invalid;
     guiregbase = simple_strtoul(p, NULL, 0);
 
@@ -4159,24 +4159,6 @@
     return -1;
 }
 
-static char __init *strtoke(char *s, const char *ct)
-{
-    static char *ssave = NULL;
-    char *sbegin, *send;
-
-    sbegin  = s ? s : ssave;
-    if (!sbegin)
-	return NULL;
-    if (*sbegin == '\0') {
-	ssave = NULL;
-	return NULL;
-    }
-    send = strpbrk(sbegin, ct);
-    if (send && *send != '\0')
-	*send++ = '\0';
-    ssave = send;
-    return sbegin;
-}
 #endif /* CONFIG_ATARI */
 
 static int atyfbcon_switch(int con, struct fb_info *fb)

_______________________________________________________________________________
Alles unter einem Dach: Informationen, Fun, E-Mails. Bei WEB.DE: http://web.de
Die gro?e Welt der Kommunikation: E-Mail, Fax, SMS, WAP: http://freemail.web.de

