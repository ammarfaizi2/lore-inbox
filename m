Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWCJLLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWCJLLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWCJLLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:11:13 -0500
Received: from airmail.airvananet.com ([12.6.244.34]:20748 "EHLO
	airmail.wirelessworld.airvananet.com") by vger.kernel.org with ESMTP
	id S1751023AbWCJLLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:11:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Confused about SIGHUP
Date: Fri, 10 Mar 2006 16:40:08 +0530
Message-ID: <653F3CF58193744C9DE59C217C072B58513904@nilgiri.india.wirelessworld.airvananet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Confused about SIGHUP
Thread-Index: AcYf3gMvb/oWE8SFSxScMOJWWdsBOAkU6uuw
From: "Sampath Kumar Herga" <sherga@airvana.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2006 11:10:13.0673 (UTC) FILETIME=[3437C990:01C64433]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not sure if this is the right forum for this question. Would appreciate
if someone could point me to the correct forum, if this isnt. 

I was trying the following program and the main thread also seems to
exit when the spawned thread exits. This happens only when I spawn the
program using the xterm -e <cmd> option to execute the program.

#include <pthread.h>
#include <signal.h>
#include <sys/types.h>
#include <linux/unistd.h>

_syscall0(pid_t,gettid)
pid_t gettid(void);


void* func(void* tmp1)
{
        printf("func; Process group = %d;\tpid =
%d;\ttid=%d;\tppid=%d\n",getpgrp(),getpid(),gettid(),getppid());
	sleep(2);
}

int main()
{
	pthread_attr_t attr;
	pthread_t thread;
	pthread_attr_init(&attr);

	pthread_create(&thread,&attr,func,0);

        printf("main; Process group = %d;\tpid =
%d;\ttid=%d;\tppid=%d\n",getpgrp(),getpid(),gettid(),getppid());
	while(1)
	{	
		printf("Hello World\n");
		sleep(1);
	}
}

main; Process group = 30100;    pid = 30100;    tid=30100;
ppid=30098
Hello World
func; Process group = 30100;    pid = 30100;    tid=30101;
ppid=30098
Hello World
Hello World


Looking at the strace, the main thread seems to be getting a SIGHUP.

30101 _exit(0)                          = ?
30100 <... rt_sigprocmask resumed> [], 8) = 0
30100 --- SIGHUP (Hangup) @ 0 (0) ---
30098 <... select resumed> )            = 1 (in [4], left {1, 0})
30098 --- SIGCHLD (Child exited) @ 0 (0) ---

I wasn't sure why SIGHUP is being delivered in this case when tid 30101
is not the process group leader?

Regards,
Sampath.
