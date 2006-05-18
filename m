Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWERTHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWERTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWERTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:07:09 -0400
Received: from smtp.mts-nn.ru ([213.177.96.23]:34283 "EHLO smtp.mts-nn.ru")
	by vger.kernel.org with ESMTP id S1751379AbWERTHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:07:08 -0400
Date: Thu, 18 May 2006 23:08:51 +0400
From: "Sergei I. Kononov" <self@borman.nnov.ru>
To: linux-kernel@vger.kernel.org
Subject: ptrace() - is kernel drop PT_PTRACED bit in task->ptrace?
Message-ID: <20060518190850.GA9987@junkyard.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-fingerprint: 3D67 ECE6 3DF6 A874 AB65  4A3B 157C 172D 7D99 2F45
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

All,

I wrote 2 small programms:
 1 - daemonize itself in loop (forever) =)
 2 - traces the fork/clone events via ptrace() interface. 

You can find both in attachment.

The strange thing is that, when I'm trying to attach
to new process (after I've detached from old one), ptrace() returns -1
and errno is EPERM.

I examined kernel/ptrace.c source code and I suppose that I've found the reason for such
behaviour. In file kernel/ptrace.c in function ptrace_attach(task)
exists PT_PTRACED bit check:
...
if (task->ptrace & PT_PTRACED)
        goto bad;
...
bad:
    task_unlock(task);
    return retval;
   
retval is set to -EPERM.

I didn't find place where PT_PTRACED bit drops, please point me to this place 
if such exists.

Or maybe I do something wrong?

Thanks.

PS: Please Cc reply to me, cause I'm not subscribed.

-- 
Sergei "df" Kononov
GnuPG ID: 0x7D992F45
Linux - because software problems should not cost money. (by Shlomi Fish)

--ew6BAiZeqk4r7MaW
Content-Type: text/x-csrc; charset=koi8-r
Content-Disposition: attachment; filename="ptrace_trace_fork.c"

#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/user.h>
#include <linux/unistd.h>
#include <linux/ptrace.h>
#include <errno.h>
#include <string.h>

#define PTRACE_ALL PTRACE_O_TRACEFORK | PTRACE_O_TRACECLONE \
         | PTRACE_O_TRACEVFORK | PTRACE_O_TRACEEXIT | \
         PTRACE_O_TRACEEXEC | PTRACE_O_TRACESYSGOOD

#define PTRACE_FORK (PTRACE_O_TRACEFORK | PTRACE_O_TRACECLONE)
#define PTRACE_GENERIC (PTRACE_O_TRACEEXIT | PTRACE_O_TRACESYSGOOD)
 
#define SIGSYSTRAP (SIGTRAP | 0x80)

int ptrace_trace(pid_t pid, pid_t new)
{
   struct user_regs_struct uregs, oregs;
   long syscall, syscall_rval;
   long *regs = 0;
   int status, event, npid, not_exit = 1;
   siginfo_t sigi;

   if ( new )
   {
      ptrace(PTRACE_DETACH, pid, 0, 0);
      wait(&status);

      if ( WIFSTOPPED(status) && (WSTOPSIG(status) != SIGSTOP )) 
      {
         printf("detach failed signal=%d\n", WSTOPSIG(status));
         exit(1);
      }
      
      pid = new;

        /* The next code is commented
         * is process really detached? looks like no
         * because of here I'll get EPERM, I suppose the problem is here:
         * kernel/ptrace.c - ptrace_attach(task)
        */
        
        /*
      ptrace(PTRACE_ATTACH, new, 0, 0);
      wait(&status);

      if ( WIFSTOPPED(status) && (WSTOPSIG(status) != SIGSTOP ))
      {
         printf("attach failed signal=%d\n", WSTOPSIG(status));
         exit(1);
      }*/
      ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_FORK | PTRACE_GENERIC | PTRACE_O_TRACEEXEC);
      ptrace(PTRACE_CONT, pid, 0, 0);
   }

   while ( not_exit )
   {
      wait(&status);

      if ( WIFSTOPPED(status) && (WSTOPSIG(status) == SIGSYSTRAP ||
               WSTOPSIG(status) == SIGTRAP) )
      {

          ptrace(PTRACE_GETSIGINFO,pid,NULL,&sigi) ;
         
         printf("siginfo=%d\n", sigi.si_code);
         event = (sigi.si_code >> 8) & WSTOPSIG(status);
   
         printf("status=%d,event=%d\n", status, event);

         switch(event)
         {
         case PTRACE_EVENT_EXEC:
            printf("exec\n");
            break;
         case PTRACE_EVENT_FORK:
         case PTRACE_EVENT_VFORK:
         case PTRACE_EVENT_CLONE:
            ptrace(PTRACE_GETEVENTMSG, pid, NULL, &npid);
            printf("fork|vfork|clone %d\n", npid);
            printf("detaching from %d, attaching to %d\n", pid, npid);
            ptrace_trace(pid, npid);
            break;

         case PTRACE_EVENT_EXIT:
            printf("[%d] exit %d\n", npid, WEXITSTATUS(status));
            not_exit = 0;
            continue;
         default:
            printf("unknown event %d\n", event);

         }
         
      }
      ptrace(PTRACE_CONT, pid, 0, WSTOPSIG(status));
         
   }
}

