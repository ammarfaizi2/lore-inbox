Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbSAMPVg>; Sun, 13 Jan 2002 10:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285745AbSAMPV0>; Sun, 13 Jan 2002 10:21:26 -0500
Received: from mx2.elte.hu ([157.181.151.9]:54146 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285709AbSAMPVT>;
	Sun, 13 Jan 2002 10:21:19 -0500
Date: Sun, 13 Jan 2002 18:18:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H5
In-Reply-To: <20020111091744.B1170@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0201131811460.5353-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Mike Kravetz wrote:

>         reacquire_kernel_lock(current);
>         if (unlikely(current->need_resched))
>                 goto need_resched_back;
>         return;
>
> The question is why do we reacquire the kernel lock before checking
> for need_resched?.  If it is not needed, we can save a lock/unlock
> cycle in the case of need_resched.

that code is something i discovered when trying to reduce scheduling
latencies for the very first lowlatency patchset i released. Back then,
1-2-3 years ago, kernel_lock usage was still common in the kernel. So it
often happened that tasks were spending more than 1 msec spinning for the
kernel lock, and often they did that in the reacquire code. So to reduce
latencies, i've added ->need_resched checking to kernel_lock() and
reacquire_kernel_lock() as well.

these days kernel_lock contention doesnt happen all that often, so i think
we should remove it from the 2.5 tree. I consider the preemptible kernel
patch to be the most advanced method to get low scheduling-latencies
anyway.

> This code isn't new with the O(1) scheduler, so I'm guessing there is
> a need to hold the kernel_lock when checking need_resched.  I just
> don't know what it is.

there is no need for it to be under the kernel_lock - i simply found it to
be an easy and common preemption point.

	Ingo

