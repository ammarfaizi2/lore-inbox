Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268738AbUHTUlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268738AbUHTUlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUHTUid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:38:33 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:49562 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S268731AbUHTUfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:35:32 -0400
Subject: Re: 2.6.8.1-mm, programs crashing on x86_64
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1093023902.908.8.camel@boxen>
References: <1093023902.908.8.camel@boxen>
Content-Type: text/plain
Message-Id: <1093034107.798.8.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 22:35:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This does not happen in linus -bk. I noticed it happens in
> 2.6.8-mm2 also, but not sure about earlier. I'll try some earlier
> -mm's and if noone knows what could be it I'll do a binary search.
> 
> Must be quite newly introduced though...
> 
> boxen:~# chroot /mnt/store/x86/ bash
> bash[911] bad frame in 32bit signal deliver frame:00000000ffffd220 rip:556605d6 rsp:ffffd500 orax:ffffffffffffffff
> bash[910] bad frame in 32bit signal deliver frame:00000000ffffd220 rip:556605d6 rsp:ffffd500 orax:ffffffffffffffff
> bash[910]: segfault at 00000000ffffd51c rip 00000000556605d6 rsp 00000000ffffd500 error 7
> bash[911]: segfault at 00000000ffffd51c rip 00000000556605d6 rsp 00000000ffffd500 error 7
> 

I forgot to tell you what environment I'm in; debian in a pure 64-bit
environment. I've got a chroot at /mnt/store/x86 where I compile kernels
for x86 boxes.

.config snippet:
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y


Anyway, found the trouble-maker. Reverting below patch fixes issues.

diff -uprN linux-2.6.8-rc3-mm1/include/asm-x86_64/processor.h linux-2.6.8-rc3-mm2/include/asm-x86_64/processor.h
--- linux-2.6.8-rc3-mm1/include/asm-x86_64/processor.h	2004-08-20 21:10:01.739109232 +0200
+++ linux-2.6.8-rc3-mm2/include/asm-x86_64/processor.h	2004-08-20 21:09:52.095575272 +0200
@@ -164,9 +164,9 @@ static inline void clear_in_cr4 (unsigne
 
 
 /*
- * User space process size: 512GB - 1GB (default).
+ * User space process size.
  */
-#define TASK_SIZE	(0x0000007fc0000000UL)
+#define TASK_SIZE	(test_thread_flag(TIF_IA32) ? 0xffffd000 : 0x0000007fc0000000UL)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.


