Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTI3V2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTI3V2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:28:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:3259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbTI3V21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:28:27 -0400
Date: Tue, 30 Sep 2003 14:08:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org, kevin.tian@intel.com,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-Id: <20030930140805.0e3158e7.akpm@osdl.org>
In-Reply-To: <3F79ED60.2030207@intel.com>
References: <3F79ED60.2030207@intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma <arun.sharma@intel.com> wrote:
>
> Some drivers seem to use macros such as _IOR/_IOW in a way that ends up calling the sizeof() operator twice. For eg:
> 
> -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
> 
> from include/asm-ia64/ioctl.h (other archs are similar):
> 
> #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),sizeof(size))

Matthew Wilcox fixed all except one of these a while back.  What is left
over is this chunk:


diff -puN drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix drivers/video/aty/aty128fb.c
--- 25/drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix	Tue Sep 30 14:04:12 2003
+++ 25-akpm/drivers/video/aty/aty128fb.c	Tue Sep 30 14:04:12 2003
@@ -2041,9 +2041,9 @@ aty128fb_setcolreg(u_int regno, u_int re
 #define ATY_MIRROR_CRT_ON	0x00000002
 
 /* out param: u32*	backlight value: 0 to 15 */
-#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
+#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
 /* in param: u32*	backlight value: 0 to 15 */
-#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, sizeof(__u32*))
+#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32*)
 
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, struct fb_info *info)


Matthew's conversion mainly converted things to size_t, but from the looks
of it, __u32* is the right thing to use in this case, I think?

