Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTIULpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTIULpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 07:45:44 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:11187 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262378AbTIULpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 07:45:43 -0400
Date: Sun, 21 Sep 2003 15:45:29 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Cc: mlindner@syskonnect.de
Subject: [PATCH] [2.4] Fix memleak on error exit path in sk98 driver.
Message-ID: <20030921114529.GA31747@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a trivial memleak in sk98 ioctl handling routinue,
   the patch is also trivial. Please apply.
   Found with help of smatch.

===== drivers/net/sk98lin/skge.c 1.14 vs edited =====
--- 1.14/drivers/net/sk98lin/skge.c	Wed Sep  3 21:15:10 2003
+++ edited/drivers/net/sk98lin/skge.c	Sun Sep 21 15:38:01 2003
@@ -3616,20 +3616,21 @@
 			Length = sizeof(pAC->PnmiStruct) + HeaderLength;
 		}
 		if (NULL == (pMemBuf = kmalloc(Length, GFP_KERNEL))) {
-			return -EFAULT;
+			return -ENOMEM;
 		}
 		if(copy_from_user(pMemBuf, Ioctl.pData, Length)) {
-			return -EFAULT;
+			goto fault;
 		}
 		if ((Ret = SkPnmiGenIoctl(pAC, pAC->IoBase, pMemBuf, &Length, 0)) < 0) {
-			return -EFAULT;
+			goto fault;
 		}
 		if(copy_to_user(Ioctl.pData, pMemBuf, Length) ) {
-			return -EFAULT;
+			goto fault;
 		}
 		Ioctl.Len = Length;
 		if(copy_to_user(rq->ifr_data, &Ioctl, sizeof(SK_GE_IOCTL))) {
-			return -EFAULT;
+fault:
+			Err = -EFAULT;
 		}
 		kfree(pMemBuf); /* cleanup everything */
 		break;
