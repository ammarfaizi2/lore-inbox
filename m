Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUJDSSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUJDSSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUJDSSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:18:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52624 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268248AbUJDSRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:17:41 -0400
Date: Mon, 4 Oct 2004 19:17:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] _raw_read_trylock bias
Message-ID: <Pine.LNX.4.44.0410041914050.3708-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i386 and x86_64 _raw_read_trylocks in preempt-smp.patch
are too successful: atomic_read() returns a signed integer.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc3-mm2/include/asm-i386/spinlock.h	2004-10-04 12:00:14.000000000 +0100
+++ linux/include/asm-i386/spinlock.h	2004-10-04 18:50:32.752864600 +0100
@@ -235,7 +235,7 @@ static inline int _raw_read_trylock(rwlo
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
-	if (atomic_read(count) < RW_LOCK_BIAS)
+	if (atomic_read(count) >= 0)
 		return 1;
 	atomic_inc(count);
 	return 0;
--- 2.6.9-rc3-mm2/include/asm-x86_64/spinlock.h	2004-10-04 12:00:15.000000000 +0100
+++ linux/include/asm-x86_64/spinlock.h	2004-10-04 18:50:32.752864600 +0100
@@ -236,7 +236,7 @@ static inline int _raw_read_trylock(rwlo
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
-	if (atomic_read(count) < RW_LOCK_BIAS)
+	if (atomic_read(count) >= 0)
 		return 1;
 	atomic_inc(count);
 	return 0;

