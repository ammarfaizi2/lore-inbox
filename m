Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUEJQV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUEJQV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbUEJQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:21:26 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:57976 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264851AbUEJQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:20:55 -0400
Subject: Re: ptrace in 2.6.5
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040510161008.GA11114@nevyn.them.org>
References: <1084203979.1421.1.camel@slack.domain.invalid>
	 <20040510161008.GA11114@nevyn.them.org>
Content-Type: text/plain
Message-Id: <1084206178.1420.10.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 10 May 2004 13:22:58 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 13:10, Daniel Jacobowitz wrote:
> On Mon, May 10, 2004 at 12:46:19PM -0300, Fabiano Ramos wrote:
> > Hi All.
> > 
> >      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
> >     When tracing a sequence like
> > 
> > 	mov ...
> > 	int 0x80
> > 	mov ....
> > 
> >     ptrace would notify the tracer after the two movs, but not after the
> > int 0x80. I want to know if it is a bug or the expected behaviour.
> 
> I think it's a bug.

When tracing the following code,

0x0804869f:  8B 4D 0C                     mov   ecx, [ebp+12]
0x080486a2:  CD 80                        int   0x80
0x080486a4:  89 45 F8                     mov   [ebp-8], eax
0x080486a7:  83 7D F8 82                  cmp   [ebp-8], -126


the tracer would produce

EIP: 0x080486a2
EIP: 0x080486a7


--- tracer.c ----
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <syscall.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <linux/user.h>
#include <unistd.h>
#include <errno.h>
 
 
extern char **environ;
 
int main(int argc, char **argv)
{
 
        struct user_regs_struct regs;
 
        int wait_val;           /*  child's return value        */
        int pid;                /*  child's process id          */
                                                                                 
        switch (pid = fork()) {
                                                                                                                        
        case -1:
                perror("fork");
                break;
                                                                                                                        
        case 0: /*  child process starts        */
                ptrace(PTRACE_TRACEME, 0, NULL, NULL);
                execv(argv[1],&argv[1]);
                                                                                                                     
        default:/*  parent process starts       */
                waitpid(pid,&wait_val,0);

		ptrace(PTRACE_SINGLESTEP,pid,NULL,NULL);                                                                                                                                        		waitpid(pid,&wait_val,0);                                                                                                                        
                while (1) {
                                                                                                                                               			/* get EIP */
	                ptrace(PTRACE_GETREGS, pid, 0, (int)&regs);
                        printf("\n0x%08lx", regs.eip);
                                                                                                                        			ptrace(PTRACE_SINGLESTEP, pid, 0, 0);
                         
                        wait(&wait_val);
                        if ( WIFEXITED(wait_val)) break;
                                                                                                                        
                }
                                                                                                                        
        }
}


