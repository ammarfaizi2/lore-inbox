Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUELCRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUELCRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUELCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:17:12 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:57720 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264890AbUELCRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:17:01 -0400
Subject: Re: [patch] really-ptrace-single-step
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405111805220.10328@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
	 <1084296680.2912.8.camel@slack.domain.invalid>
	 <20040511171740.6aa32cd1.akpm@osdl.org>
	 <1084323876.1838.14.camel@slack.domain.invalid>
	 <Pine.LNX.4.58.0405111805220.10328@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1084328384.1753.7.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 23:19:45 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 22:06, Davide Libenzi wrote:
> On Tue, 11 May 2004, Fabiano Ramos wrote:
> 
> > Sorry for that.
> > By the way the email was sent in response to the first
> > patch, not for the second version.
> 
> The second version works for me. Pls give it a spin.
> 
> 
> - Davide


Seems to be working just fine on 2.6.5 and 2.6.6. Tracing the following
code (tracer appended) would produce:


 8050cd6:	b8 c7 00 00 00       	mov    $0xc7,%eax
 8050cdb:	cd 80                	int    $0x80
 8050cdd:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
 8050ce2:	76 f0                	jbe    8050cd4 <__getuid+0x14>



EIP = 0x08050cd6

EIP = 0x08050cdb

EIP = 0x08050cdd

EIP = 0x08050ce2


--------- TRACER -----------
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

        long long totalinstr=0;        /* # of intr executed */
        unsigned char opcode;          /* syscall opcode goes in one
byte */


        int i;

       /* printing options */
       printf("\n\nPTRACE: Will execute \"");
       for (i=1; i<argc; i++)
             printf("%s ", argv[i]);

       printf("\". Please wait (it may take long...)\n\n\n");

       printf("***** SIMULATED PROGRAM OUTPUT *****\n\n");

        switch (pid = fork()) {

        case -1:
                perror("fork");
                break;

        case 0: /*  child process starts        */
                if ( ptrace(PTRACE_TRACEME, 0, NULL, NULL) < 0)
			perror("\nError in ptrace PTRACE_TRACEME");
		execv(argv[1],&argv[1]);
		break;

        default:/*  parent process starts       */
		if (waitpid(pid,&wait_val,0) < 0)
			perror("\nchild process EXITED");

		if (ptrace(PTRACE_SINGLESTEP,pid,NULL,NULL) < 0)
               		perror("\nError in ptrace PTRACE_SINGLESTEP");

                waitpid(pid,&wait_val,0);

                while (1) {

		      totalinstr++;

			/* get PC */
                      if (ptrace(PTRACE_GETREGS, pid, 0, (int)&regs) ==
-1){
                           perror("ptrace");
                            printf("Exiting on error ... \n");
                      }

		      printf("\nEIP = 0x%08lx\n", regs.eip);

		      // will stop after each instruction
                      if (ptrace(PTRACE_SINGLESTEP, pid, 0, 0) != 0)
                               perror("ptrace");

                      waitpid(pid,&wait_val,0);
		      if ( WIFEXITED(wait_val)) break;

                }

        }
	printf("\n************************************\n\n");
        printf("Number of machine instructions : %lld\n\n\n",
totalinstr);
        return 0;
}


