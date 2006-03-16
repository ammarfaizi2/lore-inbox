Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752440AbWCPRkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbWCPRkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbWCPRkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:40:41 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:1180 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1752440AbWCPRkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:40:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Janak Desai <janak@us.ibm.com>, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, Michael Kerrisk <mtk-manpages@gmx.net>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Mar 2006 10:31:38 -0700
In-Reply-To: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Thu, 16 Mar 2006 09:49:08 -0700")
Message-ID: <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sighand pointer only needs the rcu_read_lock on the
read side.  So only depending on task_lock protection
when setting this pointer is not enough.  We also need
a memory barrier to ensure the initialization is seen first.

Use rcu_assign_pointer as it does this for us, and clearly
documents that we are setting an rcu readable pointer.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/fork.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f0cdb649b7140927777f4355631648b396ee235b
diff --git a/kernel/fork.c b/kernel/fork.c
index d2706e9..2f24553 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1573,7 +1573,7 @@ asmlinkage long sys_unshare(unsigned lon
 
 		if (new_sigh) {
 			sigh = current->sighand;
-			current->sighand = new_sigh;
+			rcu_assign_pointer(current->sighand, new_sigh);
 			new_sigh = sigh;
 		}
 
-- 
1.2.4.g2d33

