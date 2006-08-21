Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWHUSsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWHUSsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHUSsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:31 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46780 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750735AbWHUSsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:08 -0400
Date: Mon, 21 Aug 2006 11:46:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Ingo Molnar <mingo@elte.hu>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/20] disable debugging version of write_lock()
Message-ID: <20060821184632.GH21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="disable-debugging-version-of-write_lock.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew Morton <akpm@osdl.org>

We've confirmed that the debug version of write_lock() can get stuck for long
enough to cause NMI watchdog timeouts and hence a crash.

We don't know why, yet.   Disable it for now.

Also disable the similar read_lock() code.  Just in case.

Thanks to Dave Olson <olson@unixfolk.com> for reporting and testing.

Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 lib/spinlock_debug.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.17.8.orig/lib/spinlock_debug.c
+++ linux-2.6.17.8/lib/spinlock_debug.c
@@ -137,6 +137,7 @@ static void rwlock_bug(rwlock_t *lock, c
 
 #define RWLOCK_BUG_ON(cond, lock, msg) if (unlikely(cond)) rwlock_bug(lock, msg)
 
+#if 0		/* __write_lock_debug() can lock up - maybe this can too? */
 static void __read_lock_debug(rwlock_t *lock)
 {
 	int print_once = 1;
@@ -159,12 +160,12 @@ static void __read_lock_debug(rwlock_t *
 		}
 	}
 }
+#endif
 
 void _raw_read_lock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	if (unlikely(!__raw_read_trylock(&lock->raw_lock)))
-		__read_lock_debug(lock);
+	__raw_read_lock(&lock->raw_lock);
 }
 
 int _raw_read_trylock(rwlock_t *lock)
@@ -210,6 +211,7 @@ static inline void debug_write_unlock(rw
 	lock->owner_cpu = -1;
 }
 
+#if 0		/* This can cause lockups */
 static void __write_lock_debug(rwlock_t *lock)
 {
 	int print_once = 1;
@@ -232,12 +234,12 @@ static void __write_lock_debug(rwlock_t 
 		}
 	}
 }
+#endif
 
 void _raw_write_lock(rwlock_t *lock)
 {
 	debug_write_lock_before(lock);
-	if (unlikely(!__raw_write_trylock(&lock->raw_lock)))
-		__write_lock_debug(lock);
+	__raw_write_lock(&lock->raw_lock);
 	debug_write_lock_after(lock);
 }
 

--
