Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSCWPl4>; Sat, 23 Mar 2002 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCWPlr>; Sat, 23 Mar 2002 10:41:47 -0500
Received: from [212.30.75.51] ([212.30.75.51]:9600 "EHLO
	radovan.kista.gajba.net") by vger.kernel.org with ESMTP
	id <S293306AbSCWPld>; Sat, 23 Mar 2002 10:41:33 -0500
Date: Sat, 23 Mar 2002 16:42:20 +0100
From: Boris Bezlaj <boris@kista.gajba.net>
To: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: mdacon.c minor cleanups
Message-Id: <20020323164220.742414d2.boris@kista.gajba.net>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Im resending mdacon.c patch if anyone is interested including it..

Its just a small cleanup(a part of kernel-janitor TODO).
Added module description, module_init/exit(), printk() parameters,...
Tested on 2.4.x, but not on 2.5(patches/compiles fine..)

Flames/improvements welcome..

Boris B.


--- drivers/video/mdacon.c.orig	Fri Sep 14 01:04:43 2001
+++ drivers/video/mdacon.c	Thu Feb 14 18:07:20 2002
@@ -78,7 +78,7 @@
 static int	mda_first_vc = 13;
 static int	mda_last_vc  = 16;
 
-static struct vc_data	*mda_display_fg = NULL;
+static struct vc_data	*mda_display_fg;
 
 MODULE_PARM(mda_first_vc, "1-255i");
 MODULE_PARM(mda_last_vc,  "1-255i");
@@ -338,7 +338,7 @@
 	mda_type_name = "MDA";
 
 	if (! mda_detect()) {
-		printk("mdacon: MDA card not detected.\n");
+		printk(KERN_WARNING __FILE__ ": MDA card not detected.\n");
 		return NULL;
 	}
 
@@ -349,7 +349,7 @@
 	/* cursor looks ugly during boot-up, so turn it off */
 	mda_set_cursor(mda_vram_len - 1);
 
-	printk("mdacon: %s with %ldK of memory detected.\n",
+	printk(KERN_INFO __FILE__ ": %s with %ldK of memory detected.\n",
 		mda_type_name, mda_vram_len/1024);
 
 	return "MDA-2";
@@ -605,28 +605,23 @@
 	con_invert_region:	mdacon_invert_region,
 };
 
-void __init mda_console_init(void)
+int __init mda_console_init(void)
 {
 	if (mda_first_vc > mda_last_vc)
-		return;
+		return -EINVAL;
 
 	take_over_console(&mda_con, mda_first_vc-1, mda_last_vc-1, 0);
-}
-
-#ifdef MODULE
-
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	mda_console_init();
-
 	return 0;
 }
 
-void cleanup_module(void)
+void __exit mda_console_exit(void)
 {
 	give_up_console(&mda_con);
 }
 
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MDA console driver. Default console allocation: vc/13 - vc/16");
+module_init(mda_console_init);
+module_exit(mda_console_exit);
 #endif
