Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTLKBqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTLKBax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:30:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:55759 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264325AbTLKBaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061473166@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061462803@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:07 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1522, 2003/12/09 10:18:07-08:00, oliver@neukum.org

[PATCH] USB: fix race with signal delivery in usbfs

apart from locking bugs, there are other races. This fixes one with
signal delivery. The signal should be delivered _before_ the reciever
is woken.


 drivers/usb/core/devio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Dec 10 16:47:18 2003
+++ b/drivers/usb/core/devio.c	Wed Dec 10 16:47:18 2003
@@ -261,7 +261,6 @@
         spin_lock(&ps->lock);
         list_move_tail(&as->asynclist, &ps->async_completed);
         spin_unlock(&ps->lock);
-        wake_up(&ps->wait);
 	if (as->signr) {
 		sinfo.si_signo = as->signr;
 		sinfo.si_errno = as->urb->status;
@@ -269,6 +268,7 @@
 		sinfo.si_addr = (void *)as->userurb;
 		send_sig_info(as->signr, &sinfo, as->task);
 	}
+        wake_up(&ps->wait);
 }
 
 static void destroy_async (struct dev_state *ps, struct list_head *list)

