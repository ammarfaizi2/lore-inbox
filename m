Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269323AbUJKXHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269323AbUJKXHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKXHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:07:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13044 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269323AbUJKXFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:05:02 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Daniel Walker" <dwalker@mvista.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <abatyrshin@ru.mvista.com>,
       <amakarov@ru.mvista.com>, <emints@ru.mvista.com>,
       <ext-rt-dev@mvista.com>, <hzhang@ch.mvista.com>, <yyang@ch.mvista.com>,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       <arnd.heursch@unibw-muenchen.de>
Subject: RE: [ANNOUNCE] Linux 2.6 Real Time Kernel
Date: Mon, 11 Oct 2004 16:05:11 -0700
Message-ID: <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041011215420.GA19796@elte.hu>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> * Sven Dietrich <sdietrich@mvista.com> wrote:
> 
> > IMO the number of raw_spinlocks should be lower, I said teens before. 
> > 
> > Theoretically, it should only need to be around hardware registers and
> > some memory maps and cache code, plus interrupt controller and other
> > SMP-contended hardware.
> 
> yeah, fully agreed. Right now the 90 locks i have means roughly 20% of
> all locking still happens as raw spinlocks.
> 
> But, there is a 'correctness' _minimum_ set of spinlocks that _must_ be
> raw spinlocks - this i tried to map in the -T4 patch. The patch does run
> on SMP systems for example. (it was developed as an SMP kernel - in fact
> i never compiled it as UP :-|.) If code has per-CPU or preemption
> assumptions then there is no choice but to make it a raw spinlock, until
> those assumptions are fixed.
> 

The grunt work is in identifying those problem areas and coming up with 
elegant, low-impact solutions. RCU locks is one example as mentioned 
before. We had a fix to serialize RCU access, but weren't happy with that.
We were hoping to get some input on this, but these problems seem to show
up more readily on slow systems (we are also testing with a bunch of 
old P1, P2 and K6 boxes all far sub 1 GHz)

> > There are some concurrency issues in kernel threads, and I think there
> > is a lot of work here.  The abstraction for LOCK_OPS is a good
> > alternative, but like the spin_undefs, its difficult to tell in the
> > code whether you are dealing with a mutex or a spinlock. 
> 
> what do you mean by 'it's difficult to tell'? In -T4 you do the choice
> of type in the data structure and the API adapts automatically. If the
> type is raw_spinlock_t then a spin_lock() is turned into a
> _raw_spin_lock(). If the type is spinlock_t then the spin_lock() is
> redirected to mutex_lock(). It's all transparently done and always
> correct.
> 

I was making this observation:
One can't look at an arbitrary piece of code and tell if it will 
be a spinlock or a mutex. One has to go look elsewhere. 
In the spin_undefs case one can look the top of the file and check for it,
in the LOCK_OPS case, you have to call up the data structure declaration.

> > There are a whole lot of caveats and race conditions that have not yet
> > been unearthed by the brief LKML testing. [...]
> 
> actually, have you tried your patchset on an SMP box? As far as i can
> see the locking in it ignores SMP issues _completely_, which makes the
> choice of locks much less useful.
> 

We stated that its been tested minimally on SMP. That means we have
had it up and running and found it to be unstable. I fully agree that
SMP is the superset to get it working on, and that PMutex is not
perfect at this point.

We will take a look at the T5 patch and see what we can do about 
PI for the system semaphore, but I am not sure how portable it would
be without also touching the assembly. FWIW PMutex is already based
in part on the system semaphore, so we might get similar problems when 
porting elsewhere.

I think we should try and eliminate the mutex as an issue ASAP so we can 
move on to the real meat. We have spec'd some requirements in the 
rttReleaseNotes, clearly not all are being met, but we hoped to capture 
most of them.
I have copied Arndt Heursch and Witold Jaworski in Germany, maybe they 
will also have some insights.


Sven


