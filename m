Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVAaRrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVAaRrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAaRps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:45:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22284 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261289AbVAaRnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:43:47 -0500
Date: Mon, 31 Jan 2005 18:43:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/vt*: possible cleanups
Message-ID: <20050131174346.GX18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly gloval code static
- vt_ioctl.c: removed the global variable keyboard_type since noone
              did actually set it to any other value

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/vt.c        |   17 +++++++++--------
 drivers/char/vt_ioctl.c  |   13 +++++--------
 include/linux/keyboard.h |    1 -
 include/linux/vt_kern.h  |    6 ------
 4 files changed, 14 insertions(+), 23 deletions(-)

--- linux-2.6.11-rc2-mm2-full/include/linux/vt_kern.h.old	2005-01-31 15:48:36.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/vt_kern.h	2005-01-31 15:51:23.000000000 +0100
@@ -35,16 +35,11 @@
 int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int lines);
 void vc_disallocate(unsigned int console);
 void reset_palette(struct vc_data *vc);
-void set_palette(struct vc_data *vc);
 void do_blank_screen(int entering_gfx);
 void do_unblank_screen(int leaving_gfx);
 void unblank_screen(void);
 void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
-int con_font_set(struct vc_data *vc, struct console_font_op *op);
-int con_font_get(struct vc_data *vc, struct console_font_op *op);
-int con_font_default(struct vc_data *vc, struct console_font_op *op);
-int con_font_copy(struct vc_data *vc, struct console_font_op *op);
 int con_set_cmap(unsigned char __user *cmap);
 int con_get_cmap(unsigned char __user *cmap);
 void scrollback(struct vc_data *vc, int lines);
@@ -75,7 +70,6 @@
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc);
 
 /* vt.c */
-void complete_change_console(struct vc_data *vc);
 int vt_waitactive(int vt);
 void change_console(struct vc_data *new_vc);
 void reset_vc(struct vc_data *vc);
--- linux-2.6.11-rc2-mm2-full/drivers/char/vt.c.old	2005-01-31 15:47:16.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/vt.c	2005-01-31 15:50:51.000000000 +0100
@@ -144,6 +144,7 @@
 static void hide_cursor(struct vc_data *vc);
 static void console_callback(void *ignored);
 static void blank_screen_t(unsigned long dummy);
+static void set_palette(struct vc_data *vc);
 
 static int printable;		/* Is console ready for printing? */
 
@@ -732,7 +733,7 @@
 	return 0;
 }
 
-inline int resize_screen(struct vc_data *vc, int width, int height)
+static inline int resize_screen(struct vc_data *vc, int width, int height)
 {
 	/* Resizes the resolution of the display adapater */
 	int err = 0;
@@ -2138,7 +2139,7 @@
  * The console must be locked when we get here.
  */
 
-void vt_console_print(struct console *co, const char *b, unsigned count)
+static void vt_console_print(struct console *co, const char *b, unsigned count)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	unsigned char c;
@@ -2233,7 +2234,7 @@
 	return console_driver;
 }
 
-struct console vt_console_driver = {
+static struct console vt_console_driver = {
 	.name		= "tty",
 	.write		= vt_console_print,
 	.device		= vt_console_device,
@@ -2899,7 +2900,7 @@
  *	Palettes
  */
 
-void set_palette(struct vc_data *vc)
+static void set_palette(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
@@ -2990,7 +2991,7 @@
 
 #define max_font_size 65536
 
-int con_font_get(struct vc_data *vc, struct console_font_op *op)
+static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font;
 	int rc = -EINVAL;
@@ -3045,7 +3046,7 @@
 	return rc;
 }
 
-int con_font_set(struct vc_data *vc, struct console_font_op *op)
+static int con_font_set(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font;
 	int rc = -EINVAL;
@@ -3102,7 +3103,7 @@
 	return rc;
 }
 
-int con_font_default(struct vc_data *vc, struct console_font_op *op)
+static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font = {.width = op->width, .height = op->height};
 	char name[MAX_FONT_NAME];
@@ -3132,7 +3133,7 @@
 	return rc;
 }
 
-int con_font_copy(struct vc_data *vc, struct console_font_op *op)
+static int con_font_copy(struct vc_data *vc, struct console_font_op *op)
 {
 	int con = op->height;
 	int rc;
--- linux-2.6.11-rc2-mm2-full/include/linux/keyboard.h.old	2005-01-31 15:52:55.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/keyboard.h	2005-01-31 15:53:00.000000000 +0100
@@ -27,7 +27,6 @@
 extern const int max_vals[];
 extern unsigned short *key_maps[MAX_NR_KEYMAPS];
 extern unsigned short plain_map[NR_KEYS];
-extern unsigned char keyboard_type;
 #endif
 
 #define MAX_NR_FUNC	256	/* max nr of strings assigned to keys */
--- linux-2.6.11-rc2-mm2-full/drivers/char/vt_ioctl.c.old	2005-01-31 15:51:37.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/vt_ioctl.c	2005-01-31 15:53:13.000000000 +0100
@@ -33,7 +33,7 @@
 #include <linux/kbd_diacr.h>
 #include <linux/selection.h>
 
-char vt_dont_switch;
+static char vt_dont_switch;
 extern struct tty_driver *console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
@@ -52,15 +52,12 @@
  * to the current console is done by the main ioctl code.
  */
 
-/* Keyboard type: Default is KB_101, but can be set by machine
- * specific code.
- */
-unsigned char keyboard_type = KB_101;
-
 #ifdef CONFIG_X86
 #include <linux/syscalls.h>
 #endif
 
+static void complete_change_console(struct vc_data *vc);
+
 /*
  * these are the valid i/o ports we're allowed to change. they map all the
  * video ports
@@ -416,7 +413,7 @@
 		/*
 		 * this is naive.
 		 */
-		ucval = keyboard_type;
+		ucval = KB_101;
 		goto setchar;
 
 		/*
@@ -1068,7 +1065,7 @@
 /*
  * Performs the back end of a vt switch
  */
-void complete_change_console(struct vc_data *vc)
+static void complete_change_console(struct vc_data *vc)
 {
 	unsigned char old_vc_mode;
 

