Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155120AbPG3V6x>; Fri, 30 Jul 1999 17:58:53 -0400
Received: by vger.rutgers.edu id <S154754AbPG3Vyh>; Fri, 30 Jul 1999 17:54:37 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:15769 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S155203AbPG3Vmi>; Fri, 30 Jul 1999 17:42:38 -0400
Date: Fri, 30 Jul 1999 14:36:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Mosberger <davidm@hpl.hp.com>
cc: Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: Re: active_mm
In-Reply-To: <199907302050.NAA24558@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.10.9907301410280.752-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



Cc'd to linux-kernel, because I don't write explanations all that often,
and when I do I feel better about more people reading them.

On Fri, 30 Jul 1999, David Mosberger wrote:
> 
> Is there a brief description someplace on how "mm" vs. "active_mm" in
> the task_struct are supposed to be used?  (My apologies if this was
> discussed on the mailing lists---I just returned from vacation and
> wasn't able to follow linux-kernel for a while).

Basically, the new setup is:

 - we have "real address spaces" and "anonymous address spaces". The
   difference is that an anonymous address space doesn't care about the
   user-level page tables at all, so when we do a context switch into an
   anonymous address space we just leave the previous address space
   active.

   The obvious use for a "anonymous address space" is any thread that
   doesn't need any user mappings - all kernel threads basically fall into
   this category, but even "real" threads can temporarily say that for
   some amount of time they are not going to be interested in user space,
   and that the scheduler might as well try to avoid wasting time on
   switching the VM state around. Currently only the old-style bdflush
   sync does that.

 - "tsk->mm" points to the "real address space". For an anonymous process,
   tsk->mm will be NULL, for the logical reason that an anonymous process
   really doesn't _have_ a real address space at all.

 - however, we obviously need to keep track of which address space we
   "stole" for such an anonymous user. For that, we have "tsk->active_mm",
   which shows what the currently active address space is.

   The rule is that for a process with a real address space (ie tsk->mm is
   non-NULL) the active_mm obviously always has to be the same as the real
   one.

   For a anonymous process, tsk->mm == NULL, and tsk->active_mm is the
   "borrowed" mm while the anonymous process is running. When the
   anonymous process gets scheduled away, the borrowed address space is
   returned and cleared.

To support all that, the "struct mm_struct" now has two counters: a
"mm_users" counter that is how many "real address space users" there are,
and a "mm_count" counter that is the number of "lazy" users (ie anonymous
users) plus one if there are any real users.

Usually there is at least one real user, but it could be that the real
user exited on another CPU while a lazy user was still active, so you do
actually get cases where you have a address space that is _only_ used by
lazy users. That is often a short-lived state, because once that thread
gets scheduled away in favour of a real thread, the "zombie" mm gets
released because "mm_users" becomes zero.

Also, a new rule is that _nobody_ ever has "init_mm" as a real MM any
more. "init_mm" should be considered just a "lazy context when no other
context is available", and in fact it is mainly used just at bootup when
no real VM has yet been created. So code that used to check

	if (current->mm == &init_mm)

should generally just do

	if (!current->mm)

instead (which makes more sense anyway - the test is basically one of "do
we have a user context", and is generally done by the page fault handler 
and things like that).

Anyway, I put a pre-patch-2.3.13-1 on ftp.kernel.org just a moment ago,
because it slightly changes the interfaces to accomodate the alpha (who
would have thought it, but the alpha actually ends up having one of the
ugliest context switch codes - unlike the other architectures where the MM
and register state is separate, the alpha PALcode joins the two, and you
need to switch both together).

> Also, I saw reference to threads being "more soft".  I'm not sure what
> this is referring to.  Perhaps it's related to the changes on how
> segment registers are being managed on x86 now?

It's more a reaction to a (temporary and already removed) naming issue.
Ingo got rid of the 1:1 mapping of "hard" thread structures on the x86
side, so now we only have one TSS per CPU, and all the kernel thread
structures are completely independent of the CPU-imposed thread structure
on x86. 

While Ingo was working on it, he called the kernel thread structure a
"soft_thread_struct", while the intel TSS structure was then called a
"hard_thread_struct". That was purely temporary and never saw the light of
day: the real names are "thread_struct" for the kernel thread structure,
and "tss_struct" for the intel TSS.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
