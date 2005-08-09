Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVHIUDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVHIUDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVHIUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:03:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:27319 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932504AbVHIUDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:03:44 -0400
Subject: Re: Signal handling possibly wrong
From: Steven Rostedt <rostedt@goodmis.org>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Robert Wilkens <robw@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <42F906EB.6060106@fujitsu-siemens.com>
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <1123612016.3167.3.camel@localhost.localdomain>
	 <42F8F6CC.7090709@fujitsu-siemens.com>
	 <1123612789.3167.9.camel@localhost.localdomain>
	 <42F8F98B.3080908@fujitsu-siemens.com>
	 <1123614253.3167.18.camel@localhost.localdomain>
	 <1123615983.18332.194.camel@localhost.localdomain>
	 <42F906EB.6060106@fujitsu-siemens.com>
Content-Type: multipart/mixed; boundary="=-1lipeiK/qt583t0aRJi0"
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 16:03:32 -0400
Message-Id: <1123617812.18332.199.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1lipeiK/qt583t0aRJi0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-08-09 at 21:41 +0200, Bodo Stroesser wrote:
> S
> > To me, the man pages make more sense, and I think the kernel is wrong.
> 
> Yes, that's what I think, too. If someone doesn't want additional signals
> to be masked, he can set sa_mask to be empty.
> OTOH, I have no idea, what POSIX specifies. Maybe kernel is right and man
> page is wrong?
> 
> 	Bodo
> > 

Man pages and kernel are right.  I just tested this out on 2.6.13-rc3
with the attached program and it seems to follow what is stated in the
man pages. So the assumption of what the code did by looking at it
proves to be the mistake. :-)

Conclusion:  sa_mask defers the signals. SA_NODEFER defers the sent
signal.

-- Steve


--=-1lipeiK/qt583t0aRJi0
Content-Disposition: attachment; filename=signal.c
Content-Type: text/x-csrc; name=signal.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>

void user1(int x)
{
	int pid = getpid();
	printf("pid[%d]: user1 start\n",pid);
	sleep(5);
	printf("pid[%d]: user1 stopped\n",pid);
}

void user2(int x)
{
	int pid = getpid();
	printf("pid[%d]:in user2\n",pid);
}

void intr(int x)
{
	int pid = getpid();
	printf("pid[%d]: received SIGINT\n",pid);
	exit(0);
}

void start1(void)
{
	struct sigaction act;

	memset(&act,0,sizeof(act));

	act.sa_handler = intr;
	if ((sigaction(SIGINT,&act,NULL)) < 0) {
		perror("child1: sigaction");
		exit(-1);
	}
		
	act.sa_handler = user1;
	sigaddset(&act.sa_mask,SIGUSR2);
	if ((sigaction(SIGUSR1,&act,NULL)) < 0) {
		perror("child1: sigaction");
		exit(-1);
	}

	act.sa_handler = user2;
	if ((sigaction(SIGUSR2,&act,NULL)) < 0) {
		perror("child1: sigaction");
		exit(-1);
	}
		
		
	for (;;)
		;

}

void start2(void)
{
	struct sigaction act;

	memset(&act,0,sizeof(act));
	
	act.sa_handler = intr;
	if ((sigaction(SIGINT,&act,NULL)) < 0) {
		perror("child2: sigaction");
		exit(-1);
	}
		
	act.sa_handler = user1;
	act.sa_flags |= SA_NODEFER;
	if ((sigaction(SIGUSR1,&act,NULL)) < 0) {
		perror("child2: sigaction");
		exit(-1);
	}
		
	act.sa_handler = user2;
	if ((sigaction(SIGUSR2,&act,NULL)) < 0) {
		perror("child1: sigaction");
		exit(-1);
	}
		
	for (;;)
		;

}

int main(int argc, char **argv)
{
	int pid[2];

	if ((pid[0] = fork()) < 0) {
		perror("fork");
	} else if (!pid[0]) {
		start1();
		exit(0);
	}
	
	if ((pid[1] = fork()) < 0) {
		perror("fork");
	} else if (!pid[1]) {
		start2();
		exit(0);
	}

	printf("parent sending %d SIGUSR1\n",pid[0]);
	kill(pid[0],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGUSR2\n",pid[0]);
	kill(pid[0],SIGUSR2);
	sleep(5);
	printf("parent sending %d SIGUSR1\n",pid[0]);
	kill(pid[0],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGUSR1\n",pid[0]);
	kill(pid[0],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGINT\n",pid[0]);
	kill(pid[0],SIGINT);

	printf("parent sending %d SIGUSR1\n",pid[1]);
	kill(pid[1],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGUSR2\n",pid[1]);
	kill(pid[1],SIGUSR2);
	sleep(5);
	printf("parent sending %d SIGUSR1\n",pid[1]);
	kill(pid[1],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGUSR1\n",pid[1]);
	kill(pid[1],SIGUSR1);
	sleep(1);
	printf("parent sending %d SIGINT\n",pid[1]);
	kill(pid[1],SIGINT);

	exit(0);
}

--=-1lipeiK/qt583t0aRJi0--

