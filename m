Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUKOTu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUKOTu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKOTuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:50:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261668AbUKOTuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:50:12 -0500
Date: Mon, 15 Nov 2004 14:50:01 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] SELinux scalability - add spin_trylock_irq and
 spin_trylock_irqsave
In-Reply-To: <Xine.LNX.4.44.0411151431090.21180-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0411151447570.21180-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch from Kaigai Kohei <kaigai@ak.jp.nec.com> adds irq and irqsave
trylock spinlock variants for use by the SELinux AVC RCU patch.

Please apply.

Signed-off-by: Kaigai Kohei <kaigai@ak.jp.nec.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@redhat.com>

---

 include/linux/spinlock.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -purN -X dontdiff linux-2.6.10-rc2.p/include/linux/spinlock.h linux-2.6.10-rc2.w/include/linux/spinlock.h
--- linux-2.6.10-rc2.p/include/linux/spinlock.h	2004-11-15 13:18:55.000000000 -0500
+++ linux-2.6.10-rc2.w/include/linux/spinlock.h	2004-11-15 13:36:12.572317408 -0500
@@ -468,6 +468,20 @@ do { \
 
 #define spin_trylock_bh(lock)			__cond_lock(_spin_trylock_bh(lock))
 
+#define spin_trylock_irq(lock) \
+({ \
+	local_irq_disable(); \
+	_spin_trylock(lock) ? \
+	1 : ({local_irq_enable(); 0; }); \
+})
+
+#define spin_trylock_irqsave(lock, flags) \
+({ \
+	local_irq_save(flags); \
+	_spin_trylock(lock) ? \
+	1 : ({local_irq_restore(flags); 0;}); \
+})
+
 #ifdef CONFIG_LOCKMETER
 extern void _metered_spin_lock   (spinlock_t *lock);
 extern void _metered_spin_unlock (spinlock_t *lock);



