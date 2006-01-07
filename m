Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752495AbWAGCK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbWAGCK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbWAGCK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:10:26 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:59088 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752492AbWAGCKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:10:25 -0500
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
	(realtime-preempt)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nedko Arnaudov <nedko@arnaudov.name>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1136595936.12468.168.camel@localhost.localdomain>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	 <20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	 <87u0cj5riq.fsf_-_@arnaudov.name>
	 <1136436273.12468.113.camel@localhost.localdomain>
	 <87u0cj3saf.fsf@arnaudov.name>
	 <1136463552.12468.119.camel@localhost.localdomain>
	 <87k6deg2z6.fsf@arnaudov.name>
	 <Pine.LNX.4.58.0601050936340.10361@gandalf.stny.rr.com>
	 <874q4ig0zj.fsf@arnaudov.name>
	 <1136595936.12468.168.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-YRmFFph3A7obXZsrtEBK"
Date: Fri, 06 Jan 2006 21:10:18 -0500
Message-Id: <1136599818.12468.172.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YRmFFph3A7obXZsrtEBK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-01-06 at 20:05 -0500, Steven Rostedt wrote:
> On Thu, 2006-01-05 at 17:15 +0200, Nedko Arnaudov wrote:
> > Will try to crash SMP ASAP, I'm not able to do tests now.
> > 
> > I do erase/burn of 210 MiB rw disk. Erase is done without crash.
> > I use version 2.01.01a03 of cdrecord.
> > It crashes when burning:
> > 
> > http://nedko.arnaudov.name/tmp/rt-cdrecord-crash.jpg
> > 
> > Same crash occurs when I run oss2jack with -d option.
> > It does not occur when running without -d option (daemonize).
> > 
> 
> Nedko,
> 
> Could you try either the patch below, or the link
> http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt2-sr2
> which has the patch included, to see if this fixes your problem.

OK, I think this is it.  Without the patch, the attached program crashes
the system. With the patch, it runs fine. I believe that cdrecord and
friends were forking processes with RT priorities. Which would crash the
system.

-- Steve


--=-YRmFFph3A7obXZsrtEBK
Content-Disposition: attachment; filename=forkme.c
Content-Type: text/x-csrc; name=forkme.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>

int main(int argc, char **argv)
{
	int pid;
	struct sched_param sp = { .sched_priority = 5 };

	sched_setscheduler(getpid(), SCHED_FIFO, &sp);

	if ((pid = fork()) < 0) {
		perror("fork");
		exit(0);
	} else if (!pid) {
		printf("child!\n");
		exit(0);
	}

	printf("parent\n");
	exit(0);
}
			

--=-YRmFFph3A7obXZsrtEBK--

