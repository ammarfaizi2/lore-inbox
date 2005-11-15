Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVKOMTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVKOMTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVKOMTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:19:04 -0500
Received: from sophia.inria.fr ([138.96.64.20]:43420 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S932420AbVKOMTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:19:02 -0500
Message-ID: <4379D21F.3050500@yahoo.fr>
Date: Tue, 15 Nov 2005 13:18:39 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, tim.bird@am.sony.com
Subject: [PATCH 2/2] kmsg_write: don't return printk return value
References: <42F08FE6.8000601@yahoo.fr> <430CA2CE.4070403@am.sony.com>
In-Reply-To: <430CA2CE.4070403@am.sony.com>
Content-Type: multipart/mixed;
 boundary="------------060408020905000102020305"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (sophia.inria.fr [138.96.64.20]); Tue, 15 Nov 2005 13:18:39 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408020905000102020305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

kmsg_write returns with printk, so some programs may be confused by
a successful write() with a return value different than the buffer length.

# /bin/echo something > /dev/kmsg
/bin/echo: write error: Inappropriate ioctl for device

The drawbacks is that the printk return value can no more be quickly checked
from userspace.

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>

---
  mem.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletion(-)

-- 
Guillaume



--------------060408020905000102020305
Content-Type: text/x-patch;
 name="kmsg_write.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmsg_write.diff"

diff -r d18e06f9c571 drivers/char/mem.c
--- a/drivers/char/mem.c	Mon Nov 14 10:22:49 2005 +0800
+++ b/drivers/char/mem.c	Mon Nov 14 15:03:06 2005 +0100
@@ -817,7 +817,7 @@
 			  size_t count, loff_t *ppos)
 {
 	char *tmp;
-	int ret;
+	ssize_t ret;
 
 	tmp = kmalloc(count + 1, GFP_KERNEL);
 	if (tmp == NULL)
@@ -826,6 +826,9 @@
 	if (!copy_from_user(tmp, buf, count)) {
 		tmp[count] = 0;
 		ret = printk("%s", tmp);
+		if (ret > count)
+			/* printk can add a prefix */
+			ret = count;
 	}
 	kfree(tmp);
 	return ret;


--------------060408020905000102020305--
