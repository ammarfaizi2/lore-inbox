Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUKWViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUKWViT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKWRoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:44:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:4496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbUKWRFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:05:54 -0500
Date: Tue, 23 Nov 2004 09:04:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: torvalds@osdl.org, michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2.6.10-rc2] RLIMIT_MEMLOCK accounting of shmctl()
 SHM_LOCK is broken
Message-Id: <20041123090449.1672494f.akpm@osdl.org>
In-Reply-To: <5143.1101227817@www28.gmx.net>
References: <5143.1101227817@www28.gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk" <mtk-lkml@gmx.net> wrote:
>
> The accounting of shmctl() SHM_LOCK memory locks against the
>  user structure is broken.  The problem is that the check
>  of the size of the to-be-locked region is based on 
>  the size of the segment as specified when it was created
>  by shmget() (this size is *not* rounded up to a page 
>  boundary).  This size is then rounded down (>> PAGE_SHIFT)
>  to PAGE_SIZE during the check in 
>  mm/mlock.c::user_shm_lock().

True.  We should make the same change to user_shm_unlock(), and we may as
well tweak the excessive spinlock coverage in there too.

--- 25/mm/mlock.c~rlimit_memlock-accounting-of-shmctl-shm_lock-is-broken	2004-11-23 08:58:13.299089928 -0800
+++ 25-akpm/mm/mlock.c	2004-11-23 09:01:31.500958664 -0800
@@ -211,10 +211,10 @@ int user_shm_lock(size_t size, struct us
 	unsigned long lock_limit, locked;
 	int allowed = 0;
 
-	spin_lock(&shmlock_user_lock);
-	locked = size >> PAGE_SHIFT;
+	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
+	spin_lock(&shmlock_user_lock);
 	if (locked + user->locked_shm > lock_limit && !capable(CAP_IPC_LOCK))
 		goto out;
 	get_uid(user);
@@ -228,7 +228,7 @@ out:
 void user_shm_unlock(size_t size, struct user_struct *user)
 {
 	spin_lock(&shmlock_user_lock);
-	user->locked_shm -= (size >> PAGE_SHIFT);
+	user->locked_shm -= (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
 	spin_unlock(&shmlock_user_lock);
 	free_uid(user);
 }
_

and then ask Hugh and Manfred to double-check.

Looking at the callers, we do:

	user_shm_lock(inode->i_size, ...);

then, later:

	user_shm_unlock(inode->i_size, ...);

which does make one wonder "what happens if the file got larger while it
was locked"?

