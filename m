Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUD2Lsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUD2Lsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 07:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUD2Lsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 07:48:40 -0400
Received: from [203.14.152.115] ([203.14.152.115]:12297 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264134AbUD2Ls2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 07:48:28 -0400
Date: Thu, 29 Apr 2004 21:46:06 +1000
To: Sebastian Podjasek <sebastian.podjasek@morenet.pl>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org, geert@linux-m68k.org
Subject: [PATCH] Module ref counting for vt console drivers
Message-ID: <20040429114606.GA14728@gondor.apana.org.au>
References: <20040428220202.GA2278@gondor.apana.org.au> <20040429045854.GB3867@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20040429045854.GB3867@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The following patch adds basic module reference counting to vt console
drivers.  Currently modules like fbcon are not counted at all.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/char/vt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/vt.c,v
retrieving revision 1.6
diff -u -r1.6 vt.c
--- a/drivers/char/vt.c	5 Apr 2004 10:54:32 -0000	1.6
+++ b/drivers/char/vt.c	29 Apr 2004 11:30:11 -0000
@@ -661,11 +661,14 @@
 static void visual_init(int currcons, int init)
 {
     /* ++Geert: sw->con_init determines console size */
+    if (sw)
+	module_put(sw->owner);
     sw = conswitchp;
 #ifndef VT_SINGLE_DRIVER
     if (con_driver_map[currcons])
 	sw = con_driver_map[currcons];
 #endif
+    __module_get(sw->owner);
     cons_num = currcons;
     display_fg = &master_display_fg;
     vc_cons[currcons].d->vc_uni_pagedir_loc = &vc_cons[currcons].d->vc_uni_pagedir;
@@ -2653,25 +2656,38 @@
  *	and become default driver for newly opened ones.
  */
 
-void take_over_console(const struct consw *csw, int first, int last, int deflt)
+int take_over_console(const struct consw *csw, int first, int last, int deflt)
 {
 	int i, j = -1;
 	const char *desc;
+	struct module *owner;
+
+	owner = csw->owner;
+	if (!try_module_get(owner))
+		return -ENODEV;
 
 	acquire_console_sem();
 
 	desc = csw->con_startup();
 	if (!desc) {
 		release_console_sem();
-		return;
+		module_put(owner);
+		return -ENODEV;
 	}
-	if (deflt)
+	if (deflt) {
+		if (conswitchp)
+			module_put(conswitchp->owner);
+		__module_get(owner);
 		conswitchp = csw;
+	}
 
 	for (i = first; i <= last; i++) {
 		int old_was_color;
 		int currcons = i;
 
+		if (con_driver_map[i])
+			module_put(con_driver_map[i]->owner);
+		__module_get(owner);
 		con_driver_map[i] = csw;
 
 		if (!vc_cons[i].d || !vc_cons[i].d->vc_sw)
@@ -2706,6 +2722,9 @@
 		printk("to %s\n", desc);
 
 	release_console_sem();
+
+	module_put(owner);
+	return 0;
 }
 
 void give_up_console(const struct consw *csw)
@@ -2713,8 +2732,10 @@
 	int i;
 
 	for(i = 0; i < MAX_NR_CONSOLES; i++)
-		if (con_driver_map[i] == csw)
+		if (con_driver_map[i] == csw) {
+			module_put(csw->owner);
 			con_driver_map[i] = NULL;
+		}
 }
 
 #endif
Index: drivers/video/console/dummycon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/dummycon.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 dummycon.c
--- a/drivers/video/console/dummycon.c	3 Jan 2003 01:36:55 -0000	1.1.1.2
+++ b/drivers/video/console/dummycon.c	29 Apr 2004 10:58:51 -0000
@@ -11,6 +11,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/init.h>
+#include <linux/module.h>
 
 /*
  *  Dummy console driver
@@ -58,6 +59,7 @@
  */
 
 const struct consw dummy_con = {
+    .owner =		THIS_MODULE,
     .con_startup =	dummycon_startup,
     .con_init =		dummycon_init,
     .con_deinit =	DUMMY,
Index: drivers/video/console/fbcon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/fbcon.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 fbcon.c
--- a/drivers/video/console/fbcon.c	5 Apr 2004 09:49:37 -0000	1.1.1.10
+++ b/drivers/video/console/fbcon.c	29 Apr 2004 11:12:28 -0000
@@ -304,8 +304,7 @@
 		return -ENODEV;
 	con2fb_map[unit] = newidx;
 	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
-	take_over_console(&fb_con, unit, unit, fbcon_is_default);
-	return 0;
+	return take_over_console(&fb_con, unit, unit, fbcon_is_default);
 }
 
 /*
@@ -2257,6 +2256,7 @@
  */
 
 const struct consw fb_con = {
+	.owner			= THIS_MODULE,
 	.con_startup 		= fbcon_startup,
 	.con_init 		= fbcon_init,
 	.con_deinit 		= fbcon_deinit,
@@ -2286,10 +2286,16 @@
 
 int __init fb_console_init(void)
 {
+	int err;
+
 	if (!num_registered_fb)
 		return -ENODEV;
 
-	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
+				fbcon_is_default);
+	if (err)
+		return err;
+
 	acquire_console_sem();
 	if (!fbcon_event_notifier_registered) {
 		fb_register_client(&fbcon_event_notifer);
Index: drivers/video/console/mdacon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/mdacon.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 mdacon.c
--- a/drivers/video/console/mdacon.c	3 Jan 2003 01:36:55 -0000	1.1.1.2
+++ b/drivers/video/console/mdacon.c	29 Apr 2004 11:17:39 -0000
@@ -370,8 +370,6 @@
 
 	if (mda_display_fg == NULL)
 		mda_display_fg = c;
-
-	MOD_INC_USE_COUNT;
 }
 
 static void mdacon_deinit(struct vc_data *c)
@@ -380,8 +378,6 @@
 
 	if (mda_display_fg == c)
 		mda_display_fg = NULL;
-
-	MOD_DEC_USE_COUNT;
 }
 
 static inline u16 mda_convert_attr(u16 ch)
@@ -586,6 +582,7 @@
  */
 
 const struct consw mda_con = {
+	.owner =		THIS_MODULE,
 	.con_startup =		mdacon_startup,
 	.con_init =		mdacon_init,
 	.con_deinit =		mdacon_deinit,
@@ -609,8 +606,7 @@
 	if (mda_first_vc > mda_last_vc)
 		return 1;
 
-	take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
-	return 0;
+	return take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
 }
 
 void __exit mda_console_exit(void)
Index: drivers/video/console/newport_con.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/newport_con.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 newport_con.c
--- a/drivers/video/console/newport_con.c	24 Mar 2003 22:01:16 -0000	1.1.1.3
+++ b/drivers/video/console/newport_con.c	29 Apr 2004 11:12:38 -0000
@@ -677,6 +677,7 @@
 #define DUMMY (void *) newport_dummy
 
 const struct consw newport_con = {
+    .owner =		THIS_MODULE,
     .con_startup =	newport_startup,
     .con_init =		newport_init,
     .con_deinit =	DUMMY,
@@ -704,9 +705,7 @@
 		printk("Error loading SGI Newport Console driver\n");
 	else
 		printk("Loading SGI Newport Console Driver\n");
-	take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
-
-	return 0;
+	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 }
 
 int cleanup_module(void)
Index: drivers/video/console/promcon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/promcon.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 promcon.c
--- a/drivers/video/console/promcon.c	11 Mar 2004 02:55:33 -0000	1.1.1.2
+++ b/drivers/video/console/promcon.c	29 Apr 2004 10:59:56 -0000
@@ -574,6 +574,7 @@
 #define DUMMY (void *) promcon_dummy
 
 const struct consw prom_con = {
+	.owner =		THIS_MODULE,
 	.con_startup =		promcon_startup,
 	.con_init =		promcon_init,
 	.con_deinit =		promcon_deinit,
Index: drivers/video/console/sticon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/sticon.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 sticon.c
--- a/drivers/video/console/sticon.c	11 Mar 2004 02:55:37 -0000	1.1.1.4
+++ b/drivers/video/console/sticon.c	29 Apr 2004 11:13:13 -0000
@@ -354,6 +354,7 @@
 }
 
 static struct consw sti_con = {
+	.owner			= THIS_MODULE,
 	.con_startup		= sticon_startup,
 	.con_init		= sticon_init,
 	.con_deinit		= sticon_deinit,
@@ -390,7 +391,7 @@
 
     if (conswitchp == &dummy_con) {
 	printk(KERN_INFO "sticon: Initializing STI text console.\n");
-	take_over_console(&sti_con, 0, MAX_NR_CONSOLES - 1, 1);
+	return take_over_console(&sti_con, 0, MAX_NR_CONSOLES - 1, 1);
     }
     return 0;
 }
Index: drivers/video/console/vgacon.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/console/vgacon.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 vgacon.c
--- a/drivers/video/console/vgacon.c	11 Mar 2004 02:55:26 -0000	1.1.1.3
+++ b/drivers/video/console/vgacon.c	29 Apr 2004 11:00:24 -0000
@@ -1065,6 +1065,7 @@
 #define DUMMY (void *) vgacon_dummy
 
 const struct consw vga_con = {
+	.owner = THIS_MODULE,
 	.con_startup = vgacon_startup,
 	.con_init = vgacon_init,
 	.con_deinit = vgacon_deinit,
Index: include/linux/console.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/include/linux/console.h,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 console.h
--- a/include/linux/console.h	11 Mar 2004 02:55:26 -0000	1.1.1.8
+++ b/include/linux/console.h	29 Apr 2004 10:47:39 -0000
@@ -19,6 +19,7 @@
 
 struct vc_data;
 struct console_font_op;
+struct module;
 
 /*
  * this is what the terminal answers to a ESC-Z or csi0c query.
@@ -27,6 +28,7 @@
 #define VT102ID "\033[?6c"
 
 struct consw {
+	struct module *owner;
 	const char *(*con_startup)(void);
 	void	(*con_init)(struct vc_data *, int);
 	void	(*con_deinit)(struct vc_data *);
@@ -58,7 +60,7 @@
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
 
-void take_over_console(const struct consw *sw, int first, int last, int deflt);
+int take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
 
 /* scroll */

--liOOAslEiF7prFVr--
