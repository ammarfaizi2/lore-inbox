Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129896AbRAKTpS>; Thu, 11 Jan 2001 14:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAKTpJ>; Thu, 11 Jan 2001 14:45:09 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:31758 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129896AbRAKTpC>;
	Thu, 11 Jan 2001 14:45:02 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101111938.f0BJcOt490764@saturn.cs.uml.edu>
Subject: Re: Subtle MM bug
To: sct@redhat.com (Stephen C. Tweedie)
Date: Thu, 11 Jan 2001 14:38:24 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        sct@redhat.com (Stephen C. Tweedie),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        phillips@innominate.de (Daniel Phillips), linux-kernel@vger.kernel.org
In-Reply-To: <20010111173512.M25375@redhat.com> from "Stephen C. Tweedie" at Jan 11, 2001 05:35:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
> On Thu, Jan 11, 2001 at 11:50:21AM -0500, Albert D. Cahalan wrote:
>> Stephen C. Tweedie writes:

>>> But is it really worth the pain?  I'd hate to have to audit the
>>> entire VFS to make sure that it works if another thread changes our
>>> credentials in the middle of a syscall, so we either end up having to
>>> lock the credentials over every VFS syscall, or take a copy of the
>>> credentials and pass it through every VFS internal call that we make.
>>
>> 1. each thread has a copy, and doesn't need to lock it
>
> We already have that...
>
>> 2. threads are commanded to change their own copy
>
> We already do that: that's how the current pthreads works.

I thought it was unimplemented. Even so, it is at least one
extra round trip to/from the kernel. (I'd guess trips>1)

>> Credentials could be changed on syscall exit. It is a bit like
>> doing signals I think, with less overhead than making userspace
>> muck around with signal handlers and synchronization crud.
>
> Yuck.  Far better to send a signal than to pollute the syscall exit
> path.  And what about syscalls which block indefinitely?  We _want_
> the signal so that they get woken up to do the credentials change.

The syscall exit path itself need not be polluted. Changes to
recalc_sigpending and do_signal would get the job done.
For the former, either add an extra word of kernel-internal
signal data or just check a simple flag. For do_signal, maybe
add an extra "if(foo)" at the top of the main loop. (that would
depend on what was done to recalc_sigpending)

I suppose the goodness or badness of this depends partly on how
much you are willing to pay for pthreads that are fast and correct.
People around here seem to like burying their heads in hope that
pthreads will just go away, while app developers stubbornly try to
use the API.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
