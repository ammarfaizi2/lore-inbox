Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbSKQSU1>; Sun, 17 Nov 2002 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSKQSU1>; Sun, 17 Nov 2002 13:20:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3077 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267543AbSKQSU0>; Sun, 17 Nov 2002 13:20:26 -0500
Date: Sun, 17 Nov 2002 10:27:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211172024470.11571-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211171023060.4425-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ingo Molnar wrote:
>
> there is no change anywhere due to NPTL. You can start and old glibc
> application from within a new glibc application and vice versa.

So then your explanation was extremely confused. Can you explain _where_ 
you're doing the ne wsystem call? If it is at execve() time in the parent, 
there is no way in hell I will accept it.

In fact, I have committed the following to my tree to make sure that there
is no user_tid pointer left over when we release a memory space, the old
code was buggy and left the user_tid alone over an execve() which meant
that a subsequent clone(CLONE_VM) and exit of the old process would have
corrupted memory.

Feel free to re-send the "set_user_tid()" patch assuming it is done from
crt0.S, and not from glibc execve() like your original explanation
claimed. Also, please send the set_user_tid() thing _separate_ from 
whatever else you did, since it has nothing to do with your other changes.

		Linus

----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.863   -> 1.864  
#	       kernel/fork.c	1.84    -> 1.85   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/17	torvalds@home.transmeta.com	1.864
# Make sure we clean user_tid when we've released the
# memory space it was associated with.
# --------------------------------------------
#
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Sun Nov 17 10:21:59 2002
+++ b/kernel/fork.c	Sun Nov 17 10:21:59 2002
@@ -408,12 +408,15 @@
 		complete(vfork_done);
 	}
 	if (tsk->user_tid) {
+		int * user_tid = tsk->user_tid;
+		tsk->user_tid = NULL;
+
 		/*
 		 * We dont check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
-		put_user(0, tsk->user_tid);
-		sys_futex((unsigned long)tsk->user_tid, FUTEX_WAKE, 1, NULL);
+		put_user(0, user_tid);
+		sys_futex((unsigned long)user_tid, FUTEX_WAKE, 1, NULL);
 	}
 }
 

