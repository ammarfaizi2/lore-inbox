Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUAAUzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUAAUyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:54:54 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:44585 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264931AbUAAUDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:43 -0500
Date: Thu, 1 Jan 2004 21:03:37 +0100
Message-Id: <200401012003.i01K3bG7031950@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 386] Genrtc warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Genrtc: Move code to kill warning if CONFIG_PROC_FS is disabled

--- linux-2.6.0/drivers/char/genrtc.c	2003-07-14 13:16:05.000000000 +0200
+++ linux-m68k-2.6.0/drivers/char/genrtc.c	2003-11-28 09:38:55.000000000 +0100
@@ -375,68 +375,13 @@
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
-
 
 /*
  *	Info exported via "/proc/rtc".
  */
 
-#ifdef CONFIG_PROC_FS
-
 static int gen_rtc_proc_output(char *buf)
 {
 	char *p;
@@ -524,6 +469,58 @@
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
