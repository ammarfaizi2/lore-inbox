Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbREZX4p>; Sat, 26 May 2001 19:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbREZX4Z>; Sat, 26 May 2001 19:56:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14978 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262176AbREZX4Q>;
	Sat, 26 May 2001 19:56:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15120.16986.610478.279574@pizda.ninka.net>
Date: Sat, 26 May 2001 16:55:06 -0700 (PDT)
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar writes:
 > (unlike bottom halves, soft-IRQs do not preempt kernel code.)
 ...

Since when do we have this rule? :-)

 > the two error cases are:
 > 
 >  #1 hard-IRQ interrupts user-space code, activates softirq, and returns to
 >     user-space code
 > 
 >  #2 hard-IRQ interrupts the idle task, activates softirq and returns to
 >     the idle task.
 > 
 > category #1 is easy to fix, in entry.S we have to check active softirqs
 > not only the exception and ret-from-syscall cases, but also in the
 > IRQ-ret-to-userspace case.
 > 
 > category #2 is subtle, because the idle process is kernel code, so
 > returning to it we do not execute active softirqs. The main two types of
 > idle handlers both had a window do 'miss' softirq execution:

Ingo, I don't think this is the fix.

You should check Softirqs on return from every single IRQ.
In do_softirq() it will make sure that we won't run softirqs
while already doing so or being already nested in a hard-IRQ.

Every port works this way, I don't know where you got this "soft-IRQs
cannot run when returning to kernel code" rule, it simply doesn't
exist.

And looking at the x86 code, I don't even understand how your fixes
can make a difference, what about the do_softirq() call in
arch/i386/kernel/irq.c:do_IRQ()???  That should be taking care of all
these "error cases" right?

Later,
David S. Miller
davem@redhat.com
