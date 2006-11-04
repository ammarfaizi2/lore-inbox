Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965582AbWKDSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582AbWKDSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbWKDSKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:10:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965582AbWKDSKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:10:07 -0500
Date: Sat, 4 Nov 2006 10:09:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Oops on 2.6.18
In-Reply-To: <Pine.LNX.4.64.0610311923100.28672@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.64.0611041006250.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610311923100.28672@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2006, Lukasz Trabinski wrote:
> 
> oceanic:~$ uname -a
> Linux oceanic.wsisiz.edu.pl 2.6.18-oceanic #1 SMP Thu Sep 28 22:26:52 CEST
> 2006 x86_64 x86_64 x86_64 GNU/Linux
> 
> filesystem with ext3/quota/acl
> 
> Oct 31 13:30:09 oceanic kernel: Unable to handle kernel paging request at 0000000000100108

Ok, this should be fixed with the commit I just checked in and pushed 
out.. That said, I don't think you'd be likely to ever be able to 
reproduce it - it looks like a very unlikely race. I think the race 
condition has been there for a long time, and googling doesn't actually 
show anybody else seemingly having ever triggered it.

But in case you care, this is what I committed.

		Linus

---
commit 45c18b0bb579b5c1b89f8c99f1b6ffa4c586ba08
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Sat Nov 4 10:06:02 2006 -0800

    Fix unlikely (but possible) race condition on task->user access
    
    There's a possible race condition when doing a "switch_uid()" from one
    user to another, which could race with another thread doing a signal
    allocation and looking at the old thread ->user pointer as it is freed.
    
    This explains an oops reported by Lukasz Trabinski:
    	http://permalink.gmane.org/gmane.linux.kernel/462241
    
    We fix this by delaying the (reference-counted) freeing of the user
    structure until the thread signal handler lock has been released, so
    that we know that the signal allocation has either seen the new value or
    has properly incremented the reference count of the old one.
    
    Race identified by Oleg Nesterov.
    
    Cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
    Cc: Oleg Nesterov <oleg@tv-sign.ru>
    Cc: Andrew Morton <akpm@osdl.org>
    Cc: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/kernel/user.c b/kernel/user.c
index 6408c04..220e586 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -187,6 +187,17 @@ void switch_uid(struct user_struct *new_
 	atomic_dec(&old_user->processes);
 	switch_uid_keyring(new_user);
 	current->user = new_user;
+
+	/*
+	 * We need to synchronize with __sigqueue_alloc()
+	 * doing a get_uid(p->user).. If that saw the old
+	 * user value, we need to wait until it has exited
+	 * its critical region before we can free the old
+	 * structure.
+	 */
+	smp_mb();
+	spin_unlock_wait(&current->sighand->siglock);
+
 	free_uid(old_user);
 	suid_keys(current);
 }
