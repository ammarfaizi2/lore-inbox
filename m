Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSFLFUq>; Wed, 12 Jun 2002 01:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFLFUp>; Wed, 12 Jun 2002 01:20:45 -0400
Received: from eagle.he.net ([216.218.174.2]:25610 "EHLO eagle.he.net")
	by vger.kernel.org with ESMTP id <S317549AbSFLFUo>;
	Wed, 12 Jun 2002 01:20:44 -0400
Date: Tue, 11 Jun 2002 22:20:55 -0700
Message-Id: <200206120520.WAA11199@eagle.he.net>
From: "Anjali Kulkarni" <anjali@indranetworks.com>
To: linux-kernel@vger.kernel.org
Subject: scheduler problems
X-Mailer: WebMail 1.25
X-IPAddress: 61.11.16.239
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am getting a problem in the scheduler() function....

I am running an in-kernel proxy on linux 2.2.16 and I get a problem in 
sched.c at line 384. It is due to the fact that the schedule() function 
does not find the 'current' process in the runqueue. (A detailed 
explanation of the OOPS message which comes when run without serial 
line debugging is given below).

With serial line debugging I got the following backtrace:---

0# schedule() at sched.c:384
1# schedule_timeout(timeout=-806527036) at sched.c:653
2# kupdate (unused=0x0) at buffer.c:1921
3# kernel_thread(fn=0xb, arg=0xbffff86c, flags=0) at process.c:496
4# system_call at process.c:812

Note that paramters to functions schedule_timeout(negative value) and 
kernel_thread are incorrect or do not seem right. 
When I booted the kernel, I set breakpoints in init/main.c where 
kupdate is created, and it shows a correct call to kernel_thread-
>kupdate->schedule_timeout->schedule with all functions called with 
correct parameters.

Can anyone tell me what's happening here? My kernel module is no way 
the cause of any of this. A detailed explanation is given below...

Thanks!
Anjali

/*--------------------In more detail-------------------------*/
I am running an in-kernel proxy on linux 2.2.16, which places high 
demand on the n/w activity of the linux m/c. I am repeatedly getting an 
OOPS message at a particular place in the scheduler() function call. I 
am trying to analyse the call trace, and it looks something like the 
following:-

schedule()
schedule_timeout()
process_timeout()
do_poll()
sys_poll()

After looking at the address where OOPS reports a problem in schedule() 
and looking at the objdump of sched.o, I found the problem is due to 
the fact that when schedule() calls del_from_runqueue(), it finds that 
the current process is *not* there on the runqueue. Further, this 
current process *IS* present in the list of task structs, in 
TASK_INTERRPUTIBLE state. This process is generally some process like 
inetd or some process doing n/w activity. 
Now, if I kill all the processes on my linux machine (just to check), 
the problem frequency reduces, but it still appears, and now the 
process not present on the runqueue is some process like init(pid 1) or 
kupdate(pid 3). These are the processes which could not be 
killed.
>From this, I concluded what happens is probably that some process 
called sys_poll which called do_poll(). In do_poll(), a 
process_timeout occured(I assume this a soft interrupt), which will try 
and wakeup the process which caused it, ie put the process on the 
runqueue. I dont know who calls the schedule_timeout? Is it the process 
which wakes up from the call to schedule_timeout() after a context 
switch occured?  I am probably not aware of exactly how to interpret a 
call trace...

Thanks again.

/*----------------------------------------------------------------*/


Anjali Kulkarni
Software Engineer
Indra Networks

~Living Well is the best Revenge~
