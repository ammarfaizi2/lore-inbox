Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUKODeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUKODeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKOCj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:39:59 -0500
Received: from ozlabs.org ([203.10.76.45]:63666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261477AbUKOCiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:38:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.5879.951131.956305@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 13:39:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pmac_zilog.c so it compiles again
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that pmac_zilog.c got missed in the dev.power_state to
dev.power.power_state conversion.  This patch makes that change, and
also fixes a problem where it would not compile if CONFIG_MAGIC_SYSRQ
was set but CONFIG_SERIAL_CORE_CONSOLE was not.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/serial/pmac_zilog.c test-pmac/drivers/serial/pmac_zilog.c
--- linux-2.5/drivers/serial/pmac_zilog.c	2004-11-08 18:37:52.000000000 +1100
+++ test-pmac/drivers/serial/pmac_zilog.c	2004-11-15 10:05:35.000000000 +1100
@@ -273,7 +273,7 @@
 			uap->flags &= ~PMACZILOG_FLAG_BREAK;
 		}
 
-#ifdef CONFIG_MAGIC_SYSRQ
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
 #ifdef USE_CTRL_O_SYSRQ
 		/* Handle the SysRq ^O Hack */
 		if (ch == '\x0f') {
@@ -289,7 +289,7 @@
 			if (swallow)
 				goto next_char;
  		}
-#endif /* CONFIG_MAGIC_SYSRQ */
+#endif /* CONFIG_MAGIC_SYSRQ && CONFIG_SERIAL_CORE_CONSOLE */
 
 		/* A real serial line, record the character and status.  */
 		if (drop)
@@ -1603,7 +1603,7 @@
 		return 0;
 	}
 
-	if (pm_state == mdev->ofdev.dev.power_state || pm_state < 2)
+	if (pm_state == mdev->ofdev.dev.power.power_state || pm_state < 2)
 		return 0;
 
 	pmz_debug("suspend, switching to state %d\n", pm_state);
@@ -1647,7 +1647,7 @@
 
 	pmz_debug("suspend, switching complete\n");
 
-	mdev->ofdev.dev.power_state = pm_state;
+	mdev->ofdev.dev.power.power_state = pm_state;
 
 	return 0;
 }
@@ -1663,7 +1663,7 @@
 	if (uap == NULL)
 		return 0;
 
-	if (mdev->ofdev.dev.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state == 0)
 		return 0;
 	
 	pmz_debug("resume, switching to state 0\n");
@@ -1716,7 +1716,7 @@
 
 	pmz_debug("resume, switching complete\n");
 
-	mdev->ofdev.dev.power_state = 0;
+	mdev->ofdev.dev.power.power_state = 0;
 
 	return 0;
 }
