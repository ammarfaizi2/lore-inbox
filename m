Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752918AbWKFMf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbWKFMf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbWKFMf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:35:28 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:1238 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752918AbWKFMf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:35:28 -0500
Date: Mon, 6 Nov 2006 07:35:03 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <1162803471.28571.303.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0611060732020.14553@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg>  <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
 <1162803471.28571.303.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Benjamin Herrenschmidt wrote:

>
> > Yes. On x86 (and x86-64) you'll never see this, because writes are always
> > seen in order regardless, and in addition, the spin_lock is actually
> > totally serializing anyway. On most other architectures, the spin_lock
> > will serialize all the writes too, but it's not guaranteed, so in theory
> > you're right. I suspect no actual architecture will do this, but hey,
> > when talking memory ordering, safe is a lot better than sorry.
>
> PowerPC doesn't serialize the writes on spin_lock, only on spin_unlock.
>
> (That is, previous writes can "leak" into the lock, but writes done
> before the unlock can't leak out of the spinlock).
>
> Now, I've just glanced at the thread, so I don't know if that's relevant
> to the problems you guys are talking about :-)
>

It is relevant.  In powerpc, can one write happen before another write?


  x = 1;
  barrier();  (only compiler barrier)
  b = 2;


And have CPU 2 see b=2 before seeing x=1?

If so, then I guess this is indeed a bug on powerpc.

-- Steve

