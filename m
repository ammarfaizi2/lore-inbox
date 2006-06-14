Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWFNKuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWFNKuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFNKuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:50:05 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:5725 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932157AbWFNKuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:50:04 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <200606132243.24584.arnd@arndb.de>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
	 <1150211828.2844.20.camel@hades.cambridge.redhat.com>
	 <200606132233.07830.arnd@arndb.de>  <200606132243.24584.arnd@arndb.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 14 Jun 2006 12:50:04 +0200
Message-Id: <1150282204.6461.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 22:43 +0200, Arnd Bergmann wrote:
> Am Tuesday 13 June 2006 22:33 schrieb Arnd Bergmann:
> > Erm, I don't think the kernel even uses those definitions, the only reason
> > to keep them is old user space.
> 
> Sorry, misinformation on my side. The kernel uses the FD_foo versions,
> not the __FD_foo ones, so I did not find them at first.
> 
> It's only used in fs/open.c though, and I wonder if that could just
> use the bitops versions directly, as these are more likely to be
> optimized well for a given architecture.

Using set_bit and clear_bit is actually overkill since they use compare
and swap to do an atomic update. That is not needed for __FD_foo. How
about the attached patch ?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

--

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] __FD_foo definitions.

Make the definitions of __FD_SET, __FD_CLR and __FD_ISSET independent
from asm/bitops.h and remove the macro magic that tests for __GLIBC__.
Use simple C inline functions instead of set_bit, clear_bit and test_bit.

Spotted by David Woodhouse <dwmw2@infradead.org>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/posix_types.h |   42 ++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/include/asm-s390/posix_types.h linux-2.6-patched/include/asm-s390/posix_types.h
--- linux-2.6/include/asm-s390/posix_types.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/posix_types.h	2006-06-14 12:37:54.000000000 +0200
@@ -76,24 +76,36 @@ typedef struct {
 } __kernel_fsid_t;
 
 
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+#ifdef __KERNEL__
 
-#ifndef _S390_BITOPS_H
-#include <asm/bitops.h>
-#endif
-
-#undef  __FD_SET
-#define __FD_SET(fd,fdsetp)  set_bit((fd),(fdsetp)->fds_bits)
-
-#undef  __FD_CLR
-#define __FD_CLR(fd,fdsetp)  clear_bit((fd),(fdsetp)->fds_bits)
-
-#undef  __FD_ISSET
-#define __FD_ISSET(fd,fdsetp)  test_bit((fd),(fdsetp)->fds_bits)
+#undef __FD_SET
+static inline void __FD_SET(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] |= (1UL<<_rem);
+}
+
+#undef __FD_CLR
+static inline void __FD_CLR(unsigned long fd, __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	fdsetp->fds_bits[_tmp] &= ~(1UL<<_rem);
+}
+
+#undef __FD_ISSET
+static inline int __FD_ISSET(unsigned long fd, const __kernel_fd_set *fdsetp)
+{
+	unsigned long _tmp = fd / __NFDBITS;
+	unsigned long _rem = fd % __NFDBITS;
+	return (fdsetp->fds_bits[_tmp] & (1UL<<_rem)) != 0;
+}
 
 #undef  __FD_ZERO
-#define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set *)(fdsetp))))
+#define __FD_ZERO(fdsetp) \
+	((void) memset ((__ptr_t) (fdsetp), 0, sizeof (__kernel_fd_set)))
 
-#endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)*/
+#endif     /* __KERNEL__ */
 
 #endif


