Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTCOERk>; Fri, 14 Mar 2003 23:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCOERk>; Fri, 14 Mar 2003 23:17:40 -0500
Received: from smtp220.tiscali.dk ([62.79.79.114]:11987 "EHLO
	smtp220.tiscali.dk") by vger.kernel.org with ESMTP
	id <S261382AbTCOERj>; Fri, 14 Mar 2003 23:17:39 -0500
Date: Sat, 15 Mar 2003 05:31:09 +0100
From: Henrik Thostrup Jensen <htj@antilogic.dk>
To: scott.feldman@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Memory leak in e100
Message-Id: <20030315053109.63cdb6cb.htj@antilogic.dk>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch fixed a memory leak in the e100 driver.
Leak was catched by smatch.

Best regards, Henrik


Please cc, as I'm not subscribed.


diff -u -r1.35 e100_main.c
--- linux/drivers/net/e100/e100_main.c	3 Mar 2003 04:36:31 -0000
+++ linux/drivers/net/e100/e100_main.c	15 Mar 2003 03:07:31 -0000
@@ -3744,6 +3744,7 @@
 	char *strings = NULL;
 	char *usr_strings;
 	int i;
+	int rc = 0;
 
 	memset((void *) &info, 0, sizeof(info));
 
@@ -3784,14 +3785,19 @@
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_to_user(ifr->ifr_data, &info, sizeof (info)))
-		return -EFAULT;
+	if (copy_to_user(ifr->ifr_data, &info, sizeof (info))) {
+		rc = -EFAULT;
+		goto exit3;
+	}
 
-	if (copy_to_user(usr_strings, strings, info.len * ETH_GSTRING_LEN))
-		return -EFAULT;
+	if (copy_to_user(usr_strings, strings, info.len * ETH_GSTRING_LEN)) {
+		rc = -EFAULT;
+		goto exit3;
+	}
 
+exit3:
 	kfree(strings);
-	return 0;
+	return rc;
 }
 
 static int
