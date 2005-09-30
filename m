Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVI3CXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVI3CXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVI3CXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbVI3CXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:03 -0400
Message-Id: <20050930022201.149837000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alexander Nyberg <alexn@telia.com>, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 02/10] [PATCH] Fix fs/exec.c:788 (de_thread()) BUG_ON
Content-Disposition: inline; filename=fix-de_thread-BUG_ON.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

It turns out that the BUG_ON() in fs/exec.c: de_thread() is unreliable
and can trigger due to the test itself being racy.

de_thread() does
 	while (atomic_read(&sig->count) > count) {
	}
	.....
	.....
	BUG_ON(!thread_group_empty(current));

but release_task does
	write_lock_irq(&tasklist_lock)
	__exit_signal
		(this is where atomic_dec(&sig->count) is run)
	__exit_sighand
	__unhash_process
		takes write lock on tasklist_lock
		remove itself out of PIDTYPE_TGID list
	write_unlock_irq(&tasklist_lock)

so there's a clear (although small) window between the
atomic_dec(&sig->count) and the actual PIDTYPE_TGID unhashing of the
thread.

And actually there is no need for all threads to have exited at this
point, so we simply kill the BUG_ON.

Big thanks to Marc Lehmann who provided the test-case.

Fixes Bug 5170 (http://bugme.osdl.org/show_bug.cgi?id=5170)

Signed-off-by: Alexander Nyberg <alexn@telia.com>
Cc: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>
Acked-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 fs/exec.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.13.y/fs/exec.c
===================================================================
--- linux-2.6.13.y.orig/fs/exec.c
+++ linux-2.6.13.y/fs/exec.c
@@ -745,8 +745,8 @@ static inline int de_thread(struct task_
         }
 
 	/*
-	 * Now there are really no other threads at all,
-	 * so it's safe to stop telling them to kill themselves.
+	 * There may be one thread left which is just exiting,
+	 * but it's safe to stop telling the group to kill themselves.
 	 */
 	sig->flags = 0;
 
@@ -785,7 +785,6 @@ no_thread_group:
 			kmem_cache_free(sighand_cachep, oldsighand);
 	}
 
-	BUG_ON(!thread_group_empty(current));
 	BUG_ON(!thread_group_leader(current));
 	return 0;
 }

--
