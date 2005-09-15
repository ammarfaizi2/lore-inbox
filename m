Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVIOHgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVIOHgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVIOHgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:36:45 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:24273 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1030447AbVIOHgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:36:44 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Thu, 15 Sep 2005 09:36:40 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 00/11] -stable review
Message-ID: <20050915073640.GA2056@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915010343.577985000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 06:03:43PM -0700 Chris Wright wrote:

> This is the start of the stable review cycle for the 2.6.13.2 release.
> There are 11 patches in this series, all will be posted as a response to
> this one.  If anyone has any issues with these being applied, please let
> us know.  If anyone is a maintainer of the proper subsystem, and wants
> to add a signed-off-by: line to the patch, please respond with it.
> 
> These patches are sent out with a number of different people on the
> Cc: line.  If you wish to be a reviewer, please email stable@kernel.org
> to add your name to the list.  If you want to be off the reviewer list,
> also email us.
> 

This might be worth putting in too (has been hit by at least two people
in the real world etc.)

tree e3a704026e65bf6fea0c7747f0fb75a506f54127
parent 32a3658533c6f4c6bf370dd730213e802464ef9b
author Alexander Nyberg <alexn@telia.com> Wed, 14 Sep 2005 18:54:06 +0200
committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 15 Sep 2005 00:26:34 -0700

[PATCH] Fix fs/exec.c:788 (de_thread()) BUG_ON

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

 fs/exec.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c
+++ b/fs/exec.c
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
