Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S273904AbRJTStk>; Sat, 20 Oct 2001 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S273918AbRJTStV>; Sat, 20 Oct 2001 14:49:21 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:41394 "EHLO snfc21.pbi.net") by vger.kernel.org with ESMTP id <S273904AbRJTStQ>; Sat, 20 Oct 2001 14:49:16 -0400
Date: Sat, 20 Oct 2001 04:52:23 -0700
From: Bruce Korb <bkorb@pacbell.net>
Subject: How do you clean up with pthread locks held?
To: linux-kernel@vger.kernel.org, bug-glibc@gnu.org, guile-user@gnu.org
Cc: bkorb@pacbell.net
Message-id: <3BD16577.5093D070@pacbell.net>
Organization: Home
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I should note that I do not conciously use pthreads.
Every thread in this process group is a complete
new process.  But the Guile library may.  Don't know.

Here's the stack trace (linux 2.4.7 & glibc-2.1):

> 4008cc66 sigsuspend () from /lib/libc.so.6
> 400324d0 __pthread_wait_for_restart_signal () \
>           from /lib/libpthread.so.0
> 40034355 __pthread_alt_lock () from /lib/libpthread.so.0
> 40030bb2 pthread_mutex_lock () from /lib/libpthread.so.0
> 400d223b free () from /lib/libc.so.6
> 400c4c91 fclose@@GLIBC_2.1 () from /lib/libc.so.6
> 0805eb9c closeServer () at agShell.c:66
> 4008f2f5 exit () from /lib/libc.so.6
> 08060837 main (argc=6, argv=0xbffff264) at autogen.c:97
> 4007cbaf __libc_start_main () from /lib/libc.so.6

"closeServer" is a callback in the "atexit()" list:

> void
> closeServer( void )
> {
>     if (serverId == NULLPROCESS)
>         return;
> 
>     (void)kill( serverId, SIGKILL );
>     serverId = NULLPROCESS;
-->   (void)fclose( serverPair.pfRead ); <-- call in stack
>     (void)fclose( serverPair.pfWrite );
>     serverPair.pfRead = serverPair.pfWrite = (FILE*)NULL;
> }

The (edited, slightly) process status:

> $ ps -t pts/1 -l
>   F S   PID  PPID ADDR SZ WCHAN  TTY   CMD
> 000 S  1393  1392 -   383 rt_sig pts/1 ksh
> 404 Z 13156 13155 -     0 do_exi pts/1 sh <defunct>
> 000 T 13155  1393 -  1005 do_sig pts/1 ag

Things to note about the program:

1.  The "serverId" process was fork()-ed with different ends of
    two separate "pipe(2)" calls for STDIN_FILENO and STDOUT_FILENO.
    These fileno's were fdopen-ed to create "pfRead" and "pfWrite".

2.  The program seg-faulted before this, calling gh_eval_str() to
    retrieve the value of a scheme variable, via:  "(. var-name)".
    The variable exists, so likely there is some internal issue.

3.  The seg-fault was handled with a siglongjump back to main(),
    with an immediate call to exit(3).

============

So, we have all kinds of issues here.  The main one is this:
How can one reliably clean up in a signal handler?  If there
are hidden pthread locks being held by a hung thread and those
locks are needed for cleanup, what do you do?  How do you
detect the issue and just let the kernel clean everything up?

My short-term hackaround will be to not close the pipes when
I am in "exit" processing.  (I close the server for other reasons,
too.)  I don't like that, though.
