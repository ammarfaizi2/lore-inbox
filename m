Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVJUMaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVJUMaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJUMaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:30:00 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:56272 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S964915AbVJUMaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:30:00 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl_string() return 1 on success.
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200510212129.AJC96678.YFMPJGOFOSMtLtNSV@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Fri, 21 Oct 2005 21:29:42 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think sysctl_string() should return 1 on success.
I verified that variables (for example, modprobe_path[]
and hotplug_path[]) that use sysctl_string() for strategy
function are NOT '\0'-terminated if newlen > sizeof(variables).

I also think ctl_perm() should be called before
calling table->strategy, for strategy function may do
read/write operations.

Best Regards.

---------- START OF PATCH ----------
--- linux-2.6.13.4/kernel/sysctl.c	2005-10-11 03:54:29.000000000 +0900
+++ linux-2.6.13.4-sysctl/kernel/sysctl.c	2005-10-21 15:33:26.000000000 +0900
@@ -16,6 +16,8 @@
  *  Wendling.
  * The list_for_each() macro wasn't appropriate for the sysctl loop.
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
+ * sysctl_string() return 1 on success, 10/21/05, Tetsuo Handa
+ * Added ctl_perm() check for non-leaf nodes, 10/21/05, Tetsuo Handa
  */
 
 #include <linux/config.h>
@@ -1088,6 +1090,12 @@
 				if (ctl_perm(table, 001))
 					return -EPERM;
 				if (table->strategy) {
+					/* Need to check permission, for
+					   table->strategy() might do r/w */
+					int op = 0;
+					if (oldval) op |= 004;
+					if (newval) op |= 002;
+					if (ctl_perm(table, op)) return -EPERM;
 					error = table->strategy(
 						table, name, nlen,
 						oldval, oldlenp,
@@ -2146,7 +2154,7 @@
 			len--;
 		((char *) table->data)[len] = 0;
 	}
-	return 0;
+	return 1;
 }
 
 /*
---------- END OF PATCH ----------
