Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbTAOQ0M>; Wed, 15 Jan 2003 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTAOQ0M>; Wed, 15 Jan 2003 11:26:12 -0500
Received: from pc2-oxfd3-6-cust118.oxfd.cable.ntl.com ([81.103.195.118]:1806
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id <S266728AbTAOQ0F>; Wed, 15 Jan 2003 11:26:05 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.x, can't ptrace a task created with clone() ?
From: Daniel Barlow <dan@telent.net>
Date: Wed, 15 Jan 2003 16:34:58 +0000
Message-ID: <87r8bebcct.fsf@noetbook.telent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tested with 4.2.20 and 2.4.21-pre3, after PTRACE_ATTACHing to a
process I created with clone(), wait() returns ECHILD .  strace
of the parent shows

clone(child_stack=0x80599a8, flags=CLONE_VM) = 1292
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({5, 0}, {5, 0})               = 0
ptrace(PTRACE_ATTACH, 1292, 0, 0)       = 0
--- SIGCHLD (Child exited) ---
wait4(-1, 0xbffffbf0, 0, NULL)          = -1 ECHILD (No child processes)
write(2, "waitpid: No child processes\n", 28) = 28

If I replace the clone in my test program with a fork, everything
works as I expected.  Is this a bug, or are my expectations at fault?
if the latter, how _do_ I attach to one of my cloned children?

Here's the test program I've been using:

#include <sched.h>
#include <sys/ptrace.h>
#include <linux/user.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


void child(void *d) 
{
    int foo;
    fprintf(stderr,"child stack is somewhere around 0x%x\n",&foo);
    while(1){
	fprintf(stderr, "still here\n");
	sleep(3);
    }
}

main() 
{
    pid_t kid;
    int waitr;
    struct user_regs_struct regs;

    kid=clone(child,SIGSTKSZ*8+malloc(SIGSTKSZ*8), CLONE_VM ,0);  
    /* kid=fork(); */
    if(kid<0) perror("clone");
    if(kid==0) child(0);
    sleep(5);
    if(kid>0) {
	if(ptrace(PTRACE_ATTACH,kid,0,0)) perror("PTRACE_ATTACH");
	if(wait(&waitr)==-1) {
	    perror("waitpid");
	    exit(1);
	}
	if(ptrace(PTRACE_GETREGS,kid,0,&regs)) perror("PTRACE_GETREGS");
	fprintf(stderr,"child stack pointer is 0x%x\n",regs.esp);
	if(ptrace(PTRACE_DETACH,kid,0,0)) perror("PTRACE_DETACH");
	kill(kid,15);
   }
}

libc 2.3.1, in case that makes a difference.  Let me know if there's
anything else you wanted to ask


-dan

-- 

   http://www.cliki.net/ - Link farm for free CL-on-Unix resources 
