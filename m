Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVDLPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVDLPbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVDLPaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:30:01 -0400
Received: from users.ccur.com ([208.248.32.211]:10327 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S262484AbVDLPXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:23:33 -0400
Date: Tue, 12 Apr 2005 11:23:18 -0400
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: [PATCH] add EOWNERDEAD and ENOTRECOVERABLE
Message-ID: <20050412152318.GA2714@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,
 This patch adds EOWNERDEAD and ENOTRECOVERABLE to all
architectures.  Though there is nothing in the kernel
that uses them yet, I know of two patches in development,
one by Intel and the other by Bull, that adds robust mutex
support to pthread_mutex*.

Robust mutexes, by de-facto industry convention, return
EOWNERDEAD when the owner of a mutex dies, and returns
ENOTRECOVERABLE if the new owner decides that it is not
able to recover from the dead state, and so wants to mark
the mutex unrecoverable.

There is interest in robust mutexes in Linux, as they are
a well established tool when writing high availability
applications on non-Linux platforms.

Even though there are kernel components to the robust mutex
patches, the exact kernel ABI can be easily changed or
even completely replaced, without affecting applications,
while the patches are still in development.  To achieve
this immunity, the applications need only to access robust
services through the pthreads library and they must link
only with the dynamic version of the library.  This works
only because pthread robust mutexes are a de-facto
standard, enforced by standard usage by long established
applications, which any implementation of robust mutexes
is required to match if it is to be accepted.

However, one piece of the ABI that does leak through is
the value of EOWNERDEAD and ENOTRECOVERABLE.  If these
values could be fixed then application writers would feel
more comfortable using these patches while they are still
in development.  In addition, if the patches are never
accepted into the standard kernel, but live forever in
various high availability vendor kernels as a specialty
item, then it gives their users an unchanging ABI that they
can live with -- even when they migrate their application
binaries to a competing high availability Linux kernel.

I know that it is rare for an unused patch to be accepted;
however it has happened at least once before when there
was need -- eg, the security hooks patch, so this patch
request may not be completely out of line.

Regards,
Joe

i386 compile tested.

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.12-rc2-jak/include/asm-alpha/errno.h   |    3 +++
 2.6.12-rc2-jak/include/asm-generic/errno.h |    3 +++
 2.6.12-rc2-jak/include/asm-mips/errno.h    |    3 +++
 2.6.12-rc2-jak/include/asm-parisc/errno.h  |    3 +++
 2.6.12-rc2-jak/include/asm-sparc/errno.h   |    3 +++
 2.6.12-rc2-jak/include/asm-sparc64/errno.h |    3 +++
 6 files changed, 18 insertions(+)

diff -puNa include/asm-generic/errno.h~owner.notrecoverable.errnos include/asm-generic/errno.h
--- 2.6.12-rc2/include/asm-generic/errno.h~owner.notrecoverable.errnos	2005-04-12 09:54:38.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-generic/errno.h	2005-04-12 11:16:50.681480153 -0400
@@ -102,4 +102,7 @@
 #define	EKEYREVOKED	128	/* Key has been revoked */
 #define	EKEYREJECTED	129	/* Key was rejected by service */
 
+#define	EOWNERDEAD	130	/* Owner died */
+#define	ENOTRECOVERABLE	131	/* State not recoverable */
+
 #endif
diff -puNa include/asm-alpha/errno.h~owner.notrecoverable.errnos include/asm-alpha/errno.h
--- 2.6.12-rc2/include/asm-alpha/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-alpha/errno.h	2005-04-12 11:16:17.548396780 -0400
@@ -116,4 +116,7 @@
 #define	EKEYREVOKED	134	/* Key has been revoked */
 #define	EKEYREJECTED	135	/* Key was rejected by service */
 
+#define	EOWNERDEAD	136	/* Owner died */
+#define	ENOTRECOVERABLE	137	/* State not recoverable */
+
 #endif
diff -puNa include/asm-mips/errno.h~owner.notrecoverable.errnos include/asm-mips/errno.h
--- 2.6.12-rc2/include/asm-mips/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-mips/errno.h	2005-04-12 11:16:29.262658422 -0400
@@ -115,6 +115,9 @@
 #define	EKEYREVOKED	163	/* Key has been revoked */
 #define	EKEYREJECTED	164	/* Key was rejected by service */
 
+#define	EOWNERDEAD	165	/* Owner died */
+#define	ENOTRECOVERABLE	166	/* State not recoverable */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 #ifdef __KERNEL__
diff -puNa include/asm-parisc/errno.h~owner.notrecoverable.errnos include/asm-parisc/errno.h
--- 2.6.12-rc2/include/asm-parisc/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-parisc/errno.h	2005-04-12 11:14:19.353941346 -0400
@@ -115,5 +115,8 @@
 #define ENOTSUP		252	/* Function not implemented (POSIX.4 / HPUX) */
 #define ECANCELLED	253	/* aio request was canceled before complete (POSIX.4 / HPUX) */
 
+#define EOWNERDEAD	254	/* Owner died */
+#define ENOTRECOVERABLE	255	/* State not recoverable */
+
 
 #endif
diff -puNa include/asm-sparc/errno.h~owner.notrecoverable.errnos include/asm-sparc/errno.h
--- 2.6.12-rc2/include/asm-sparc/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-sparc/errno.h	2005-04-12 11:15:55.987596555 -0400
@@ -107,4 +107,7 @@
 #define	EKEYREVOKED	130	/* Key has been revoked */
 #define	EKEYREJECTED	131	/* Key was rejected by service */
 
+#define	EOWNERDEAD	132	/* Owner died */
+#define	ENOTRECOVERABLE	133	/* State not recoverable */
+
 #endif
diff -puNa include/asm-sparc64/errno.h~owner.notrecoverable.errnos include/asm-sparc64/errno.h
--- 2.6.12-rc2/include/asm-sparc64/errno.h~owner.notrecoverable.errnos	2005-04-12 10:04:36.000000000 -0400
+++ 2.6.12-rc2-jak/include/asm-sparc64/errno.h	2005-04-12 11:16:01.526774474 -0400
@@ -107,4 +107,7 @@
 #define	EKEYREVOKED	130	/* Key has been revoked */
 #define	EKEYREJECTED	131	/* Key was rejected by service */
 
+#define	EOWNERDEAD	132	/* Owner died */
+#define	ENOTRECOVERABLE	133	/* State not recoverable */
+
 #endif /* !(_SPARC64_ERRNO_H) */

_

