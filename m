Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUGMLQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUGMLQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUGMLQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:16:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:10112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264908AbUGMLQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:16:32 -0400
Message-ID: <40F3C48F.30905@suse.de>
Date: Tue, 13 Jul 2004 13:16:31 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: hotplug <linux-hotplug-devel@lists.sourceforge.net>
Subject: [PATCH] Enable all events for initramfs
Content-Type: multipart/mixed;
 boundary="------------070904040203040305050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904040203040305050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

currently most driver events are not sent out when using initramfs as 
driver_init() (which triggers the events) is called before init_workqueues.

This patch rearranges the init calls so that the hotplug event queue is 
enabled prior to calling driver_init(), hence we're getting all hotplug 
events again.

Patch is relative to 2.6.7-mm6, but should apply to 2.6.8-rc1 also.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------070904040203040305050202
Content-Type: text/x-patch;
 name="early-hotplug-events.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="early-hotplug-events.patch"

--- linux-2.6.7-mm6/init/main.c.orig	2004-07-09 11:01:04.000000000 +0200
+++ linux-2.6.7-mm6/init/main.c	2004-07-09 11:14:19.000000000 +0200
@@ -93,6 +93,7 @@
 extern void populate_rootfs(void);
 extern void driver_init(void);
 extern void prepare_namespace(void);
+extern void usermodehelper_init(void);
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -599,6 +600,10 @@
  */
 static void __init do_basic_setup(void)
 {
+	/* drivers will send hotplug events */
+	init_workqueues();
+	usermodehelper_init();
+
 	driver_init();
 
 #ifdef CONFIG_SYSCTL
@@ -608,7 +613,6 @@
 	/* Networking initialization needs a process context */ 
 	sock_init();
 
-	init_workqueues();
 	do_initcalls();
 }
 
--- linux-2.6.7-mm6/kernel/kmod.c.orig	2004-07-09 11:02:32.000000000 +0200
+++ linux-2.6.7-mm6/kernel/kmod.c	2004-07-13 14:11:09.287575443 +0200
@@ -272,10 +272,8 @@
 }
 EXPORT_SYMBOL(call_usermodehelper);
 
-static __init int usermodehelper_init(void)
+void __init usermodehelper_init(void)
 {
 	khelper_wq = create_singlethread_workqueue("khelper");
 	BUG_ON(!khelper_wq);
-	return 0;
 }
-core_initcall(usermodehelper_init);

--------------070904040203040305050202--
