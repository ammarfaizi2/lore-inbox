Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUGIEvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUGIEvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUGIEvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:51:55 -0400
Received: from zero.aec.at ([193.170.194.10]:50953 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264206AbUGIEvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:51:51 -0400
To: ncunningham@linuxmail.org
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it>
	<2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it>
	<2fPfF-2Dv-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 09 Jul 2004 06:51:46 +0200
In-Reply-To: <2fPfF-2Dv-19@gated-at.bofh.it> (Nigel Cunningham's message of
 "Fri, 09 Jul 2004 00:10:07 +0200")
Message-ID: <m34qohrdel.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> writes:

I think a better solution would be to apply the appended patch 

And then just mark the function you know needs to be inlined
as __always_inline__. I did this on x86-64 for some functions
too that need to be always inlined (although using the attribute
directly because all x86-64 compilers support it)

The rationale is that the inlining algorithm in gcc 3.4+ is quite
a lot better and actually eliminates some not-so-great inlining
we had in the past and makes the kernel a bit smaller.

-Andi

P.S.: compiler.h seems to be not "gcc 4.0 safe". Probably that needs
to be fixed too.

diff -u linux-2.6.7-bk9-work/include/linux/compiler.h-o linux-2.6.7-bk9-work/include/linux/compiler.h
--- linux-2.6.7-bk9-work/include/linux/compiler.h-o	2004-07-08 23:58:54.000000000 +0200
+++ linux-2.6.7-bk9-work/include/linux/compiler.h	2004-07-09 08:45:13.465161312 +0200
@@ -120,4 +120,8 @@
 #define noinline
 #endif
 
+#ifndef __always_inline
+#define __always_inline
+#endif
+
 #endif /* __LINUX_COMPILER_H */
diff -u linux-2.6.7-bk9-work/include/linux/compiler-gcc3.h-o linux-2.6.7-bk9-work/include/linux/compiler-gcc3.h
--- linux-2.6.7-bk9-work/include/linux/compiler-gcc3.h-o	2004-07-08 23:58:33.000000000 +0200
+++ linux-2.6.7-bk9-work/include/linux/compiler-gcc3.h	2004-07-09 08:45:11.167510608 +0200
@@ -9,6 +9,10 @@
 # define __inline	__inline__ __attribute__((always_inline))
 #endif
 
+#if __GNUC_MINOR__ >= 1
+# define __always_inline inline __attribute__((always_inline))
+#endif
+
 #if __GNUC_MINOR__ > 0
 # define __deprecated	__attribute__((deprecated))
 #endif


