Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUDVUvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUDVUvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUDVUvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:51:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264671AbUDVUua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:50:30 -0400
Date: Thu, 22 Apr 2004 16:50:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Al Niessner <Al.Niessner@jpl.nasa.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: atomic_t and atomic_inc
In-Reply-To: <1082660320.28900.193.camel@morte.jpl.nasa.gov>
Message-ID: <Pine.LNX.4.53.0404221641120.940@chaos>
References: <1082660320.28900.193.camel@morte.jpl.nasa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Al Niessner wrote:

>
> First, I am not subscribed to this list so please reply to me directly
> if you wish a timely response to any questions. In any case, I will lurk
> in the archives for responses.
>
> I am using atomic_t to count interrupts from some piece of hardware.
> These interrupts come at a fairly high rate -- 10 KHz and higher. The
> problem is, will I get increment problem at the limit of atomic_t or
> will it wrap around without error? I read the docs (man pages, on-line
> api docs, this list and other stuff) and none of them talk about the
> behavior of atomic_t at the boundaries. Furthermore, am I guaranteed of
> any boundary behavior across platforms?
>
> Thank you in advance for any and all help.

Type atomic_t is an integer that can be accessed in memory
with an uninterruptible instruction. This limits the atomic_t
type in 32-bit machines to 32-bits, in 64-bit machines to 64-bits,
etc. It has nothing to do with wrap-around. If you increment
0xffffffff it becomes 0 even it it's an atomic type.

In an ISR, the code won't be interrupted until you enable interrupts,
which you shouldn't do anyway. This means that even non-atomic types
are safe, even in SMP machines if the increment is after a spin-lock.

So, you can use 'long long' types for interrupt counters and no
information will be lost until you wrap 0xffffffffffffffff, which
will take quite some time. The problem remains, however, in
reading this value. You need to either read it under a spinlock
or read several times until you get the same value twice in a row.

Spin-locks are easier.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


