Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVLICOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVLICOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVLICOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:14:41 -0500
Received: from takamine.ncl.cs.columbia.edu ([128.59.18.70]:28629 "EHLO
	takamine.ncl.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1751220AbVLICOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:14:39 -0500
Date: Thu, 8 Dec 2005 21:16:42 -0500 (EST)
From: Oren Laadan <orenl@cs.columbia.edu>
X-X-Sender: orenl@takamine.ncl.cs.columbia.edu
To: trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fork: fix race in setting child's pgrp and tty
Message-ID: <Pine.LNX.4.63.0512082011140.7662@takamine.ncl.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fork: fix race in setting child's pgrp and tty

In fork, child should recopy parent's pgrp/tty after it has tasklist_lock.
Otherwise following a setpgid() on the parent, *after* copy_signal(), the
child will own a stale pgrp (which may be reused); (eg. if copy_mm() 
sleeps a long while due to memory pressure). Similar issue for the tty.

Signed-off-by: Oren Laadan <orenl@cs.columbia.edu>
---

diff --git a/kernel/fork.c b/kernel/fork.c
index fb8572a..059e71f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1055,6 +1055,15 @@ static task_t *copy_process(unsigned lon
  			!cpu_online(task_cpu(p))))
  		set_task_cpu(p, smp_processor_id());

+	/* 
+	 * signal->{prgp,tty} may have changed since we had copied them;
+	 * pgrp may have been freed -- and reused -- since then  [orenl]
+	 */
+	if (p->signal != current->signal) {
+		p->signal->tty = current->signal->tty;
+		p->signal->pgrp = process_group(current);
+	}
+
  	/*
  	 * Check for pending SIGKILL! The new thread should not be allowed
  	 * to slip out of an OOM kill. (or normal SIGKILL.)
