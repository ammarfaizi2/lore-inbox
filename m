Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbTEWX5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbTEWX5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:57:04 -0400
Received: from palrel13.hp.com ([156.153.255.238]:13988 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264204AbTEWX5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:57:02 -0400
Message-ID: <75A9FEBA25015040A761C1F74975667D01442107@hplex4.hpl.hp.com>
From: "Boehm, Hans" <hans_boehm@hp.com>
To: "'Davide Libenzi'" <davidel@xmailserver.org>,
       "Boehm, Hans" <hans_boehm@hp.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
Date: Fri, 23 May 2003 17:10:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pthread_spin_lock() under the NPTL version in RH9 does basically what my custom locks do in the uncontested case, aside from the function call.  But remember that this began with a discussion about whether it was reasonable for user locking code to explicitly yield rather than relying on pthreads to suspend the thread.  I don't think pthread_spin_lock is relevant in this context, for two reasons:

1) At least the RH9 version of pthread_spin_lock in NPTL literally spins and makes no attempt to yield or block.  This only makes sense at user level if you are 100% certain that the processors won't be overcommitted.  Otherwise there is little to be lost by blocking once you have spun for sufficiently long.  You could use pthread_spin_trylock and block explicitly, but that gets us back to custom blocking code.

2) AFAICT, pthread_spin_lock is currently a little too bleeding edge to be widely used.  I tried to time it, but failed.  Pthread.h doesn't include the declaration for pthread_spin_lock_t by default, at least not yet.  It doesn't seem to have a Linux man page, yet.  I tried to define the magic macro to get it declared, but that broke something else.

Hans

> -----Original Message-----
> From: Davide Libenzi [mailto:davidel@xmailserver.org]
> Sent: Friday, May 23, 2003 11:05 AM
> To: Boehm, Hans
> Cc: 'Arjan van de Ven'; Hans Boehm; MOSBERGER, DAVID
> (HP-PaloAlto,unix3); Linux Kernel Mailing List; 
> linux-ia64@linuxia64.org
> Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
> 
> 
> On Fri, 23 May 2003, Boehm, Hans wrote:
> 
> > Sorry about the typo and misnaming for the test program.  I 
> attached the correct version that prints the right labels.
> >
> > The results I posted did not use NPTL.  (Presumably OpenMP 
> wasn't targeted at NPTL either.)  I don't think that NPTL has 
> any bearing on the underlying issues that I mentioned, though 
> path lengths are probably a bit shorter.  It should also 
> handle contention substantially better, but that wasn't tested.
> >
> > I did rerun the test case on a 900 MHz Itanium 2 machine 
> with a more recent Debian installation with NPTL.  I get 
> 200msecs (20nsecs/iter) with the custom lock, and 768 for 
> pthreads.  (With static linking that decreases to 658 for 
> pthreads.)  Pthreads (and/or some of the other 
> infrastructure) is clearly getting better, but I don't think 
> the difference will disappear.
> 
> To make things more fair you should test against pthread 
> spinlocks. Also,
> for tight loops like that, even an extra call deep level 
> (that pthread is
> likely to do) is going to matter.
> 
> 
> 
> - Davide
> 
