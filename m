Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288686AbSA3HAg>; Wed, 30 Jan 2002 02:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSA3HAR>; Wed, 30 Jan 2002 02:00:17 -0500
Received: from waste.org ([209.173.204.2]:50322 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288686AbSA3HAI>;
	Wed, 30 Jan 2002 02:00:08 -0500
Date: Wed, 30 Jan 2002 01:00:04 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: <E16Vir4-0005rs-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0201292328530.25123-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0201291813110.25443-100000@waste.org> you write:
>
> > Nearly as good would be replacing the current logic for figuring out the
> > current processor id through current with logic to access the per-cpu
> > data. The primary use of that id is indexing that data anyway.
>
> And if you'd been reading this thread, you would have already seen
> this idea, and if you'd read the x86 code, you'd have realised that
> the tradeoff is arch-specific.

This 'thread' as you call it began with the message I replied to. Nor can
I find any other reference to the idea on recent threads relating to
per_cpu on this list.

Looking closer, I've found an issue with your patch related to the above,
so I think it bears closer examination. The common case is of course to
access data for the current CPU, either by dedicated register on non-x86
as you've mentioned, or a scheme like I proposed, which works out
something like this:

#define per_cpu_offset(cpu) (current->per_cpu_offset)
#define smp_processor_id() (per_cpu(current_processor_id,0))

The problem is that either of these schemes don't let you get at the data
on anything but the current processor, because per_cpu would be per-force
ignoring its CPU argument to actually take advantage of the convenient
pointer/register. What is needed is an additional this_cpu interface that
looks generically something like this:

#define this_cpu(var)
(*(__typeof__(&var)((void *)&var + per_cpu_offset(smp_processor_id()))))

and on x86 something like this:

#define this_cpu(var)
(*(__typeof__(&var)((void *)&var + current->per_cpu_offset)))
#define smp_processor_id() (this_cpu(current_processor_id))

I suspect in practice the lack of a this_cpu style interface would be a
great nuisance, given that it's _the common case by definition_. Reviewing
the other arches in the main tree, going through current seems to _always_
be better than indexing __per_cpu_offset for the common case because all
arches except SPARC look in current for the processor id and SPARC already
has a register for current. And there have been various suggestions for
fitting current into special registers on x86 as well.

(While it's obviously possible to extend the task struct to hold both the
offset and the processor id, it seems that the main use of the
smp_processor_id is looking up per-cpu data and that it should largely
disappear once a per_cpu/this_cpu framework is in use. And updating both
on moving between processors would then seem pointless.)

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

