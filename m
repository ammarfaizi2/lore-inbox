Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbSKQLRR>; Sun, 17 Nov 2002 06:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbSKQLRR>; Sun, 17 Nov 2002 06:17:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:27282 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267489AbSKQLRP>;
	Sun, 17 Nov 2002 06:17:15 -0500
Date: Sun, 17 Nov 2002 13:40:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Luca Barbieri <ldb@ldb.ods.org>
Subject: [patch] threading fix, tid-2.5.47-A3
Message-ID: <Pine.LNX.4.44.0211171314200.7001-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) implements another threading related
detail, it changes the way TID setting/clearing works. These changes fix a
weakness of NPTL's handling of the "initial thread", noticed by Luca
Barbieri.

the problem is the following: the 'initial thread', ie. the 'process',
does not have any ->user_tid value set. But still it's a generic thread
that can be pthread_join()-ed upon. (but pthread_join() does not work, the
kernel does not do the futex wakeup because ->user_tid is NULL.)

the solution is to add a new syscall that sets the current->user_tid
address. This new syscall is used by glibc's exec() implementation.  
Another change is to make CLONE_SETTID work even if CLONE_VM is not used.
This means that the TID must be set in the child's address space, not in
the parent's address space. I've also merged SETTID and CLEARTID, the two
should always be used together by any new-style threading abstraction.

the sys_set_tid_address() syscall returns the current TID, which is used
by glibc to set the TID address in the parent's context. (this is cheaper
than to do a put_user() in kernel-space.)

to implement the above semantics i've used the schedule_tail() callback to
do the TID setting in the child's context - doing it a'la
ptrace_writedata() / access_process_vm() would be way too expensive. It
looks a bit ugly to do the TID setting both in schedule_tail() and
do_fork(), and to do the CLONE_VM check, but the correct (and generic)  
solution

In future glibc versions every process and thread will have a nonzero
user_tid address, so the callback is necessary.

Ulrich Drepper has changed glibc/NPTL to use these new semantics and the
initial thread now works fine. Also, i've compressed the CLONE flags to
remove the CLONE_CLEARTID hole, since NPTL is the only one using them
currently.

(the patch has no effect on old-style threading libraries.)

	Ingo

