Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUDMNJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUDMNJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:09:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30439 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263413AbUDMNJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:09:06 -0400
Date: Tue, 13 Apr 2004 10:10:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
Message-ID: <20040413131017.GA11294@logos.cnet>
References: <200404091311.50787@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404091311.50787@zigzag.lvk.cs.msu.su>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 01:11:50PM +0400, Nikita V. Youshchenko wrote:
> Hello.
> 
> Several days ago I've posted to linux-kernel describing "zombie problem" 
> related to sigqueue overflow.
> 
> Futher exploration of the problem showed that the reason of the described 
> behaviour is in user-space. There is a process that blocks a signal and 
> later receives tons of such signals. This effectively causes sigqueue 
> overflow.
> 
> The following program gives the same effect:
> 
> #include <signal.h>
> #include <unistd.h>
> #include <stdlib.h>
> 
> int main()
> {
>         sigset_t set;
>         int i;
>         pid_t pid;
> 
>         sigemptyset(&set);
>         sigaddset(&set, 40);
>         sigprocmask(SIG_BLOCK, &set, 0);
> 
>         pid = getpid();
>         for (i = 0; i < 1024; i++)
>                 kill(pid, 40);
> 
>         while (1)
>                 sleep(1);
> }
> 
> Running this program on 2.4 or 2.6 kernel with 
> default /proc/sys/kernel/rtsig-max value will cause sigqueue overflow, and 
> all linuxthreads-based programs, INCLUDING DAEMONS RUNNING AS ROOT, will 
> stop receiving notifications about thread exits, so all completed threads 
> will become zombies. Exact reason why this is hapenning is described in 
> detail in my previous postings.
> 
> This is a local DoS.
> 
> Affected system services include (but are not limited to) mysql and clamav. 
> In fact, any linuxthreads application will be affected.
> 
> The problem is not that bad on 2.6, since NPTL is used instead of 
> linuxthreads, so there are no zombies from system daemons. However, bad 
> things still happen: when sigqueue is overflown, all processes get zeroed 
> siginfo, which causes random application misbehaviours (like hangs in 
> pthread_cancel()).
> 
> I don't know what is the correct solution for this issue. Probably there 
> should be per-process or per-user (but not systemwide) limits on number of 
> pending signals.

Indeed, per-user sigqueue limit is the way to fix this.

Anyone willing to implement it ? 

