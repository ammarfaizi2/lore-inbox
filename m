Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTBUPMi>; Fri, 21 Feb 2003 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbTBUPMh>; Fri, 21 Feb 2003 10:12:37 -0500
Received: from [81.80.245.157] ([81.80.245.157]:35219 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S267488AbTBUPMb>; Fri, 21 Feb 2003 10:12:31 -0500
Date: Fri, 21 Feb 2003 16:22:27 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Rusty Russel <rusty@rustcorp.com.au>
Subject: call_usermodehelper signals bug ?
Message-ID: <20030221152227.GG12964@cedar.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rusty Russel <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think there is a bug involved somewhere in the signal treatment
for a program launched via the new call_usermodehelper, but I 
have trouble trying to pinpoint it.

The problem is visible on my RedHat 8.0 scripts, when I insert
a pcmcia network card. This in turn launches hotplug, which launches
/sbin/ifup, which launches /sbin/arping, which never ends (although
he should end upon reception of 3 times SIGALRM, triggered by alarm(1)):
	# strace -p 2588
	recvfrom(0, "\0\1\10\0\6\4\0\1\0P\4\2\304\304QP\365\222\0\0\0\0\0\0"..., 4096, 0, {sin_family=AF_PACKET, proto=0x806, if3, pkttype=1, addr(6)={1, }, [20]) = 46
	rt_sigprocmask(SIG_BLOCK, [INT ALRM], ~[KILL CHLD STOP], 8) = 0
	gettimeofday({1045840191, 536542}, NULL) = 0
	rt_sigprocmask(SIG_SETMASK, ~[KILL CHLD STOP], NULL, 8) = 0
	recvfrom(0, "\0\1\10\0\6\4\0\1\0P\4\2\304\304QP\365\222\0\0\0\0\0\0"..., 4096, 0, {sin_family=AF_PACKET, proto=0x806, if3, pkttype=1, addr(6)={1, }, [20]) = 46
	rt_sigprocmask(SIG_BLOCK, [INT ALRM], ~[KILL CHLD STOP], 8) = 0
	gettimeofday({1045840192, 528618}, NULL) = 0
	rt_sigprocmask(SIG_SETMASK, ~[KILL CHLD STOP], NULL, 8) = 0

As a result, the network doesn't come up at all.

I succeded in reproducing the bug with a simple module which calls
call_usermodehelper and a foo.c program which uses SIGALRM (derived
from arping source code).

I feel that this has something to do with the elimination of 
        sigemptyset(&curtask->blocked);
        flush_signals(curtask);
        flush_signal_handlers(curtask);
        recalc_sigpending(curtask);
in call_usermodehelper() with the new implementation but I'm not
expert in this area.

Here is the simple module:
	#include <linux/module.h>
	#include <linux/init.h>
	#include <linux/kernel.h>
	#include <linux/kmod.h>

	static int test_init(void) {
		char *argv[2], *envp[1];
		argv[0] = "/tmp/foo";
		argv[1] = 0;
		envp[0] = 0;
		return call_usermodehelper(argv [0], argv, envp, 0);
	}
	
	module_init(test_init);

And the usermode program:
	#include <sys/signal.h>
	#include <unistd.h>
	#include <stdio.h>

	void set_signal(int signo, void (*handler)(void))
	{
		struct sigaction sa;
	
		memset(&sa, 0, sizeof(sa));
		sa.sa_handler = (void (*)(int))handler;
		sa.sa_flags = SA_RESTART;
		sigaction(signo, &sa, NULL);
	}
	
	void catcher(void)
	{
		static int count = 0;
		printf("Here\n");
		if (++count == 3)
			exit(0);
		alarm(1);
	}
	
	int
	main(int argc, char **argv)
	{
		set_signal(SIGALRM, catcher);
	
		catcher();
	
		while(1) {
			sleep(1);
		}
	}


Does this ring a bell to someone ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
