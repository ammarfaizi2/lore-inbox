Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWIVHsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWIVHsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWIVHsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:48:30 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:25235 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750891AbWIVHs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:48:29 -0400
Date: Fri, 22 Sep 2006 16:48:13 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-ID: <20060922074813.GA20921@localhost.Internal.Linux-SH.ORG>
References: <swfzmcse7mm.wl%takata@linux-m32r.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swfzmcse7mm.wl%takata@linux-m32r.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:29:53PM +0900, Hirokazu Takata wrote:
> Matthew Wilcox pointed out that generic__raw_read_trylock() is
> unfit for use.
> 
> Here is a patch to fix __raw_read_trylock() for m32r.
> It is taken from the i386 implementation.
> 
This might be a stupid question, but why exactly are we ripping out
generic__raw_read_trylock() if architectures are going to implement a
generic implementation anyways, rather than just changing it to match
the proper semantics?

With this the m32r patch can be dropped and the rest of the
architectures can switch over as necessary to optimized versions, rather
than being fundamentally broken.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 include/asm-i386/spinlock.h |   10 +---------
 kernel/spinlock.c           |    9 +++++++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/asm-i386/spinlock.h b/include/asm-i386/spinlock.h
index d102036..2aba6b3 100644
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -169,15 +169,7 @@ static inline void __raw_write_lock(raw_
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-static inline int __raw_read_trylock(raw_rwlock_t *lock)
-{
-	atomic_t *count = (atomic_t *)lock;
-	atomic_dec(count);
-	if (atomic_read(count) >= 0)
-		return 1;
-	atomic_inc(count);
-	return 0;
-}
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 static inline int __raw_write_trylock(raw_rwlock_t *lock)
 {
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index fb524b0..8d50b9d 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -15,6 +15,7 @@ #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 #include <linux/module.h>
+#include <asm/atomic.h>
 
 /*
  * Generic declaration of the raw read_trylock() function,
@@ -22,8 +23,12 @@ #include <linux/module.h>
  */
 int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
 {
-	__raw_read_lock(lock);
-	return 1;
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (atomic_read(count) >= 0)
+		return 1;
+	atomic_inc(count);
+	return 0;
 }
 EXPORT_SYMBOL(generic__raw_read_trylock);
