Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271691AbTG2NOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271694AbTG2NOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:14:31 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:59012
	"EHLO gaston") by vger.kernel.org with ESMTP id S271691AbTG2NOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:14:20 -0400
Subject: [PATCH] Framebuffer: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059484419.8537.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 09:13:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a mecanism for in-kernel "clients" of a framebuffer
device to get notified of events on this framebuffer device. It adds
some basic Power Management callbacks based on this, and implements
support in fbcon.

This allows fbdev low level drivers to instruct clients like "fbcon"
to stop touching the framebuffer as the hardware is going to be
suspended, and to restore the display after resume. I also defined
(but didn't use yet) a mode change hook that would allow to restore
2.4 functionality of fbset to the fbdev driver keeping fbcon in sync
with the new mode (lots of users are asking for this).

There is room for improvement, but this is a first step that makes
suspend/resume work more reliably on pmacs. I'll send aty128fb and
radeonfb bits using this framework once it's merged.

Ben.

diff -urN linux-2.5/drivers/video/console/fbcon.c linuxppc-2.5-benh/drivers/video/console/fbcon.c
--- linux-2.5/drivers/video/console/fbcon.c	2003-07-29 08:51:30.000000000 -0400
+++ linuxppc-2.5-benh/drivers/video/console/fbcon.c	2003-06-04 10:03:18.000000000 -0400
@@ -199,7 +199,8 @@
 	if (!info || (info->cursor.rop == ROP_COPY))
 		return;
 	info->cursor.enable ^= 1;
-	info->fbops->fb_cursor(info, &info->cursor);
+	if (!info->suspended)
+		info->fbops->fb_cursor(info, &info->cursor);
 }
 
 #if (defined(__arm__) && defined(IRQ_VSYNCPULSE)) || defined(CONFIG_ATARI) || defined(CONFIG_MAC)
@@ -948,6 +949,9 @@
 	if (!height || !width)
 		return;
 
+	if (info->suspended)
+		return;
+
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;
@@ -972,6 +976,9 @@
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
 
+	if (info->suspended)
+		return;
+
 	accel_putc(vc, info, c, real_y(p, ypos), xpos);
 }
 
@@ -987,6 +994,9 @@
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
 
+	if (info->suspended)
+		return;
+
 	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
 }
 
@@ -1001,6 +1011,9 @@
 	int y = real_y(p, vc->vc_y);
 	struct fb_cursor cursor;
 	
