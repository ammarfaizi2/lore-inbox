Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUJDWex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUJDWex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUJDWbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:31:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:6355 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268665AbUJDVdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:33:32 -0400
Subject: [PATCH] hvc_console fix to prevent oops and late hangup and write
	operations
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-gMkQtXo8v7JDE4y91EY2"
Organization: IBM Linux Technology Center
Message-Id: <1096925594.3666.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 16:33:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gMkQtXo8v7JDE4y91EY2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

This patch prevents execution of hvc_write() and hvc_hangup() after the
tty layer has executed a final hvc_close() against a device.  This patch
provides a better method than was previously used.  tty->driver_data is
no longer invalidated so we'll no longer get oopses when the tty layer
allows late hangup() and write() operations.

changelog
-------------------------------------------------------------------------
drivers/char/hvc_console.c

-Removed silly tty->driver_data = NULL; from hvc_close which prevents
possible oops in hvc_write() and hvc_hangup() due to improperly acting
ldisc close ordering.

-Added hp->count <= 0 check to hvc_write() and hvc_hangup() to prevent
execution of these function after hvc_close() has been invoked by the
tty layer.  Same tty ldisc issues as above are the reason.

-Added some comments to clarify the situation.

-Awaiting a forth coming patch from Alan Cox which should clean up the
close ordering and prevent the late hangup and write ops from happening.

Thanks,
Ryan S. Arnold
IBM Linux Technology Center

--=-gMkQtXo8v7JDE4y91EY2
Content-Disposition: attachment; filename=hvc_hangup_write_close.patch
Content-Type: text/x-patch; name=hvc_hangup_write_close.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>
--- linux-2.6.9-rc2-bk10/drivers/char/hvc_console.c	2004-09-24 13:15:08.293801870 -0500
+++ hvc_console_linux-2.6.9-rc2-bk10/drivers/char/hvc_console.c	2004-09-24 13:42:07.706625410 -0500
@@ -220,6 +220,7 @@
 		spin_unlock_irqrestore(&hp->lock, flags);
 		tty->driver_data = NULL;
 		kobject_put(kobjp);
+		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
 	}
 	/* Force wakeup of the polling thread */
 	hvc_kick();
@@ -239,7 +240,7 @@
 
 	/*
 	 * No driver_data means that this close was issued after a failed
-	 * hvcs_open by the tty layer's release_dev() function and we can just
+	 * hvc_open by the tty layer's release_dev() function and we can just
 	 * exit cleanly because the kobject reference wasn't made.
 	 */
 	if (!tty->driver_data)
@@ -265,13 +266,6 @@
 		 */
 		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
 
-		/*
-		 * Since the line disc doesn't block writes during tty close
-		 * operations we'll set driver_data to NULL and then make sure
-		 * to check tty->driver_data for NULL in hvc_write().
-		 */
-		tty->driver_data = NULL;
-
 		if (irq != NO_IRQ)
 			free_irq(irq, hp);
 
@@ -293,7 +287,21 @@
 	int temp_open_count;
 	struct kobject *kobjp;
 
+	if (!hp)
+		return;
+
 	spin_lock_irqsave(&hp->lock, flags);
+
+	/*
+	 * The N_TTY line discipline has problems such that in a close vs
+	 * open->hangup case this can be called after the final close so prevent
+	 * that from happening for now.
+	 */
+	if (hp->count <= 0) {
+		spin_unlock_irqrestore(&hp->lock, flags);
+		return;
+	}
+
 	kobjp = &hp->kobj;
 	temp_open_count = hp->count;
 	hp->count = 0;
@@ -427,6 +435,9 @@
 	if (!hp)
 		return -EPIPE;
 
+	if (hp->count <= 0)
+		return -EIO;
+
 	if (from_user)
 		written = __hvc_write_user(hp, buf, count);
 	else

--=-gMkQtXo8v7JDE4y91EY2--

