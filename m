Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271009AbUJUWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271009AbUJUWSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270972AbUJUV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:56:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:37277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270999AbUJUVyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:54:06 -0400
Date: Thu, 21 Oct 2004 14:54:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: [PATCH] make __sigqueue_alloc() a general helper
Message-ID: <20041021145402.O2441@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posix timers preallocate siqueue structures during timer creation
and keep them for reuse.  This allocation happens in user context
with no locks held, however it's designated as an atomic allocation.
Loosen this restriction, and while we're at it let's do a bit of code
consolidation so signal sending uses same __sigqueue_alloc() helper.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 kernel/signal.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

===== kernel/signal.c 1.139 vs edited =====
--- 1.139/kernel/signal.c	2004-10-19 21:12:13 -07:00
+++ edited/kernel/signal.c	2004-10-21 13:46:54 -07:00
@@ -265,18 +265,18 @@
 	return sig;
 }
 
-static struct sigqueue *__sigqueue_alloc(void)
+static inline struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
 {
 	struct sigqueue *q = NULL;
 
-	if (atomic_read(&current->user->sigpending) <
-			current->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
-		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
+	if (atomic_read(&t->user->sigpending) <
+			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
+		q = kmem_cache_alloc(sigqueue_cachep, flags);
 	if (q) {
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = NULL;
-		q->user = get_uid(current->user);
+		q->user = get_uid(t->user);
 		atomic_inc(&q->user->sigpending);
 	}
 	return(q);
@@ -764,14 +764,8 @@
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&t->user->sigpending) <
-			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
-		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
-
+	q = __sigqueue_alloc(t, GFP_ATOMIC);
 	if (q) {
-		q->flags = 0;
-		q->user = get_uid(t->user);
-		atomic_inc(&q->user->sigpending);
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
 		case 0:
@@ -1298,7 +1292,7 @@
 {
 	struct sigqueue *q;
 
-	if ((q = __sigqueue_alloc()))
+	if ((q = __sigqueue_alloc(current, GFP_KERNEL)))
 		q->flags |= SIGQUEUE_PREALLOC;
 	return(q);
 }
