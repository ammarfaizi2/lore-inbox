Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130007AbQK1VNc>; Tue, 28 Nov 2000 16:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130632AbQK1VNN>; Tue, 28 Nov 2000 16:13:13 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:7431 "HELO sith.mimuw.edu.pl")
        by vger.kernel.org with SMTP id <S130007AbQK1VMl>;
        Tue, 28 Nov 2000 16:12:41 -0500
Date: Tue, 28 Nov 2000 21:43:09 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] no RLIMIT_NPROC for root, please
Message-ID: <20001128214309.F2680@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-test11-pre6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why is RLIMIT_NPROC apllied to root(uid 0) processes? It's not kernel job to
prevent admin from shooting him/her self in the foot.

root should be able to do fork() regardless of any limits,
and IMHO the following patch is the right thing.


--- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
+++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
@@ -560,7 +560,8 @@
 	*p = *current;
 
 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
+	if (p->user->uid &&
+	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))
 		goto bad_fork_free;
 	atomic_inc(&p->user->__count);
 	atomic_inc(&p->user->processes);

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, type MANIAC         |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
