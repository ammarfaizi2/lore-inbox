Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWGUWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWGUWgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWGUWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:36:42 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:30945 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751243AbWGUWgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:36:42 -0400
Date: Fri, 21 Jul 2006 18:30:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] spinlock_debug: don't recompute (jiffies_per_loop *
  HZ) in spinloop
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607211834_MC3-1-C5BD-B57D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In spinlock_debug.c, the spinloops call __delay() on every iteration.
Because that is an external function, (jiffies_per_loop * HZ), the
loop's iteration limit, gets recomputed every time. Caching it
explicitly prevents that.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

__delay() should really be declared __attribute_pure.


--- 2.6.18-rc2-64-numa.orig/lib/spinlock_debug.c
+++ 2.6.18-rc2-64-numa/lib/spinlock_debug.c
@@ -99,11 +99,12 @@ static inline void debug_spin_unlock(spi
 
 static void __spin_lock_debug(spinlock_t *lock)
 {
-	int print_once = 1;
 	u64 i;
+	u64 loops = loops_per_jiffy * HZ;
+	int print_once = 1;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < loops; i++) {
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -164,11 +165,12 @@ static void rwlock_bug(rwlock_t *lock, c
 
 static void __read_lock_debug(rwlock_t *lock)
 {
-	int print_once = 1;
 	u64 i;
+	u64 loops = loops_per_jiffy * HZ;
+	int print_once = 1;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < loops; i++) {
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -237,11 +239,12 @@ static inline void debug_write_unlock(rw
 
 static void __write_lock_debug(rwlock_t *lock)
 {
-	int print_once = 1;
 	u64 i;
+	u64 loops = loops_per_jiffy * HZ;
+	int print_once = 1;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < loops; i++) {
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
-- 
Chuck
