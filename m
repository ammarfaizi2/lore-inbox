Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWBHGoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWBHGoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWBHGoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:44:19 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31874 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161022AbWBHGnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:53 -0500
Message-Id: <20060208064919.231158000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Norbert Tretkowski <norbert@tretkowski.de>,
       Steve Langasek <vorlon@debian.org>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: [PATCH 23/23] [alpha] __cmpxchg() must really always be inlined
Content-Disposition: inline; filename=__cmpxchg-must-really-always-be-inlined.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

With the latest 2.6.15 kernel builds for alpha on Debian, we ran into a
problem with undefined references to __cmpxchg_called_with_bad_pointer() in
a couple of kernel modules (xfs.ko and drm.ko; see
http://bugs.debian.org/347556).

It looks like people have been trying to out-clever each other wrt the
definition of "inline" on this architecture :), with the result that
__cmpxchg(), which must be inlined so the compiler can see its argument is
const, is not guaranteed to be inlined.  Indeed, it was not being inlined
when building with -Os.

The attached patch fixes the issue by adding an
__attribute__((always_inline)) explicitly to the definition of __cmpxchg()
instead of relying on redefines of "inline" elsewhere to make this happen.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 
 include/asm-alpha/system.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.3.orig/include/asm-alpha/system.h
+++ linux-2.6.15.3/include/asm-alpha/system.h
@@ -562,7 +562,7 @@ __cmpxchg_u64(volatile long *m, unsigned
    if something tries to do an invalid cmpxchg().  */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-static inline unsigned long
+static __always_inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {

--
