Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136850AbREJQuK>; Thu, 10 May 2001 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136851AbREJQt7>; Thu, 10 May 2001 12:49:59 -0400
Received: from adsl-64-168-227-89.dsl.sntc01.pacbell.net ([64.168.227.89]:5383
	"EHLO brian-laptop.dyn.us.mvd") by vger.kernel.org with ESMTP
	id <S136850AbREJQtt>; Thu, 10 May 2001 12:49:49 -0400
Date: Thu, 10 May 2001 09:49:53 -0700
From: "Brian J. Murrell" <brian@mountainviewdata.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ip autoconfig with modules, kernel 2.4
Message-ID: <20010510094953.C28095@brian-laptop.us.mvd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please CC me on any responses as I don't read the kernel-list in my
inbox.  Thanx.

I am looking for comments on the attached patch.  It's purpose is to
allow IP AutoConfig to happen additionally after the loading of an
initial ramdisk.

This allows one to use a "generic all-purpose" built kernel (i.e. a
fully modular kernel) to retrieve it's IP configuration via BOOTP or
RARP (and DHCP when that is ported into 2.4) as long as the ethernet
driver module for the installed ethernet card is loaded via the
initial ramdisk.

Of course, this elminates the need to build kernels with lots of
statically linked ethernet drivers or building lots of kernels with
specific drivers statically linked in.

My hope is that this is seen as a good idea (and a good
implementation) and that the patch is accepted into the Linux kernel.

All comments welcome.

Thanx,
b.


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Description: Patch for ipautoconfig with ethernet modules
Content-Disposition: attachment; filename="linux-2.4.2-ip-autoconf.patch"

--- linux-2.2.17.old/init/main.c.orig	Tue Mar 27 15:59:08 2001
+++ linux-2.2.17/init/main.c	Tue Mar 27 16:01:03 2001
@@ -132,6 +132,10 @@
 kdev_t real_root_dev;
 #endif
 
+#if CONFIG_IP_PNP
+extern int __init ip_auto_config(void);
+#endif
+
 int root_mountflags = MS_RDONLY;
 char *execute_command;
 
@@ -863,6 +863,9 @@
 			while (pid != wait(&i));
 		if (MAJOR(real_root_dev) != RAMDISK_MAJOR
 		     || MINOR(real_root_dev) != 0) {
+#if CONFIG_IP_PNP
+			ip_auto_config();
+#endif
 			error = change_root(real_root_dev,"/initrd");
 			if (error)
 				printk(KERN_ERR "Change root to /initrd: "
--- linux/net/ipv4/ipconfig.c	Wed May  9 00:05:43 2001
+++ linux/net/ipv4/ipconfig.c.new	Wed May  9 00:05:41 2001
@@ -823,7 +823,7 @@
  *	IP Autoconfig dispatcher.
  */
 
-static int __init ip_auto_config(void)
+int __init ip_auto_config(void)
 {
 	if (!ic_enable)
 		return 0;

--+g7M9IMkV8truYOl--
