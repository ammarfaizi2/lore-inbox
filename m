Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264576AbTLGVcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTLGV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:28:44 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:22599 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S264545AbTLGUzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:54 -0500
Date: Sun, 7 Dec 2003 21:51:34 +0100
Message-Id: <200312072051.hB7KpYNZ000801@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 145] Genrtc warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Genrtc: Move code to kill warning if CONFIG_PROC_FS is disabled

--- linux-2.4.23/drivers/char/genrtc.c	2003-05-09 11:02:26.000000000 +0200
+++ linux-m68k-2.4.23/drivers/char/genrtc.c	2003-11-30 17:37:51.000000000 +0100
@@ -378,69 +378,13 @@
 	return 0;
 }
 
-static int gen_rtc_read_proc(char *page, char **start, off_t off,
-			     int count, int *eof, void *data);
-
-
-/*
- *	The various file operations we support.
- */
-
-static struct file_operations gen_rtc_fops = {
-	.owner		= THIS_MODULE,
-#ifdef CONFIG_GEN_RTC_X
-	.read		= gen_rtc_read,
-	.poll		= gen_rtc_poll,
-#endif
-	.ioctl		= gen_rtc_ioctl,
-	.open		= gen_rtc_open,
-	.release	= gen_rtc_release,
-};
-
-static struct miscdevice rtc_gen_dev =
-{
-	.minor		= RTC_MINOR,
-	.name		= "rtc",
-	.fops		= &gen_rtc_fops,
-};
-
-static int __init rtc_generic_init(void)
-{
-	int retval;
-
-	printk(KERN_INFO "Generic RTC Driver v%s\n", RTC_VERSION);
-
-	retval = misc_register(&rtc_gen_dev);
-	if(retval < 0)
-		return retval;
 
 #ifdef CONFIG_PROC_FS
-	if((create_proc_read_entry ("driver/rtc", 0, 0, gen_rtc_read_proc, NULL)) == NULL){
-		misc_deregister(&rtc_gen_dev);
-		return -ENOMEM;
-	}
-#endif
-
-	return 0;
-}
-
-static void __exit rtc_generic_exit(void)
-{
-	remove_proc_entry ("driver/rtc", NULL);
-	misc_deregister(&rtc_gen_dev);
-}
-
-module_init(rtc_generic_init);
-module_exit(rtc_generic_exit);
-EXPORT_NO_SYMBOLS;
-
 
 /*
  *	Info exported via "/proc/rtc".
  */
 
-#ifdef CONFIG_PROC_FS
-
 static int gen_rtc_proc_output(char *buf)
 {
 	char *p;
@@ -528,6 +472,59 @@
 #endif /* CONFIG_PROC_FS */
 
 
+/*
+ *	The various file operations we support.
+ */
+
+static struct file_operations gen_rtc_fops = {
+	.owner		= THIS_MODULE,
+#ifdef CONFIG_GEN_RTC_X
+	.read		= gen_rtc_read,
+	.poll		= gen_rtc_poll,
+#endif
+	.ioctl		= gen_rtc_ioctl,
+	.open		= gen_rtc_open,
+	.release	= gen_rtc_release,
+};
+
+static struct miscdevice rtc_gen_dev =
+{
+	.minor		= RTC_MINOR,
+	.name		= "rtc",
+	.fops		= &gen_rtc_fops,
+};
+
+static int __init rtc_generic_init(void)
+{
+	int retval;
+
+	printk(KERN_INFO "Generic RTC Driver v%s\n", RTC_VERSION);
+
+	retval = misc_register(&rtc_gen_dev);
+	if(retval < 0)
+		return retval;
+
+#ifdef CONFIG_PROC_FS
+	if((create_proc_read_entry ("driver/rtc", 0, 0, gen_rtc_read_proc, NULL)) == NULL){
+		misc_deregister(&rtc_gen_dev);
+		return -ENOMEM;
+	}
+#endif
+
+	return 0;
+}
+
+static void __exit rtc_generic_exit(void)
+{
+	remove_proc_entry ("driver/rtc", NULL);
+	misc_deregister(&rtc_gen_dev);
+}
+
+
+module_init(rtc_generic_init);
+module_exit(rtc_generic_exit);
+EXPORT_NO_SYMBOLS;
+
 MODULE_AUTHOR("Richard Zidlicky");
 MODULE_LICENSE("GPL");
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
