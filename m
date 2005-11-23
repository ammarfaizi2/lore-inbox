Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVKWDlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVKWDlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVKWDlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:41:47 -0500
Received: from smtp.hickorytech.net ([216.114.192.16]:42653 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S932499AbVKWDlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:41:46 -0500
Message-ID: <4383E4F6.8000202@mnsu.edu>
Date: Tue, 22 Nov 2005 21:41:42 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Zan Lynx <zlynx@acm.org>, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu> <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org> <20051122170507.37ebbc0c.akpm@osdl.org> <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 22 Nov 2005, Andrew Morton wrote:
>  
>
>>>Why does it happen at all, though?
>>>      
>>>
>>davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
>>That required inclusion of ext3 and jbd header files.  Those files explode
>>unpleasantly when CONFIG_JBD=n.
>>    
>>
>
>Oh. How about just making jbd.h do the rigt thing, and not care about the 
>configuration?
>
>If we include jbd.h, we want the jbd data structures. There's never any 
>reason to care whether jbd is enabled or not afaik.
>
>Ie maybe just something like this?
>
>(Untested, obviously. I'm just assuming that anything that actually 
>_needs_ the jbd functionality should have made sure that jdb is enabled.)
>
>Zan, Jeffrey?
>
>		Linus
>---
>diff --git a/include/linux/jbd.h b/include/linux/jbd.h
>index aa56172..dcde7ad 100644
>--- a/include/linux/jbd.h
>+++ b/include/linux/jbd.h
>@@ -16,8 +16,6 @@
> #ifndef _LINUX_JBD_H
> #define _LINUX_JBD_H
> 
>-#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || !defined(__KERNEL__)
>-
> /* Allow this file to be included directly into e2fsprogs */
> #ifndef __KERNEL__
> #include "jfs_compat.h"
>@@ -1083,19 +1081,4 @@ extern int jbd_blocks_per_page(struct in
> 
> #endif	/* __KERNEL__ */
> 
>-#endif	/* CONFIG_JBD || CONFIG_JBD_MODULE || !__KERNEL__ */
>-
>-/*
>- * Compatibility no-ops which allow the kernel to compile without CONFIG_JBD
>- * go here.
>- */
>-
>-#if defined(__KERNEL__) && !(defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE))
>-
>-#define J_ASSERT(expr)			do {} while (0)
>-#define J_ASSERT_BH(bh, expr)		do {} while (0)
>-#define buffer_jbd(bh)			0
>-#define journal_buffer_journal_lru(bh)	0
>-
>-#endif	/* defined(__KERNEL__) && !defined(CONFIG_JBD) */
> #endif	/* _LINUX_JBD_H */
>  
>

This one compiles and boots just fine.  I was also able to loop mount an
ext2 filesystem.

Thanks for all the effort!

BTW: Since I have your ear, this same version DOES seem to have some
other bug as well.  I did a "make distclean" and the "rm -f" of all he
object files hung forever in "D" state.  I'm using XFS on IDE disks. 
I'm using the same config as was posted before.  I didn't get anything
in an log files that would indicate a problem.  Has this been reported? 
If not, what can I do to make a meaningful report?

-- 
Jeffrey Hundstad

