Return-Path: <linux-kernel-owner+w=401wt.eu-S932493AbXAQPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXAQPhe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAQPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:37:24 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:39290 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbXAQPhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:37:12 -0500
X-IronPort-AV: i="4.13,199,1167638400"; 
   d="scan'208"; a="759576028:sNHT45573312"
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: On some configs, sparse spinlock balance checking is broken
X-Message-Flag: Warning: May contain useful information
References: <adaejpumt41.fsf@cisco.com> <20070117063450.GC14027@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 Jan 2007 07:37:02 -0800
In-Reply-To: <20070117063450.GC14027@elte.hu> (Ingo Molnar's message of "Wed, 17 Jan 2007 07:34:50 +0100")
Message-ID: <adavej5k6ld.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Jan 2007 15:37:04.0552 (UTC) FILETIME=[56BDCA80:01C73A4D]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > i think the right way to fix it might be to define a _spin_unlock() 
 > within those #ifdef branches, and then to define spin_lock as:
 > 
 > static inline void spin_lock(spinlock_t *lock) __acquires(lock)

I tried a similar approach, but what got me was that sparse doesn't
pay attention to the "__acquires()" annotation there.  However I now
realized that putting "__acquire()" inside the implementation of the
function (which sparse can see for inline functions) actually works.

And actually the lock stuff is OK, since it's not inlined -- it's the
unlock stuff that goes directly to the __raw versions.  But something
like the following works for me; does it look OK to you?

---

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 94b767d..8ec4142 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -228,15 +228,45 @@ do {								\
 # define read_unlock_irq(lock)		_read_unlock_irq(lock)
 # define write_unlock_irq(lock)		_write_unlock_irq(lock)
 #else
-# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
-# define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
-# define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
-# define spin_unlock_irq(lock) \
-    do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
-# define read_unlock_irq(lock) \
-    do { __raw_read_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
-# define write_unlock_irq(lock) \
-    do { __raw_write_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
+static inline void spin_unlock(spinlock_t *lock)
+{
+	__release(lock);
+	__raw_spin_unlock(&(lock)->raw_lock);
+}
+
+static inline void read_unlock(rwlock_t *lock)
+{
+	__release(lock);
+	__raw_read_unlock(&(lock)->raw_lock);
+}
+
+static inline void write_unlock(rwlock_t *lock)
+{
+	__release(lock);
+	__raw_write_unlock(&(lock)->raw_lock);
+}
+
+static inline void spin_unlock_irq(spinlock_t *lock)
+{
+	__release(lock);
+	__raw_spin_unlock(&(lock)->raw_lock);
+	local_irq_enable();
+}
+
+static inline void read_unlock_irq(rwlock_t *lock)
+{
+	__release(lock);
+	__raw_read_unlock(&(lock)->raw_lock);
+	local_irq_enable();
+}
+
+static inline void write_unlock_irq(rwlock_t *lock)
+{
+	__release(lock);
+	__raw_write_unlock(&(lock)->raw_lock);
+	local_irq_enable();
+}
+
 #endif
 
 #define spin_unlock_irqrestore(lock, flags) \
