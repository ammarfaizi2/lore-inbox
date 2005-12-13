Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVLMPQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVLMPQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLMPQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:16:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:50912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964970AbVLMPQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:16:04 -0500
Message-ID: <439EE5B0.2030709@suse.de>
Date: Tue, 13 Dec 2005 16:16:00 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] uml: Framebuffer driver for UML
References: <439EE38C.6020602@suse.de>
In-Reply-To: <439EE38C.6020602@suse.de>
Content-Type: multipart/mixed;
 boundary="------------040204070305050904010506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040204070305050904010506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

   Hi,

$subject says pretty much all: This adds a framebuffer driver for UML.

Output is rendered into an X11 window, X11 keyboard and mouse events are 
forwarded to the input system.  The patch also enables several 
subsystems for UML (fb, input) which are needed for a working 
framebuffer console.

The driver is activated by "x11=<width>x<height>@<fps>" on the kernel 
commane line.  width and height specify the size of the window and thus 
of the virtual framebuffer.  fps is the update rate in frames per second 
(maximum rate, only hit if there are frequent screen updates ...).

please apply,

   Gerd

--------------040204070305050904010506
Content-Type: text/plain;
 name="uml-x11-fb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-x11-fb"

Subject: [patch] uml: x11 fb
From: kraxel@suse.de

Framebuffer driver for UML

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
Index: linux-2.6.14/arch/um/Kconfig
===================================================================
--- linux-2.6.14.orig/arch/um/Kconfig	2005-12-12 10:37:32.000000000 +0100
+++ linux-2.6.14/arch/um/Kconfig	2005-12-12 10:38:39.000000000 +0100
@@ -121,6 +121,16 @@ config NET
 	recommended to read the NET-HOWTO, available from
 	<http://www.tldp.org/docs.html#howto>.
 
+source "drivers/input/Kconfig"
+source "drivers/char/Kconfig"
+source "drivers/video/Kconfig"
+
+config X11_FB
+	bool "X11 Framebuffer driver"
+	depends on FB && !MODE_TT && !STATIC_LINK
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 
 source "fs/Kconfig.binfmt"
 
Index: linux-2.6.14/arch/um/drivers/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/Makefile	2005-12-07 13:24:03.000000000 +0100
+++ linux-2.6.14/arch/um/drivers/Makefile	2005-12-12 10:38:39.000000000 +0100
@@ -16,6 +16,7 @@ hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
+x11-objs := x11_kern.o x11_user.o
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
 
@@ -48,6 +49,7 @@ obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
 obj-$(CONFIG_PTY_CHAN) += pty.o
 obj-$(CONFIG_TTY_CHAN) += tty.o 
