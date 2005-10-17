Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVJQWlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVJQWlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVJQWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:40:56 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33219 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932354AbVJQWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:40:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH 3/4] swsusp: two simplifications
Date: Mon, 17 Oct 2005 23:58:30 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200510172336.53194.rjw@sisk.pl>
In-Reply-To: <200510172336.53194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172358.31349.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch simplifies the progress meter in disk.c:free_some_memory()
and makes disk.c:pm_suspend_disk() call device_resume() explicitly in the
suspend path.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/disk.c	2005-10-17 23:28:33.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/disk.c	2005-10-17 23:28:52.000000000 +0200
@@ -92,10 +92,7 @@
 	printk("Freeing memory...  ");
 	while ((tmp = shrink_all_memory(10000))) {
 		pages += tmp;
-		printk("\b%c", p[i]);
-		i++;
-		if (i > 3)
-			i = 0;
+		printk("\b%c", p[i++ % 4]);
 	}
 	printk("\bdone (%li pages freed)\n", pages);
 }
@@ -177,13 +174,12 @@
 		goto Done;
 
 	if (in_suspend) {
+		device_resume();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
 		else {
-		/* swsusp_write can not fail in device_resume,
-		   no need to do second device_resume */
 			swsusp_free();
 			unprepare_processes();
 			return error;
Index: linux-2.6.14-rc4-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/swsusp.c	2005-10-17 23:28:47.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/swsusp.c	2005-10-17 23:28:52.000000000 +0200
@@ -562,7 +562,7 @@
 int swsusp_write(void)
 {
 	int error;
-	device_resume();
+
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */

