Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbTIOUgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTIOUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:36:37 -0400
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:7945 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261587AbTIOUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:36:34 -0400
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A17@ausx2kmpc106.aus.amer.dell.com>
From: Stuart_Hayes@Dell.com
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-tape locks up when loaded in kernel 2.4.22
Date: Mon, 15 Sep 2003 15:36:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1378FD5A1416532-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With certain configurations, loading ide-tape will lock up the system.  This
is caused by the "feature" variable in idetape_issue_packet_command not
being initialized (to 0).  The patch just sets feature to 0 at the beginning
of the function.

This patch is for kernel 2.4.22 (though there were no changes to ide-tape.c
between 2.4.22 and 2.4.23-pre4).

Thanks
Stuart
stuart_hayes@dell.com




diff -BurN linux-vanilla/drivers/ide/ide-tape.c
linux-idetape-quickpatch/drivers/ide/ide-tape.c
--- linux-vanilla/drivers/ide/ide-tape.c	2003-06-13
09:51:33.000000000 -0500
+++ linux-idetape-quickpatch/drivers/ide/ide-tape.c	2003-09-15
13:08:36.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.17b	Dec, 2002
+ * linux/drivers/ide/ide-tape.c		Version 1.17c	Sep, 2003
  *
  * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
  *
@@ -313,6 +313,9 @@
  *			Cosmetic fixes to miscellaneous debugging output
messages.
  *			Set the minimum /proc/ide/hd?/settings values for
"pipeline",
  *			 "pipeline_min", and "pipeline_max" to 1.
+ * Ver 1.17c Sep 2003	Stuart Hayes <stuart_hayes@dell.com>
+ *			Initialized "feature" in
idetape_issue_packet_command
+ *			 (this was causing lockups on certain systems)
  *
  * Here are some words from the first releases of hd.c, which are quoted
  * in ide.c and apply here as well:
@@ -422,7 +425,7 @@
  *		sharing a (fast) ATA-2 disk with any (slow) new ATAPI
device.
  */
 
-#define IDETAPE_VERSION "1.17b-ac1"
+#define IDETAPE_VERSION "1.17c"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -2367,6 +2370,8 @@
 	atapi_feature_t feature;
 	atapi_bcount_t bcount;
 
+	feature.all = 0;
+
 #if IDETAPE_DEBUG_BUGS
 	if (tape->pc->c[0] == IDETAPE_REQUEST_SENSE_CMD &&
 	    pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {

