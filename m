Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWIGIaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWIGIaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIGIaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:30:05 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17360
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751111AbWIGIaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:30:03 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: readdir race fix (take 3)
Date: Thu, 7 Sep 2006 10:31:33 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <200609062312.57774.jdelvare@suse.de> <m1zmdcty4i.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmdcty4i.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lj9/ENxgP0zvx6j"
Message-Id: <200609071031.33855.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_lj9/ENxgP0zvx6j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 7 September 2006 00:43, Eric W. Biederman wrote:
> Have you tested 2.6.18-rc6 without my patch?

Yes I did, it didn't crash after a couple hours. Of course it doesn't 
prove anything as the crash appears to be the result of a race.

I'll now apply Oleg's fix and see if things get better.

> I guess the practical question is what was your test methodology to
> reproduce this problem?  A couple of more people running the same
> test on a few more machines might at least give us confidence in what
> is going on.

"My" test program forks 1000 children who sleep for 1 second then look for 
themselves in /proc, warn if they can't find themselves, and exit. So 
basically the idea is that the process list will shrink very rapidly at 
the same moment every child does readdir(/proc).

I attached the test program, I take no credit (nor shame) for it, it was 
provided to me by IBM (possibly on behalf of one of their own customers) 
as a way to demonstrate and reproduce the original readdir(/proc) race 
bug.

-- 
Jean Delvare

--Boundary-00=_lj9/ENxgP0zvx6j
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test.c"

#include <stdlib.h>
#include <stdio.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/param.h>
#include <utmp.h>
#include <pwd.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <syslog.h>
#include <errno.h>
#include <stdarg.h>
#include <ctype.h>

#define NUM_CHILDREN 1000

findme(i)
int i;
{
	DIR * dir = NULL;
	struct dirent *d;
	int pid;
	int mypid;

	mypid = getpid();


	if ((dir = opendir("/proc")) == (DIR *)0)
	{
		perror("failed to open /proc\n");
		exit(1);
	}

	while((d = readdir(dir)) != (struct dirent *)0) {
        	if ((pid = (pid_t)atoi(d->d_name)) == 0) continue;
		if (pid==mypid) return(1);
	}
	printf("\nfailed to find myself: pid %d, iteration %d\n",mypid,i);
	return(0);
}

fork_child(i)
int i;
{
    int pid;

    switch ((pid = fork())) {
    case 0:   /* child */
	sleep(1);
	findme(i);
	exit(0);
	;;
    case -1:  /* error */
	perror("failed to fork\n");
	exit(1);
	;;
    default:  /* parent */
	;;
   }
	
}


main()
{
	int i;
        (void)signal(SIGCHLD, SIG_IGN);


	for (i=0; i<NUM_CHILDREN; i++)
	{
		fork_child(i);
	}

}

--Boundary-00=_lj9/ENxgP0zvx6j--
