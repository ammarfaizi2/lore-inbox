Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUDIJMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUDIJMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 05:12:52 -0400
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:51112 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S261160AbUDIJMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 05:12:49 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
Date: Fri, 9 Apr 2004 13:11:50 +0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404091311.50787@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1BBs3E-0000el-00*mUAEXQt6.FA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Several days ago I've posted to linux-kernel describing "zombie problem" 
related to sigqueue overflow.

Futher exploration of the problem showed that the reason of the described 
behaviour is in user-space. There is a process that blocks a signal and 
later receives tons of such signals. This effectively causes sigqueue 
overflow.

The following program gives the same effect:

#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
        sigset_t set;
        int i;
        pid_t pid;

        sigemptyset(&set);
        sigaddset(&set, 40);
        sigprocmask(SIG_BLOCK, &set, 0);

        pid = getpid();
        for (i = 0; i < 1024; i++)
                kill(pid, 40);

        while (1)
                sleep(1);
}

Running this program on 2.4 or 2.6 kernel with 
default /proc/sys/kernel/rtsig-max value will cause sigqueue overflow, and 
all linuxthreads-based programs, INCLUDING DAEMONS RUNNING AS ROOT, will 
stop receiving notifications about thread exits, so all completed threads 
will become zombies. Exact reason why this is hapenning is described in 
detail in my previous postings.

This is a local DoS.

Affected system services include (but are not limited to) mysql and clamav. 
In fact, any linuxthreads application will be affected.

The problem is not that bad on 2.6, since NPTL is used instead of 
linuxthreads, so there are no zombies from system daemons. However, bad 
things still happen: when sigqueue is overflown, all processes get zeroed 
siginfo, which causes random application misbehaviours (like hangs in 
pthread_cancel()).

I don't know what is the correct solution for this issue. Probably there 
should be per-process or per-user (but not systemwide) limits on number of 
pending signals.

