Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSHPCiB>; Thu, 15 Aug 2002 22:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSHPCiB>; Thu, 15 Aug 2002 22:38:01 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:64224 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317434AbSHPCh7>; Thu, 15 Aug 2002 22:37:59 -0400
Date: Thu, 15 Aug 2002 23:38:02 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [patch] complain about unknown CLONE_* flags
Message-ID: <20020815233802.A30018@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0208130916280.7291-100000@home.transmeta.com> <Pine.LNX.4.44.0208132025530.6752-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208132025530.6752-100000@localhost.localdomain>; from mingo@elte.hu on Tue, Aug 13, 2002 at 08:32:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About new clone() flags...

One of the obvious things for a thread library is to:

    (a) try clone() with lots of snazzy flags
    (b) if that returns -EINVAL, we must be running on an older kernel;
        try with fewer flags and more workarounds

However, I don't see any code in sys_clone() that rejects a call that
specifies unknown flags.  So, code that uses e.g. CLONE_SETTID will
appear to run perfectly well on an old kernel... except that it will
behave incorrectly.

That leads to having to write some silly test for each feature prior to
using it, instead of trying it and falling back.  E.g. I'd need to
do the silly signal-blocking workaround when creating the second thread
in a program, just to find out whether CLONE_SETTID actually worked.
Either that, or check the kernel version.

Ingo, how do you handle this sort of backward compatibility in your
latest pthreads library, or don't you do backward compatibility?

For future-proofing, here's a patch:

diff -u linux-2.5/kernel/fork.c.orig linux-2.5/kernel/fork.c
--- linux-2.5/kernel/fork.c
+++ linux-2.5/kernel/fork.c	Thu Aug 15 23:35:00 2002
@@ -619,6 +619,11 @@
 	struct task_struct *p = NULL;
 	struct completion vfork;
 
+	if ((clone_flags & ~(0UL|CSIGNAL|CLONE_VM|CLONE_FS|CLONE_FILES
+			     |CLONE_SIGHAND|CLONE_PID|CLONE_PTRACE|CLONE_VFORK
+			     |CLONE_PARENT|CLONE_THREAD)))
+		return ERR_PTR (-EINVAL);
+
 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
