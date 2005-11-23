Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVKWBjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVKWBjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVKWBja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:39:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965074AbVKWBja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:39:30 -0500
Date: Tue, 22 Nov 2005 17:39:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: jeffrey.hundstad@mnsu.edu, Zan Lynx <zlynx@acm.org>, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <20051122170507.37ebbc0c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu>
 <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
 <20051122170507.37ebbc0c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Andrew Morton wrote:
> > 
> > Why does it happen at all, though?
> 
> davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
> That required inclusion of ext3 and jbd header files.  Those files explode
> unpleasantly when CONFIG_JBD=n.

Oh. How about just making jbd.h do the rigt thing, and not care about the 
configuration?

If we include jbd.h, we want the jbd data structures. There's never any 
reason to care whether jbd is enabled or not afaik.

Ie maybe just something like this?

(Untested, obviously. I'm just assuming that anything that actually 
_needs_ the jbd functionality should have made sure that jdb is enabled.)

Zan, Jeffrey?

		Linus
---
diff --git a/include/linux/jbd.h b/include/linux/jbd.h
index aa56172..dcde7ad 100644
--- a/include/linux/jbd.h
+++ b/include/linux/jbd.h
@@ -16,8 +16,6 @@
 #ifndef _LINUX_JBD_H
 #define _LINUX_JBD_H
 
-#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || !defined(__KERNEL__)
-
 /* Allow this file to be included directly into e2fsprogs */
 #ifndef __KERNEL__
 #include "jfs_compat.h"
@@ -1083,19 +1081,4 @@ extern int jbd_blocks_per_page(struct in
 
 #endif	/* __KERNEL__ */
 
-#endif	/* CONFIG_JBD || CONFIG_JBD_MODULE || !__KERNEL__ */
-
-/*
- * Compatibility no-ops which allow the kernel to compile without CONFIG_JBD
- * go here.
- */
-
-#if defined(__KERNEL__) && !(defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE))
-
-#define J_ASSERT(expr)			do {} while (0)
-#define J_ASSERT_BH(bh, expr)		do {} while (0)
-#define buffer_jbd(bh)			0
-#define journal_buffer_journal_lru(bh)	0
-
-#endif	/* defined(__KERNEL__) && !defined(CONFIG_JBD) */
 #endif	/* _LINUX_JBD_H */
