Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263293AbUJ2RMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbUJ2RMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263446AbUJ2RJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:09:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:7899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263429AbUJ2RGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:06:53 -0400
Date: Fri, 29 Oct 2004 10:06:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       roland@topspin.com, Andrew Morton <akpm@osdl.org>
Subject: Re: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
Message-ID: <20041029100646.F14339@build.pdx.osdl.net>
References: <1099062404.13098.59.camel@localhost.localdomain> <OMEGLKPBDPDHAGCIBHHJGEMIFCAA.aathan-linux-kernel-1542@cloakmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJGEMIFCAA.aathan-linux-kernel-1542@cloakmail.com>; from aathan-linux-kernel-1542@cloakmail.com on Fri, Oct 29, 2004 at 12:43:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
