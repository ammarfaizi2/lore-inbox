Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbVKCVJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbVKCVJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbVKCVJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:09:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030485AbVKCVJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:09:24 -0500
Message-ID: <436A7C75.8050101@redhat.com>
Date: Thu, 03 Nov 2005 16:09:09 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory leak in dentry_open()
Content-Type: multipart/mixed;
 boundary="------------010207000501050402080806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010207000501050402080806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

There is a memory leak possible in dentry_open().  If get_empty_filp()
fails, then the references to dentry and mnt need to be released.
The attached patch adds the calls to dput() and mntput() to release
these two references.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------010207000501050402080806
Content-Type: text/plain;
 name="open-enfile.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="open-enfile.devel"

--- linux-2.6.14/fs/open.c.org
+++ linux-2.6.14/fs/open.c
@@ -894,8 +894,11 @@ struct file *dentry_open(struct dentry *
 
 	error = -ENFILE;
 	f = get_empty_filp();
-	if (f == NULL)
+	if (f == NULL) {
+		dput(dentry);
+		mntput(mnt);
 		return ERR_PTR(error);
+	}
 
 	return __dentry_open(dentry, mnt, flags, f, NULL);
 }

--------------010207000501050402080806--
