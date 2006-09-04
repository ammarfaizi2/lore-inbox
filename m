Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWIDNXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWIDNXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWIDNXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:23:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50849 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964913AbWIDNXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:23:09 -0400
Subject: [PATCH]: Fix locking for tty drivers when doing urgent characters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:45:41 +0100
Message-Id: <1157377544.30801.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you send a priority character (as is done for flow control) then the
tty driver can either have its own method for "jumping the queue" or the
characrer can be queued normally. In the latter case we call the write
method but without the atomic_write_lock taken elsewhere.

Make this consistent. Note that the send_xchar method if implemented
remains outside of the lock as it can jump ahead of a current write so
must not be locked out by it.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c linux-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c	2006-09-01 13:59:10.000000000 +0100
@@ -423,24 +628,28 @@
  *
  *	Send a high priority character to the tty even if stopped
  *
- *	Locking: none
- *
- *	FIXME: overlapping calls with start/stop tty lose state of tty
+ *	Locking: none for xchar method, write ordering for write method.
  */
 
-static void send_prio_char(struct tty_struct *tty, char ch)
+static int send_prio_char(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;
 
 	if (tty->driver->send_xchar) {
 		tty->driver->send_xchar(tty, ch);
-		return;
+		return 0;
 	}
+	
+	if (mutex_lock_interruptible(&tty->atomic_write_lock))
+		return -ERESTARTSYS;
+		
 	if (was_stopped)
 		start_tty(tty);
 	tty->driver->write(tty, &ch, 1);
 	if (was_stopped)
 		stop_tty(tty);
+	mutex_unlock(&tty->atomic_write_lock);
+	return 0;
 }
 
 int n_tty_ioctl(struct tty_struct * tty, struct file * file,
@@ -514,11 +740,11 @@
 				break;
 			case TCIOFF:
 				if (STOP_CHAR(tty) != __DISABLED_CHAR)
-					send_prio_char(tty, STOP_CHAR(tty));
+					return send_prio_char(tty, STOP_CHAR(tty));
 				break;
 			case TCION:
 				if (START_CHAR(tty) != __DISABLED_CHAR)
-					send_prio_char(tty, START_CHAR(tty));
+					return send_prio_char(tty, START_CHAR(tty));
 				break;
 			default:
 				return -EINVAL;

