Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265831AbUFIXKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUFIXKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbUFIXKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:10:40 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:50307 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S265831AbUFIXKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:10:39 -0400
Subject: PATCH: 2.6.7-rc3 drivers/scsi/megaraid.c: user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: linux-megaraid-devel@dell.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 16:10:32 -0700
Message-Id: <1086822637.32059.140.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since arg is a user pointer, so are uioc_mimd and uiocp, and hence umc is 
a user pointer.  Thus reading umc->xferaddr requires dereferencing a user 
pointer, which isn't safe.  Let me know if you have any questions or I've
made an error.

Best,
Rob

--- linux-2.6.7-rc3-full/drivers/scsi/megaraid.c.orig	Wed Jun  9 12:43:49 2004
+++ linux-2.6.7-rc3-full/drivers/scsi/megaraid.c	Wed Jun  9 12:43:10 2004
@@ -3815,7 +3815,8 @@ mega_n_to_m(void *arg, megacmd_t *mc)
 
 			umc = MBOX_P(uiocp);
 
-			upthru = (mega_passthru *)umc->xferaddr;
+			if (get_user(upthru, (mega_passthru **)&umc->xferaddr))
+				return (-EFAULT);
 
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus) )
 				return (-EFAULT);
@@ -3831,7 +3832,8 @@ mega_n_to_m(void *arg, megacmd_t *mc)
 
 			umc = (megacmd_t *)uioc_mimd->mbox;
 
-			upthru = (mega_passthru *)umc->xferaddr;
+			if (get_user(upthru, (mega_passthru **)&umc->xferaddr))
+				return (-EFAULT);
 
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus) )
 				return (-EFAULT);



