Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVHLVIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVHLVIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVHLVIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:08:40 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:26268 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932089AbVHLVIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:08:39 -0400
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
	sa_mask
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, gdt@linuxppc.org,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <9a87484905081212317ca8c04e@mail.gmail.com>
References: <1123615983.18332.194.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
	 <1123621223.9553.4.camel@localhost.localdomain>
	 <1123621637.9553.7.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
	 <1123643401.9553.32.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr>
	 <20050812184503.GX7762@shell0.pdx.osdl.net>
	 <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain>
	 <9a87484905081212317ca8c04e@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-VEs9qzIVJAGiC0Ki+uBP"
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 17:08:11 -0400
Message-Id: <1123880891.5296.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VEs9qzIVJAGiC0Ki+uBP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-08-12 at 21:31 +0200, Jesper Juhl wrote:

> > 
> I've got a 4-way pSeries p550 running AIX 5.3 here : 
> 
> $ uname -s -M -p -v -r
> AIX 3 5 powerpc IBM,9113-550
> 
> Output from your program :
> 
> $ ./a.out
> Unknown return code!!
> Unknown return code!!
> Unknown return code!!
> Unknown return code!!
> Unknown return code!!
> Unknown return code!!
> sa_mask blocks sig
> 

Did you try my updated code (the one with the extra sleep?). Here's
another version where I output the unknown return code.  Funny that this
didn't print any other error message. Since the return codes should show
something else.

Please try the attached.

Thanks,

-- Steve


--=-VEs9qzIVJAGiC0Ki+uBP
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
	sleep(1);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
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
			printf("Unknown return code (%d)!!\n",ret);
	}

	exit(0);
}

--=-VEs9qzIVJAGiC0Ki+uBP--