int got_sig = 0;

void sigusr1(int d)
{
   got_sig = 1;
}

int main(int argc, char **argv, char **env)
{
   pid_t cp, pp;
   int status;

   signal(SIGUSR1, sigusr1);

   pp = getpid();
   cp = fork();

   if ( cp == 0 )
   {
      ptrace(PTRACE_TRACEME, 0, 0, 0);

      kill(pp, SIGUSR1);
      while( ! got_sig );
      
      execl(argv[1], argv[1], NULL);
   }
   else if ( cp > 0 )
   {

      printf("forkall=0x%x\n", PTRACE_ALL);

      while( ! got_sig );
      kill(cp, SIGUSR1);
      wait(&status);
      
      if ( ptrace(PTRACE_SETOPTIONS, cp, 0, \
                                PTRACE_FORK | PTRACE_GENERIC \
                                | PTRACE_O_TRACEEXEC ) == -1 && errno )
      {
         printf("ptrace(): %s\n", strerror(errno));
         exit(1);
      }
      ptrace(PTRACE_CONT, cp, 0, WSTOPSIG(status));

      ptrace_trace(cp, 0);
   }
   else
   {
      fprintf(stderr, "fork() failed\n");
   }

   return 0;
}

--ew6BAiZeqk4r7MaW
Content-Type: text/x-csrc; charset=koi8-r
Content-Disposition: attachment; filename="zdaemon.c"

#include <stdio.h>
#include <syslog.h>
#include <fcntl.h>
#include <sys/resource.h>
#include <signal.h>
#include <sys/stat.h>
#include <unistd.h>

void daemonize();

int main(int argc, char **argv)
{
    daemonize();

    while(1) {
       sleep(5);
       daemonize();
    }
    return 1;
}


void sig_handler(int signo)
{
   return;
}

void daemonize()
{
     struct sigaction term_sig; /* for SIGTERM, SIGINT, SIGHUP, SIGUSR1 and SIGUSR2 */
     pid_t pid;
     
     
     /* fork new child */
     if ( (pid = fork()) > 0 )
     {
         exit(0); /* parent must die */
     }
     else if ( pid < 0 )
          fprintf(stderr, "fork failed\n");

     setsid(); /* new session started */
     
     chdir("/"); /* our root is / */
          
     close(STDIN_FILENO); /* close stdin */
     close(STDERR_FILENO); /* close stderr and stdout if close_fd is 1 */
     close(STDOUT_FILENO);
     
     /* structs for signal handling */
     memset(&term_sig, 0, sizeof(term_sig));
     
     term_sig.sa_handler = &sig_handler; /* default signal handler function */

     sigaction(SIGTERM, &term_sig, NULL);
     sigaction(SIGINT, &term_sig, NULL);
     sigaction(SIGHUP, &term_sig, NULL);
     sigaction(SIGUSR1, &term_sig, NULL);
     sigaction(SIGUSR2, &term_sig, NULL);
     
     return;
}

--ew6BAiZeqk4r7MaW--
