Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293718AbSCESzN>; Tue, 5 Mar 2002 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSCESzC>; Tue, 5 Mar 2002 13:55:02 -0500
Received: from 216-42-72-143.ppp.netsville.net ([216.42.72.143]:21678 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293718AbSCESyo>; Tue, 5 Mar 2002 13:54:44 -0500
Date: Tue, 05 Mar 2002 13:54:20 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br
Subject: [PATCH] proc race on task_struct->sig
Message-ID: <359000000.1015354460@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

I think collect_sigign_sigcatch can race against exit_sighand.
I haven't been able to reproduce it, but I think it causes
the oops reported in the 'Kernel Hangs 2.4.16 on heavy io Oracle
Tivolie TSM' thread.

This patch should fix it:

-chris

--- test.1/fs/proc/array.c Wed, 27 Feb 2002 11:54:30 -0500
+++ test.1(w)/fs/proc/array.c Tue, 05 Mar 2002 11:16:44 -0500
@@ -226,6 +226,7 @@
 	sigemptyset(ign);
 	sigemptyset(catch);
 
+	spin_lock_irq(&p->sigmask_lock);
 	if (p->sig) {
 		k = p->sig->action;
 		for (i = 1; i <= _NSIG; ++i, ++k) {
@@ -235,6 +236,7 @@
 				sigaddset(catch, i);
 		}
 	}
+	spin_unlock_irq(&p->sigmask_lock);
 }
 
 static inline char * task_sig(struct task_struct *p, char *buffer)

