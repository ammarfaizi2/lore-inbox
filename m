Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUITTKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUITTKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUITTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:10:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:36242 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266689AbUITTJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:09:43 -0400
Date: Mon, 20 Sep 2004 21:16:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       Ben Collins <bcollins@debian.org>,
       Andreas Bombe <andreas.bombe@munich.netsurf.de>,
       Manfred Weihs <weihs@ict.tuwien.ac.at>,
       Christian Toegel <christian.toegel@gmx.at>
Subject: [PATCH] raw1394_read ignores __copy_to_user return value
Message-ID: <Pine.LNX.4.61.0409202101130.2729@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__copy_to_user can fail, and if it does something has gone wrong and we 
should act accordingly.

Currently the return value of __copy_to_user is not checked in 
raw1394_read which generates the warning below with gcc 3.4.1. 

  CC      drivers/ieee1394/raw1394.o
include/asm/uaccess.h: In function `raw1394_read':
drivers/ieee1394/raw1394.c:446: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result

Here's a patch to check the return value and return -EFAULT on failure.
I don't have hardware, so I've only compile tested this. Please review and 
consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc2-bk5-orig/drivers/ieee1394/raw1394.c linux-2.6.9-rc2-bk5/drivers/ieee1394/raw1394.c
--- linux-2.6.9-rc2-bk5-orig/drivers/ieee1394/raw1394.c	2004-08-14 07:36:11.000000000 +0200
+++ linux-2.6.9-rc2-bk5/drivers/ieee1394/raw1394.c	2004-09-20 21:00:33.000000000 +0200
@@ -443,7 +443,10 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (__copy_to_user(buffer, &req->req, sizeof(req->req))) {
+                free_pending_request(req);
+                return -EFAULT;
+        }
 
         free_pending_request(req);
         return sizeof(struct raw1394_request);


--
Jesper Juhl


PS. I'm only subscribed to linux-kernel, so please keep me on CC for 
replies from other lists.


