Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWHYAsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWHYAsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 20:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHYAsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 20:48:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:46317 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932243AbWHYAsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 20:48:52 -0400
Subject: [PATCH] Pass sparse the lock expression given to lock annotations
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:48:56 -0700
Message-Id: <1156466936.3418.58.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock annotation macros __acquires, __releases, __acquire, and __release
all currently throw the lock expression passed as an argument.  Now that
sparse can parse __context__ and __attribute__((context)) with a context
expression, pass the lock expression down to sparse as the context expression.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
This patch depends on the Linux patch "Make spinlock/rwlock annotations
more accurate by using parameters, not types" (currently in -mm as
make-spinlock-rwlock-annotations-more-accurate-by-using.patch) and on
the sparse patch "Parse and track multiple contexts by
expression" (Message-ID
1156447273.3418.34.camel@josh-work.beaverton.ibm.com , available at
http://marc.theaimsgroup.com/?i=1156447273.3418.34.camel@josh-work.beaverton.ibm.com ).

Starting from a base of 2.6.18-rc4 plus
make-spinlock-rwlock-annotations-more-accurate-by-using.patch, using
allyesconfig, I tested sparse -Wcontext with and without this patch, and
confirmed that it generates identical output.

 include/linux/compiler.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b3963cf..2ed6528 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -10,10 +10,10 @@ # define __safe		__attribute__((safe))
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
 # define __iomem	__attribute__((noderef, address_space(2)))
-# define __acquires(x)	__attribute__((context(0,1)))
-# define __releases(x)	__attribute__((context(1,0)))
-# define __acquire(x)	__context__(1)
-# define __release(x)	__context__(-1)
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
 # define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 extern void __chk_user_ptr(void __user *);
 extern void __chk_io_ptr(void __iomem *);
-- 
1.4.1.1


