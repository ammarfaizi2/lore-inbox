Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbREVCwK>; Mon, 21 May 2001 22:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbREVCwB>; Mon, 21 May 2001 22:52:01 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:36771 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262358AbREVCvx>; Mon, 21 May 2001 22:51:53 -0400
Message-Id: <5.0.2.1.2.20010521193935.00ae8cb8@pxwang.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 21 May 2001 19:50:41 -0700
To: alan@lxorguk.ukuu.org.uk
From: Philip Wang <PXWang@stanford.edu>
Subject: [PATCH] drivers/acpi/driver.c
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@cs.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

There is a bug in driver.c of not freeing memory on error 
paths.  buf.pointer is allocated but not freed if copy_to_user fails.  The 
addition I made was to kfree buf.pointer before returning -EFAULT.  Thanks!

Philip

--- /2.4.4/linux/drivers/acpi/driver.c  Fri Feb  9 11:45:58 2001
+++ driver.c    Mon May 21 19:21:14 2001
@@ -311,8 +311,10 @@
		size = buf.length - file->f_pos;
		if (size > *len)
			size = *len;
-		if (copy_to_user(buffer, data, size))
-			return -EFAULT;
+		if (copy_to_user(buffer, data, size)) {
+			kfree(buf.pointer);
+			return -EFAULT;
+		}
	}

	kfree(buf.pointer);

