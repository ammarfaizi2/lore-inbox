Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWKFBrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWKFBrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423231AbWKFBrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 20:47:47 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:31408 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1423223AbWKFBrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 20:47:47 -0500
Date: Mon, 6 Nov 2006 02:47:46 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
In-Reply-To: <787b0d920611050802o460a4000r5ce154e589732a02@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611060237570.16390@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com> 
 <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
 <787b0d920611050802o460a4000r5ce154e589732a02@mail.gmail.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Albert Cahalan wrote:

> On 11/4/06, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>> >> Does one Linux kernel run on system with 1024 cpus? I guess it
>> >> must fry spinlocks... (or even lockup due to spinlock livelocks)
>> >
>> > The SGI Altix can have 2048 CPUs.
>> 
>> And does it run one image of Linux? Or more images each on few cpus?
>
> Yes, of course it runs one image of Linux. It's SMP, not a cluster.
> If I remember right:
>
> 2 CPUs per chip
> 2 chips per board (with local RAM; this is NUMA)
> 512 boards per machine
>
>> How do they solve problem with spinlock livelocks?
>> 
>> If time-spent-outside-spinlock/time-spent-in-spinlock < number-of-cpus,
>> the spinlock livelock may happen --- this condition is not true normally
>> with 2 or 4 cpus, but for that high amount of cpus, there is a danger.
>> 
>> Or do they have some special hardware spinlock instruction that guarantees
>> fairness?
>
> Well first of all it's using IA-64 processors. These do atomic operations
> via instructions that are essentially "take lock" and "release lock".
> The non-CPU hardware probably recognizes these operations by the
> special bus cycles and does whatever is needed to ensure fairness.

It looks like a normal looping spinlock with rep nop and cmpxchg on i386. 
Not that I understand IA64 assembler --- but look at 
ia64_spinlock_contention --- it looks like a loop with pause and nonatomic 
test and a branch to acquire spinlock atomically with cmpxchg --- nothing 
that would prevent starving there.

> Second of all, I think we just try to avoid having long spinlock hold
> times. The SGI people love using RCU. As I recall, SGI also caused
> Linux to get a sequence lock for jiffies.

That is right, that you should avoid contention --- but the kernel should 
be stable no matter what userspace programs you run. Or does it mean that 
scientists can run only trusted programs on Altix that do not perform too 
many certain syscalls concurently in order to not jam spinlocks?

Mikulas
