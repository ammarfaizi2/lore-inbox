Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275421AbTHIWM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275423AbTHIWM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:12:26 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:36357 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S275421AbTHIWMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:12:22 -0400
Message-ID: <3F357161.7940B75@SteelEye.com>
Date: Sat, 09 Aug 2003 18:10:41 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.22-pre] nbd: fix race conditions
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net> <3F33D41E.89CFA182@SteelEye.com> <3F3402F7.A8986417@SteelEye.com>
Content-Type: multipart/mixed;
 boundary="------------5788F72CC2C31F32F6510CE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5788F72CC2C31F32F6510CE0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch is similar to one I posted yesterday for 2.6. It fixes the
following race conditions in nbd:
 
1) adds locking and properly orders the code in NBD_CLEAR_SOCK to
eliminate races with other code
 
2) adds an lo->sock check to nbd_clear_que to eliminate races between
do_nbd_request and nbd_clear_que, which resulted in the dequeuing of
active requests
 
3) adds an lo->sock check to NBD_DO_IT to eliminate races with
NBD_CLEAR_SOCK, which caused an Oops when "nbd-client -d" was called
 

Marcelo,

If we can get this into 2.4.22, that would be great. I know there's at
least one person who's consistently getting oopses with nbd.

Thanks,
Paul
--------------5788F72CC2C31F32F6510CE0
Content-Type: text/x-diff; charset=us-ascii;
 name="nbd-race_fixes_2_4_21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nbd-race_fixes_2_4_21.diff"

--- linux-2.4.21-PRISTINE/drivers/block/nbd.c	Fri Jun 13 10:51:32 2003
+++ linux-2.4.21/drivers/block/nbd.c	Sat Aug  9 13:25:49 2003
@@ -428,23 +428,24 @@ static int nbd_ioctl(struct inode *inode
                 return 0 ;
  
 	case NBD_CLEAR_SOCK:
+		error = 0;
+		down(&lo->tx_lock);
+		lo->sock = NULL;
+		up(&lo->tx_lock);
+		spin_lock(&lo->queue_lock);
+		file = lo->file;
+		lo->file = NULL;
+		spin_unlock(&lo->queue_lock);
 		nbd_clear_que(lo);
 		spin_lock(&lo->queue_lock);
 		if (!list_empty(&lo->queue_head)) {
-			spin_unlock(&lo->queue_lock);
-			printk(KERN_ERR "nbd: Some requests are in progress -> can not turn off.\n");
-			return -EBUSY;
-		}
-		file = lo->file;
-		if (!file) {
-			spin_unlock(&lo->queue_lock);
-			return -EINVAL;
+			printk(KERN_ERR "nbd: disconnect: some requests are in progress -> please try again.\n");
+			error = -EBUSY;
 		}
-		lo->file = NULL;
-		lo->sock = NULL;
 		spin_unlock(&lo->queue_lock);
-		fput(file);
-		return 0;
+		if (file)
+			fput(file);
+		return error;
 	case NBD_SET_SOCK:
 		if (lo->file)
 			return -EBUSY;
@@ -491,9 +492,12 @@ static int nbd_ioctl(struct inode *inode
 		 * there should be a more generic interface rather than
 		 * calling socket ops directly here */
 		down(&lo->tx_lock);
-		printk(KERN_WARNING "nbd: shutting down socket\n");
-		lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
-		lo->sock = NULL;
+		if (lo->sock) {
+			printk(KERN_WARNING "nbd: shutting down socket\n");
+			lo->sock->ops->shutdown(lo->sock,
+				SEND_SHUTDOWN|RCV_SHUTDOWN);
+			lo->sock = NULL;
+		}
 		up(&lo->tx_lock);
 		spin_lock(&lo->queue_lock);
 		file = lo->file;
@@ -505,6 +509,13 @@ static int nbd_ioctl(struct inode *inode
 			fput(file);
 		return lo->harderror;
 	case NBD_CLEAR_QUE:
+		down(&lo->tx_lock);
+		if (lo->sock) {
+			up(&lo->tx_lock);
+			return 0; /* probably should be error, but that would
+				   * break "nbd-client -d", so just return 0 */
+		}
+		up(&lo->tx_lock);
 		nbd_clear_que(lo);
 		return 0;
 #ifdef PARANOIA

--------------5788F72CC2C31F32F6510CE0--

