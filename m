Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbREVDqL>; Mon, 21 May 2001 23:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbREVDqB>; Mon, 21 May 2001 23:46:01 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:49837 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262558AbREVDpx>; Mon, 21 May 2001 23:45:53 -0400
Message-Id: <5.0.2.1.2.20010521204131.00ae0028@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 21 May 2001 20:45:33 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] drivers/acpi/driver.c (repost)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a repost of my previous message, which came out garbled.  Now you 
should be able to run patch -pO from the root linux dir on the files...

There is a bug in driver.c of not freeing memory on error 
paths.  buf.pointer is allocated but not freed if copy_to_user fails.  The 
addition I made was to kfree buf.pointer before returning -EFAULT.  Thanks!

Philip

--- drivers/acpi/driver.c.orig       Mon May 21 20:36:55 2001
+++ drivers/acpi/driver.c    Mon May 21 20:37:21 2001
@@ -311,8 +311,10 @@
                 size = buf.length - file->f_pos;
                 if (size > *len)
                         size = *len;
-               if (copy_to_user(buffer, data, size))
-                       return -EFAULT;
+               if (copy_to_user(buffer, data, size)) {
+                 kfree(buf.pointer);
+                 return -EFAULT;
+               }
         }

         kfree(buf.pointer);

