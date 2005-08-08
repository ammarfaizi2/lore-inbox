Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVHHSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVHHSgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVHHSgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:36:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36336 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932185AbVHHSf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:35:59 -0400
Message-ID: <42F7A609.5030502@mvista.com>
Date: Mon, 08 Aug 2005 11:35:53 -0700
From: Dave Jiang <djiang@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de>
In-Reply-To: <p73slxn1dry.fsf@bragg.suse.de>
Content-Type: multipart/mixed;
 boundary="------------010800020804010604080701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010800020804010604080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> Dave Jiang <djiang@mvista.com> writes:
> 
>>Am I doing something wrong, or is this intended to be this way on
>>x86_64, or is something incorrect in the kernel? This method works
>>fine on i386. Thanks for any help!
> 
> 
> I just tested your program on SLES9 with updated kernel and RBP
> looks correct to me. Probably something is wrong with your user space
> includes or your compiler.
> 
> -Andi

I revised the app a little so that it would allow the threads to start, 
thus should prevent rBP w/ all 0's showing up. Below are some of results 
that I've gotten from various different distros and platforms. As you 
can see, the f's shows up on most of them, including Suse 9.2. The only 
one showed up looking ok is the Mandrake/Mandriva distro. I'm not sure 
how different SLES9 is from Suse9.2....

2.6.13-rc5 w/ custom rootfs (NPTL) and toolchain (gcc 3.4.3 based), em64t:
Thread 1 (0x407ff960) created
Thread 2 (0x40fff960) created
Main pid: 0x2aaaaaef3860
pid1[0x407ff960] signaled

tb_sig_handler entered
thread 0x407ff960 context
rIP: 00002aaaaad5fb15
rSP: 00000000407ff610
rBP: 00000000ffffffff

pid2[0x40fff960] signaled

tb_sig_handler entered
thread 0x40fff960 context
rIP: 00002aaaaad5fb15
rSP: 0000000040fff610
rBP: 00000000ffffffff
--------------------------------------------------------------

FC4, em64t
Thread 1 (0x40a00960) created
Thread 2 (0x41401960) created
Main pid: 0x2aaaaaad59e0
pid1[0x40a00960] signaled

tb_sig_handler entered
thread 0x40a00960 context
rIP: 0000003cdc9925d1
rSP: 00000000409fffc0
rBP: 00000000ffffffff

pid2[0x41401960] signaled

tb_sig_handler entered
thread 0x41401960 context
rIP: 0000003cdc9925d1
rSP: 0000000041400fc0
rBP: 00000000ffffffff
------------------------------------------------------------

Mandrake 10.2, em64t
Thread 1 (0x40800960) created
Thread 2 (0x41001960) created
Main pid: 0x2aaaaaf07ea0
pid1[0x40800960] signaled

tb_sig_handler entered
thread 0x40800960 context
rIP: 00002aaaaad643b5
rSP: 00000000407fffc0
rBP: 00000000408001d0

pid2[0x41001960] signaled

tb_sig_handler entered
thread 0x41001960 context
rIP: 00002aaaaad643b5
rSP: 0000000041000fc0
rBP: 00000000410011d0
------------------------------------------------------------

Suse 9.2, AMD64
Thread 1 (0x401ff960) created
Thread 2 (0x403ff960) created
Main pid: 0x2a959a3860
pid1[0x401ff960] signaled

tb_sig_handler entered
thread 0x401ff960 context
rIP: 0000002a9580d675
rSP: 00000000401ff5e0
rBP: 00000000ffffffff

pid2[0x403ff960] signaled

tb_sig_handler entered
thread 0x403ff960 context
rIP: 0000002a9580d675
rSP: 00000000403ff5e0
rBP: 00000000ffffffff

-- 
Dave

------------------------------------------------------
Dave Jiang
Software Engineer          Phone: (480) 517-0372
MontaVista Software, Inc.    Fax: (480) 517-0262
2141 E Broadway Rd, St 108   Web: www.mvista.com
Tempe, AZ  85282          mailto:djiang@mvista.com
------------------------------------------------------


--------------010800020804010604080701
Content-Type: text/x-c;
 name="ttest1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ttest1.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <signal.h>
#include <unistd.h>
#include <sys/ucontext.h>
#include <malloc.h>
#include <errno.h>

#define SCP_FROM_UCONTEXT(uc) \
    ((struct sigcontext *) &((struct ucontext *)(uc))->uc_mcontext)

static int _traceback_signal = -1;
static pthread_t pid1 = 0;
static pthread_t pid2 = 0;
static pthread_t pidmain = 0;

extern int __libc_allocate_rtsig(int high);

static void tb_sig_handler(int sig, siginfo_t *info, void *ucontext)
{
	struct sigcontext *scp;
	int ret, i;

	printf("\n%s entered\n", __func__);
	printf("thread 0x%lx context\n", pthread_self());
	scp = SCP_FROM_UCONTEXT(ucontext);

	printf("rIP: %16.16lx\n", scp->rip);
	printf("rSP: %16.16lx\n", scp->rsp);
	printf("rBP: %16.16lx\n", scp->rbp);

	printf("\n");
}

void * test_thread1(void *arg)
{
	while(1) {
		sleep(2);
	};
	return NULL;
}

void * test_thread2(void *arg)
{
	while(1) {
		sleep(2);
	};
	return NULL;
}

int main()
{
	struct sigaction act;
	int ret = 0;
	
	_traceback_signal = __libc_allocate_rtsig(1);
	act.sa_sigaction = tb_sig_handler;
	sigemptyset(&act.sa_mask);
	act.sa_flags = SA_RESTART | SA_SIGINFO;
	sigaction(_traceback_signal, &act, NULL);

	ret = pthread_create(&pid1, NULL, test_thread1, NULL);
	if(ret < 0) {
		fprintf(stderr, "thread 1 creation failed\n");
		return -1;
	}
	printf("Thread 1 (0x%lx) created\n", pid1);

	sleep(1);

	ret = pthread_create(&pid2, NULL, test_thread2, NULL);
	if(ret < 0) {
		fprintf(stderr, "thread 2 creation failed\n");
		return -1;
	}
	printf("Thread 2 (0x%lx) created\n", pid2);

	sleep(1);

	pidmain = pthread_self();

	printf("Main pid: 0x%lx\n", pidmain);
	
	ret = pthread_kill(pid1, _traceback_signal);
	if(ret >= 0) {
		printf("pid1[0x%lx] signaled\n", pid1);
	}

	sleep(1);
	
	ret = pthread_kill(pid2, _traceback_signal);
	if(ret >= 0) {
		printf("pid2[0x%lx] signaled\n", pid2);
	}

	sleep(5);

#if 0
	ret = pthread_kill(pidmain, _traceback_signal);
	if(ret >= 0) {
		printf("pidmain[0x%lx] signaled\n", pidmain);
	}
#endif

	return 0;
}
	


--------------010800020804010604080701--
