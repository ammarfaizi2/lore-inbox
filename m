Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423033AbWJGAXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423033AbWJGAXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423035AbWJGAXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:23:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:65086 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423033AbWJGAXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:23:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mqxcHz/GomA7c/V4+FoAnFaYA7D6O3L3xsFv3vf43UuOAwYEr/NZJ7ctm7M+o+u0E3OPuilOIdPvc4vaFIjoWz8etM7o2+sT3fVUr0fGbK2cUl8yjaxrxNHouFR+F8NeL/V5geiU58qLwbcm5Zsp7cyCAfHleo47LfPfg4g/D/w=
Date: Sat, 7 Oct 2006 04:23:15 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: lock_flags_t vs typecheck(unsigned long, flags)
Message-ID: <20061007002315.GA5338@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I've checked ~3/4 of spin_lock_irqsave callers and found something
like 20 deviations from unsigned long, some preventive measures should be
set up, I became sure.

So far I have 2 working (unfinished) things:

a) sparse checking

	typedef unsigned long __bitwise__ lock_flags_t;

	plus annotations in core and arch headers plus
	s/unsigned long/lock_flags_t/

	+: comprehensive checking
	-: not so many folks do sparse runs, so bugs will probably
	   stay unnoticed longer :-(

b) compiler checking: BUILD_BUG_ON + typecheck()

	needs local_irq_save() protection + it's removal from FRV.

	+: in best case -- compile error, in average case: warning.
	-: tiny wrappers around spin_lock_irqsave in drivers are
	   likely to hide offenders.

What folks want to see in tree?

--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -183,13 +183,43 @@ #define write_lock(lock)		_write_lock(lo
 #define read_lock(lock)			_read_lock(lock)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
-#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
-#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#define spin_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		flags = _spin_lock_irqsave(lock);			\
+	} while (0)
+#define read_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		flags = _read_lock_irqsave(lock);			\
+	} while (0)
+#define write_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		flags = _write_lock_irqsave(lock);			\
+	} while (0)
 #else
-#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
-#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
-#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#define spin_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_spin_lock_irqsave(lock, flags);			\
+	} while (0)
+#define read_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_read_lock_irqsave(lock, flags);			\
+	} while (0)
+#define write_lock_irqsave(lock, flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_write_lock_irqsave(lock, flags);			\
+	} while (0)
 #endif
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
@@ -224,16 +254,28 @@ # define write_unlock_irq(lock) \
     do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
 #endif
 
-#define spin_unlock_irqrestore(lock, flags) \
-					_spin_unlock_irqrestore(lock, flags)
+#define spin_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_spin_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
-#define read_unlock_irqrestore(lock, flags) \
-					_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_read_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define read_unlock_bh(lock)		_read_unlock_bh(lock)
 
-#define write_unlock_irqrestore(lock, flags) \
-					_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irqrestore(lock, flags)				\
+	do {								\
+		BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+		typecheck(unsigned long, flags);			\
+		_write_unlock_irqrestore(lock, flags);			\
+	} while (0)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
 #define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
@@ -247,6 +289,8 @@ ({ \
 
 #define spin_trylock_irqsave(lock, flags) \
 ({ \
+	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(flags));	\
+	typecheck(unsigned long, flags);			\
 	local_irq_save(flags); \
 	spin_trylock(lock) ? \
 	1 : ({ local_irq_restore(flags); 0; }); \

