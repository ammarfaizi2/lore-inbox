Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269733AbUICTD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269733AbUICTD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUICTD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:03:56 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:47071 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S269767AbUICTDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:03:05 -0400
Message-ID: <4138C175.4040301@am.sony.com>
Date: Fri, 03 Sep 2004 12:09:41 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc: make kernel inline redefinition ubiquitous
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, the kernel redefinition for inline
(with attribute(__always_inline)) is not being used when it
should be.  Most of the time, this has no detectable effect.
However, under certain conditions, such as when one is using
the gcc -finstrument-functions feature, this results in link
errors.

This patch adds some include lines needed to avoid this
situation (at least for configurations that I tested).
Also, this patch removes a conditional which disables
the kernel redefinition of inline for gcc 3.4 and above.
(IOW, for gcc 3.4 and above, currently the kernel does
NOT redefine 'inline' to be always inline, but with
this change it will.)

This was discussed before at:

http://groups.google.com/groups?q=always_inline&hl=en&lr=&ie=UTF-8&selm=2hjY2-7YV-9%40gated-at.bofh.it&rnum=1


Signed-off-by: Tim Bird <tim.bird@am.sony.com>
---
 asm-ppc/delay.h       |    1 +
 asm-ppc/processor.h   |    1 +
 linux/compiler-gcc3.h |    2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff -ruN -X ../../dontdiff linux-2.6.7/include/asm-ppc/delay.h branch_KFI/include/asm-ppc/delay.h
--- linux-2.6.7/include/asm-ppc/delay.h	2004-06-15 22:19:42.000000000 -0700
+++ branch_KFI/include/asm-ppc/delay.h	2004-08-11 15:30:22.000000000 -0700
@@ -2,6 +2,7 @@
 #ifndef _PPC_DELAY_H
 #define _PPC_DELAY_H

+#include <linux/compiler.h>	/* for kernel inline definition */
 #include <asm/param.h>

 /*
diff -ruN -X ../../dontdiff linux-2.6.7/include/asm-ppc/processor.h branch_KFI/include/asm-ppc/processor.h
--- linux-2.6.7/include/asm-ppc/processor.h	2004-06-15 22:18:38.000000000 -0700
+++ branch_KFI/include/asm-ppc/processor.h	2004-08-11 15:35:25.000000000 -0700
@@ -10,6 +10,7 @@

 #include <linux/config.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>	/* for kernel inline definition */

 #include <asm/ptrace.h>
 #include <asm/types.h>
diff -ruN -X ../../dontdiff linux-2.6.7/include/linux/compiler-gcc3.h branch_KFI/include/linux/compiler-gcc3.h
--- linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-15 22:18:45.000000000 -0700
+++ branch_KFI/include/linux/compiler-gcc3.h	2004-08-11 14:16:34.000000000 -0700
@@ -3,7 +3,7 @@
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>

-#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
+#if __GNUC_MINOR__ >= 1
 # define inline		__inline__ __attribute__((always_inline))
 # define __inline__	__inline__ __attribute__((always_inline))
 # define __inline	__inline__ __attribute__((always_inline))


-- 
=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
