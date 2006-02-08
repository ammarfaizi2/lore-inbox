Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWBHQK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWBHQK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWBHQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:10:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59548 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161076AbWBHQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:10:58 -0500
To: Andrew Morton <akpm@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fork:  Allow init to become a session leader.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 09:10:08 -0700
Message-ID: <m1acd196hr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the bug fixes from killing session == 0 and pgrp == 0 we
have essentially made pid == 1 a session leader.  However reading
through the code I can see nothing, that sets the session->leader
flag.  In fact we actively clear it in all cases during clone.
And setsid will fail to set it because the session == 1 and
process group == 1 already exist.

So this patch forces the session leader flag and for good measure
the pgrp, session and tty of init as well.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/fork.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

6bc9fa2aca38bf739e20ae6192a068310ff9739a
diff --git a/kernel/fork.c b/kernel/fork.c
index a08e5cf..ff10b11 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1179,9 +1179,16 @@ static task_t *copy_process(unsigned lon
 		attach_pid(p, PIDTYPE_PID, p->pid);
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
 		if (thread_group_leader(p)) {
-			p->signal->tty = current->signal->tty;
-			p->signal->pgrp = process_group(current);
-			p->signal->session = current->signal->session;
+			if (unlikely(p->pid == 1)) {
+				p->signal->tty = NULL;
+				p->signal->leader = 1;
+				p->signal->pgrp = 1;
+				p->signal->session = 1;
+			} else {
+				p->signal->tty = current->signal->tty;
+				p->signal->pgrp = process_group(current);
+				p->signal->session = current->signal->session;
+			}
 			attach_pid(p, PIDTYPE_PGID, process_group(p));
 			attach_pid(p, PIDTYPE_SID, p->signal->session);
 			__get_cpu_var(process_counts)++;
-- 
1.1.5.g3480

