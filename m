Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292407AbSCICNd>; Fri, 8 Mar 2002 21:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292408AbSCICNO>; Fri, 8 Mar 2002 21:13:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34316 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292407AbSCICNE>; Fri, 8 Mar 2002 21:13:04 -0500
Date: Fri, 8 Mar 2002 18:12:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020308235510.EBDF83FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.33.0203081802540.5197-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, Hubertus Franke wrote:
> >
> > The point being that the difference between a "decl" and a "lock ;  decl"
> > is about 1:12 or so in performance.
>
> I am no expert in architecture, but if its done through the cache coherency 
> mechanism, the overhead shouldn't be 12:1. You simply mark the cache line as 
> part of you instruction to avoid a cache line transfer. How can that be 12 
> times slower.  .. Ready to be educated....

A lock in a SMP system also needs to synchronize the instruction stream,
and not let stores move "out" from the locked region.

On a UP system, this all happens automatically (well, getting it to happen
right is obviously one of the big issues in an out-of-order CPU core, but
it's a very fundamental part of the core, so it's "free" in the sense that
if it isn't done, the CPU simply doesn't work).

On SMP, it's a memory barrier. This is why a "lock ; decl" is more
expensive than a "decl" - it's the implied memory ordering constraints (on
other architectures they are explicit). On an intel CPU, this basically
means that the pipeline is drained, so a locked instruction takes roughly
12 cycles on a PPro core (AMD's K7 core seems to be rather more graceful
about this one). I haven't timed a P4 lately, I think it's worse.

Other architectures do the memory ordering explicitly, and some are
better, some are worse. But it always costs you _something_.

		Linus

