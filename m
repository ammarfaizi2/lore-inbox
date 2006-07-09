Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWGIMe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWGIMe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWGIMe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:34:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:7742 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030472AbWGIMe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=q1vZGxfgp1TS9F0OKmwtp15v3Ow+bcXPVE7UQzBfZu/lHPzRd0PAZSQSE1cqiIpt+aeWSKFdL4Aabfs8nWM95z4RgGMBuZEoYNEnK1SXdrEky1lsmMctODnAdX6kX61wfIBT0hf6Uu0v5rXu92rAd0+C5eMacb+lpuRu3On5i5I=
Message-ID: <44B0F7D9.8040203@gmail.com>
Date: Sun, 09 Jul 2006 14:34:33 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm] lockdep.c likely 
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed this

+unlikely | 53202934|    80576  trace_softirqs_on()@:/usr/src/linux-mm/kernel/lockdep.c@1861
[..]
+unlikely | 53202350|    80542  trace_softirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1895
[..]
+unlikely |272060329|  3784394  trace_hardirqs_on()@:/usr/src/linux-mm/kernel/lockdep.c@1787
[..]
+unlikely |361155686|  2959425  check_unlock()@:/usr/src/linux-mm/kernel/lockdep.c@2197
[..]
+unlikely |  1821294|  1140788  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1977
 unlikely |        0|  2962331  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1965
 unlikely |        0|  2962035  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1962
+unlikely |361188304|  2961749  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1959
[..]
+unlikely | 14528808|   413114  debug_check_no_locks_freed()@:/usr/src/linux-mm/kernel/lockdep.c@2607
 likely   |    92394|      156  lock_kernel()@:/usr/src/linux-mm/lib/kernel_lock.c@70
 unlikely |        0|   305177  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1927
 unlikely |        0|   305177  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1925
+unlikely |  2156369|   305176  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1922
 unlikely |        0|  4412613  trace_hardirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1837
+unlikely |319757688|  4409721  trace_hardirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1834

in /proc/likely_prof

I'm not sure of it, but patch below should optimalize it.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/kernel/lockdep.c linux-mm/kernel/lockdep.c
--- linux-mm-clean/kernel/lockdep.c	2006-07-09 12:07:15.000000000 +0200
+++ linux-mm/kernel/lockdep.c	2006-07-09 14:09:31.000000000 +0200
@@ -1784,7 +1784,7 @@ void trace_hardirqs_on(void)
 	struct task_struct *curr = current;
 	unsigned long ip;

-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (likely(!debug_locks || current->lockdep_recursion))
 		return;

 	if (DEBUG_LOCKS_WARN_ON(unlikely(!early_boot_irqs_enabled)))
@@ -1831,7 +1831,7 @@ void trace_hardirqs_off(void)
 {
 	struct task_struct *curr = current;

-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (likely(!debug_locks || current->lockdep_recursion))
 		return;

 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
@@ -1858,7 +1858,7 @@ void trace_softirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;

-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return;

 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
@@ -1892,7 +1892,7 @@ void trace_softirqs_off(unsigned long ip
 {
 	struct task_struct *curr = current;

-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return;

 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
@@ -1919,7 +1919,7 @@ void trace_softirqs_off(unsigned long ip
 void lockdep_init_map(struct lockdep_map *lock, const char *name,
 		      struct lock_class_key *key)
 {
-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return;

 	if (DEBUG_LOCKS_WARN_ON(!key))
@@ -1956,7 +1956,7 @@ static int __lock_acquire(struct lockdep
 	int chain_head = 0;
 	u64 chain_key;

-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return 0;

 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
@@ -1974,7 +1974,7 @@ static int __lock_acquire(struct lockdep
 	/*
 	 * Not cached yet or subclass?
 	 */
-	if (unlikely(!class)) {
+	if (likely(!class)) {
 		class = register_lock_class(lock, subclass);
 		if (!class)
 			return 0;
@@ -2194,7 +2194,7 @@ print_unlock_inbalance_bug(struct task_s
 static int check_unlock(struct task_struct *curr, struct lockdep_map *lock,
 			unsigned long ip)
 {
-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return 0;
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return 0;
@@ -2604,7 +2604,7 @@ void debug_check_no_locks_freed(const vo
 	unsigned long flags;
 	int i;

-	if (unlikely(!debug_locks))
+	if (likely(!debug_locks))
 		return;

 	local_irq_save(flags);
