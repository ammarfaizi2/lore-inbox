Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTBPTR4>; Sun, 16 Feb 2003 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbTBPTR4>; Sun, 16 Feb 2003 14:17:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267337AbTBPTR4>; Sun, 16 Feb 2003 14:17:56 -0500
Date: Sun, 16 Feb 2003 11:24:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <27100000.1045423143@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302161119020.2952-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Martin J. Bligh wrote:
>
> task_lock nests *inside* tasklist_lock but ... :

Yeah, this is a problem with any signal, not just SAK.

In fact, in general it is always _wrong_ to nest a non-interrupt-safe 
lock inside an interrupt-safe spinlock, because then you can never take 
the non-interrupt-safe one on its own (because an interrupt may come in 
and take the interrupt-safe lock, at which point that CPU has now 
violated ordering). 

And if you always nest the interrupt-unsafee one inside the interrupt- 
safe one, you might as well not have the interrupt-unsafe one in the first 
place, since the outer lock _always_ protects the code in question anyway.

Which implies that either
 - the task lock should be _outside_ the tasklist_lock
or
 - the task lock should be made interrupt-safe.

If we make the tasklock one interrupt-safe, that should fix the signal
issue, and we can use the tasklock to protect "task->signal" and 
"task->sighand". 

In short, everything really seems to be pointing that way: the current
task lock simply _is_ broken, and has apparently always been broken (but
the ABBA deadlock is just extremely rare in practice, since you have to
get an interrupt at just the right point on one CPU, while you have the AB
case on another).

		Linus

