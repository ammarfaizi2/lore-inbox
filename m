Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVATVsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVATVsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVATVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:47:54 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21225 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262060AbVATVrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:47:18 -0500
Message-ID: <41F026E1.5050006@nortelnetworks.com>
Date: Thu, 20 Jan 2005 15:47:13 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [bug?]  strange behaviour with longjmp, itimer, and read/recv (but
 not pause)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm seeing something odd, and I'm hoping someone can help.  Running 
linux 2.6.9 on ppc.

I was writing a small test program to verify behaviour of network code 
when interrupted by a signal.  To make the code bulletproof (or so I 
hoped) I used setjmp/longjmp to recover from the case where the syscall 
was being automatically restarted.  Everything seemed to be okay.

However, I then reversed the order of the tests (doing the SA_RESTART 
case first).  At this point I got the strange behaviour that the third 
signal was never delivered.  Strace and gdb both show the recv() call 
running forever, and the signal never gets delivered.

It this point I suspected my setjmp/longjmp code was bad, so to test it 
I changed the recv() call to a pause() call.  After that change, 
everything worked fine.  I changed it to a read() call, and it breaks 
again with the third signal never being delivered.

Looking at the strace output, the only interesting thing I see is that 
both recv() and read() return with (errno == ERESTARTSYS), while pause() 
returns with (errno == ERESTARTNOHAND).

I've included the source code as well as traces of the pause() and 
recv() runs.  If anyone has any ideas I'd love to hear them....

Chris









#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <string.h>
#include <linux/stddef.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <setjmp.h>
#include <unistd.h>

jmp_buf env;
volatile int signalled;
void handler(int sig)
{
	if (signalled)
		longjmp(env, 1);
	signalled = 1;
	struct itimerval itv = {{0,0},{0,500000}};
	setitimer(ITIMER_REAL,&itv,0);
}


void dotest(int sock, int flags)
{
	int rc = setjmp(env);
	if (rc) {
		printf("system call was not interrupted\n");
		return;
	}
	
	struct sigaction action;
	action.sa_handler = handler;
	action.sa_flags = flags;
	sigaction(SIGALRM, &action, 0);
	
	signalled = 0;
	
	struct itimerval itv = {{0,0},{0,500000}};
	setitimer(ITIMER_REAL,&itv,0);
	
	
	char buf;
	rc = recv(sock, &buf, 1, 0);
         if(rc < 0) {
		int localerrno = errno;
		printf("recv() interrupted, errno: %d\n", localerrno);
                 return;
         }
}


int main()
{
	int sock = socket (PF_INET, SOCK_DGRAM, 0);
	
	printf("\ntesting behaviour of recv() on signal interruption with 
restarted syscalls:\n");
	dotest(sock, SA_RESTART);

	printf("testing behaviour of recv() on signal interruption with 
non-restarted syscalls:\n");
	dotest(sock, 0);

	
    return 0;
}







using pause()


write(1, "testing behaviour of recv() on s"..., 76testing behaviour of 
recv() on signal interruption with restarted syscalls:
) = 76
rt_sigaction(SIGALRM, {0x10000844, [], SA_RESTART}, NULL, 8) = 0
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
pause()                                 = ? ERESTARTNOHAND (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
sigreturn()                             = ? (mask now [])
write(1, "recv() interrupted, errno: 4\n", 29recv() interrupted, errno: 4
) = 29
write(1, "testing behaviour of recv() on s"..., 80testing behaviour of 
recv() on signal interruption with non-restarted syscalls:
) = 80
rt_sigaction(SIGALRM, {0x10000844, [], 0}, NULL, 8) = 0
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
pause()                                 = ? ERESTARTNOHAND (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
sigreturn()                             = ? (mask now [])
write(1, "recv() interrupted, errno: 4\n", 29recv() interrupted, errno: 4
) = 29



using recv()



write(1, "testing behaviour of recv() on s"..., 76testing behaviour of 
recv() on signal interruption with restarted syscalls:
) = 76
rt_sigaction(SIGALRM, {0x100008a4, [], SA_RESTART}, NULL, 8) = 0
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
recv(3, 0x7ffff620, 1, 0)               = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
sigreturn()                             = ? (mask now [])
recv(3, 0x7ffff620, 1, 0)               = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
write(1, "system call was not interrupted\n", 32system call was not 
interrupted
) = 32
write(1, "testing behaviour of recv() on s"..., 80testing behaviour of 
recv() on signal interruption with non-restarted syscalls:
) = 80
rt_sigaction(SIGALRM, {0x100008a4, [], 0}, NULL, 8) = 0
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={0, 500000}}, NULL) = 0
recv(3,