+	if (info->suspended)
+		return;
+
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
 		if (softback_lines) {
@@ -1385,6 +1398,9 @@
 	if (!count || vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return 0;
 
+	if (info->suspended)
+		return 0;
+
 	fbcon_cursor(vc, CM_ERASE);
 
 	/*
@@ -1545,6 +1561,9 @@
 	if (!width || !height)
 		return;
 
+	if (info->suspended)
+		return;
+
 	/*  Split blits that cross physical y_wrap case.
 	 *  Pathological case involves 4 blits, better to use recursive
 	 *  code rather than unrolled case
@@ -1633,6 +1652,9 @@
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
+	if (info->suspended)
+		return 0;
+
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1704,6 +1726,9 @@
 	if (blank < 0)		/* Entering graphics mode */
 		return 0;
 
+	if (info->suspended)
+		return 0;
+
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
 	if (!info->fbops->fb_blank) {
@@ -2067,6 +2092,9 @@
 	int i, j, k;
 	u8 val;
 
+	if (info->suspended)
+		return 0;
+
 	if (!vc->vc_can_do_color
 	    || (!info->fbops->fb_blank && console_blanked))
 		return -EINVAL;
@@ -2171,6 +2199,9 @@
 	struct display *p = &fb_display[fg_console];
 	int offset, limit, scrollback_old;
 
+	if (info->suspended)
+		return 0;
+
 	if (softback_top) {
 		if (vc->vc_num != fg_console)
 			return 0;
@@ -2259,6 +2290,19 @@
 	return 0;
 }
 
+static void fbcon_suspended(void *data, struct fb_info *info)
+{
+	/* Here, we should do something to properly
+	 * synchronize with the cursor interrupt on
+	 * SMP...
+	 */
+}
+
+static void fbcon_resumed(void *data, struct fb_info *info)
+{
+	update_screen(fg_console);
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -2285,16 +2329,25 @@
 	.con_resize             = fbcon_resize,
 };
 
+static struct fb_client_ops fbcon_client = {
+	.owner			= THIS_MODULE,
+	.mode_changed		= NULL, /* TODO */
+	.suspended		= fbcon_suspended,
+	.resumed		= fbcon_resumed,
+};
+
 int __init fb_console_init(void)
 {
 	if (!num_registered_fb)
 		return -ENODEV;
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	register_fb_client(&fbcon_client, NULL);
 	return 0;
 }
 
 void __exit fb_console_exit(void)
 {
+	unregister_fb_client(&fbcon_client);
 	give_up_console(&fb_con);
 }	
 
diff -urN linux-2.5/drivers/video/fbmem.c linuxppc-2.5-benh/drivers/video/fbmem.c
--- linux-2.5/drivers/video/fbmem.c	2003-07-29 08:51:28.000000000 -0400
+++ linuxppc-2.5-benh/drivers/video/fbmem.c	2003-07-23 20:05:02.000000000 -0400
@@ -143,6 +143,8 @@
 extern int sstfb_setup(char*);
 extern int i810fb_init(void);
 extern int i810fb_setup(char*);
+extern int ibmlcdfb_init(void);
+extern int ibmlcdfb_setup(char*);
 extern int ffb_init(void);
 extern int ffb_setup(char*);
 extern int cg6_init(void);
@@ -250,6 +252,9 @@
 #ifdef CONFIG_FB_STI
 	{ "stifb", stifb_init, stifb_setup },
 #endif
+#ifdef CONFIG_FB_IBMLCDC
+	{ "ibmlcdfb", ibmlcdfb_init, ibmlcdfb_setup },
+#endif
 #ifdef CONFIG_FB_FFB
 	{ "ffb", ffb_init, ffb_setup },
 #endif
@@ -392,6 +397,9 @@
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
+static LIST_HEAD(fb_clients);
+static DECLARE_MUTEX(fb_clients_lock);
+
 #ifdef CONFIG_FB_OF
 static int ofonly __initdata = 0;
 #endif
@@ -935,6 +943,8 @@
 			fb_pan_display(info, &info->var);
 
 			fb_set_cmap(&info->cmap, 1, info);
+
+			fb_clients_call_mode_changed(info);
 		}
 	}
 	return 0;
@@ -1371,6 +1381,82 @@
 
 __setup("video=", video_setup);
 
+int
+fb_set_suspend(struct fb_info *info, int suspended)
+{
+	if (suspended == info->suspended)
+		return 0;
+
+	info->suspended = suspended;
+	if (suspended)
+		fb_clients_call_suspended(info);
+	else
+		fb_clients_call_resumed(info);
+
+	return 0;
+}
+
+int register_fb_client(struct fb_client_ops *ops, void *data)
+{
+	struct fb_client *client;
+
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if (client == NULL)
+		return -ENOMEM;
+
+	memset(client, 0, sizeof(*client));
+	client->ops = ops;
+	client->data = data;
+	
+	down(&fb_clients_lock);
+	list_add(&client->link, &fb_clients);
+	up(&fb_clients_lock);
+
+	return 0;
+}
+
+int unregister_fb_client(struct fb_client_ops *ops)
+{
+	struct fb_client *client = NULL;
+	struct list_head *pos;
+	
+	down(&fb_clients_lock);
+	list_for_each(pos, &fb_clients) {
+		client = list_entry(pos, struct fb_client, link);
+		if (client->ops == ops) {
+			list_del(&client->link);
+			kfree(client);
+			break;
+		}
+	}
+	up(&fb_clients_lock);
+
+	return 0;
+}
+
+#define make_fb_client_call(name) \
+int fb_clients_call_##name(struct fb_info *info) \
+{ \
+	struct fb_client *client = NULL; \
+	struct list_head *pos; \
+\
+	down(&fb_clients_lock); \
+	list_for_each(pos, &fb_clients) { \
+		client = list_entry(pos, struct fb_client, link); \
+		if (try_module_get(client->ops->owner)) { \
+			if (client->ops->name) \
+				client->ops->name(client->data, info); \
+			module_put(client->ops->owner); \
+		} \
+	} \
+	up(&fb_clients_lock); \
+	return 0; \
+}
+
+make_fb_client_call(mode_changed)
+make_fb_client_call(suspended)
+make_fb_client_call(resumed)
+
     /*
      *  Visible symbols for modules
      */
@@ -1387,5 +1473,11 @@
 EXPORT_SYMBOL(fb_get_buffer_offset);
 EXPORT_SYMBOL(move_buf_unaligned);
 EXPORT_SYMBOL(move_buf_aligned);
+EXPORT_SYMBOL(fb_set_suspend);
+EXPORT_SYMBOL(register_fb_client);
+EXPORT_SYMBOL(unregister_fb_client);
+EXPORT_SYMBOL(fb_clients_call_mode_changed);
+EXPORT_SYMBOL(fb_clients_call_suspended);
+EXPORT_SYMBOL(fb_clients_call_resumed);
 
 MODULE_LICENSE("GPL");
diff -urN linux-2.5/include/linux/fb.h linuxppc-2.5-benh/include/linux/fb.h
--- linux-2.5/include/linux/fb.h	2003-07-29 08:52:16.000000000 -0400
+++ linuxppc-2.5-benh/include/linux/fb.h	2003-07-23 20:05:24.000000000 -0400
@@ -352,6 +352,44 @@
 struct fb_info;
 struct vm_area_struct;
 struct file;
+struct fb_client;
+
+	/*
+	 * Framebuffer clients. Currently, this is only used
+	 * by fbcon to get notified of events on the framebuffer,
+	 * though that should be extended to the userland interface
+	 * some way.
+	 * 
+	 * We should also add more callbacks to better deal with
+	 * hotplug displays (add/removal notification). This is
+	 * not to replaced by a device class, though it could be
+	 * wrapped in a device interface according to the driver
+	 * model, I have to think more about it.
+	 * 
+	 * Locking rules: The callback should not take the console
+	 * semaphore explicitely (call acquire_console_sem()) as it
+	 * will typically already be owned.
+	 * 
+	 */ 
+struct fb_client_ops {	
+	struct module *owner;
+
+	/* Userland initiated mode change */
+	void	(*mode_changed)(void *data, struct fb_info *info);
+	/* The device is beeing suspended, do not access from
+	 * that point
+	 */
+	void	(*suspended)(void *data, struct fb_info *info);
+	/* The device is back to life, refresh screen
+	 */
+	void	(*resumed)(void *data, struct fb_info *info);
+};
+
+struct fb_client {
+	struct list_head	link;
+	struct fb_client_ops	*ops;
+	void			*data;
+};
 
     /*
      *  Frame buffer operations
@@ -399,6 +437,7 @@
    int node;
    int flags;
    int open;                            /* Has this been open already ? */
+   int suspended;			/* Is this currently suspended ? */
 #define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
    struct fb_var_screeninfo var;        /* Current var */
    struct fb_fix_screeninfo fix;        /* Current fix */
@@ -412,6 +451,7 @@
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+   
    /* From here on everything is device dependent */
    void *par;	
 };
@@ -575,6 +615,22 @@
 			       unsigned int default_bpp);
 #endif
 
+/* Power Management: called by low driver to notify other layers,
+ * driver should have acquired the console semaphore prior to
+ * calling this
+ */
+extern int fb_set_suspend(struct fb_info *info, int suspended);
+
+/*
+ * fb_client operations
+ */
+
+extern int register_fb_client(struct fb_client_ops *ops, void *data);
+extern int unregister_fb_client(struct fb_client_ops *ops);
+extern int fb_clients_call_mode_changed(struct fb_info *info);
+extern int fb_clients_call_suspended(struct fb_info *info);
+extern int fb_clients_call_resumed(struct fb_info *info);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_FB_H */

