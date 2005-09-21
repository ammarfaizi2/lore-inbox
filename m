Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVIUU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVIUU3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVIUU3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:29:51 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:41156 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S964812AbVIUU3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:29:50 -0400
Message-ID: <4331C2A0.5050803@neostrada.pl>
Date: Wed, 21 Sep 2005 22:29:20 +0200
From: MichalK <fallow@neostrada.pl>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.14-rc1-git5] block-kconfig-iosched-default-selection.patch
Content-Type: multipart/mixed;
 boundary="------------040308000009050208090300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308000009050208090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040308000009050208090300
Content-Type: text/x-patch;
 name="block-kconfig-iosched-default-selection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block-kconfig-iosched-default-selection.patch"


>From Michal Kaczmarski <fallow@neostrada.pl>

I think selection of a default IO scheduler via Kconfig 
can be a nice addition to the kernel.
---
 Kconfig.iosched |   17 +++++++++++++++++
 elevator.c      |   35 ++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff -Naur a/drivers/block/Kconfig.iosched b/drivers/block/Kconfig.iosched
--- a/drivers/block/Kconfig.iosched	2005-08-29 01:41:01.000000000 +0200
+++ b/drivers/block/Kconfig.iosched	2005-09-21 19:09:56.000000000 +0200
@@ -38,4 +38,21 @@
 	  among all processes in the system. It should provide a fair
 	  working environment, suitable for desktop systems.
 
+choice 
+	prompt "Default IO scheduler"
+	default IOSCHED_DEFAULT_AS
+	---help---
+	  This option gives you possibility of choice the default IO 
+	  scheduler from selected to compile IO schedulers.
+	  
+config	IOSCHED_DEFAULT_AS 
+	bool "Anticipatory IO scheduler" if IOSCHED_AS
+config	IOSCHED_DEFAULT_DEADLINE 
+	bool "Deadline IO scheduler" if IOSCHED_DEADLINE
+config	IOSCHED_DEFAULT_CFQ 
+	bool "CFQ IO scheduler" if IOSCHED_CFQ
+config	IOSCHED_DEFAULT_NOOP
+	bool "NOOP IO scheduler" if IOSCHED_NOOP
+endchoice
+
 endmenu
diff -Naur a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	2005-08-29 01:41:01.000000000 +0200
+++ b/drivers/block/elevator.c	2005-09-21 19:33:10.000000000 +0200
@@ -24,6 +24,7 @@
  * - completely modularize elevator setup and teardown
  *
  */
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
@@ -153,21 +154,37 @@
 
 static void elevator_setup_default(void)
 {
-	/*
-	 * check if default is set and exists
-	 */
-	if (chosen_elevator[0] && elevator_find(chosen_elevator))
-		return;
 
 #if defined(CONFIG_IOSCHED_AS)
+ #if defined(CONFIG_IOSCHED_DEFAULT_AS)
 	strcpy(chosen_elevator, "anticipatory");
-#elif defined(CONFIG_IOSCHED_DEADLINE)
+ #endif
+#endif
+#if defined(CONFIG_IOSCHED_DEADLINE)
+ #if defined(CONFIG_IOSCHED_DEFAULT_DEADLINE)
 	strcpy(chosen_elevator, "deadline");
-#elif defined(CONFIG_IOSCHED_CFQ)
+ #endif
+#endif
+#if defined(CONFIG_IOSCHED_CFQ)
+ #if defined(CONFIG_IOSCHED_DEFAULT_CFQ)
 	strcpy(chosen_elevator, "cfq");
-#elif defined(CONFIG_IOSCHED_NOOP)
+ #endif
+#endif
+#if defined(CONFIG_IOSCHED_NOOP)
+ #if defined(CONFIG_IOSCHED_DEFAULT_NOOP)
 	strcpy(chosen_elevator, "noop");
-#else
+ #endif
+#endif
+
+	/*
+	 * check if default is set and exists
+	 */
+	if (chosen_elevator[0] && elevator_find(chosen_elevator))
+		return;
+	else strcpy(chosen_elevator, "noop");
+	
+	
+#if !defined(CONFIG_IOSCHED_AS) && !defined(CONFIG_IOSCHED_DEADLINE) && !defined(CONFIG_IOSCHED_CFQ) && !defined(CONFIG_IOSCHED_NOOP)
 #error "You must build at least 1 IO scheduler into the kernel"
 #endif
 }

--------------040308000009050208090300--
