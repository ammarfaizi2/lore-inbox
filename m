Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWCHDoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWCHDoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWCHDoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:44:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6829 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750735AbWCHDoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:44:19 -0500
Date: Tue, 7 Mar 2006 22:45:09 -0500 (EST)
From: Wu Zhou <woodzltc@cn.ibm.com>
X-X-Sender: woodzltc@localhost.localdomain
To: andrea@suse.de
cc: linux-kernel@vger.kernel.org
Subject: About [PATCH] ptrace/coredump/exit_group deadlock
Message-ID: <Pine.LNX.4.64.0603072158110.6316@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

I am recently tracking a problem showing first in kernel 2.6.15 that 
ptraced multithreaded exec dies with a spurious SIGKILL (the url is 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177240).

In this case, the child thread calls execve to run a user specified 
command. When running in ptraced environment (e.g. strace -f -o log 
./threadexec /bin/echo hi), the process dies by SIGKILL immediately 
after execing the command (/bin/echo in this example).

After some tracking, I found that it might be related with your patch 
in http://marc.theaimsgroup.com/?l=linux-kernel&m=112833915827432&w=2, 
titled "ptrace/coredump/exit_group deadlock".  After reversing your
patch, the case runs ok.

The SIGKILL is sent in ptrace_untrace when sys_execve call flush_old_exec
to flush the old executable.  In that process, signal->flags of threadexec
is set to SIGNAL_GROUP_EXIT by zap_other_threads.  And the following code 
send the fatal SIGKILL to threadexec, so it dies.

+	if (child->signal->flags & SIGNAL_GROUP_EXIT) {
+		sigaddset(&child->pending.signal, SIGKILL);
+		signal_wake_up(child, 1);
+	}

I am not sure if I understand all these code.  But I see that you 
mentioned that "The __ptrace_unlink does nothing because the signal->flags 
is set to SIGNAL_GROUP_EXIT|SIGNAL_STOP_DEQUEUED".  Maybe the above code 
should change to something like this:

+       if (child->signal->flags & (SIGNAL_GROUP_EXIT|SIGNAL_STOP_DEQUEUED) ) {
+               sigaddset(&child->pending.signal, SIGKILL);
+               signal_wake_up(child, 1);
+       }

That is just my guess anyway.  Forgive me if it is incorrect.  

BTW, you mentioned a gdb bug report which can reproduce the deadlock you are
trying to fix.  Can you give me a pointer to that?  That will be helpful 
for me to understand more cleanly about the problem.  Thanks in advance.

Appended is the source code of the above mentioned testcase:

#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <stdlib.h>

struct args {
  char **argv;
  char **envp;
};

// Child thread
static void *
exec_args (void *arg)
{
  struct args *args = arg;

  printf ("this is in child thread\n");
  execve (args->argv[1], args->argv + 1, args->envp);
  /* Reaching here implies an error.  */
  perror ("execve");
  exit (1);

}

int
main (int argc, char **argv, char **envp)
{
  if (argc < 2) {
    printf ("Usage: %s command args ...\n", argv[0]);
    return 1;
  }

  struct args args;
  args.argv = argv;
  args.envp = envp;
  pthread_t thread;
  if (pthread_create (&thread, NULL, exec_args, &args)) {
    perror ("pthread_create");
    exit (1);
  }

  void *retval;
  if (pthread_join (thread, &retval)) {
    perror ("pthread_join");
    exit (1);
  }

  /* Should this ever be reached?  */
  exit (1);
}

Just for you reference.

Regards
- Wu Zhou

P.S: please include me in the cc-list.  I don't subscribe to the mail list 
yet.
