Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbREUXi5>; Mon, 21 May 2001 19:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262538AbREUXir>; Mon, 21 May 2001 19:38:47 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:58249 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262536AbREUXib>; Mon, 21 May 2001 19:38:31 -0400
Message-Id: <5.0.2.1.2.20010521163446.00a85fa0@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 21 May 2001 16:38:19 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] drivers/mtd/mtdchar.c
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm Philip, from Professor Dawson Engler's Meta-Compilation Group at 
Stanford University.

There is a bug in mtdchar.c of not freeing memory on error paths.  databuf 
is allocated but not freed if copy_from_user fails.  The addition I made 
was to kfree databuf before returning -EFAULT.  Thanks!

Warmly,

Philip

linux/2.4.4/drivers/mtd/mtdchar.c Fri Feb 9 11:30:23 2001
+++ mtdchar.c Mon May 21 13:33:02 2001
@@ -310,9 +310,10 @@
if (!databuf)
return -ENOMEM;

- if (copy_from_user(databuf, buf.ptr, buf.length))
- return -EFAULT;
-
+ if (copy_from_user(databuf, buf.ptr, buf.length)) {
+ kfree(databuf);
+ return -EFAULT;
+ }
ret = (mtd->write_oob)(mtd, buf.start, buf.length, &retlen,
databuf);

if (copy_to_user((void *)arg + sizeof(loff_t), &retlen,
sizeof(ssize_t)))


