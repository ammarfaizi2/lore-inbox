Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267219AbUHDD1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267219AbUHDD1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUHDD1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 23:27:51 -0400
Received: from gau.lava.net ([64.65.64.28]:58612 "EHLO gau.lava.net")
	by vger.kernel.org with ESMTP id S267219AbUHDD1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 23:27:46 -0400
Date: Tue, 3 Aug 2004 17:27:43 -1000 (HST)
From: Tim Newsham <newsham@lava.net>
To: linux-kernel@vger.kernel.org
Subject: ptrace EPERM as root?
Message-ID: <Pine.BSI.4.58.0408031721400.13369@malasada.lava.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing unexpected behavior in gdb when I trace over code
that does a setresgid().  A small test case illustrates this:

  int
  main()
  {
    if(setresgid(-1, 0x63, -1) == -1) {
        perror("setresgid");
        return 1;
    }
    printf("done\n");
    return 0;
  }

If I single step this as root in redhat9 it reports that it
cannot get the registers (operation not permitted) after I step
the setresgid call.  This also happens on another linux machine
I have, but not in redhat7:

    redhat9 - 2.4.20-8smp        error
    redhat7.1 - 2.4.20-20.7      no error
    ??? - 2.4.18                 error

I went a step further and wrote a program that just steps the
program with ptrace and records the PC.  It returns EPERM right
after coming back from the setresgid system call  (The traceing
program is included below).

Why does this fail on systems and not on others?  Why would root
ever not be able to debug a process (even if it is changing its
ids)?

(please CC me on replies)
Tim N.



----- tracing program ----

#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <linux/user.h>

static long
xptrace(int req, pid_t pid, void *addr, void *data)
{
    long x = ptrace(req, pid, addr, data);
    if(x == -1) {
	perror("ptrace");
	exit(1);
    }
    return x;
}

static pid_t
runprog(char **argv)
{
    pid_t pid = fork();

    if(pid == 0) {
	xptrace(PTRACE_TRACEME, 0, 0, 0);
	execv(argv[0], argv);
	perror("execv");
	exit(1);
    }
    return pid;
}

int
main(int argc, char **argv)
{
    struct user_regs_struct r;
    long  off, minoff, loff, cnt, mincnt;
    int stat;
    pid_t pid;

    if(argc < 2) {
	 fprintf(stderr, "usage: %s prog [args]\n", argv[0]);
	 exit(1);
    }
    pid = runprog(argv + 1);
    minoff = -1;
    loff = 0;
    cnt = 0;
    for(;;) {
	if(pid != wait(&stat))
	    break;

	xptrace(PTRACE_GETREGS, pid, 0, &r);
	off = r.eip;

	if(minoff == -1 || (off < loff || off > (loff+8))) {
	    if(minoff != -1)
	        fprintf(stderr, "%08lx - %08lx    %ld\n",
		        minoff, loff, mincnt);
	    minoff = off;
	    mincnt = cnt;
	}
	loff = off;
	cnt++;

	xptrace(PTRACE_SINGLESTEP, pid, 0, 0);
    }
    return 0;
}



