Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTKGXWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKGWUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:20:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:40138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264386AbTKGPKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:10:41 -0500
Date: Fri, 7 Nov 2003 07:09:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Gross <mgross@linux.co.intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <Pine.LNX.4.56.0311070918310.18447@earth>
Message-ID: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Ingo Molnar wrote:
> On Thu, 6 Nov 2003, Linus Torvalds wrote:
> 
> > So I've got a feeling that 
> >  - we should remove the "kick" argument from "try_to_wake_up()"
> >  - the signal wakeup case should instead do a _regular_ wakeup.
> >  - we should kick the process if the wakeup _fails_.
> 
> agreed - and this essential mechanism was my intention when i added the
> kick argument originally. The problem is solved the simplest way via the
> patch below - ie. i missed the other !success branch within
> try_to_wake_up().

The thing is, that simple patch does NOT solve the problem, as Mark
already noted. Why? Because while it makes "try_to_waker_up()" do the
rigth thing, it doesn't make "wake_up_process_kick()" do the right thing.

The "mask" argument isn't supported by "wake_up_process_kick()", so the
_caller_ has to do

	if (mask & state)
		wake_up_process_kick()

so now you have _another_ case where the kicking isn't done (in the 
caller).

That's why I think the whole interface is scrogged, and why the "simpler" 
patch is not very workable.

> but i fully agree with your other suggestion - there's no problem with
> sending the IPI later and outside of the wakeup spinlock. In fact doing so
> removes a variable from the wakeup hotpath and cleans up stuff. Hence i'd
> suggest to apply the attached patch which implements your suggestion. I've
> tested it and it solves the latency problem of the code Mark posted. It
> compiles & boots on both UP and SMP x86.

This seems to work for me, and I obviously agree with it. I'll have to 
think for a bit whether I can call this an important enough bug to care 
for 2.6.0, since it's only a performance regression. 

(It _looks_ obvious enough, but can you check that there are no pointers
that we might be following in the "is it running" checks that could be
stale because we don't hold the runqueue lock any more).

			Linus

