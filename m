Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272861AbTG3NOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272872AbTG3NOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:14:51 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:45184
	"EHLO gaston") by vger.kernel.org with ESMTP id S272861AbTG3NOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:14:42 -0400
Subject: [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1059567270.8545.70.camel@gaston>
References: <1059484419.8537.19.camel@gaston>
	 <20030729174919.GC2601@openzaurus.ucw.cz> <1059567270.8545.70.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059570860.2418.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 09:14:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resent with proper recipients list, sorry)

So, here's a new version that removes checking for suspend field
all over fbcon. I tried it here with a modified radeonfb that sets
the fbops to some dummy functions (provided by fbmem.c in this
patch though you may want to move them around).
In theory, I could implement power management properly without the client
notification mecanism by just setting the dummy fbops and directly calling
update_screen from the low level fbdev on resume, but that doesn't smell
good. The console subsystem is a bit of a nightmare to me, James, can we
currently have several consoles on several heads ? (that currcons in
vt.c is disturbing me). It may be worth doing better than just update_screen
(fg_console) when resuming in fbcon.c... (this callback will be called for
each fbdev who is waking up).

Let me know what you think, in all cases, asap so I can push the remaining
fbdev driver bits.

Ben.

===== drivers/video/fbmem.c 1.77 vs edited =====
--- 1.77/drivers/video/fbmem.c	Mon May 26 20:51:43 2003
+++ edited/drivers/video/fbmem.c	Wed Jul 30 08:59:06 2003
@@ -392,6 +392,9 @@
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
+static LIST_HEAD(fb_clients);
+static DECLARE_MUTEX(fb_clients_lock);
+
 #ifdef CONFIG_FB_OF
 static int ofonly __initdata = 0;
 #endif
@@ -935,6 +938,8 @@
 			fb_pan_display(info, &info->var);
 
 			fb_set_cmap(&info->cmap, 1, info);
+
+			fb_clients_call_mode_changed(info);
 		}
 	}
 	return 0;
@@ -1371,6 +1376,107 @@
 
 __setup("video=", video_setup);
 
+/*
+ * Dummy operations used typically when power managing
+ */
+
+int fb_dummy_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	return 0;
+}
+
+void fb_dummy_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+}
+
+void fb_dummy_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+}
+
+void fb_dummy_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+}
+
+/*
+ * Wrappers to client calls
+ */
+
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
@@ -1387,5 +1493,15 @@
 EXPORT_SYMBOL(fb_get_buffer_offset);
 EXPORT_SYMBOL(move_buf_unaligned);
 EXPORT_SYMBOL(move_buf_aligned);
+EXPORT_SYMBOL(fb_set_suspend);
+EXPORT_SYMBOL(register_fb_client);
+EXPORT_SYMBOL(unregister_fb_client);
+EXPORT_SYMBOL(fb_clients_call_mode_changed);
+EXPORT_SYMBOL(fb_clients_call_suspended);
+EXPORT_SYMBOL(fb_clients_call_resumed);
+EXPORT_SYMBOL(fb_dummy_fillrect);
+EXPORT_SYMBOL(fb_dummy_copyarea);
+EXPORT_SYMBOL(fb_dummy_imageblit);
+EXPORT_SYMBOL(fb_dummy_cursor);
 
 MODULE_LICENSE("GPL");
===== drivers/video/console/fbcon.c 1.102 vs edited =====
--- 1.102/drivers/video/console/fbcon.c	Tue May  6 09:50:50 2003
+++ edited/drivers/video/console/fbcon.c	Wed Jul 30 08:59:44 2003
@@ -2259,6 +2259,19 @@
 	return 0;
 }
 
+static void fbcon_suspended(void *data, struct fb_info *info)
+{
+	/* Here, we should do something to properly erase the
+	 * cursor and synchronize with the cursor interrupt on
+	 * SMP... (may not be that critical though...)
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
@@ -2285,16 +2298,25 @@
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
 
===== include/linux/fb.h 1.53 vs edited =====
--- 1.53/include/linux/fb.h	Thu Apr 24 06:30:41 2003
+++ edited/include/linux/fb.h	Wed Jul 30 09:01:06 2003
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
@@ -475,6 +515,10 @@
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect); 
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
+extern int fb_dummy_cursor(struct fb_info *info, struct fb_cursor *cursor);
+extern void fb_dummy_fillrect(struct fb_info *info, const struct fb_fillrect *rect); 
+extern void fb_dummy_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
+extern void fb_dummy_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
@@ -574,6 +618,22 @@
 			       const struct fb_videomode *default_mode,
 			       unsigned int default_bpp);
 #endif
+
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
 
 #endif /* __KERNEL__ */
 
