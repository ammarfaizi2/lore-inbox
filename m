Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUJHDLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUJHDLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJHDHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:07:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44172 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267487AbUJGS0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:26:31 -0400
Date: Thu, 7 Oct 2004 11:26:12 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, John Hawkes <hawkes@sgi.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Message-Id: <20041007182612.30713.16318.72016@tomahawk.engr.sgi.com>
Subject: [PATCH 1/1] lockmeter: lockmeter-lockmeter-fix-for-generic_read_trylock.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The patch in the mm tree named: lockmeter-lockmeter-fix-for-generic_read_trylock.patch
is incorrect.  It should be as shown be replaced by this patch.  (generic_raw_read_trylock()
should be a copy of what is in kernel/spinlock.c and should not call _metered_read_lock()).

The incorrect patch breaks lockmeter on any platform that uses generic_raw_read_trylock().
(This is part of the problem with lockmeter for Altix.)

(Thanks to John Hawkes for finding this.)

From: Ray Bryant <raybry@sgi.com>

Update lockmeter.c with generic_raw_read_trylock fix.

Signed-off-by: Ray Bryant <raybry@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/lockmeter.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN kernel/lockmeter.c~lockmeter-lockmeter-fix-for-generic_read_trylock kernel/lockmeter.c
--- 25/kernel/lockmeter.c~lockmeter-lockmeter-fix-for-generic_read_trylock	2004-09-16 21:32:25.175963856 -0700
+++ 25-akpm/kernel/lockmeter.c	2004-09-16 21:32:25.180963096 -0700
@@ -1213,6 +1213,18 @@ __read_lock_failed: \
  * except for the fact tht calls to _raw_ routines are replaced by
  * corresponding calls to the _metered_ routines
  */
+
+/*
+ * Generic declaration of the raw read_trylock() function,
+ * architectures are supposed to optimize this:
+ */
+int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
+{
+	_raw_read_lock(lock);
+	return 1;
+}
+EXPORT_SYMBOL(generic_raw_read_trylock);
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
_

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
