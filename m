Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129740AbQK2HrN>; Wed, 29 Nov 2000 02:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130272AbQK2HrD>; Wed, 29 Nov 2000 02:47:03 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:61154 "EHLO
        horus.its.uow.edu.au") by vger.kernel.org with ESMTP
        id <S129414AbQK2Hq6>; Wed, 29 Nov 2000 02:46:58 -0500
Message-ID: <3A24AE13.9A27C292@uow.edu.au>
Date: Wed, 29 Nov 2000 18:19:47 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOps in exec_usermodehelper
In-Reply-To: <E29780A2645@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On 29 Nov 00 at 1:53, Andrew Morton wrote:
> 
> > hmm..  Quite a few things fixed here.
> >
> > Could you please test this patch?  It's against 2.4.0-test12-pre2,
> > should be OK against test11.
> 
> I upgraded to 12-pre2 already ;-) It looks like that it works.

Yup.  It works.

> > - keventd is now capable of reaping dead children.  I will be all ears
> >   if someone can tell me how to get a kernel thread to accept signals
> >   without having to install a handler with
> >
> >     sa.sa_handler = (__sighandler_t)100;
> 
> Is there any reason why not set sa.sa_handler to SIG_IGN?

Nope.  SIG_IGN works well for SIGCHLD, which is special-cased
for the reasons which you identify.  Thanks.

> According
> to arch/i386/kernel/signal.c:do_signal(), signal manpage and my memory,
> kernel does automatic child reaping in such configuration. So you
> could even remove waitpid() loop from keventd. I did not tried it yet,
> but it looks like obvious solution...

Unfortunately this doesn't work for kernel threads.

do_signal()
{
	...
        /*
         * We want the common case to go fast, which
         * is why we may in certain cases get here from
         * kernel mode. Just return without doing anything
         * if so.
         */
        if ((regs->xcs & 3) != 3)
		return 1;
	...
	<child reaping code goes here>

I suspect all the fancy signal frame assembly would blow up if it
tried to build a frame on a kernel stack.  Not sure...

do_signal() could be altered to do the reaping even for kernel
threads, but that means touching every arch and it's not The Right Way.

Similarly, the kernel thread could be reparented to init via
REMOVE_LINKS/SET_LINKS but again, I didn't want to commit a
layering violation just because proper signal and task management
for kernel threads is tricky.

> BTW, are you sure that kernel does not try to deliver SIGSEGV to
> keventd() when signal arrives. It looks like that it should, but it
> probably fails somewhere during way due to non-existent userspace for
> this process.

Well, the fault handler exception table walker will see we're running
a kernel thread and will force an oops.  Plus SIGSEGV is blocked...

> > +   sa.sa.sa_handler = (__sighandler_t)100;     /* Surely there's a better way? */
> > +   sa.sa.sa_flags = 0;
> 
> SA_RESTART?

That's handled during signal delivery.  Kernel threads don't get that
far.

> SA_NOCLDSTOP ?

Kernel threads can block SIGSTOP :)


BTW, quite a lot of the modprobe-specific stuff can probably now
be thrown away - it can use this version of call_usermodehelper().
But that's not a bug.   Next time..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
