Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317758AbSFLSai>; Wed, 12 Jun 2002 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317760AbSFLSag>; Wed, 12 Jun 2002 14:30:36 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:56513 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317758AbSFLSaS> convert rfc822-to-8bit; Wed, 12 Jun 2002 14:30:18 -0400
Message-ID: <3D0793B4.EABB4DFE@austin.ibm.com>
Date: Wed, 12 Jun 2002 13:32:20 -0500
From: Saurabh Desai <ausdesai@yahoo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D0776EE.4040701@loewe-komp.de> <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 12 Jun 2002, Peter Wächtler wrote:
> >
> > For the uncontended case: their is no blocked process...
> 
> Wrong.
> 
> The process that holds the lock can die _before_ it gets contended.
> 
> When another thread comes in, it now is contended, but the kernel doesn't
> know about anything.
> 
> > One (or more) process is blocked in a waitqueue in the kernel - waiting
> > for a futex to be released.
> >
> > The lock holder crashes - say with SIGSEGV.
> 
> The lock holder may have crashed long before the waiting process even
> started waiting.

	Is it possible to check whether the holder process exist before
start waiting? may be in user-space? 

> 
> Besides, the kernel only knows about those processes that see contention.
> Even if the contention happened _before_ the lock holder crashed, the
> kernel doesn't know about the lock holder itself - it only knows about the
> process that caused the contention. The kernel will get to know about the
> lock holder only when it tris to resolve the contention, and since that
> one has crashed, that will never happen.

	Just curious: is there anything to register a cleanup handler
when a process holds a lock, so when that goes away, run the cleanup and
wakeup all waiters?
 
> 
> > I know that the kernel can't do anything about the aborted critical section.
> > But the waiters should be "freed" - and now we can discuss if we kill them
> > or report an error and let them deal with that.
> 
> The waiters should absolutely _not_ be freed. There's nothign they can do
> about it. The data inside the critical region is no longer valid, and
> 
> > Can't be done? I don't think that this would add a performance hit
> > since it's only done on exit (and especially "abnormal" exit).
> 
> But the point is not that it would be a performance hit on "exit()", but
> that WE DON'T TRACK THE LOCKS in the kernel in the first place.
> 
> Right now the kernel does _zero_ work for a lock that isn't contended. It
> doesn't know _anything_ about the process that got the lock initially.
> 
> Any amount of tracking would be _extremely_ expensive. Right now getting
> an uncontended lock is about 15 CPU cycles in user space.
> 
> Tryin to tell the kernel about gettign that lock takes about 1us on a P4
> (system call overhead), ie we're talking 18000 cycles. 18 THOUSAND cycles
> minimum. Compared to the current 15 cycles. That's more than three orders
> of magnitude slower than the current code, and you just lost the whole
> point of doing this all in user space in the first place.
> 
>                 Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
