Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTKGWEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTKGWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:48552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264598AbTKGT2l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:28:41 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1068233275660@kroah.com>
Subject: Re: [PATCH] More fixes for 2.6.0-test9
In-Reply-To: <10682332743672@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Nov 2003 11:27:55 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1419, 2003/11/07 10:07:03-08:00, mdharm-usb@one-eyed-alien.net

[PATCH] USB: fix a thread-exit problem at module unload

This patch fixes a thread-exit problem when the usb-storage module is
unloaded with a preemptable kernel.  Please refer to the comments in the
code for more detail.


 drivers/usb/storage/usb.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
--- a/drivers/usb/storage/usb.c	Fri Nov  7 11:22:10 2003
+++ b/drivers/usb/storage/usb.c	Fri Nov  7 11:22:10 2003
@@ -417,10 +417,21 @@
 		scsi_unlock(host);
 	} /* for (;;) */
 
-	/* notify the exit routine that we're actually exiting now */
-	complete(&(us->notify));
-
-	return 0;
+	/* notify the exit routine that we're actually exiting now 
+	 *
+	 * complete()/wait_for_completion() is similar to up()/down(),
+	 * except that complete() is safe in the case where the structure
+	 * is getting deleted in a parallel mode of execution (i.e. just
+	 * after the down() -- that's necessary for the thread-shutdown
+	 * case.
+	 *
+	 * complete_and_exit() goes even further than this -- it is safe in
+	 * the case that the thread of the caller is going away (not just
+	 * the structure) -- this is necessary for the module-remove case.
+	 * This is important in preemption kernels, which transfer the flow
+	 * of execution immediately upon a complete().
+	 */
+	complete_and_exit(&(us->notify), 0);
 }	
 
 /***********************************************************************

