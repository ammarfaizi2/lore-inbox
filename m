Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313268AbSC1W2o>; Thu, 28 Mar 2002 17:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313269AbSC1W2e>; Thu, 28 Mar 2002 17:28:34 -0500
Received: from orinoco.cisco.com ([64.101.176.25]:28361 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S313268AbSC1W2W>;
	Thu, 28 Mar 2002 17:28:22 -0500
Message-ID: <3CA39732.2050209@cisco.com>
Date: Thu, 28 Mar 2002 16:20:34 -0600
From: Stephen Baker <stbaker@cisco.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Patch; setpriority
In-Reply-To: <Pine.LNX.3.96.1020328161615.18779D-200000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

You correct, I have tried this approach before and it seem like doubling 
the work on the system.  For one your create a thread which is really a 
process to create another process; that's ok for a small app but not a 
very scalable solution considering all the code in glibc used for 
pthread_create.   This is a bigger problem is when you only have one 
thread at nice value 0 and all other are higher value.  Now you have to 
have the main thread do it's work and the check flags to see if it needs 
to create the new thread so it can have a nice value you can change.

All this is really just pigeon dancing around the fact that Linux 
doesn't implement the PTHREAD_SCOPE_PROCESS which is all I want .  I t 
would make Linux match Solaris and BSD model for POSIX threads.  I guess 
it wouldn't be POSIX if everyone implemented it the same set of 
supported features.  That's why I resorted to changing the nice value in 
hopes of have some say in how things get scheduled without all the 
superuser / capabilities hacks.

After all this info I will go back and try to find a work around. 
 Thanks Bill and Chris for the help.
SB

Bill Davidsen wrote:

>  Rather than expect people who have been following this to reread I'll
>put this here. I believe the capability of nice(2) setting and restoring
>is (a) very seldom useful given the new scheduler, and (b) can be done
>with a bit of effort and no assult on SUS by doing the nice work in a nice
>thread. 
>
>  Code is attached.
>
>On Wed, 27 Mar 2002, Chris Wright wrote:
>
>>* Stephen Baker (stbaker@cisco.com) wrote:
>>
>>>This patch will allow a process or thread to changes it's priority 
>>>dynamically based on it's capabilities.  In our case we wanted to use 
>>>threads with Linux.  To have true priorities we need root to use 
>>>SCHED_FIFO or SCHED_RR; in many case root access is not allowed but we 
>>>still wanted priorities.  So we started using setpriority to change a 
>>>threads priority.  Now we used nice values from 19 to 0 which did not 
>>>require root access.  In some cases a thread need to raise it's nice 
>>>level and this would fail.  I also saw a note man renice(8) that said 
>>>this bug exists.
>>>
>>hmm, SUS v3 seems to disagree.
>>
>>"Only a process with appropriate privileges can lower its nice value."
>>
>>and with this patch setpriority(2) is now inconsistent with nice(2)
>>(albeit i don't know how much longer that interface will persist in arch
>>independent portion of the kernel based on the comments surrounding it).
>>
>
>
>------------------------------------------------------------------------
>
>/* try changing nice(2) for a single thread */
>
>#include <stdio.h>
>#include <unistd.h>
>#include <pthread.h>
>
>int pid;
>void part1(int *);
>pthread_mutex_t print_lock = PTHREAD_MUTEX_INITIALIZER;
>#define MAX_LOOP		100
>
>main(int argc, char *argv[])
>{
>	int j, stat;
>	volatile int i = 0;
>	pthread_t thrd1;
>
>	pid = getpid();
>	fprintf(stderr, "parent pid: %d\n", pid);
>	pthread_create(&thrd1, NULL, (void *)part1, (void *)&i);
>	/* note that I am not doing a damn thing here */
>	pthread_join(thrd1, NULL);
>
>	fprintf(stderr, "Normal termination\n");
>	exit(0);
>}
>
>void
>part1(int *ix)
>{
>	/* do one ps before nice(2) call */
>	system("ps l");
>	/* now be nice and try again */
>	fprintf(stderr, "\n--> nice\n");
>	nice(6);
>	system("ps l");
>}
>


