Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265988AbUFDUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUFDUnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUFDUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:43:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:34020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265988AbUFDUnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:43:37 -0400
Date: Fri, 4 Jun 2004 13:42:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: mike.miller@hp.com
Cc: mikem@beardog.cca.cpqcorp.net, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6.7-rc1
Message-Id: <20040604134251.70a1ffef.akpm@osdl.org>
In-Reply-To: <20040602201326.GA1346@beardog.cca.cpqcorp.net>
References: <20040602201326.GA1346@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
>
> 
> This patch provides a conversion routine for 32-bit user space apps that
> call into a 64-bit kernel on x86_64 architectures.  This is required for
> the HP Array Configuration utility and the HP management agents.  Without
> this patch the apps will not function.  The 2 ioctls affected are the cciss
> pass thru ioctls.
> 
> Caveat: it spits out 2 warnings during compilation.  I've tried everything
> I can think of to clean them up, but...  If anyone has any helpful
> suggestions I'm all ears.

The below fixes up the warnings.  Please test it?

It's very unusual for a disk driver to have `#ifdef __x86_64__' stuff in
it.  Is this problem really unique to x86_64 or should the new code be
enabled for all 64-bit architectures?


--- 25-x86_64/drivers/block/cciss.c~cciss-update-warning-fix	Fri Jun  4 13:40:20 2004
+++ 25-x86_64-akpm/drivers/block/cciss.c	Fri Jun  4 13:42:22 2004
@@ -532,13 +532,16 @@ int cciss_ioctl32_passthru(unsigned int 
 	IOCTL_Command_struct arg64;
 	mm_segment_t old_fs;
 	int err;
+	unsigned long cp;
 
 	err = 0;
 	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info, sizeof(arg64.LUN_info));
 	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
 	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
 	err |= get_user(arg64.buf_size, &arg32->buf_size);
-	err |= get_user(arg64.buf, &arg32->buf);
+	err |= get_user(cp, &arg32->buf);
+	arg64.buf = (BYTE *)cp;
+
 	if (err)
 		return -EFAULT;
 
@@ -561,6 +564,7 @@ int cciss_ioctl32_big_passthru(unsigned 
 	BIG_IOCTL_Command_struct arg64;
 	mm_segment_t old_fs;
 	int err;
+	unsigned long cp;
 
 	err = 0;
 	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info, sizeof(arg64.LUN_info));
@@ -568,8 +572,12 @@ int cciss_ioctl32_big_passthru(unsigned 
 	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
 	err |= get_user(arg64.buf_size, &arg32->buf_size);
 	err |= get_user(arg64.malloc_size, &arg32->malloc_size);
-	err |= get_user(arg64.buf, &arg32->buf);
-	if (err) return -EFAULT;
+	err |= get_user(cp, &arg32->buf);
+	arg64.buf = (BYTE *)cp;
+
+	if (err)
+		return -EFAULT;
+
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	err = sys_ioctl(fd, CCISS_BIG_PASSTHRU, (unsigned long) &arg64);
_

