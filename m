Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUIOSnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUIOSnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUIOSnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:43:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46039 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267285AbUIOSlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:41:39 -0400
Subject: [PATCH] hvc_console fix to protect hvc_write against ldisc write
	after hvc_close
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-VkaQlwfzNrVkb4I9FaRh"
Organization: IBM
Message-Id: <1095273835.3294.278.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 13:43:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VkaQlwfzNrVkb4I9FaRh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

Due to the tty ldisc code not stopping write operations against a driver
even after a tty has been closed I added a mechanism to hvc_console in
my previous patch to prevent this by nulling out the tty->driver_data in
hvc_close() but I forgot to check tty->driver_data in hvc_write(). 
Anton Blanchard got several oops'es from hvc_write() accessing NULL as
if it were a pointer to an hvc_struct usually stored in
tty->driver_data.

So this patch checks tty->driver_data in hvc_write() before it is used. 
Hopefully once Alan Cox's patch is checked in ldisc writes won't
continue to happen after tty closes.

Anton Blanchard has tested this patch and is unable to reproduce the
oops with it applied.

Changelog:
drivers/char/hvc_console.c
-Added comment to hvc_close() to explain the reason for NULLing
tty->driver_data.
-Added check to hvc_write() to verify that tty->driver_data is valid
(NOT NULL) which would be the case if the write operation was invoked
after a tty close was initiated on the tty.

Thanks,

Ryan S. Arnold
IBM Linux Technology Center

--=-VkaQlwfzNrVkb4I9FaRh
Content-Disposition: attachment; filename=hvc_console_write.patch
Content-Type: text/x-patch; name=hvc_console_write.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>
--- linux-2.6.9-rc1/drivers/char/hvc_console.c	Fri Sep 10 15:14:57 2004
+++ hvc_console_working_linux-2.6.9-rc1/drivers/char/hvc_console.c	Mon Sep 13 10:29:53 2004
@@ -265,6 +265,11 @@
 		 */
 		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
 
+		/*
+		 * Since the line disc doesn't block writes during tty close
+		 * operations we'll set driver_data to NULL and then make sure
+		 * to check tty->driver_data for NULL in hvc_write().
+		 */
 		tty->driver_data = NULL;
 
 		if (irq != NO_IRQ)
@@ -418,6 +423,10 @@
 	struct hvc_struct *hp = tty->driver_data;
 	int written;
 
+	/* This write was probably executed during a tty close. */
+	if (!hp)
+		return -EPIPE;
+
 	if (from_user)
 		written = __hvc_write_user(hp, buf, count);
 	else

--=-VkaQlwfzNrVkb4I9FaRh--