+obj-$(CONFIG_X11_FB) += x11.o
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
Index: linux-2.6.14/arch/um/drivers/x11_kern.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14/arch/um/drivers/x11_kern.c	2005-12-12 17:10:48.000000000 +0100
@@ -0,0 +1,549 @@
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/fb.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/console.h>
+#include <linux/pagemap.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/platform_device.h>
+
+#include "irq_kern.h"
+#include "irq_user.h"
+#include "x11_kern.h"
+#include "x11_user.h"
+
+#define DRIVER_NAME "uml-x11-fb"
+
+/* ------------------------------------------------------------------ */
+
+static int x11_enable  = 0;
+static int x11_fps     = 5;
+static int x11_width;
+static int x11_height;
+
+struct x11_mapping {
+	struct list_head	  next;
+	struct vm_area_struct     *vma;
+	atomic_t                  map_refs;
+	int                       faults;
+	struct x11_kerndata       *kd;
+};
+
+struct x11_kerndata {
+	/* common stuff */
+	struct x11_window         *win;
+	struct task_struct        *kthread;
+	wait_queue_head_t         wq;
+	int                       has_data;
+
+	/* framebuffer driver */
+	unsigned char             *fb;
+	struct fb_fix_screeninfo  *fix;
+        struct fb_var_screeninfo  *var;
+	struct fb_info            *info;
+	struct timer_list         refresh;
+	int                       dirty, y1, y2;
+
+	/* fb mapping */
+	struct semaphore          mm_lock;
+	int                       nr_pages;
+	struct page               **pages;
+	struct list_head	  mappings;
+
+	/* input drivers */
+	struct input_dev          *kbd;
+	struct input_dev          *mouse;
+};
+
+void x11_update_screen(struct x11_kerndata *kd)
+{
+	int y1,y2,offset,length;
+	unsigned char *src, *dst;
+	struct list_head *item;
+	struct x11_mapping *map;
+
+	y1 = kd->y1;
+	y2 = kd->y2;
+	kd->dirty = kd->y1 = kd->y2 = 0;
+	down(&kd->mm_lock);
+	list_for_each(item, &kd->mappings) {
+		map = list_entry(item, struct x11_mapping, next);
+		if (!map->faults)
+			continue;
+		zap_page_range(map->vma, map->vma->vm_start,
+			       map->vma->vm_end - map->vma->vm_start, NULL);
+		map->faults = 0;
+	}
+	up(&kd->mm_lock);
+
+	offset = y1 * kd->fix->line_length;
+	length = (y2 - y1) * kd->fix->line_length;
+	src = kd->fb + offset;
+	dst = x11_get_fbmem(kd->win) + offset;
+	memcpy(dst,src,length);
+	x11_blit_fb(kd->win, y1, y2);
+}
+
+static int x11_thread(void *data)
+{
+	struct x11_kerndata *kd = data;
+	DECLARE_WAITQUEUE(wait,current);
+
+	add_wait_queue(&kd->wq, &wait);
+	for (;;) {
+		if (kthread_should_stop())
+			break;
+		if (kd->dirty)
+			x11_update_screen(kd);
+		if (kd->has_data) {
+			kd->has_data = 0;
+			x11_has_data(kd->win,kd);
+			reactivate_fd(x11_get_fd(kd->win), X11_IRQ);
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+	}
+	remove_wait_queue(&kd->wq, &wait);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* input driver                                                       */
+
+void x11_kbd_input(struct x11_kerndata *kd, int key, int down)
+{
+	if (key >= KEY_MAX) {
+		if (down)
+			printk("%s: unknown key pressed [%d]\n",
+			       __FUNCTION__, key-KEY_MAX);
+		return;
+	}
+	input_report_key(kd->kbd,key,down);
+	input_sync(kd->kbd);
+}
+
+void x11_mouse_input(struct x11_kerndata *kd, int key, int down,
+		     int x, int y)
+{
+	if (key != KEY_RESERVED)
+		input_report_key(kd->mouse, key, down);
+	input_report_abs(kd->mouse, ABS_X, x);
+	input_report_abs(kd->mouse, ABS_Y, y);
+	input_sync(kd->mouse);
+}
+
+void x11_cad(struct x11_kerndata *kd)
+{
+	printk("%s\n",__FUNCTION__);
+}
+
+/* ------------------------------------------------------------------ */
+/* framebuffer driver                                                 */
+
+static int x11_setcolreg(unsigned regno, unsigned red, unsigned green,
+			 unsigned blue, unsigned transp,
+			 struct fb_info *info)
+{
+	if (regno >= info->cmap.len)
+		return 1;
+
+	switch (info->var.bits_per_pixel) {
+	case 16:
+		if (info->var.red.offset == 10) {
+			/* 1:5:5:5 */
+			((u32*) (info->pseudo_palette))[regno] =
+				((red   & 0xf800) >>  1) |
+				((green & 0xf800) >>  6) |
+				((blue  & 0xf800) >> 11);
+		} else {
+			/* 0:5:6:5 */
+			((u32*) (info->pseudo_palette))[regno] =
+				((red   & 0xf800)      ) |
+				((green & 0xfc00) >>  5) |
+				((blue  & 0xf800) >> 11);
+		}
+		break;
+	case 24:
+		red   >>= 8;
+		green >>= 8;
+		blue  >>= 8;
+		((u32 *)(info->pseudo_palette))[regno] =
+			(red   << info->var.red.offset)   |
+			(green << info->var.green.offset) |
+			(blue  << info->var.blue.offset);
+		break;
+	case 32:
+		red   >>= 8;
+		green >>= 8;
+		blue  >>= 8;
+		((u32 *)(info->pseudo_palette))[regno] =
+			(red   << info->var.red.offset)   |
+			(green << info->var.green.offset) |
+			(blue  << info->var.blue.offset);
+		break;
+	}
+	return 0;
+}
+
+static void x11_fb_timer(unsigned long data)
+{
+	struct x11_kerndata *kd = (struct x11_kerndata*)data;
+	kd->dirty++;
+	wake_up(&kd->wq);
+}
+
+static void x11_fb_refresh(struct x11_kerndata *kd, int y1, int h)
+{
+	int y2;
+
+	y2 = y1 + h;
+	if (0 == kd->y2) {
+		kd->y1 = y1;
+		kd->y2 = y2;
+	}
+	if (kd->y1 > y1)
+		kd->y1 = y1;
+	if (kd->y2 < y2)
+		kd->y2 = y2;
+
+	if (timer_pending(&kd->refresh))
+		return;
+	mod_timer(&kd->refresh, jiffies + HZ/x11_fps);
+}
+
+void x11_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+{
+	struct x11_kerndata *kd = p->par;
+
+	cfb_fillrect(p, rect);
+	x11_fb_refresh(kd, rect->dy, rect->height);
+}
+
+void x11_imageblit(struct fb_info *p, const struct fb_image *image)
+{
+	struct x11_kerndata *kd = p->par;
+
+	cfb_imageblit(p, image);
+	x11_fb_refresh(kd, image->dy, image->height);
+}
+
+void x11_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+{
+	struct x11_kerndata *kd = p->par;
+
+	cfb_copyarea(p, area);
+	x11_fb_refresh(kd, area->dy, area->height);
+}
+
+/* ------------------------------------------------------------------ */
+
+static void
+x11_fb_vm_open(struct vm_area_struct *vma)
+{
+	struct x11_mapping *map = vma->vm_private_data;
+
+	atomic_inc(&map->map_refs);
+}
+
+static void
+x11_fb_vm_close(struct vm_area_struct *vma)
+{
+	struct x11_mapping *map = vma->vm_private_data;
+	struct x11_kerndata *kd = map->kd;
+
+	down(&kd->mm_lock);
+	if (atomic_dec_and_test(&map->map_refs)) {
+		list_del(&map->next);
+		kfree(map);
+	}
+	up(&kd->mm_lock);
+}
+
+static struct page*
+x11_fb_vm_nopage(struct vm_area_struct *vma, unsigned long vaddr,
+		 int *type)
+{
+	struct x11_mapping *map = vma->vm_private_data;
+	struct x11_kerndata *kd = map->kd;
+	int pgnr = (vaddr - vma->vm_start) >> PAGE_SHIFT;
+	struct page *page;
+	int y1,y2;
+
+        if (pgnr >= kd->nr_pages)
+		return NOPAGE_SIGBUS;
+
+	down(&kd->mm_lock);
+	page = kd->pages[pgnr];
+	get_page(page);
+	map->faults++;
+
+	y1 = pgnr * PAGE_SIZE / kd->fix->line_length;
+	y2 = (pgnr * PAGE_SIZE + PAGE_SIZE-1) / kd->fix->line_length;
+	if (y2 > kd->var->yres)
+		y2 = kd->var->yres;
+	x11_fb_refresh(kd, y1, y2 - y1);
+	up(&kd->mm_lock);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+	return page;
+}
+
+static struct vm_operations_struct x11_fb_vm_ops =
+{
+	.open     = x11_fb_vm_open,
+	.close    = x11_fb_vm_close,
+	.nopage   = x11_fb_vm_nopage,
+};
+
+int x11_mmap(struct fb_info *p, struct file *file,
+	     struct vm_area_struct * vma)
+{
+	struct x11_kerndata *kd = p->par;
+	struct x11_mapping *map;
+	int retval;
+	int map_pages;
+
+	down(&kd->mm_lock);
+
+	retval = -ENOMEM;
+	if (NULL == (map = kmalloc(sizeof(*map), GFP_KERNEL))) {
+		printk("%s: oops, out of memory\n",__FUNCTION__);
+		goto out;
+	}
+	memset(map,0,sizeof(*map));
+
+	retval = -EINVAL;
+	if (!(vma->vm_flags & VM_WRITE)) {
+		printk("%s: need writable mapping\n",__FUNCTION__);
+		goto out;
+	}
+	if (!(vma->vm_flags & VM_SHARED)) {
+		printk("%s: need shared mapping\n",__FUNCTION__);
+		goto out;
+	}
+	if (vma->vm_pgoff != 0) {
+		printk("%s: need offset 0 (vm_pgoff=%ld)\n",__FUNCTION__,
+		       vma->vm_pgoff);
+		goto out;
+	}
+
+	map_pages = (vma->vm_end - vma->vm_start + PAGE_SIZE-1) >> PAGE_SHIFT;
+	if (map_pages > kd->nr_pages) {
+		printk("%s: mapping to big (%ld > %d)\n",__FUNCTION__,
+		       vma->vm_end - vma->vm_start, p->fix.smem_len);
+		goto out;
+	}
+
+	map->vma = vma;
+	map->faults = 0;
+	map->kd = kd;
+	atomic_set(&map->map_refs,1);
+	list_add(&map->next,&kd->mappings);
+	vma->vm_ops   = &x11_fb_vm_ops;
+	vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
+	vma->vm_private_data = map;
+	retval = 0;
+
+out:
+	up(&kd->mm_lock);
+	return retval;
+}
+
+/* ------------------------------------------------------------------ */
+
+static struct fb_ops x11_fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= x11_setcolreg,
+	.fb_fillrect	= x11_fillrect,
+	.fb_copyarea	= x11_copyarea,
+	.fb_imageblit	= x11_imageblit,
+	.fb_mmap        = x11_mmap,
+};
+
+/* ---------------------------------------------------------------------------- */
+
+static irqreturn_t x11_irq(int irq, void *data, struct pt_regs *unused)
+{
+	struct x11_kerndata *kd = data;
+
+	kd->has_data++;
+	wake_up(&kd->wq);
+	return IRQ_HANDLED;
+}
+
+static int __init x11_probe(struct device *device)
+{
+	struct x11_kerndata *kd;
+	int i;
+
+	kd = kzalloc(sizeof(*kd),GFP_KERNEL);
+	if (NULL == kd)
+		return -ENOMEM;
+
+	kd->kbd   = input_allocate_device();
+	kd->mouse = input_allocate_device();
+	if (NULL == kd->kbd || NULL == kd->mouse)
+		goto fail_free;
+
+	kd->win = x11_open(x11_width, x11_height);
+	if (NULL == kd->win) {
+		printk(DRIVER_NAME ": can't open X11 window\n");
+		goto fail_free;
+	}
+	kd->fix = x11_get_fix(kd->win);
+	kd->var = x11_get_var(kd->win);
+	INIT_LIST_HEAD(&kd->mappings);
+
+	/* alloc memory */
+	kd->fb  = vmalloc(kd->fix->smem_len);
+	if (NULL == kd->fb) {
+		printk("%s: vmalloc(%d) failed\n",
+		       __FUNCTION__,kd->fix->smem_len);
+		goto fail_close;
+	}
+	memset(kd->fb,0,kd->fix->smem_len);
+	kd->nr_pages  = (kd->fix->smem_len + PAGE_SIZE-1) >> PAGE_SHIFT;
+	kd->pages = kmalloc(sizeof(struct page*)*kd->nr_pages, GFP_KERNEL);
+	if (NULL == kd->pages)
+		goto fail_vfree;
+	for (i = 0; i < kd->nr_pages; i++)
+		kd->pages[i] = vmalloc_to_page(kd->fb + i*PAGE_SIZE);
+
+	/* framebuffer setup */
+	kd->info = framebuffer_alloc(sizeof(u32) * 256, device);
+	kd->info->pseudo_palette = kd->info->par;
+	kd->info->par = kd;
+        kd->info->screen_base = kd->fb;
+
+	kd->info->fbops = &x11_fb_ops;
+	kd->info->var = *kd->var;
+	kd->info->fix = *kd->fix;
+	kd->info->flags = FBINFO_FLAG_DEFAULT;
+
+	fb_alloc_cmap(&kd->info->cmap, 256, 0);
+	register_framebuffer(kd->info);
+	printk(KERN_INFO "fb%d: %s frame buffer device, %dx%d, %d fps, %d bpp (%d:%d:%d)\n",
+	       kd->info->node, kd->info->fix.id,
+	       kd->var->xres, kd->var->yres, x11_fps, kd->var->bits_per_pixel,
+	       kd->var->red.length, kd->var->green.length, kd->var->blue.length);
+
+	/* keyboard setup */
+	set_bit(EV_KEY, kd->kbd->evbit);
+	for (i = 0; i < KEY_MAX; i++)
+		set_bit(i, kd->kbd->keybit);
+	kd->kbd->id.bustype = BUS_HOST;
+	kd->kbd->name = DRIVER_NAME " virtual keyboard";
+	kd->kbd->phys = DRIVER_NAME "/input0";
+	kd->kbd->cdev.dev = device;
+	input_register_device(kd->kbd);
+
+	/* mouse setup */
+        init_input_dev(kd->mouse);
+	set_bit(EV_ABS,     kd->mouse->evbit);
+	set_bit(EV_KEY,     kd->mouse->evbit);
+	set_bit(BTN_TOUCH,  kd->mouse->keybit);
+	set_bit(BTN_LEFT,   kd->mouse->keybit);
+	set_bit(BTN_MIDDLE, kd->mouse->keybit);
+	set_bit(BTN_RIGHT,  kd->mouse->keybit);
+	set_bit(ABS_X,      kd->mouse->absbit);
+	set_bit(ABS_Y,      kd->mouse->absbit);
+	kd->mouse->absmin[ABS_X] = 0;
+	kd->mouse->absmax[ABS_X] = kd->var->xres;
+	kd->mouse->absmin[ABS_Y] = 0;
+	kd->mouse->absmax[ABS_Y] = kd->var->yres;
+	kd->mouse->id.bustype = BUS_HOST;
+	kd->mouse->name = DRIVER_NAME " virtual mouse";
+	kd->mouse->phys = DRIVER_NAME "/input1";
+	kd->mouse->cdev.dev = device;
+	input_register_device(kd->mouse);
+
+	/* misc common kernel stuff */
+	init_MUTEX(&kd->mm_lock);
+	init_waitqueue_head(&kd->wq);
+	init_timer(&kd->refresh);
+	kd->refresh.function = x11_fb_timer;
+	kd->refresh.data     = (unsigned long)kd;
+
+	kd->kthread = kthread_run(x11_thread, kd,
+				  DRIVER_NAME " thread");
+	um_request_irq(X11_IRQ, x11_get_fd(kd->win), IRQ_READ, x11_irq,
+		       SA_INTERRUPT | SA_SHIRQ, DRIVER_NAME, kd);
+
+	return 0;
+
+fail_vfree:
+	vfree(kd->fb);
+fail_close:
+	x11_close(kd->win);
+fail_free:
+	if (kd->kbd)
+		input_free_device(kd->kbd);
+	if (kd->mouse)
+		input_free_device(kd->mouse);
+	kfree(kd);
+	return -ENODEV;
+}
+
+static struct device_driver x11_driver = {
+	.name  = DRIVER_NAME,
+	.bus   = &platform_bus_type,
+	.probe = x11_probe,
+};
+static struct platform_device x11_device = {
+	.name  = DRIVER_NAME,
+};
+
+static int __init x11_init(void)
+{
+	int ret;
+
+	ret = driver_register(&x11_driver);
+	if (ret)
+		return ret;
+	if (!x11_enable)
+		return 0;
+	ret = platform_device_register(&x11_device);
+	if (ret)
+		driver_unregister(&x11_driver);
+	return ret;
+}
+
+static void __exit x11_fini(void)
+{
+	if (x11_enable)
+		platform_device_unregister(&x11_device);
+	driver_unregister(&x11_driver);
+}
+
+module_init(x11_init);
+module_exit(x11_fini);
+
+extern int console_use_vt; /* FIXME */
+
+static int x11_setup(char *str)
+{
+	if (3 == sscanf(str,"%dx%d@%d",&x11_width,&x11_height,&x11_fps) ||
+	    2 == sscanf(str,"%dx%d",&x11_width,&x11_height)) {
+#if defined(CONFIG_DUMMY_CONSOLE)
+		printk("%s: enable linux vt subsystem\n",__FUNCTION__);
+		x11_enable = 1;
+		console_use_vt = 1;
+		conswitchp = &dummy_con;
+#endif
+		return 0;
+	}
+	return -1;
+}
+__setup("x11=", x11_setup);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2.6.14/arch/um/drivers/x11_user.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14/arch/um/drivers/x11_user.c	2005-12-12 17:12:27.000000000 +0100
@@ -0,0 +1,514 @@
+#include <stdlib.h>
+#include <string.h>
+
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+#include <linux/fb.h>
+#include <linux/input.h>
+
+#include <X11/X.h>
+#include <X11/Xlib.h>
+#include <X11/Xutil.h>
+#include <X11/keysym.h>
+#include <X11/extensions/XShm.h>
+
+#include "x11_kern.h"
+#include "x11_user.h"
+
+/* --------------------------------------------------------------------------- */
+
+struct x11_window {
+	/* misc x11 stuff */
+	Display                   *dpy;
+	Window                    root, win;
+	GC                        gc;
+	XVisualInfo               vi;
+	Atom                      delete_window;
+
+	/* framebuffer -- x11 */
+	XImage                    *ximage;
+	char                      *xidata;
+	XShmSegmentInfo           shminfo;
+
+	/* framebuffer -- kernel */
+	struct fb_fix_screeninfo  fix;
+        struct fb_var_screeninfo  var;
+
+	/* kbd state */
+	unsigned char keydown[32];
+};
+
+/* --------------------------------------------------------------------------- */
+
+/*
+ * map X11 keycodes to linux keycodes
+ *
+ * WARNING: X11 keycodes are not portable, this likely breaks as soon
+ * as one uses a X-Server not running on a linux machine as display.
+ *
+ * Using portable keysyms instead creates some strange and hard to
+ * handle keymapping effects through.  That happens because both host
+ * and uml machine are mapping keys then ...
+ *
+ * FIXME: Our pseudo mouse driver delivers absolute coordinates in a
+ * touchscreen-like manner.  Everybody (gpm, x.org) seems to interpret
+ * those as relative coordinates though.
+ */
+static int x11_keymap[] = {
+	[   9 ] = KEY_ESC,
+	[  10 ] = KEY_1,
+	[  11 ] = KEY_2,
+	[  12 ] = KEY_3,
+	[  13 ] = KEY_4,
+	[  14 ] = KEY_5,
+	[  15 ] = KEY_6,
+	[  16 ] = KEY_7,
+	[  17 ] = KEY_8,
+	[  18 ] = KEY_9,
+	[  19 ] = KEY_0,
+	[  20 ] = KEY_MINUS,
+	[  21 ] = KEY_EQUAL,
+	[  22 ] = KEY_BACKSPACE,
+
+	[  23 ] = KEY_TAB,
+	[  24 ] = KEY_Q,
+	[  25 ] = KEY_W,
+	[  26 ] = KEY_E,
+	[  27 ] = KEY_R,
+	[  28 ] = KEY_T,
+	[  29 ] = KEY_Y,
+	[  30 ] = KEY_U,
+	[  31 ] = KEY_I,
+	[  32 ] = KEY_O,
+	[  33 ] = KEY_P,
+	[  34 ] = KEY_LEFTBRACE,
+	[  35 ] = KEY_RIGHTBRACE,
+	[  36 ] = KEY_ENTER,
+
+	[  37 ] = KEY_LEFTCTRL,
+	[  38 ] = KEY_A,
+	[  39 ] = KEY_S,
+	[  40 ] = KEY_D,
+	[  41 ] = KEY_F,
+	[  42 ] = KEY_G,
+	[  43 ] = KEY_H,
+	[  44 ] = KEY_J,
+	[  45 ] = KEY_K,
+	[  46 ] = KEY_L,
+	[  47 ] = KEY_SEMICOLON,
+	[  48 ] = KEY_APOSTROPHE,
+	[  49 ] = KEY_GRAVE,
+
+	[  50 ] = KEY_LEFTSHIFT,
+	[  51 ] = KEY_BACKSLASH,
+	[  52 ] = KEY_Z,
+	[  53 ] = KEY_X,
+	[  54 ] = KEY_C,
+	[  55 ] = KEY_V,
+	[  56 ] = KEY_B,
+	[  57 ] = KEY_N,
+	[  58 ] = KEY_M,
+	[  59 ] = KEY_COMMA,
+	[  60 ] = KEY_DOT,
+	[  61 ] = KEY_SLASH,
+	[  62 ] = KEY_RIGHTSHIFT,
+
+	[  63 ] = KEY_KPASTERISK,
+	[  64 ] = KEY_LEFTALT,
+	[  65 ] = KEY_SPACE,
+	[  66 ] = KEY_CAPSLOCK,
+
+	[  67 ] = KEY_F1,
+	[  68 ] = KEY_F2,
+	[  69 ] = KEY_F3,
+	[  70 ] = KEY_F4,
+	[  71 ] = KEY_F5,
+	[  72 ] = KEY_F6,
+	[  73 ] = KEY_F7,
+	[  74 ] = KEY_F8,
+	[  75 ] = KEY_F9,
+	[  76 ] = KEY_F10,
+	[  77 ] = KEY_NUMLOCK,
+	[  78 ] = KEY_SCROLLLOCK,
+
+	[  79 ] = KEY_KP7,
+	[  80 ] = KEY_KP8,
+	[  81 ] = KEY_KP9,
+	[  82 ] = KEY_KPMINUS,
+	[  83 ] = KEY_KP4,
+	[  84 ] = KEY_KP5,
+	[  85 ] = KEY_KP6,
+	[  86 ] = KEY_KPPLUS,
+	[  87 ] = KEY_KP1,
+	[  88 ] = KEY_KP2,
+	[  89 ] = KEY_KP3,
+	[  90 ] = KEY_KP0,
+	[  91 ] = KEY_KPDOT,
+
+	// [  92 ] = KEY_Print,
+	// [  93 ] = KEY_Mode_switch,
+	[  94 ] = KEY_102ND,
+
+	[  95 ] = KEY_F11,
+	[  96 ] = KEY_F12,
+	[  97 ] = KEY_HOME,
+	[  98 ] = KEY_UP,
+	[  99 ] = KEY_PAGEUP,
+	[ 100 ] = KEY_LEFT,
+	[ 102 ] = KEY_RIGHT,
+	[ 103 ] = KEY_END,
+	[ 104 ] = KEY_DOWN,
+	[ 105 ] = KEY_PAGEDOWN,
+	[ 106 ] = KEY_INSERT,
+	[ 107 ] = KEY_DELETE,
+
+	// [ 108 ] = KEY_KP_Enter,
+	[ 109 ] = KEY_RIGHTCTRL,
+	// [ 110 ] = KEY_Pause,
+	// [ 111 ] = KEY_Print,
+	// [ 112 ] = KEY_KP_Divide,
+	[ 113 ] = KEY_RIGHTALT,
+	// [ 114 ] = KEY_Pause,
+	// [ 115 ] = KEY_Super_L,
+	// [ 116 ] = KEY_Super_R,
+	[ 117 ] = KEY_MENU,
+	// [ 124 ] = KEY_ISO_Level3_Shift,
+	// [ 126 ] = KEY_KP_Equal,
+};
+
+static void x11_kbd_send(struct x11_window *win, struct x11_kerndata *kd,
+			 int keycode, int updown)
+{
+	int key = KEY_RESERVED;
+
+	if (keycode < sizeof(x11_keymap)/sizeof(x11_keymap[0]))
+		key = x11_keymap[keycode];
+	if (KEY_RESERVED == key)
+		return;
+	x11_kbd_input(kd, key, updown);
+	if (keycode < 256) {
+		int by = keycode / 8;
+		int bi = keycode % 8;
+		if (updown)
+			win->keydown[by] |= (1 << bi);
+		else
+			win->keydown[by] &= ~(1 << bi);
+	}
+}
+
+static void x11_kbd(struct x11_window *win, struct x11_kerndata *kd, XEvent *e)
+{
+	int updown = 0;
+	unsigned long by,bi;
+
+	switch (e->type) {
+	case KeyPress:
+		updown = 1;
+		/* fall though */
+	case KeyRelease:
+		x11_kbd_send(win, kd, e->xkey.keycode, updown);
+		break;
+	case KeymapNotify:
+		for (by = 0; by < 32; by++) {
+			if (win->keydown[by] == e->xkeymap.key_vector[by])
+				continue;
+			for (bi = 0; bi < 8; bi++) {
+				if ((win->keydown[by] & (1 << bi)) ==
+				    (e->xkeymap.key_vector[by] & (1 << bi)))
+					continue;
+				updown = e->xkeymap.key_vector[by] & (1 << bi)
+					? 1 : 0;
+				x11_kbd_send(win, kd, by * 8 + bi, updown);
+			}
+		}
+		break;
+	}
+}
+
+static int x11_mousemap[] = {
+	[ Button1 ] = BTN_LEFT,    /* BTN_TOUCH ??? */
+	[ Button2 ] = BTN_MIDDLE,
+	[ Button3 ] = BTN_RIGHT,
+	[ Button4 ] = BTN_FORWARD, /* is this the wheel ??? */
+	[ Button5 ] = BTN_BACK,    /* is this the wheel ??? */
+};
+
+static void x11_mouse(struct x11_window *win, struct x11_kerndata *kd,
+		      XEvent *e)
+{
+	int key = KEY_RESERVED;
+
+	if (e->xbutton.button < sizeof(x11_mousemap)/sizeof(x11_mousemap[0]))
+		key = x11_mousemap[e->xbutton.button];
+	x11_mouse_input(kd, key, e->type == ButtonPress,
+			e->xbutton.x, e->xbutton.y);
+}
+
+/* --------------------------------------------------------------------------- */
+
+static int mitshm_err;
+
+static int
+catch_no_mitshm(Display * dpy, XErrorEvent * event)
+{
+	mitshm_err++;
+	return 0;
+}
+
+static void init_color(int32_t mask, struct fb_bitfield *bf)
+{
+	int i;
+
+	memset(bf, 0, sizeof(*bf));
+	for (i = 0; i < 32; i++) {
+		if (mask & ((int32_t)1 << i))
+			bf->length++;
+		else if (!bf->length)
+			bf->offset++;
+	}
+}
+
+struct x11_window *x11_open(int width, int height)
+{
+	char *title = "user mode linux framebuffer";
+	struct x11_window *win;
+	XSizeHints hints;
+	XTextProperty prop;
+	XVisualInfo *info, template;
+	void *old_handler;
+	int n,bytes_pp;
+
+	win = malloc(sizeof(*win));
+	if (NULL == win)
+		goto fail;
+
+	win->dpy = XOpenDisplay(NULL);
+	if (NULL == win->dpy)
+		goto fail_free;
+
+	/* get visual info */
+	template.screen = XDefaultScreen(win->dpy);
+	template.depth  = DefaultDepth(win->dpy, DefaultScreen(win->dpy));
+	info = XGetVisualInfo(win->dpy, VisualScreenMask | VisualDepthMask,
+			      &template, &n);
+	if (0 == n)
+		goto fail_free;
+	win->vi = info[0];
+	XFree(info);
+	if (win->vi.class != TrueColor && win->vi.class != DirectColor)
+		goto fail_free;
+
+	/* create pixmap */
+	mitshm_err  = 0;
+	old_handler = XSetErrorHandler(catch_no_mitshm);
+	win->ximage = XShmCreateImage(win->dpy,win->vi.visual,win->vi.depth,
+				      ZPixmap, NULL, &win->shminfo,
+				      width, height);
+	if (NULL == win->ximage)
+		goto shm_error;
+	bytes_pp = win->ximage->bits_per_pixel/8;
+	win->shminfo.shmid = shmget(IPC_PRIVATE,
+				    win->ximage->bytes_per_line * win->ximage->height,
+				    IPC_CREAT | 0777);
+	if (-1 == win->shminfo.shmid)
+		goto shm_error;
+	win->shminfo.shmaddr = (char *) shmat(win->shminfo.shmid, 0, 0);
+	if ((void *)-1 == win->shminfo.shmaddr)
+		goto shm_error;
+
+	win->ximage->data = win->shminfo.shmaddr;
+	win->shminfo.readOnly = False;
+        XShmAttach(win->dpy, &win->shminfo);
+	XSync(win->dpy, False);
+	if (mitshm_err)
+		goto shm_error;
+	shmctl(win->shminfo.shmid, IPC_RMID, 0);
+	XSetErrorHandler(old_handler);
+	goto have_ximage;
+
+shm_error:
+	/* can't use shared memory -- cleanup and try without */
+	if (win->ximage) {
+		XDestroyImage(win->ximage);
+		win->ximage = NULL;
+#if 1
+		/*
+		   Hmm, seems not to work without MIT shm, maybe due
+                   to the amount of data being sent over the socket
+                   then?  What does libX11 when writing to the socket
+		   returns -EAGAIN?
+		*/
+		goto fail_free;
+#endif
+	}
+	if ((void *)-1 != win->shminfo.shmaddr  &&  NULL != win->shminfo.shmaddr)
+		shmdt(win->shminfo.shmaddr);
+	XSetErrorHandler(old_handler);
+
+	memset(&win->shminfo,0,sizeof(win->shminfo));
+	if (NULL == (win->xidata = malloc(width * height *
+					  (win->vi.depth > 16) ? 4 : 2)))
+		goto fail_free;
+
+	win->ximage = XCreateImage(win->dpy, win->vi.visual, win->vi.depth,
+				   ZPixmap, 0,  win->xidata,
+				   width, height, 8, 0);
+	bytes_pp = win->ximage->bits_per_pixel/8;
+
+have_ximage:
+	/* fill structs */
+	win->var.xres           = width;
+	win->var.xres_virtual   = width;
+	win->var.yres           = height;
+	win->var.yres_virtual   = height;
+	win->var.bits_per_pixel = bytes_pp * 8;
+	win->var.pixclock       = 10000000 / win->var.xres * 1000 / win->var.yres;
+	win->var.left_margin    = (win->var.xres / 8) & 0xf8;
+	win->var.hsync_len      = (win->var.xres / 8) & 0xf8;
+
+	init_color(win->vi.red_mask,   &win->var.red);
+	init_color(win->vi.green_mask, &win->var.green);
+	init_color(win->vi.blue_mask,  &win->var.blue);
+
+	win->var.activate       = FB_ACTIVATE_NOW;
+	win->var.height		= -1;
+	win->var.width		= -1;
+	win->var.right_margin	= 32;
+	win->var.upper_margin	= 16;
+	win->var.lower_margin	= 4;
+	win->var.vsync_len	= 4;
+	win->var.vmode		= FB_VMODE_NONINTERLACED;
+
+	win->fix.visual         = FB_VISUAL_TRUECOLOR;
+	win->fix.line_length    = win->ximage->bytes_per_line;
+	win->fix.smem_start     = 0;
+	win->fix.smem_len       = win->fix.line_length * win->var.yres;
+
+	strcpy(win->fix.id,"x11");
+	win->fix.type		= FB_TYPE_PACKED_PIXELS;
+	win->fix.accel		= FB_ACCEL_NONE;
+
+	/* create + init window */
+	hints.flags      = PMinSize | PMaxSize;
+	hints.min_width  = width;
+	hints.min_height = height;
+	hints.max_width  = width;
+	hints.max_height = height;
+	XStringListToTextProperty(&title,1,&prop);
+
+	win->root  = RootWindow(win->dpy, DefaultScreen(win->dpy));
+	win->win = XCreateSimpleWindow(win->dpy, win->root,
+				       0, 0, width, height,
+				       CopyFromParent, CopyFromParent,
+				       BlackPixel(win->dpy, DefaultScreen(win->dpy)));
+	win->gc = XCreateGC(win->dpy, win->win, 0, NULL);
+	XSelectInput(win->dpy, win->win,
+		     KeyPressMask    | KeyReleaseMask    | /* virtual keyboard */
+		     ButtonPressMask | ButtonReleaseMask | /* mouse (touchscreen?) */
+		     PointerMotionMask | ExposureMask | StructureNotifyMask |
+		     PropertyChangeMask | KeymapStateMask);
+	XMapWindow(win->dpy,win->win);
+	XSetWMNormalHints(win->dpy,win->win,&hints);
+	XSetWMName(win->dpy,win->win,&prop);
+	win->delete_window = XInternAtom(win->dpy, "WM_DELETE_WINDOW", False);
+	XSetWMProtocols(win->dpy, win->win, &win->delete_window, 1);
+
+	XFlush(win->dpy);
+	return win;
+
+fail_free:
+	free(win);
+fail:
+	return NULL;
+}
+
+void x11_close(struct x11_window *win)
+{
+	if (win->shminfo.shmid) {
+		XShmDetach(win->dpy, &win->shminfo);
+		XDestroyImage(win->ximage);
+		shmdt(win->shminfo.shmaddr);
+	} else {
+		XDestroyImage(win->ximage);
+	}
+	XDestroyWindow(win->dpy,win->win);
+	XCloseDisplay(win->dpy);
+}
+
+int x11_get_fd(struct x11_window *win)
+{
+	return ConnectionNumber(win->dpy);
+}
+
+struct fb_fix_screeninfo* x11_get_fix(struct x11_window *win)
+{
+	return &win->fix;
+}
+
+struct fb_var_screeninfo* x11_get_var(struct x11_window *win)
+{
+	return &win->var;
+}
+
+void* x11_get_fbmem(struct x11_window *win)
+{
+	return win->ximage->data;
+}
+
+int x11_blit_fb(struct x11_window *win, int y1, int y2)
+{
+	int x1 = 0;
+	int x2 = win->var.xres;
+
+	if (win->shminfo.shmid) {
+		XShmPutImage(win->dpy, win->win, win->gc, win->ximage,
+			     x1,y1,x1,y1, x2-x1,y2-y1, True);
+	} else {
+		XPutImage(win->dpy, win->win, win->gc, win->ximage,
+			  x1,y1,x1,y1, x2-x1,y2-y1);
+	}
+	XFlush(win->dpy);
+	return 0;
+}
+
+int x11_has_data(struct x11_window *win, struct x11_kerndata *kd)
+{
+	XEvent e;
+	int count = 0;
+
+	while (True == XCheckMaskEvent(win->dpy, ~0, &e)) {
+		count++;
+		switch (e.type) {
+		case KeyPress:
+		case KeyRelease:
+		case KeymapNotify:
+			x11_kbd(win, kd, &e);
+			break;
+		case ButtonPress:
+		case ButtonRelease:
+			x11_mouse(win, kd, &e);
+			break;
+		case MotionNotify:
+			x11_mouse_input(kd, KEY_RESERVED, 0,
+			                e.xmotion.x, e.xmotion.y);
+			break;
+		case Expose:
+			if (0 == e.xexpose.count)
+				x11_blit_fb(win, 0, win->var.yres);
+			break;
+		case ClientMessage:
+			/* hmm, don't get client messages ... */
+			if (e.xclient.data.l[0] == win->delete_window)
+				x11_cad(kd);
+			break;
+		}
+	}
+	return count;
+}
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2.6.14/arch/um/include/x11_kern.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14/arch/um/include/x11_kern.h	2005-12-12 10:38:39.000000000 +0100
@@ -0,0 +1,9 @@
+/* x11_kern */
+
+struct x11_window;
+struct x11_kerndata;
+
+void x11_kbd_input(struct x11_kerndata *kd, int key, int down);
+void x11_mouse_input(struct x11_kerndata *kd, int key, int down,
+		     int x, int y);
+void x11_cad(struct x11_kerndata *kd);
Index: linux-2.6.14/arch/um/include/x11_user.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14/arch/um/include/x11_user.h	2005-12-12 10:38:39.000000000 +0100
@@ -0,0 +1,15 @@
+/* x11_user */
+
+struct x11_window;
+struct x11_kerndata;
+
+struct x11_window *x11_open(int width, int height);
+void x11_close(struct x11_window *win);
+int x11_has_data(struct x11_window *win, struct x11_kerndata *kd);
+int x11_blit_fb(struct x11_window *win, int y1, int y2);
+
+int x11_get_fd(struct x11_window *win);
+struct fb_fix_screeninfo* x11_get_fix(struct x11_window *win);
+struct fb_var_screeninfo* x11_get_var(struct x11_window *win);
+void* x11_get_fbmem(struct x11_window *win);
+
Index: linux-2.6.14/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/um_arch.c	2005-12-12 10:37:32.000000000 +0100
+++ linux-2.6.14/arch/um/kernel/um_arch.c	2005-12-12 17:11:22.000000000 +0100
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -14,6 +14,7 @@
 #include "linux/bootmem.h"
 #include "linux/spinlock.h"
 #include "linux/utsname.h"
+#include "linux/console.h"
 #include "linux/sysrq.h"
 #include "linux/seq_file.h"
 #include "linux/delay.h"
@@ -58,7 +59,7 @@ static void add_arg(char *arg)
 	strcat(command_line, arg);
 }
 
