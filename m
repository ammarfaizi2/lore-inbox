Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVGKTMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVGKTMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKTMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:12:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57574 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262337AbVGKTMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:12:01 -0400
Message-ID: <42D2C34C.4040406@redhat.com>
Date: Mon, 11 Jul 2005 15:06:52 -0400
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bcrl@kvack.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Add ENOSYS into sys_io_cancel
Content-Type: multipart/mixed;
 boundary="------------090908030008040201040206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908030008040201040206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Previously sent via private mail that doesn't seem to go thru - resend 
via office mailer.

Note that other than few exceptions, most of the current filesystem 
and/or drivers do not have aio cancel specifically defined 
(kiob->ki_cancel field is mostly NULL). However, sys_io_cancel system 
call universally sets return code to -EGAIN. This gives applications a 
wrong impression that this call is implemented but just never works. We 
have customer inquires about this issue.

Upload a trivial patch to address this confusion.

-- Wendy



--------------090908030008040201040206
Content-Type: text/plain;
 name="cancel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cancel.patch"

--- linux-2.6.12/fs/aio.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/fs/aio.c	2005-07-10 12:48:14.000000000 -0400
@@ -1641,8 +1641,9 @@ asmlinkage long sys_io_cancel(aio_contex
 		cancel = kiocb->ki_cancel;
 		kiocb->ki_users ++;
 		kiocbSetCancelled(kiocb);
-	} else
+	} else 
 		cancel = NULL;
+	 
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (NULL != cancel) {
@@ -1659,8 +1660,10 @@ asmlinkage long sys_io_cancel(aio_contex
 			if (copy_to_user(result, &tmp, sizeof(tmp)))
 				ret = -EFAULT;
 		}
-	} else
+	} else {
+		ret = -ENOSYS;
 		printk(KERN_DEBUG "iocb has no cancel operation\n");
+	} 
 
 	put_ioctx(ctx);
 

--------------090908030008040201040206--
