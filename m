Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTLQN13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTLQN13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 08:27:29 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:7079 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S261406AbTLQN10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 08:27:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16352.22968.706710.576954@gargle.gargle.HOWL>
Date: Wed, 17 Dec 2003 08:27:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [patch] qla1280 crash fix in error handling
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes a big in the qla1280 driver where it would
leave a pointer to an on the stack completion event in a command
structure if qla1280_mailbox_command fails. The result is that the
interrupt handler later tries to complete() garbage on the stack. The
mailbox command can fail if a device on the bus decides to lock up etc.

Patch relative to 2.6.0-test11 but should apply to the current BK tree
as well.

Cheers,
Jes

--- linux-2.6.0-test11/drivers/scsi/orig/qla1280.c	Wed Dec 17 05:14:18 2003
+++ linux-2.6.0-test11/drivers/scsi/qla1280.c	Wed Dec 17 05:20:02 2003
@@ -16,9 +16,13 @@
 * General Public License for more details.
 *
 ******************************************************************************/
-#define QLA1280_VERSION      "3.23.37"
+#define QLA1280_VERSION      "3.23.37.1"
 /*****************************************************************************
     Revision History:
+    Rev  3.23.37.1 December 17, 2003, Jes Sorensen
+	- Delete completion queue from srb if mailbox command failed to
+	  to avoid qla1280_done completeting qla1280_error_action's
+	  obsolete context
     Rev  3.23.37 October 1, 2003, Jes Sorensen
 	- Make MMIO depend on CONFIG_X86_VISWS instead of yet another
 	  random CONFIG option
@@ -1464,8 +1468,15 @@
 	/* If we didn't manage to issue the action, or we have no
 	 * command to wait for, exit here */
 	if (result == FAILED || handle == NULL ||
-	    handle == (unsigned char *)INVALID_HANDLE)
+	    handle == (unsigned char *)INVALID_HANDLE) {
+		/*
+		 * Clear completion queue to avoid qla1280_done() trying
+		 * to complete the command at a later stage after we
+		 * have exited the current context
+		 */
+		sp->wait = NULL;
 		goto leave;
+	}
 
 	/* set up a timer just in case we're really jammed */
 	init_timer(&timer);
