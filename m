Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVBAJmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVBAJmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVBAJmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:42:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23529 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261933AbVBAJmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:42:50 -0500
Message-ID: <41FF4F18.90008@in.ibm.com>
Date: Tue, 01 Feb 2005 15:12:48 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] s390: getdents patch for 32 -> 64 converter
Content-Type: multipart/mixed;
 boundary="------------060608080902030704060709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060608080902030704060709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch solves a problem with working of getdents while using 32 bit 
binaries on 64 bit Linux/390. glibc expects d_type to be passed if we 
have a kernel version after 2.6.4, so we have to also handle it in the 
32bit syscall converter. Similar patch was given for PPC by Marcus 
Meissner 
(http://ozlabs.org/pipermail/linuxppc64-dev/2004-March/001359.html) and 
was integrated into 2.6.5.

Thanks,
Sripathi.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>


--------------060608080902030704060709
Content-Type: text/plain;
 name="filldir_2.6.10_patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filldir_2.6.10_patch.patch"

--- linux-2.6.10/arch/s390/kernel/compat_linux.c	2004-12-25 03:05:24.000000000 +0530
+++ /home/sripathi/12795/mainline/compat_linux.c	2005-02-01 14:06:33.000000000 +0530
@@ -433,7 +433,7 @@ static int filldir(void * __buf, const c
 {
 	struct linux_dirent32 * dirent;
 	struct getdents_callback32 * buf = (struct getdents_callback32 *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
@@ -447,6 +447,7 @@ static int filldir(void * __buf, const c
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
+	put_user(d_type, (char *) dirent + reclen - 1);
 	buf->current_dir = ((void *)dirent) + reclen;
 	buf->count -= reclen;
 	return 0;

--------------060608080902030704060709--
