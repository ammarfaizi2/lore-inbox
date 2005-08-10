Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVHJDdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVHJDdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 23:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVHJDdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 23:33:52 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12275 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964934AbVHJDdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 23:33:52 -0400
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
	sa_mask
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Robert Wilkens <robw@optonline.net>, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Andrew Morton <akpm@osdl.org>, gdt@linuxppc.org,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <1123643401.9553.32.camel@localhost.localdomain>
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <1123612016.3167.3.camel@localhost.localdomain>
	 <42F8F6CC.7090709@fujitsu-siemens.com>
	 <1123612789.3167.9.camel@localhost.localdomain>
	 <42F8F98B.3080908@fujitsu-siemens.com>
	 <1123614253.3167.18.camel@localhost.localdomain>
	 <1123615983.18332.194.camel@localhost.localdomain>
	 <42F906EB.6060106@fujitsu-siemens.com>
	 <1123617812.18332.199.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
	 <1123621223.9553.4.camel@localhost.localdomain>
	 <1123621637.9553.7.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	 <1123643401.9553.32.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-Ri5uuzF7eX9BGkSsL5Sj"
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 23:33:35 -0400
Message-Id: <1123644815.9553.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ri5uuzF7eX9BGkSsL5Sj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-08-09 at 23:10 -0400, Steven Rostedt wrote:
>         memset(&act,0,sizeof(act));
>         sigaddset(&act.sa_mask,SIGUSR1);
>         ret = testsig(&act,SIGUSR1,SIGUSR1);
>         if (ret == 1) {
>                 printf("sa_mask does not block sig\n");
>         } else if (ret == 0) {
>                 printf("sa_mask blocks sig\n");
>         } else {
>                 printf("Unknown return code!!\n");
>         }
> 
>         exit(0);
>         exit(0);

Yuck! OK I was into the cut and paste here. This probably would look
much better as 

ret = testsig(&act,SIGUSR1,SIGUSR1);
switch (ret) {
case 0:
	printf("...");
	break;
case 1:
	printf("...");
	break;
default:
	printf("Unknown...");
}

And what was I doing with the double exits??

OK, time for bed.

-- Steve


--=-Ri5uuzF7eX9BGkSsL5Sj
Content-Disposition: attachment; filename=test_signal.c
Content-Type: text/x-csrc; name=test_signal.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static int u1;
static int u2;

static void user1(int x)
{
	/* for testing against itself */
	if (u1)
		u2 = 1;
	u1 = 1;
	sleep(5);
	u1 = 0;
}

static void user2(int x)
{
	if (u1)
		u2 = 1;
}

static void intr(int x)
{
	exit(u2);
}

static void start(struct sigaction *act)
{
	struct sigaction a;

	memset(&a,0,sizeof(a));

	a.sa_handler = intr;
	if ((sigaction(SIGINT,&a,NULL)) < 0) {
		perror("sigaction");
		exit(-1);
	}
	
	/*
	 * This is the testing handler
	 */
	act->sa_handler = user1;
	if ((sigaction(SIGUSR1,act,NULL)) < 0) {
		perror("sigaction");
		exit(-1);
	}

	a.sa_handler = user2;
	if ((sigaction(SIGUSR2,&a,NULL)) < 0) {
		perror("sigaction");
		exit(-1);
	}
		
		
	for (;;)
		;

}
int testsig(struct sigaction *act, int sig1, int sig2)
{
	int pid;
	int status;

	if ((pid = fork()) < 0) {
		perror("fork");
	} else if (!pid) {
		/*
		 * Test1 sa_mask includes SIGUSR2
		 */
		start(act);
		exit(0);
	}
	/*
	 * Send first signal to start the test.
	 */
	kill(pid,sig1);
	/*
	 * SIGUSR1 sleeps for 5, just sleep for on here
	 * to make sure the system got it.
	 */
	sleep(1);
	/*
	 * Send the second signal to the child, to see if 
	 * this wakes it up.
	 */
	kill(pid,sig2);
	sleep(1);
	/*
	 * End the test.
	 */
	kill(pid,SIGINT);
	waitpid(pid,&status,0);
	return WEXITSTATUS(status);
}

int main(int argc, char **argv)
{
	struct sigaction act;
	int ret;
	
	memset(&act,0,sizeof(act));
	sigaddset(&act.sa_mask,SIGUSR2);
	ret = testsig(&act,SIGUSR1,SIGUSR2);
	switch (ret) {
		case 0:
			printf("sa_mask blocks other signals\n");
			break;
		case 1:
			printf("sa_mask does not block other signals\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	ret = testsig(&act,SIGUSR1,SIGUSR2);
	switch (ret) {
		case 0:
			printf("SA_NODEFER blocks other signals\n");
			break;
		case 1:
			printf("SA_NODEFER does not block other signals\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	sigaddset(&act.sa_mask,SIGUSR2);
	ret = testsig(&act,SIGUSR1,SIGUSR2);
	switch (ret) {
		case 0:
			printf("SA_NODEFER does not affect sa_mask\n");
			break;
		case 1:
			printf("SA_NODEFER affects sa_mask\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	sigaddset(&act.sa_mask,SIGUSR1);
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	switch (ret) {
		case 0:
			printf("SA_NODEFER and sa_mask blocks sig\n");
			break;
		case 1:
			printf("SA_NODEFER and sa_mask does not block sig\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	switch (ret) {
		case 0:
			printf("!SA_NODEFER blocks sig\n");
			break;
		case 1:
			printf("!SA_NODEFER does not block sig\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	switch (ret) {
		case 0:
			printf("SA_NODEFER blocks sig\n");
			break;
		case 1:
			printf("SA_NODEFER does not block sig\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	sigaddset(&act.sa_mask,SIGUSR1);
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	switch (ret) {
		case 0:
			printf("sa_mask blocks sig\n");
			break;
		case 1:
			printf("sa_mask does not block sig\n");
			break;
		default:
			printf("Unknown return code!!\n");
	}

	exit(0);
}

--=-Ri5uuzF7eX9BGkSsL5Sj--

