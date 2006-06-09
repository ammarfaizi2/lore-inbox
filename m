Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWFIInv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWFIInv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWFIInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:43:51 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:59923 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWFIIno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=sNU33WCS3GwFHTTMfFgMv3M5MYhTWjWUf9Ps4+HKdZ6WJlMFO/xBDZEo/SRLlwoiF0eq+93NWwMGbemJEnjFEkpLpfCZwWY8nPM5gEnceTCW8gMEq8zOHeoTs7+ZFUDKSb39B+eKw1Xf2lXP4HPJdk/N/36t9R4LdVSn9lltJ3w=
Message-ID: <448933EB.3070003@gmail.com>
Date: Fri, 09 Jun 2006 16:40:11 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] VT binding: Update fbcon to support binding
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The control for binding/unbinding is moved from fbcon to the console
layer. Thus the fbcon sysfs attributes, attach and detach, are also gone.

    1. Add a notifier event that tells fbcon if a framebuffer driver has been
       unregistered.  If no registered driver remains, fbcon will unregister
       itself from the console layer.

    2. Replaced calls to give_up_console() with unregister_con_driver().

    3. Still use take_over_console() instead of register_con_driver() to
       maintain compatibility

    4. Respect the parameter first_fb_vc and last_fb_vc instead of using 0 and
       MAX_NR_CONSOLES - 1. These parameters are settable by the user.

    5. When fbcon is completely unbound from the console layer, fbcon will
       also release (iow, decrement module reference counts to zero) all fbdev
       drivers. In other words, a bind or unbind request from the console layer
       will propagate down to the framebuffer drivers.

    6. If fbcon is not bound to the console, it will ignore all notifier
       events (except driver registration and unregistration) and all sysfs
       requests.
   
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |  201 +++++++++++++++++++++++++++++------------
 drivers/video/fbmem.c         |    7 +
 include/linux/fb.h            |   12 +-
 3 files changed, 154 insertions(+), 66 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 4b7be68..839f414 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -125,6 +125,8 @@ static int softback_lines;
 static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
+static int fbcon_has_exited;
+
 /* font data */
 static char fontname[40];
 
@@ -140,7 +142,6 @@ #define CM_SOFTBACK	(8)
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
 
-static void fbcon_free_font(struct display *);
 static int fbcon_set_origin(struct vc_data *);
 
 #define CURSOR_DRAW_DELAY		(1)
@@ -255,7 +256,7 @@ static void fbcon_rotate_all(struct fb_i
 	if (!ops || ops->currcon < 0 || rotate > 3)
 		return;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		vc = vc_cons[i].d;
 		if (!vc || vc->vc_mode != KD_TEXT ||
 		    registered_fb[con2fb_map[i]] != info)
@@ -534,7 +535,7 @@ static int search_fb_in_map(int idx)
 {
 	int i, retval = 0;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] == idx)
 			retval = 1;
 	}
@@ -545,7 +546,7 @@ static int search_for_mapped_con(void)
 {
 	int i, retval = 0;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != -1)
 			retval = 1;
 	}
@@ -567,6 +568,7 @@ static int fbcon_takeover(int show_logo)
 
 	err = take_over_console(&fb_con, first_fb_vc, last_fb_vc,
 				fbcon_is_default);
+
 	if (err) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			con2fb_map[i] = -1;
@@ -801,8 +803,8 @@ static int set_con2fb_map(int unit, int 
 	if (oldidx == newidx)
 		return 0;
 
-	if (!info)
- 		err =  -EINVAL;
+	if (!info || fbcon_has_exited)
+		return -EINVAL;
 
  	if (!err && !search_for_mapped_con()) {
 		info_idx = newidx;
@@ -838,6 +840,9 @@ static int set_con2fb_map(int unit, int 
  		con2fb_init_display(vc, info, unit, show_logo);
 	}
 
+	if (!search_fb_in_map(info_idx))
+		info_idx = newidx;
+
 	release_console_sem();
  	return err;
 }
@@ -1040,6 +1045,7 @@ #ifdef CONFIG_MAC
 #endif				/* CONFIG_MAC */
 
 	fbcon_add_cursor_timer(info);
+	fbcon_has_exited = 0;
 	return display_desc;
 }
 