-struct cpuinfo_um boot_cpu_data = { 
+struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
 	.ipi_pipe		= { -1, -1 }
 };
@@ -148,20 +149,20 @@ void set_cmdline(char *cmd)
 
 	umid = get_umid(1);
 	if(umid != NULL){
-		snprintf(argv1_begin, 
-			 (argv1_end - argv1_begin) * sizeof(*ptr), 
+		snprintf(argv1_begin,
+			 (argv1_end - argv1_begin) * sizeof(*ptr),
 			 "(%s) ", umid);
 		ptr = &argv1_begin[strlen(argv1_begin)];
 	}
 	else ptr = argv1_begin;
 
 	snprintf(ptr, (argv1_end - ptr) * sizeof(*ptr), "[%s]", cmd);
-	memset(argv1_begin + strlen(argv1_begin), '\0', 
+	memset(argv1_begin + strlen(argv1_begin), '\0',
 	       argv1_end - argv1_begin - strlen(argv1_begin));
 #endif
 }
 
-static char *usage_string = 
+static char *usage_string =
 "User Mode Linux v%s\n"
 "	available at http://user-mode-linux.sourceforge.net/\n\n";
 
@@ -206,7 +207,7 @@ static int __init uml_ncpus_setup(char *
 
 __uml_setup("ncpus=", uml_ncpus_setup,
 "ncpus=<# of desired CPUs>\n"
-"    This tells an SMP kernel how many virtual processors to start.\n\n" 
+"    This tells an SMP kernel how many virtual processors to start.\n\n"
 );
 #endif
 
@@ -387,7 +388,7 @@ int linux_main(int argc, char **argv)
 	argv1_begin = argv[1];
 	argv1_end = &argv[1][strlen(argv[1])];
 #endif
-  
+
 	highmem = 0;
 	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
 	max_physmem = get_kmem_end() - uml_physmem - iomem_size - MIN_VMALLOC;
@@ -456,6 +457,8 @@ static struct notifier_block panic_exit_
 	.priority 		= 0
 };
 
+extern int console_use_vt; /* FIXME */
+
 void __init setup_arch(char **cmdline_p)
 {
 	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
@@ -463,6 +466,9 @@ void __init setup_arch(char **cmdline_p)
         strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
+#if defined(CONFIG_DUMMY_CONSOLE)
+	console_use_vt = 0;
+#endif
 }
 
 void __init check_bugs(void)
Index: linux-2.6.14/drivers/video/fbmem.c
===================================================================
--- linux-2.6.14.orig/drivers/video/fbmem.c	2005-12-12 10:37:58.000000000 +0100
+++ linux-2.6.14/drivers/video/fbmem.c	2005-12-12 10:38:39.000000000 +0100
@@ -1182,12 +1182,16 @@ fb_mmap(struct file *file, struct vm_are
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+#elif defined(CONFIG_UML)
+	/* nothing */
 #else
 #warning What do we have to do here??
 #endif
+#ifndef CONFIG_UML
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
+#endif
 #endif /* !__sparc_v9__ */
 	return 0;
 #endif /* !sparc32 */
Index: linux-2.6.14/include/asm-um/irq.h
===================================================================
--- linux-2.6.14.orig/include/asm-um/irq.h	2005-12-07 13:24:03.000000000 +0100
+++ linux-2.6.14/include/asm-um/irq.h	2005-12-12 10:38:39.000000000 +0100
@@ -15,8 +15,9 @@
 #define SIGIO_WRITE_IRQ 	11
 #define TELNETD_IRQ 		12
 #define XTERM_IRQ 		13
+#define X11_IRQ 		14
 
-#define LAST_IRQ XTERM_IRQ
+#define LAST_IRQ X11_IRQ
 #define NR_IRQS (LAST_IRQ + 1)
 
 #endif
Index: linux-2.6.14/drivers/char/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/char/Kconfig	2005-12-12 10:37:33.000000000 +0100
+++ linux-2.6.14/drivers/char/Kconfig	2005-12-12 10:38:39.000000000 +0100
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UML
+	depends on VT && !S390
 	default y
 
 config SERIAL_NONSTANDARD
Index: linux-2.6.14/arch/um/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/Makefile	2005-12-12 10:37:32.000000000 +0100
+++ linux-2.6.14/arch/um/Makefile	2005-12-12 10:38:39.000000000 +0100
@@ -126,12 +126,22 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
+ifeq ($(SUBARCH),x86_64)
+  libdir = lib64
+else
+  libdir = lib
+endif
+UML_LIBS := -L/usr/$(libdir) -lutil
+ifeq ($(CONFIG_X11_FB),y)
+UML_LIBS += -L/usr/X11R6/$(libdir) -lX11 -lXext
+endif
+
 CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
 	-Wl,--start-group $(vmlinux-main) -Wl,--end-group \
-	-lutil \
+	$(UML_LIBS) \
 	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) \
 	FORCE ,$^) ; rm -f linux
 endef

--------------040204070305050904010506--
