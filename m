Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbTGMP7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270017AbTGMP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 11:59:12 -0400
Received: from mailg.telia.com ([194.22.194.26]:29905 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S269978AbTGMP7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 11:59:10 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Incorrect timeout in CDROM_SEND_PACKET ioctl in 2.5 kernels
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2003 18:12:56 +0200
Message-ID: <m2u19q1k3b.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CDROM_SEND_PACKET ioctl passes a struct cdrom_generic_command from
user space, which contains a timeout field. The timeout is measured in
jiffies, but the conversion from user to kernel jiffies is missing,
which makes the timeout 10 times shorter than it should be in 2.5
kernels on x86. This causes CDRW formatting with cdrwtool to fail. The
following patch fixes this problem.

--- linux/drivers/cdrom/cdrom.c.old	Sun Jul 13 16:34:37 2003
+++ linux/drivers/cdrom/cdrom.c	Sun Jul 13 15:19:11 2003
@@ -295,6 +295,8 @@
 #define cdinfo(type, fmt, args...) 
 #endif
 
+#define MULDIV(X,MUL,DIV) ((((X % DIV) * MUL) / DIV) + ((X / DIV) * MUL))
+
 /* These are used to simplify getting data in from and back to user land */
 #define IOCTL_IN(arg, type, in)					\
 	if (copy_from_user(&(in), (type *) (arg), sizeof (in)))	\
@@ -2171,6 +2173,7 @@
 			return -ENOSYS;
 		cdinfo(CD_DO_IOCTL, "entering CDROM_SEND_PACKET\n"); 
 		IOCTL_IN(arg, struct cdrom_generic_command, cgc);
+		cgc.timeout = MULDIV(cgc.timeout, HZ, USER_HZ);
 		return cdrom_do_cmd(cdi, &cgc);
 		}
 	case CDROM_NEXT_WRITABLE: {

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
