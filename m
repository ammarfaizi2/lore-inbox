Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266361AbRGBD6Y>; Sun, 1 Jul 2001 23:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266362AbRGBD6O>; Sun, 1 Jul 2001 23:58:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:29457 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266361AbRGBD6D>;
	Sun, 1 Jul 2001 23:58:03 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15167.61332.139916.158874@cargo.ozlabs.ibm.com>
Date: Mon, 2 Jul 2001 13:50:44 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: hang from HUP'ing init in linuxrc
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I tried running the Debian installer on top of a 2.4.6-pre6
kernel.  It got up to the point of installing libc and then the system
hung.  It was still taking interrupts (I could change vt's, etc.) but
no user processes were running.

What was happening was rather interesting.  The init process was stuck
inside prepare_namespace(), in the while loop here (this is lines 749
- 751 of init/main.c):

		pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
		if (pid>0)
			while (pid != wait(&i));

The installer had sent a HUP signal to init.  The init process thus
had current->sigpending == 1.  When it called wait, it got down into
sys_wait4 which worked out that there were children but none were
zombies, and at that point it would normally sleep, but because there
were signals pending, it returned -ERESTARTSYS.  Now, on the way out
from the system call, the kernel noticed that it was returning to
kernel mode and thus didn't deliver any signals, and sigpending stayed
at 1.

Thus the system was sitting in a tight loop calling wait() over and
over again in kernel mode in the init process.

This was on PPC.  I had a look at the i386 code and AFAICS it will do
the same thing.  The check for whether we are returning to user mode
is in do_signal there (whereas PPC does the check in entry.S) but the
net effect in both cases is that we don't execute the main body of
do_signal when we are returning from a syscall from a process running
in kernel mode.

I'm not sure what the best way to fix this is.  The problem would crop
up whenever we have a kernel thread which wants to wait for a child
process.  I don't think we want to start delivering signals to kernel
threads in the same way that we do to usermode processes though.

Any suggestions?

Paul.