@@ -1067,17 +1073,36 @@ static void fbcon_init(struct vc_data *v
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-	t = &fb_display[svc->vc_num];
-	if (!vc->vc_font.data) {
-		vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
-		vc->vc_font.width = (*default_mode)->vc_font.width;
-		vc->vc_font.height = (*default_mode)->vc_font.height;
-		p->userfont = t->userfont;
-		if (p->userfont)
-			REFCOUNT(p->fontdata)++;
+	t = &fb_display[fg_console];
+	if (!p->fontdata) {
+		if (t->fontdata) {
+			struct vc_data *fvc = vc_cons[fg_console].d;
+
+			vc->vc_font.data = (void *)(p->fontdata =
+						    fvc->vc_font.data);
+			vc->vc_font.width = fvc->vc_font.width;
+			vc->vc_font.height = fvc->vc_font.height;
+			p->userfont = t->userfont;
+
+			if (p->userfont)
+				REFCOUNT(p->fontdata)++;
+		} else {
+			const struct font_desc *font = NULL;
+
+			if (!fontname[0] || !(font = find_font(fontname)))
+				font = get_default_font(info->var.xres,
+							info->var.yres);
+			vc->vc_font.width = font->width;
+			vc->vc_font.height = font->height;
+			vc->vc_font.data = (void *)(p->fontdata = font->data);
+			vc->vc_font.charcount = 256; /* FIXME  Need to
+							support more fonts */
+		}
 	}
+
 	if (p->userfont)
 		charcnt = FNTCHARCNT(p->fontdata);
+
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
@@ -1151,13 +1176,47 @@ static void fbcon_init(struct vc_data *v
 	ops->p = &fb_display[fg_console];
 }
 
+static void fbcon_free_font(struct display *p)
+{
+	if (p->userfont && p->fontdata && (--REFCOUNT(p->fontdata) == 0))
+		kfree(p->fontdata - FONT_EXTRA_WORDS * sizeof(int));
+	p->fontdata = NULL;
+	p->userfont = 0;
+}
+
 static void fbcon_deinit(struct vc_data *vc)
 {
 	struct display *p = &fb_display[vc->vc_num];
+	struct fb_info *info;
+	struct fbcon_ops *ops;
+	int idx;
 
-	if (info_idx != -1)
-	    return;
 	fbcon_free_font(p);
+	idx = con2fb_map[vc->vc_num];
+
+	if (idx == -1)
+		goto finished;
+
+	info = registered_fb[idx];
+
+	if (!info)
+		goto finished;
+
+	ops = info->fbcon_par;
+
+	if (!ops)
+		goto finished;
+
+	if (CON_IS_VISIBLE(vc))
+		fbcon_del_cursor_timer(info);
+
+	ops->flags &= ~FBCON_FLAGS_INIT;
+finished:
+
+	if (!con_is_bound(&fb_con) && !fbcon_has_exited)
+		fbcon_exit();
+
+	return;
 }
 
 /* ====================================================================== */
@@ -2227,14 +2286,6 @@ static int fbcon_blank(struct vc_data *v
 	return 0;
 }
 
-static void fbcon_free_font(struct display *p)
-{
-	if (p->userfont && p->fontdata && (--REFCOUNT(p->fontdata) == 0))
-		kfree(p->fontdata - FONT_EXTRA_WORDS * sizeof(int));
-	p->fontdata = NULL;
-	p->userfont = 0;
-}
-
 static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 {
 	u8 *fontdata = vc->vc_font.data;
@@ -2448,7 +2499,7 @@ static int fbcon_set_font(struct vc_data
 
 	FNTSUM(new_data) = csum;
 	/* Check if the same font is on some other console already */
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		struct vc_data *tmp = vc_cons[i].d;
 		
 		if (fb_display[i].userfont &&
@@ -2773,7 +2824,7 @@ static void fbcon_set_all_vcs(struct fb_
 	if (!ops || ops->currcon < 0)
 		return;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		vc = vc_cons[i].d;
 		if (!vc || vc->vc_mode != KD_TEXT ||
 		    registered_fb[con2fb_map[i]] != info)
@@ -2835,21 +2886,55 @@ static int fbcon_mode_deleted(struct fb_
 	return found;
 }
 
+static int fbcon_fb_unregistered(int idx)
+{
+	int i;
+
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		if (con2fb_map[i] == idx)
+			con2fb_map[i] = -1;
+	}
+
+	if (idx == info_idx) {
+		info_idx = -1;
+
+		for (i = 0; i < FB_MAX; i++) {
+			if (registered_fb[i] != NULL) {
+				info_idx = i;
+				break;
+			}
+		}
+	}
+
+	if (info_idx != -1) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
+			if (con2fb_map[i] == -1)
+				con2fb_map[i] = info_idx;
+		}
+	}
+
+	if (!num_registered_fb)
+		unregister_con_driver(&fb_con);
+
+	return 0;
+}
+
 static int fbcon_fb_registered(int idx)
 {
 	int ret = 0, i;
 
 	if (info_idx == -1) {
-		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			if (con2fb_map_boot[i] == idx) {
 				info_idx = idx;
 				break;
 			}
 		}
+
 		if (info_idx != -1)
 			ret = fbcon_takeover(1);
 	} else {
-		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			if (con2fb_map_boot[i] == idx &&
 			    con2fb_map[i] == -1)
 				set_con2fb_map(i, idx, 0);
@@ -2888,7 +2973,7 @@ static void fbcon_new_modelist(struct fb
 	struct fb_var_screeninfo var;
 	struct fb_videomode *mode;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (registered_fb[con2fb_map[i]] != info)
 			continue;
 		if (!fb_display[i].mode)
@@ -2916,6 +3001,14 @@ static int fbcon_event_notify(struct not
 	struct fb_con2fbmap *con2fb;
 	int ret = 0;
 
+	/*
+	 * ignore all events except driver registration and deregistration
+	 * if fbcon is not active
+	 */
+	if (fbcon_has_exited && !(action == FB_EVENT_FB_REGISTERED ||
+				  action == FB_EVENT_FB_UNREGISTERED))
+		goto done;
+
 	switch(action) {
 	case FB_EVENT_SUSPEND:
 		fbcon_suspended(info);
@@ -2936,6 +3029,9 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_FB_REGISTERED:
 		ret = fbcon_fb_registered(info->node);
 		break;
+	case FB_EVENT_FB_UNREGISTERED:
+		ret = fbcon_fb_unregistered(info->node);
+		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		con2fb = event->data;
 		ret = set_con2fb_map(con2fb->console - 1,
@@ -2953,6 +3049,7 @@ static int fbcon_event_notify(struct not
 		break;
 	}
 
+done:
 	return ret;
 }
 
@@ -2997,6 +3094,9 @@ static ssize_t store_rotate(struct class
 	int rotate, idx;
 	char **last = NULL;
 
+	if (fbcon_has_exited)
+		return count;
+
 	acquire_console_sem();
 	idx = con2fb_map[fg_console];
 
@@ -3018,6 +3118,9 @@ static ssize_t store_rotate_all(struct c
 	int rotate, idx;
 	char **last = NULL;
 
+	if (fbcon_has_exited)
+		return count;
+
 	acquire_console_sem();
 	idx = con2fb_map[fg_console];
 
@@ -3037,6 +3140,9 @@ static ssize_t show_rotate(struct class_
 	struct fb_info *info;
 	int rotate = 0, idx;
 
+	if (fbcon_has_exited)
+		return 0;
+
 	acquire_console_sem();
 	idx = con2fb_map[fg_console];
 
@@ -3050,32 +3156,9 @@ err:
 	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
-static ssize_t store_attach(struct class_device *class_device,
-			    const char *buf, size_t count)
-{
-	if (info_idx == -1)
-		fbcon_start();
-
-	return count;
-}
-
-static ssize_t store_detach(struct class_device *class_device,
-			    const char *buf, size_t count)
-{
-	if (info_idx != -1) {
-		fbcon_exit();
-		give_up_console(&fb_con);
-	}
-
-	info_idx = -1;
-	return count;
-}
-
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
-	__ATTR(attach, S_IWUSR, NULL, store_attach),
-	__ATTR(detach, S_IWUSR, NULL, store_detach),
 };
 
 static int fbcon_init_class_device(void)
@@ -3112,7 +3195,6 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
 
-	acquire_console_sem();
 #ifdef CONFIG_ATARI
 	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
 #endif
@@ -3131,11 +3213,9 @@ #endif
 		if (info == NULL)
 			continue;
 
-		for (j = 0; j < MAX_NR_CONSOLES; j++) {
-			if (con2fb_map[j] == i) {
-				con2fb_map[j] = -1;
+		for (j = first_fb_vc; j <= last_fb_vc; j++) {
+			if (con2fb_map[j] == i)
 				mapped = 1;
-			}
 		}
 
 		if (mapped) {
@@ -3151,11 +3231,10 @@ #endif
 
 			if (info->queue.func == fb_flashcursor)
 				info->queue.func = NULL;
-
 		}
 	}
 
-	release_console_sem();
+	fbcon_has_exited = 1;
 }
 
 static int __init fb_console_init(void)
@@ -3189,7 +3268,7 @@ module_init(fb_console_init);
 
 #ifdef MODULE
 
-static void fbcon_deinit_class_device(void)
+static void __exit fbcon_deinit_class_device(void)
 {
 	int i;
 
@@ -3204,7 +3283,9 @@ static void __exit fb_console_exit(void)
 	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_class_device();
 	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
+	fbcon_exit();
 	release_console_sem();
+	unregister_con_driver(&fb_con);
 }	
 
 module_exit(fb_console_exit);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index de6543b..9527a52 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1353,6 +1353,7 @@ register_framebuffer(struct fb_info *fb_
 int
 unregister_framebuffer(struct fb_info *fb_info)
 {
+	struct fb_event event;
 	int i;
 
 	i = fb_info->node;
@@ -1360,13 +1361,17 @@ unregister_framebuffer(struct fb_info *f
 		return -EINVAL;
 	devfs_remove("fb/%d", i);
 
-	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
+	if (fb_info->pixmap.addr &&
+	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	fb_cleanup_class_device(fb_info);
 	class_device_destroy(fb_class, MKDEV(FB_MAJOR, i));
+	event.info = fb_info;
+	blocking_notifier_call_chain(&fb_notifier_list,
+				     FB_EVENT_FB_UNREGISTERED, &event);
 	return 0;
 }
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index c64f252..07a08e9 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -504,17 +504,19 @@ #define FB_EVENT_RESUME			0x03
 #define FB_EVENT_MODE_DELETE            0x04
 /*      A driver registered itself */
 #define FB_EVENT_FB_REGISTERED          0x05
+/*      A driver unregistered itself */
+#define FB_EVENT_FB_UNREGISTERED        0x06
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
-#define FB_EVENT_GET_CONSOLE_MAP        0x06
+#define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
-#define FB_EVENT_SET_CONSOLE_MAP        0x07
+#define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
-#define FB_EVENT_BLANK                  0x08
+#define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
-#define FB_EVENT_NEW_MODELIST           0x09
+#define FB_EVENT_NEW_MODELIST           0x0A
 /*	The resolution of the passed in fb_info about to change and
         all vc's should be changed         */
-#define FB_EVENT_MODE_CHANGE_ALL	0x0A
+#define FB_EVENT_MODE_CHANGE_ALL	0x0B
 
 struct fb_event {
 	struct fb_info *info;


