Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbTIUD5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTIUD5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 23:57:52 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:60073 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261716AbTIUD5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 23:57:50 -0400
Message-ID: <3F6D22DE.10001@terra.com.br>
Date: Sun, 21 Sep 2003 01:02:38 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Cciss-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Memory leak in block/cciss.c driver
Content-Type: multipart/mixed;
 boundary="------------020600000609000607020506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600000609000607020506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Linus,

	Patch against 2.6-test5 which removes a few memory leaks from the cciss 
block driver.

	Bug found by smatch checker.

	Please apply,

	Cheers.

Felipe
-- 
It's most certainly GNU/Linux, not Linux. Read more at
http://www.gnu.org/gnu/why-gnu-linux.html

--------------020600000609000607020506
Content-Type: text/plain;
 name="cciss-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss-leak.patch"

--- linux-2.6.0-test5/drivers/block/cciss.c	Mon Sep  8 16:50:32 2003
+++ linux-2.6.0-test5-fwd/drivers/block/cciss.c	Sun Sep 21 00:46:33 2003
@@ -754,16 +754,24 @@
 			status = -ENOMEM;
 			goto cleanup1;
 		}
-		if (copy_from_user(ioc, (void *) arg, sizeof(*ioc)))
-			return -EFAULT;
+		if (copy_from_user(ioc, (void *) arg, sizeof(*ioc))) {
+			status = -EFAULT;
+			goto cleanup1;
+		}
 		if ((ioc->buf_size < 1) &&
-			(ioc->Request.Type.Direction != XFER_NONE))
-				return -EINVAL;
+			(ioc->Request.Type.Direction != XFER_NONE)) {
+				status = -EINVAL;
+				goto cleanup1;
+		}
 		/* Check kmalloc limits  using all SGs */
-		if (ioc->malloc_size > MAX_KMALLOC_SIZE)
-			return -EINVAL;
-		if (ioc->buf_size > ioc->malloc_size * MAXSGENTRIES)
-			return -EINVAL;
+		if (ioc->malloc_size > MAX_KMALLOC_SIZE) {
+			status = -EINVAL;
+			goto cleanup1;
+		}
+		if (ioc->buf_size > ioc->malloc_size * MAXSGENTRIES) {
+			status = -EINVAL;
+			goto cleanup1;
+		}
 		buff = (unsigned char **) kmalloc(MAXSGENTRIES * 
 				sizeof(char *), GFP_KERNEL);
 		if (!buff) {

--------------020600000609000607020506--

