Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUJ2Rrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUJ2Rrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbUJ2Rrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:47:51 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:25073
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S263426AbUJ2RpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:45:14 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Chris Wright" <chrisw@osdl.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <roland@topspin.com>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
Date: Fri, 29 Oct 2004 13:44:38 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJEEMOFCAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041029100646.F14339@build.pdx.osdl.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chrt 25 bash

Shell remains as badly hung as everything else.  The code sets the SCHED_RR priority of the task and threads in tt1 to 10.  I'm left
thinking:  Shouldn't the system be scheduling the shell?  Is this a problem with priority inversion due to 2+ threads doing the
lock()/unlock() dance and never giving the bash a chance to run?  Is the system able to schedule signal and/or select wakeups (for
bash) in this condition?

Thanks, I wasn't aware of the chrt command and had only been using nice on my shell.  The man pages on all this stuff are rather
confusing:  Which priority numbers are valid, how priorities interact, negative vs. positive priorities, process vs. thread
priority, what is a "dynamic" vs. "static" priority, etc.

My impression after re-re-read reading the man pages was that it would be sufficient to have a non SCHED_RR shell with a high enough
nice value.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Chris Wright
Sent: Friday, October 29, 2004 1:07 PM
To: Andrew A.
Cc: Alan Cox; Linux Kernel Mailing List; roland@topspin.com; Andrew
Morton
Subject: Re: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)


* Andrew A. (aathan-linux-kernel-1542@cloakmail.com) wrote:
> I suspect what is happening here is that my process is essentially in a
>
> while(1)
> {
>   lock();
>   unlock();
> }
>
> loop from two or mode SCHED_RR threads running at nice -15.  They seem to be unkillable.

Give yourself a shell that's SCHED_RR with a higher priority.  I've used
the small hack below to debug userspace SCHED_RR problems (newer distros
have a chrt utility to do this).

thanks,
-chris
--

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sched.h>
#include <string.h>
#include <errno.h>

main(int argc, char *argv[])
{
	pid_t pid = 0;
	int priority = 99;
	int policy = SCHED_RR;
	struct sched_param sched;

	if (argc > 1) {
		pid = atoi(argv[1]);
		if (argc > 2) {
			priority = atoi(argv[2]);
			if (argc > 3)
				policy = atoi(argv[3]);
		}
	}

	memset(&sched, 0, sizeof(sched));
	sched.sched_priority = priority;
	if (sched_setscheduler(pid, policy, &sched) < 0) {
		printf("setscheduler: %s\n", strerror(errno));
		exit(1);
	}

	if (!pid) { /* turn this into a shell */
		argv[0] = "/bin/bash";
		argv[1] = NULL;
		execv(argv[0], argv);
	}

}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



