Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWIJEMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWIJEMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWIJEMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:12:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8415 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965226AbWIJEMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:12:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] file: Add locking to f_getown
Date: Sat, 09 Sep 2006 22:11:18 -0600
Message-ID: <m1r6ykfjix.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has been needed for a long time, but now with the advent
of a reference counted struct pid there are real consequences
for getting this wrong.  

Someone I think it was Oleg Nesterov pointed out that this construct
was missing locking, when I introduced struct pid.  After taking time
to review the locking construct already present I figured out which
lock needs to be taken.  The other paths that access f_owner.pid
take either the f_owner read or the write lock.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/fcntl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 821ebb9..b1dd4d4 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -305,9 +305,11 @@ void f_delown(struct file *filp)
 pid_t f_getown(struct file *filp)
 {
 	pid_t pid;
+	read_lock(&filp->f_owner.lock);
 	pid = pid_nr(filp->f_owner.pid);
 	if (filp->f_owner.pid_type == PIDTYPE_PGID)
 		pid = -pid;
+	read_unlock(&filp->f_owner.lock);
 	return pid;
 }
 
-- 
1.4.2.rc3.g7e18e-dirty

