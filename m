Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTKITJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTKITJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:09:25 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12817 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262776AbTKITJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:09:22 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH][2.6.0-test9] fix 32/64 bits for input events
Date: Sun, 9 Nov 2003 21:36:11 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bkor/ad9tBYqZr7"
Message-Id: <200311092136.11212.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_bkor/ad9tBYqZr7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Input bits are kept as array of unsigned long and when no bit is set the whole 
"unsigned long" is represented as single 0 in hotplug events and /proc files. 
It makes rather hard for user-level programs to guess which bits are set - 
programs need to know size of kernel long to correctly interpret output.

One possibility is attached patch. It makes sure every long is always output 
in full. Another possibility (I like it more frankly speaking) is to always 
use 32 bit type for arrays. But it needs more than two lines of trivial 
changes.

regards

-andrey

PS do I miss something or input /proc functions really never check for buffer 
overflow?

--Boundary-00=_bkor/ad9tBYqZr7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test9-input_user_bits.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-test9-input_user_bits.patch"

--- linux-2.6.0-test9/drivers/input/input.c	2003-11-09 21:17:59.000000000 +0300
+++ ../tmp/linux-2.6.0-test9/drivers/input/input.c	2003-10-25 22:21:42.000000000 +0400
@@ -330,8 +330,7 @@ static struct input_device_id *input_mat
 		for (j = NBITS(max) - 1; j >= 0; j--) \
 			if (dev->bit[j]) break; \
 		for (; j >= 0; j--) \
-			scratch += sprintf(scratch, "%0*lx ", \
-					BITS_PER_LONG/4, dev->bit[j]); \
+			scratch += sprintf(scratch, "%lx ", dev->bit[j]); \
 		scratch++; \
 	} while (0)
 
@@ -584,8 +583,7 @@ static struct file_operations input_fops
 		for (i = NBITS(max) - 1; i >= 0; i--) \
 			if (dev->bit[i]) break; \
 		for (; i >= 0; i--) \
-			len += sprintf(buf + len, "%0*lx ", \
-					BITS_PER_LONG/4, dev->bit[i]); \
+			len += sprintf(buf + len, "%lx ", dev->bit[i]); \
 		len += sprintf(buf + len, "\n"); \
 	} while (0)
 

--Boundary-00=_bkor/ad9tBYqZr7--

