Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290045AbSAQQ5Y>; Thu, 17 Jan 2002 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290048AbSAQQ5P>; Thu, 17 Jan 2002 11:57:15 -0500
Received: from wireless90.cs.wisc.edu ([128.105.48.190]:53121 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290045AbSAQQ5G>; Thu, 17 Jan 2002 11:57:06 -0500
To: Mike Coleman <mkc@mathdogs.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com>
From: vic <zandy@cs.wisc.edu>
Date: Thu, 17 Jan 2002 10:57:08 -0600
Message-ID: <m3advcq5jv.fsf@localhost.localdomain>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to respond to feedback for the ptrace patch I sent toward the
end of december.  The original message is below.

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > +			if (signr == SIGSTOP && current->ptrace & PT_PTRACED)
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
>> --- linux-2.4.16/kernel/ptrace.c	Wed Nov 21 16:43:01 2001
>> +++ linux-2.4.16.1/kernel/ptrace.c	Fri Dec 21 10:42:44 2001
>> @@ -89,8 +89,10 @@
>>  		SET_LINKS(task);
>>  	}
>>  	write_unlock_irq(&tasklist_lock);
>> -
>> -	send_sig(SIGSTOP, task, 1);
>> +	if (task->state != TASK_STOPPED)
>> +		send_sig(SIGSTOP, task, 1);
>> +	else
>> +		task->exit_code = SIGSTOP;
>>  	return 0;
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
