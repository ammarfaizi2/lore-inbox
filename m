Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUKAOyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUKAOyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267842AbUKAOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:54:33 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:32041 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266519AbUKAOu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:50:58 -0500
Subject: [PATCH 2.4] usb serial write fix
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1099320668.2853.7.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 01 Nov 2004 08:51:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix usb serial write path in post_helper to check return
code from component driver write routine and
resubmit if necessary. The post helper introduced in
2.4.27-pre6 can lose write data if component device write is busy.

This was previously reported as a problem with
the pl2303 driver running PPP by oleksiy@jabber.ru
Oleksiy has tested the patch with success.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.4.28-pre4/drivers/usb/serial/usbserial.c	2004-08-07 18:26:05.000000000 -0500
+++ b/drivers/usb/serial/usbserial.c	2004-11-01 08:29:07.000000000 -0600
@@ -508,8 +508,18 @@ static void post_helper(void *arg)
 		down(&port->sem);
 		dbg("%s - port %d len %d backlog %d", __FUNCTION__,
 		    port->number, job->len, port->write_backlog);
-		if (port->tty != NULL)
-			__serial_write(port, 0, job->buff, job->len);
+		if (port->tty != NULL) {
+			int rc;
+			int sent = 0;
+			while (sent < job->len) {
+				rc = __serial_write(port, 0, job->buff + sent, job->len - sent);
+				if ((rc < 0) || signal_pending(current))
+					break;
+				sent += rc;
+				if ((sent < job->len) && current->need_resched)
+					schedule();
+			}
+		}
 		up(&port->sem);
 
 		spin_lock_irqsave(&post_lock, flags);


