Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVHJDKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVHJDKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 23:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHJDKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 23:10:23 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:6655 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964916AbVHJDKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 23:10:22 -0400
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
	sa_mask
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, gdt@linuxppc.org,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org>
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
Content-Type: multipart/mixed; boundary="=-0wgYlme1oi4Ljo5+M0yX"
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 23:10:01 -0400
Message-Id: <1123643401.9553.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0wgYlme1oi4Ljo5+M0yX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-08-09 at 14:27 -0700, Linus Torvalds wrote:
> On the other hand, the standard seems to be a bit confused according to 
> google:
> 
>   "This mask is formed by taking the union of the current signal mask and
>    the value of the sa_mask for the signal being delivered unless
>    SA_NODEFER or SA_RESETHAND is set, and then including the signal being
>    delivered. If and when the user's signal handler returns normally, the
>    original signal mask is restored."
> 
> Quite frankly, the way I read it is actually the old Linux behaviour: the 
> "unless SA_NODEFER or SA_RESETHAND is set" seems to be talking about the 
> whole union of the sa_mask thing, _not_ just the "and the signal being 
> delivered" part. Exactly the way the kernel currently does (except we 
> should apparently _also_ do it for SA_RESETHAND).

Actually I take it the other way.  The wording is awful. But the "unless
SA_NODEFER or SA_RESETHAND is set, and then including the signal being
delivered".  This looks to me that it adds the signal being delivered to
the blocked mask unless the SA_NODEFER or SA_RESETHAND is set. I kind of
wonder if English is the native language of those that wrote this.  
> 
> So if we decide to change the kernel behaviour, I'd like this to be in -mm
> for a while before merging (or merge _very_ early after 2.6.13). I could
> imagine this confusing some existing binaries that had only been tested
> with the old Linux behaviour, regardless of what a standard says. 
> Especially since the standard itself is so confusing and badly worded.
> 
> Maybe somebody can tell what other systems do, since I assume the standard 
> is trying to describe behaviour that actually exists in the wild..

Well, I wrote this (attached) test program to see how signals are
affected by different settings.  It's best run under an idle system, so
if someone has another unix out there that can run this and return the
results, we can see how they work.  This test program has possible race
conditions but should work fine on an idle system. But that's just the
nature of testing signals and other asynchronous activities, as well as
just writing something up in a couple of minutes ;-)

A non-modified Linux returns this:

   sa_mask blocks other signals
   SA_NODEFER does not block other signals
   SA_NODEFER affects sa_mask
   SA_NODEFER and sa_mask does not block sig
   !SA_NODEFER blocks sig
   SA_NODEFER does not block sig
   sa_mask blocks sig

This shows the following:

1. That signals in sa_mask are blocked while the signal handler is
running. 
2. SA_NODEFER does not by itself block other signals (this should never
be anything else).
3. SA_NODEFER does affect the sa_mask (which is the topic of this
discussion). 
4. When SA_NODEFER is set and sa_mask has the signal itself set, then
the signal is blocked (I believe that this is wrong too. If the signal
is itself in sa_mask then SA_NODEFER should still not let it run. This
should be interresting to see what other unices do).
5. When SA_NODEFER is not set, the signal is blocked (this is correct).
6. When SA_NODEFER is set (with nothing in sa_mask) the signal is not
blocked (also correct).
7. When the signal itself is set in sa_mask, then the signal is blocked
(correct).

With a patched kernel we get the following output:

   sa_mask blocks other signals
   SA_NODEFER does not block other signals
   SA_NODEFER does not affect sa_mask
   SA_NODEFER and sa_mask blocks sig
   !SA_NODEFER blocks sig
   SA_NODEFER does not block sig
   sa_mask blocks sig

Here the differences are that SA_NODEFER does _not_ affect the sa_mask,
and that when both the sig is in sa_mask and the SA_NODEFER is set, then
the signal is still blocked.  I can see this being useful if the sa_mask
is generated, and the NODEFER is expected to be the default. This allows
for overriding the default.

So, if someone can run this test on another unix system, then we can
have an idea of how others handle this.

-- Steve


--=-0wgYlme1oi4Ljo5+M0yX
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
	if (ret == 1) {
		printf("sa_mask does not block other signals\n");
	} else if (ret == 0) {
		printf("sa_mask blocks other signals\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	ret = testsig(&act,SIGUSR1,SIGUSR2);
	if (ret == 1) {
		printf("SA_NODEFER does not block other signals\n");
	} else if (ret == 0) {
		printf("SA_NODEFER blocks other signals\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	sigaddset(&act.sa_mask,SIGUSR2);
	ret = testsig(&act,SIGUSR1,SIGUSR2);
	if (ret == 1) {
		printf("SA_NODEFER affects sa_mask\n");
	} else if (ret == 0) {
		printf("SA_NODEFER does not affect sa_mask\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	sigaddset(&act.sa_mask,SIGUSR1);
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	if (ret == 1) {
		printf("SA_NODEFER and sa_mask does not block sig\n");
	} else if (ret == 0) {
		printf("SA_NODEFER and sa_mask blocks sig\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	if (ret == 1) {
		printf("!SA_NODEFER does not block sig\n");
	} else if (ret == 0) {
		printf("!SA_NODEFER blocks sig\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	memset(&act,0,sizeof(act));
	act.sa_flags |= SA_NODEFER;
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	if (ret == 1) {
		printf("SA_NODEFER does not block sig\n");
	} else if (ret == 0) {
		printf("SA_NODEFER blocks sig\n");
	} else {
		printf("Unknown return code!!\n");
	}

	memset(&act,0,sizeof(act));
	sigaddset(&act.sa_mask,SIGUSR1);
	ret = testsig(&act,SIGUSR1,SIGUSR1);
	if (ret == 1) {
		printf("sa_mask does not block sig\n");
	} else if (ret == 0) {
		printf("sa_mask blocks sig\n");
	} else {
		printf("Unknown return code!!\n");
	}

	exit(0);
	exit(0);
}

--=-0wgYlme1oi4Ljo5+M0yX--

