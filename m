Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbTDYAWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTDXXfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35714 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264490AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228052721@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <1051228052617@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.8, 2003/04/23 17:35:11-07:00, greg@kroah.com

[PATCH] USB: cdc-acm: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/class/cdc-acm.c |   60 ++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 27 deletions(-)


diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Thu Apr 24 16:24:52 2003
+++ b/drivers/usb/class/cdc-acm.c	Thu Apr 24 16:24:52 2003
@@ -432,43 +432,47 @@
 		dbg("send break failed");
 }
 
-static int acm_tty_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
+static int acm_tty_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	struct acm *acm = tty->driver_data;
-	unsigned int mask, newctrl;
 
-	if (!ACM_READY(acm)) return -EINVAL;
+	if (!ACM_READY(acm))
+		return -EINVAL;
 
-	switch (cmd) {
+	return (acm->ctrlout & ACM_CTRL_DTR ? TIOCM_DTR : 0) |
+	       (acm->ctrlout & ACM_CTRL_RTS ? TIOCM_RTS : 0) |
+	       (acm->ctrlin  & ACM_CTRL_DSR ? TIOCM_DSR : 0) |
+	       (acm->ctrlin  & ACM_CTRL_RI  ? TIOCM_RI  : 0) |
+	       (acm->ctrlin  & ACM_CTRL_DCD ? TIOCM_CD  : 0) |
+	       TIOCM_CTS;
+}
 
-		case TIOCMGET:
+static int acm_tty_tiocmset(struct tty_struct *tty, struct file *file,
+			    unsigned int set, unsigned int clear)
+{
+	struct acm *acm = tty->driver_data;
+	unsigned int newctrl;
 
-			return put_user((acm->ctrlout & ACM_CTRL_DTR ? TIOCM_DTR : 0) |
-				(acm->ctrlout & ACM_CTRL_RTS ? TIOCM_RTS : 0) |
-				(acm->ctrlin  & ACM_CTRL_DSR ? TIOCM_DSR : 0) |
-				(acm->ctrlin  & ACM_CTRL_RI  ? TIOCM_RI  : 0) |
-				(acm->ctrlin  & ACM_CTRL_DCD ? TIOCM_CD  : 0) |
-				 TIOCM_CTS, (unsigned long *) arg);
+	if (!ACM_READY(acm))
+		return -EINVAL;
 
-		case TIOCMSET:
-		case TIOCMBIS:
-		case TIOCMBIC:
+	newctrl = acm->ctrlout;
+	set = (set & TIOCM_DTR ? ACM_CTRL_DTR : 0) | (set & TIOCM_RTS ? ACM_CTRL_RTS : 0);
+	clear = (clear & TIOCM_DTR ? ACM_CTRL_DTR : 0) | (clear & TIOCM_RTS ? ACM_CTRL_RTS : 0);
 
-			if (get_user(mask, (unsigned long *) arg))
-				return -EFAULT;
+	newctrl = (newctrl & ~clear) | set;
 
-			newctrl = acm->ctrlout;
-			mask = (mask & TIOCM_DTR ? ACM_CTRL_DTR : 0) | (mask & TIOCM_RTS ? ACM_CTRL_RTS : 0);
+	if (acm->ctrlout == newctrl)
+		return 0;
+	return acm_set_control(acm, acm->ctrlout = newctrl);
+}
 
-			switch (cmd) {
-				case TIOCMSET: newctrl  =  mask; break;
-				case TIOCMBIS: newctrl |=  mask; break;
-				case TIOCMBIC: newctrl &= ~mask; break;
-			}
+static int acm_tty_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct acm *acm = tty->driver_data;
 
-			if (acm->ctrlout == newctrl) return 0;
-			return acm_set_control(acm, acm->ctrlout = newctrl);
-	}
+	if (!ACM_READY(acm))
+		return -EINVAL;
 
 	return -ENOIOCTLCMD;
 }
@@ -750,7 +754,9 @@
 	.unthrottle =		acm_tty_unthrottle,
 	.chars_in_buffer =	acm_tty_chars_in_buffer,
 	.break_ctl =		acm_tty_break_ctl,
-	.set_termios =		acm_tty_set_termios
+	.set_termios =		acm_tty_set_termios,
+	.tiocmget =		acm_tty_tiocmget,
+	.tiocmset =		acm_tty_tiocmset,
 };
 
 /*

