Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154892AbPFIBnH>; Tue, 8 Jun 1999 21:43:07 -0400
Received: by vger.rutgers.edu id <S154810AbPFIB0t>; Tue, 8 Jun 1999 21:26:49 -0400
Received: from ns.cartsys.com ([205.217.49.138]:4648 "EHLO Indigo.cartsys.com") by vger.rutgers.edu with ESMTP id <S155027AbPFIBKN>; Tue, 8 Jun 1999 21:10:13 -0400
Message-ID: <375DBEF2.5EECE92D@cartsys.com>
Date: Tue, 08 Jun 1999 18:10:10 -0700
From: Nate Eldredge <nate@cartsys.com>
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.2.10 i586)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.rutgers.edu
Subject: [PATCH] Re: Bug: Tracing recursive system calls
References: <E10r9LE-0006v4-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> 
> > syscall_trace is in the fast path?!?  It only gets called when a process
> > is being traced, and nobody expects traced processes to run extremely
> > fast, do they?
> 
> Fast path for tracing syscalls. It would be nice to avoid a check every
> trace is what I mean.
> 
> > The problem isn't that the child thread is traced, it's that the `clone'
> > call itself from `kernel_thread' is traced.  So one would have to clear
> > the flag and then reset it in the parent.
> 
> Ok
> 
> > Besides, this doesn't suffice.  There are other places in the kernel
> > that make system calls (there's a `waitpid' in `request_module' for
> > instance).  We would need to find and change all of these and institute
> > a rule for the future, or else change the inline asm definitions in
> > asm/unistd.h.  Either seems a lot more complex.
> 
> Good point. My solution is simple elegant and wrong.

Then here is a patch.  It is against 2.2.10pre2, but I suspect it will
apply to other versions.  I make no claim for its elegance, etc, but it
works for me.  If anyone thinks of a better one, that would be nice.

The other arches should probably adopt similar changes.  I don't know
enough about anything but Intel to do it.

--- arch/i386/kernel/ptrace.c.bak       Mon Jun  7 13:37:01 1999
+++ arch/i386/kernel/ptrace.c   Tue Jun  8 17:51:36 1999
@@ -675,11 +675,14 @@
        return ret;
 }
 
-asmlinkage void syscall_trace(void)
+asmlinkage void syscall_trace(int unused)
 {
+       struct pt_regs *regs = (struct pt_regs *) &unused;
        if ((current->flags & (PF_PTRACED|PF_TRACESYS))
                        != (PF_PTRACED|PF_TRACESYS))
                return;
+       if (!user_mode(regs))
+               return; /* Don't trace the kernel's syscalls */
        current->exit_code = SIGTRAP;
        current->state = TASK_STOPPED;
        notify_parent(current, SIGCHLD);

-- 

Nate Eldredge
nate@cartsys.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
