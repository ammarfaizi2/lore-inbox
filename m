Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbTCQVOD>; Mon, 17 Mar 2003 16:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261958AbTCQVOD>; Mon, 17 Mar 2003 16:14:03 -0500
Received: from www-auth.cs.wisc.edu ([128.105.7.18]:57810 "EHLO
	www-auth.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S261954AbTCQVOA>; Mon, 17 Mar 2003 16:14:00 -0500
From: Rajesh Rajamani <raj@cs.wisc.edu>
Message-ID: <1047936295.3e763d273307c@www-auth.cs.wisc.edu>
Date: Mon, 17 Mar 2003 15:24:55 -0600
To: linux-kernel@vger.kernel.org
Cc: zandy@cs.wisc.edu, raj@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4) 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 206.154.118.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I'm working on adding a function 

void debugbreak(void);

to glibc.  I got the inspiration for this from Windows.  Windows has a
DebugBreak() function, which when invoked from  a process, spawns a
debugger, which then attaches to the process.  I think this would be
invaluable to linux developers in situations where they currently have to
put an infinite loop and attach to a running process (say, to stop in a
library that has been LD_PRELOADed).

To this end, I've been experimenting and found out that gdb can't attach
to a process that has been stopped.  I'd like to send a SIGSTOP as soon as
debugbreak() is invoked, so that all threads are stopped in a state close
to the one they were in, when the debugbreak() was invoked. 

I spoke to Vic Zandy about this and he informed me that he had submitted a patch
 that would allow ptrace to attach to stopped processes also (the thread of
discussion is pasted below).  I believe the patch was not accepted at that time.
   I was wondering what the official line on this is?  If there are no serious
objections, will the community consider accepting the patch?  It would go a long
way in helping me accomplish my goal.

Thank you,
Raj

PS - I am not subscribed to the kernel mailing list.  Would appreciate your
cc-ing your reply to me.
-------------------------------------------------------------------------------
Vic Zandy wrote --

This is to respond to feedback for the ptrace patch I sent toward the
end of december.  The original message is below.

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > +   if (signr == SIGSTOP && current->ptrace & PT_PTRACED)
> This does not I suspect do what you think - surely you want brackets ?

I agree the second term should be wrapped in parens (it is now in the
patch below); but isn't that logically equivalent to what I had?

From: Mike Coleman <mkc@mathdogs.com>:
> Also, is this something that used to work?  Or would this be a change in the
> semantics of ptrace?

This is a change of semantics at least going back to 2.2.

>> Another bug is that it is not possible to use PTRACE_DETACH to leave a
>> process stopped, because ptrace ignores SIGSTOPs sent by the tracing
>> process.
>
> Unless I'm missing something (frequently the case), there are two cases here:
> (1) the tracer wants to leave the tracee stopped, and (2) the tracer wants the
> process to continue running in as natural a way as possible, meaning without
> sending it a SIGCONT (which can cause the SIGCONT signal handler to execute).
> As things currently stand, we have behavior (2), and (1) is not possible.
> With your change, we'd have behavior (1), and (2) would not be possible.

I agree that the ability to do (2) should be preserved, but I don't
see how this patch breaks it; do you have an example?

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>> --- linux-2.4.16/kernel/ptrace.c Wed Nov 21 16:43:01 2001
>> +++ linux-2.4.16.1/kernel/ptrace.c Fri Dec 21 10:42:44 2001
>> @@ -89,8 +89,10 @@
>>    SET_LINKS(task);
>>   }
>>   write_unlock_irq(&tasklist_lock);
>> -
>> - send_sig(SIGSTOP, task, 1);
>> + if (task->state != TASK_STOPPED)
>> +  send_sig(SIGSTOP, task, 1);
>> + else
>> +  task->exit_code = SIGSTOP;
>>   return 0;
>>  
>>  bad:
>
> It seems that trace is started in the place different from
> usual. Then, I think PTRACE_KILL doesn't work.

I don't agree, it seems to work for me.

I'd still want to check uml and subterfuge, which I'll do after these
points are cleared up.

Thanks,
Vic

From: vic <zandy@cs.wisc.edu>
Subject: [PATCH] ptrace on stopped processes (2.4)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
 alan@lxorguk.ukuu.org.uk
Date: Fri, 21 Dec 2001 13:53:32 -0600

This patch fixes a couple problems with ptrace's interaction with
stopped processes on Linux 2.4.

The most significant bug is that gdb cannot attach to a stopped
process.  Specifically, the wait that follows the PTRACE_ATTACH will
block indefinitely.

Another bug is that it is not possible to use PTRACE_DETACH to leave a
process stopped, because ptrace ignores SIGSTOPs sent by the tracing
process.

This patch is against 2.4.16 on x86.  I have tested gdb and strace.
After this patch is reviewed, I would be happy to submit an analogous
patch for the other platforms, although I cannot test it.

Vic Zandy

--- linux-2.4.16/arch/i386/kernel/signal.c      Fri Sep 14 16:15:40 2001
+++ linux-2.4.16.1/arch/i386/kernel/signal.c    Wed Jan 16 22:19:16 2002
@@ -620,9 +620,9 @@
                                continue;
                        current->exit_code = 0;
 
-                       /* The debugger continued.  Ignore SIGSTOP.  */
-                       if (signr == SIGSTOP)
-                               continue;
+                       /* The debugger continued. */
+                       if (signr == SIGSTOP && (current->ptrace & PT_PTRACED))
+                               continue; /* ignore SIGSTOP */
 
                        /* Update the siginfo structure.  Is this good?  */
                        if (signr != info.si_signo) {
--- linux-2.4.16/kernel/ptrace.c        Wed Nov 21 16:43:01 2001
+++ linux-2.4.16.1/kernel/ptrace.c      Fri Dec 21 10:42:44 2001
@@ -89,8 +89,10 @@
                SET_LINKS(task);
        }
        write_unlock_irq(&tasklist_lock);
-
-       send_sig(SIGSTOP, task, 1);
+       if (task->state != TASK_STOPPED)
+               send_sig(SIGSTOP, task, 1);
+       else
+               task->exit_code = SIGSTOP;
        return 0;
 
 bad:
-
