Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCWGuP>; Fri, 23 Mar 2001 01:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRCWGuF>; Fri, 23 Mar 2001 01:50:05 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:27399 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129679AbRCWGuE>; Fri, 23 Mar 2001 01:50:04 -0500
To: paulus@samba.org, torvalds@transmeta.com (Linus Torvalds)
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
	<15027.20462.682109.679714@argo.linuxcare.com.au>
	<vbasnkblsvd.fsf@mozart.stat.wisc.edu>
	<15034.53871.560040.366149@argo.linuxcare.com.au>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Paul Mackerras's message of "Fri, 23 Mar 2001 15:34:55 +1100 (EST)"
Date: 23 Mar 2001 00:49:16 -0600
Message-ID: <vbalmpxyo7n.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:
> 
> I didn't realize you were talking about linux 2.4.0 and pppd 2.3.11.

That was my stupid oversight.  I carefully tested and retested the
patch under 2.4.0-test5, then ported it to 2.4.2 and sent it off with
only a cursory check using the new pppd [smack forehead here].

> > In particular, the comment above "ppp_asynctty_close" is misleading.
> > It's true that the TTY layer won't call any further line discipline
> > entries while the "close" is executing; however, there may be
> > processes already sleeping in line discipline functions called before
> > the hangup.  For example, "ppp_asynctty_close" could be called while
> > we sleep in the "get_user" in "ppp_channel_ioctl" (called from
> > "ppp_asynctty_ioctl").  Therefore, calling "PPPIOCATTACH" on an
> > unattached PPP-disciplined TTY could, in unlikely circumstances
> > (argument swapped out), lead to a crash.
> 
> Yuck.  I don't see that we can protect against this without having
> some sort of lock in the tty structure, though.  We can't protect the
> existence of the channel structure with a lock inside that structure.
> Ideally the necessary protection would be provided at the tty level.

Well, the closer I look at line discipline locking the less I think I
understand it.  I can't even see what prevents an "ldisc.close"
function from being called when an "ldisc.open" is sleeping on a
memory allocation.

Can someone help me understand?

When changing line disciplines, "sys_ioctl" gets the big kernel lock
for us, and the "tty_set_ldisc" function doesn't get any additional
locks.  It just calls the line discipline "open" function.

Suppose, at this point, the modem hangs up.  From a hardware
interrupt, "tty_hangup" is called which schedule_tasks the tq_hangup
routine, "do_tty_hangup".

Now, suppose the line discipline "open" function doesn't do any
special locking and has a harmless-looking "kmalloc" that isn't
GPF_ATOMIC.  It falls asleep and gives up the big kernel lock!!

Now, the eventd kernel thread wakes up and runs "do_tty_hangup".
"do_tty_hangup" has no trouble getting the big kernel lock and running
the "flush_buffer", "write_wakeup", and "close" line discipline
function on the half-initialized line discipline all with no further
locking.  In a naive implementation, "close" would start freeing the
same kernel structures that "open" hasn't had a chance to allocate!
And, now, "open" is free to wake up and try allocating structures for
a line discipline that has already been shutdown from the TTY.

Does this mean that all line discipline implementations must use a
spinlock around critical code in "open", "close", and every other line
discipline function?  It looks like they must, and it looks like most
don't right now.

Maybe I'm just overlooking something obvious.

> >                                                            Can we
> > eliminate "ppp_channel_ioctl" from "ppp_async.c" entirely, as in the
> > patch below?  We're requiring people to upgrade to "pppd" 2.4.0
> > anyway, and it has no need for these calls.  This would give me a warm,
> > fuzzy feeling.
> 
> Sure, that would be fine.  I'll make up a patch and send it to Linus.

Thank you.

Kevin <buhr@stat.wisc.edu>
