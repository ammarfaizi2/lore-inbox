Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTI0Bjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 21:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTI0Bjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 21:39:52 -0400
Received: from dp.samba.org ([66.70.73.150]:52616 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261988AbTI0Bjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 21:39:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] try_and_request_module() improvements 
In-reply-to: Your message of "Wed, 17 Sep 2003 00:53:54 MST."
             <20030917075354.GF10078@gaz.sfgoth.com> 
Date: Sat, 27 Sep 2003 11:37:33 +1000
Message-Id: <20030927013944.E56C32C0FF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030917075354.GF10078@gaz.sfgoth.com> you write:
> With the GCC ({}) extension it shouldn't be too bad:
> 
> 	({ might_sleep();			\
> 	   current_definition_goes_here;	\
> 	 })

OK, here 'tis.

Haven't actually tested it yet, but this is for feedback.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Request Module Returns Void
Author: Mitchell Blank Jr <mitch@sfgoth.com>, Rusty Russell
Status: Booted on 2.6.0-test5-bk3

D: request_module returns an error code: you can't rely on that, so don't.
D: The module might have been removed again, or not register what you want:
D: you have to search again.  Remove the temptation: make it return void.
D: 
D: Also, use a macro if !CONFIG_KMOD, to get rid of the string literal.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/drivers/ide/ide-probe.c .27081-linux-2.6.0-test5-bk12.updated/drivers/ide/ide-probe.c
--- .27081-linux-2.6.0-test5-bk12/drivers/ide/ide-probe.c	2003-09-22 10:27:58.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/drivers/ide/ide-probe.c	2003-09-27 11:29:38.000000000 +1000
@@ -1164,15 +1164,15 @@ struct kobject *ata_probe(dev_t dev, int
 		return NULL;
 	if (drive->driver == &idedefault_driver) {
 		if (drive->media == ide_disk)
-			(void) request_module("ide-disk");
+			request_module("ide-disk");
 		if (drive->scsi)
-			(void) request_module("ide-scsi");
+			request_module("ide-scsi");
 		if (drive->media == ide_cdrom || drive->media == ide_optical)
-			(void) request_module("ide-cd");
+			request_module("ide-cd");
 		if (drive->media == ide_tape)
-			(void) request_module("ide-tape");
+			request_module("ide-tape");
 		if (drive->media == ide_floppy)
-			(void) request_module("ide-floppy");
+			request_module("ide-floppy");
 	}
 	if (drive->driver == &idedefault_driver)
 		return NULL;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/drivers/ide/ide.c .27081-linux-2.6.0-test5-bk12.updated/drivers/ide/ide.c
--- .27081-linux-2.6.0-test5-bk12/drivers/ide/ide.c	2003-09-22 10:27:58.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/drivers/ide/ide.c	2003-09-27 11:29:38.000000000 +1000
@@ -448,7 +448,7 @@ void ide_probe_module (void)
 {
 	if (!ide_probe) {
 #if defined(CONFIG_KMOD) && defined(CONFIG_BLK_DEV_IDE_MODULE)
-		(void) request_module("ide-probe-mod");
+		request_module("ide-probe-mod");
 #endif /* (CONFIG_KMOD) && (CONFIG_BLK_DEV_IDE_MODULE) */
 	} else {
 		(void)ide_probe();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/drivers/media/video/zoran_card.c .27081-linux-2.6.0-test5-bk12.updated/drivers/media/video/zoran_card.c
--- .27081-linux-2.6.0-test5-bk12/drivers/media/video/zoran_card.c	2003-09-22 10:27:59.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/drivers/media/video/zoran_card.c	2003-09-27 11:29:38.000000000 +1000
@@ -1349,12 +1349,7 @@ find_zr36057 (void)
 		}
 
 		if (i2c_dec_name) {
-			if ((result = request_module(i2c_dec_name)) < 0) {
-				dprintk(1,
-					KERN_ERR
-					"%s: failed to load module %s: %d\n",
-					ZR_DEVNAME(zr), i2c_dec_name, result);
-			}
+			request_module(i2c_dec_name);
 		}
 
 		/* i2c encoder */
@@ -1369,12 +1364,7 @@ find_zr36057 (void)
 		}
 
 		if (i2c_enc_name) {
-			if ((result = request_module(i2c_enc_name)) < 0) {
-				dprintk(1,
-					KERN_ERR
-					"%s: failed to load module %s: %d\n",
-					ZR_DEVNAME(zr), i2c_enc_name, result);
-			}
+			request_module(i2c_enc_name);
 		}
 
 		if (zoran_register_i2c(zr) < 0) {
@@ -1392,22 +1382,12 @@ find_zr36057 (void)
 		if (zr->card.video_codec != 0 &&
 		    (codec_name =
 		     codecid_to_modulename(zr->card.video_codec)) != NULL) {
-			if ((result = request_module(codec_name)) < 0) {
-				dprintk(1,
-					KERN_ERR
-					"%s: failed to load modules %s: %d\n",
-					ZR_DEVNAME(zr), codec_name, result);
-			}
+			request_module(codec_name);
 		}
 		if (zr->card.video_vfe != 0 &&
 		    (vfe_name =
 		     codecid_to_modulename(zr->card.video_vfe)) != NULL) {
-			if ((result = request_module(vfe_name)) < 0) {
-				dprintk(1,
-					KERN_ERR
-					"%s: failed to load modules %s: %d\n",
-					ZR_DEVNAME(zr), vfe_name, result);
-			}
+			request_module(vfe_name);
 		}
 
 		/* reset JPEG codec */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/drivers/mtd/chips/chipreg.c .27081-linux-2.6.0-test5-bk12.updated/drivers/mtd/chips/chipreg.c
--- .27081-linux-2.6.0-test5-bk12/drivers/mtd/chips/chipreg.c	2003-09-22 10:09:01.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/drivers/mtd/chips/chipreg.c	2003-09-27 11:29:38.000000000 +1000
@@ -63,11 +63,7 @@ struct mtd_info *do_map_probe(const char
 	struct mtd_chip_driver *drv;
 	struct mtd_info *ret;
 
-	drv = get_mtd_chip_driver(name);
-
-	if (!drv && !request_module("%s", name))
-		drv = get_mtd_chip_driver(name);
-
+	drv = try_then_request_module(get_mtd_chip_driver(name), "%s", name);
 	if (!drv)
 		return NULL;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/drivers/mtd/mtdpart.c .27081-linux-2.6.0-test5-bk12.updated/drivers/mtd/mtdpart.c
--- .27081-linux-2.6.0-test5-bk12/drivers/mtd/mtdpart.c	2003-09-22 10:22:14.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/drivers/mtd/mtdpart.c	2003-09-27 11:29:38.000000000 +1000
@@ -526,11 +526,8 @@ int parse_mtd_partitions(struct mtd_info
 	int ret = 0;
 		
 	for ( ; ret <= 0 && *types; types++) {
-		parser = get_partition_parser(*types);
-#ifdef CONFIG_KMOD
-		if (!parser && !request_module("%s", *types))
-				parser = get_partition_parser(*types);
-#endif
+		parser = try_then_request_module(get_partition_parser(*types),
+						 "%s", *types);
 		if (!parser) {
 			printk(KERN_NOTICE "%s partition parsing not available\n",
 			       *types);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/fs/dquot.c .27081-linux-2.6.0-test5-bk12.updated/fs/dquot.c
--- .27081-linux-2.6.0-test5-bk12/fs/dquot.c	2003-09-22 10:23:11.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/fs/dquot.c	2003-09-27 11:29:38.000000000 +1000
@@ -129,10 +129,8 @@ static struct quota_format_type *find_qu
 		int qm;
 
 		for (qm = 0; module_names[qm].qm_fmt_id && module_names[qm].qm_fmt_id != id; qm++);
-		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name)) {
-			actqf = NULL;
-			goto out;
-		}
+		if (!module_names[qm].qm_fmt_id)
+			request_module(module_names[qm].qm_mod_name);
 		for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
 		if (actqf && !try_module_get(actqf->qf_owner))
 			actqf = NULL;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/fs/filesystems.c .27081-linux-2.6.0-test5-bk12.updated/fs/filesystems.c
--- .27081-linux-2.6.0-test5-bk12/fs/filesystems.c	2003-09-22 10:09:07.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/fs/filesystems.c	2003-09-27 11:29:38.000000000 +1000
@@ -209,21 +209,18 @@ int get_filesystem_list(char * buf)
 	return len;
 }
 
-struct file_system_type *get_fs_type(const char *name)
+static struct file_system_type *__get_fs_type(const char *name)
 {
 	struct file_system_type *fs;
-
 	read_lock(&file_systems_lock);
 	fs = *(find_filesystem(name));
 	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
 	read_unlock(&file_systems_lock);
-	if (!fs && (request_module("%s", name) == 0)) {
-		read_lock(&file_systems_lock);
-		fs = *(find_filesystem(name));
-		if (fs && !try_module_get(fs->owner))
-			fs = NULL;
-		read_unlock(&file_systems_lock);
-	}
 	return fs;
 }
+
+struct file_system_type *get_fs_type(const char *name)
+{
+	return try_then_request_module(__get_fs_type(name), "%s", name);
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/fs/nls/nls_base.c .27081-linux-2.6.0-test5-bk12.updated/fs/nls/nls_base.c
--- .27081-linux-2.6.0-test5-bk12/fs/nls/nls_base.c	2003-09-26 11:08:06.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/fs/nls/nls_base.c	2003-09-27 11:29:38.000000000 +1000
@@ -227,12 +227,12 @@ struct nls_table *load_nls(char *charset
 		return nls;
 
 #ifdef CONFIG_KMOD
-	ret = request_module("nls_%s", charset);
-	if (ret != 0) {
+	request_module("nls_%s", charset);
+	nls = find_nls(charset);
+	if (!nls) {
 		printk("Unable to load NLS charset %s\n", charset);
 		return NULL;
 	}
-	nls = find_nls(charset);
 #endif
 	return nls;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/include/linux/kmod.h .27081-linux-2.6.0-test5-bk12.updated/include/linux/kmod.h
--- .27081-linux-2.6.0-test5-bk12/include/linux/kmod.h	2003-09-22 10:28:12.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/include/linux/kmod.h	2003-09-27 11:31:50.000000000 +1000
@@ -20,16 +20,19 @@
  */
 
 #include <linux/config.h>
+#include <linux/kernel.h>
+/* FIXME Sep 2003: Too many files rely on this #include indirectly.  Remove */
 #include <linux/errno.h>
-#include <linux/compiler.h>
 
 #ifdef CONFIG_KMOD
-extern int request_module(const char * name, ...) __attribute__ ((format (printf, 1, 2)));
+extern void request_module(const char *name, ...) __attribute__ ((format (printf, 1, 2)));
+#define try_then_request_module(x, mod...) \
+	({ might_sleep(); (x) ?: ({ request_module(mod); (x); }); })
 #else
-static inline int request_module(const char * name, ...) { return -ENOSYS; }
+#define request_module(name...)
+#define try_then_request_module(x, mod...)	{( might_sleep(); (x); )}
 #endif
 
-#define try_then_request_module(x, mod...) ((x) ?: (request_module(mod), (x)))
 extern int call_usermodehelper(char *path, char *argv[], char *envp[], int wait);
 
 #ifdef CONFIG_HOTPLUG
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27081-linux-2.6.0-test5-bk12/kernel/kmod.c .27081-linux-2.6.0-test5-bk12.updated/kernel/kmod.c
--- .27081-linux-2.6.0-test5-bk12/kernel/kmod.c	2003-09-22 10:28:13.000000000 +1000
+++ .27081-linux-2.6.0-test5-bk12.updated/kernel/kmod.c	2003-09-27 11:29:38.000000000 +1000
@@ -49,16 +49,14 @@ char modprobe_path[256] = "/sbin/modprob
  * request_module - try to load a kernel module
  * @module_name: Name of module
  *
- * Load a module using the user mode module loader. The function returns
- * zero on success or a negative errno code on failure. Note that a
- * successful module load does not mean the module did not then unload
- * and exit on an error of its own. Callers must check that the service
- * they requested is now available not blindly invoke it.
+ * Load a module using the user mode module loader.  Callers must check
+ * that the service they requested is now available not blindly invoke it:
+ * see try_then_request_module().
  *
  * If module auto-loading support is disabled then this function
  * becomes a no-operation.
  */
-int request_module(const char *fmt, ...)
+void request_module(const char *fmt, ...)
 {
 	va_list args;
 	char module_name[MODULE_NAME_LEN];
@@ -76,8 +74,11 @@ int request_module(const char *fmt, ...)
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
-	if (ret >= MODULE_NAME_LEN)
-		return -ENAMETOOLONG;
+	if (ret >= MODULE_NAME_LEN) {
+		printk(KERN_ERR "request_module for %i chars\n", ret);
+		return;
+	}
+		
 
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
@@ -100,7 +101,7 @@ int request_module(const char *fmt, ...)
 			       "request_module: runaway loop modprobe %s\n",
 			       module_name);
 		atomic_dec(&kmod_concurrent);
-		return -ENOMEM;
+		return;
 	}
 
 	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
@@ -115,7 +116,6 @@ int request_module(const char *fmt, ...)
 		}
 	}
 	atomic_dec(&kmod_concurrent);
-	return ret;
 }
 #endif /* CONFIG_KMOD */
 
