Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132809AbRDDMxm>; Wed, 4 Apr 2001 08:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132810AbRDDMxW>; Wed, 4 Apr 2001 08:53:22 -0400
Received: from chiara.elte.hu ([157.181.150.200]:34572 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132809AbRDDMxL>;
	Wed, 4 Apr 2001 08:53:11 -0400
Date: Wed, 4 Apr 2001 13:51:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <3ACA6BF4.9A3F93A2@chromium.com>
Message-ID: <Pine.LNX.4.30.0104041338020.4611-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Apr 2001, Fabio Riccardi wrote:

> I agree that a better threading model would surely help in a web
> server, but to me this is not an excuse to live up with a broken
> scheduler.

believe me, there are many other parts of the kernel that are not
optimized for the nutcase. In this case it's the scheduler that punishes
you first. Do not shoot the messenger.

> The X15 server I'm working on now is a sort of user-space TUX, it uses
> only 8 threads per CPU and it achieves the same level of performance
> of the kernel space TUX. Even in this case the performance advantage
> of the multiqueue scheduler is remarkable, especially on a multi-CPU
> (> 2) architecture.

then your design is still bad. TUX has no problems with the scheduler, and
TUX doesnt have many runnable processes at once. And this has nothing to
do with TUX being within the kernel.

> To achieve some decent disk/CPU/network overlapping with the current
> linux blocking disk IO limitations there is no way to avoid a "bunch
> of server threads". [...]

false.

> [...] I've (experimentally) figured out that 8-16 threads per CPU can
> assure some reasonable overlapping, depending on the memory size and
> disk subsystem speed. On a 8-way machine this means 64-128 active
> tasks, [...]

if they are doing IO *only* then there wont be 64-128 active tasks. This
is how TUX does async IO: helper threads do the IO and *only* the IO. This
way cache locality is maximized. (the scheduler is irrelevant in this
case.) Again you are blaming the scheduler - the poor scheduler is simply
the first kernel subsystem that tells you: your design still sucks. (if
you have 64-128 active tasks then you already pay a very big cache
footprint price as well.) [I'm wondering how your solution was just as
fast as TUX, although you claim that the scheduler was already killing
things. Perhaps your test was done over localhost or was saturating
network bandwidth?]

> Unless we want to maintain the position tha the only way to achieve
> good performance is to embed server applications in the kernel, [...]

FYI, TUX related functionality is constantly being pushed out and made
accessible to userspace as well. Witness zerocopy, IRQ-affinity, and tons
of generic patches such as pagecache-scalability and timer-scalability.
(and soon the remaining, TUX-private improvements too.) TUX is intended to
be a testbed for kernel subsystems, where performance optimizations and
APIs can be tested without having to export them to userspace. (exporting
to userspace cannot be done lightly and makes things less flexible.)

	Ingo

