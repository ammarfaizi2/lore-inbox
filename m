Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312490AbSCYSyR>; Mon, 25 Mar 2002 13:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSCYSyI>; Mon, 25 Mar 2002 13:54:08 -0500
Received: from stat8.steeleye.com ([63.113.59.41]:64519 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S312490AbSCYSx4>; Mon, 25 Mar 2002 13:53:56 -0500
Date: Mon, 25 Mar 2002 13:52:39 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Paul Clements <Paul.Clements@steeleye.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix
 resync  counter errors
In-Reply-To: <15518.22081.287786.88466@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10203251333490.5915-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

Thanks for your feedback. Replies below...

--
Paul Clements
SteelEye Technology
Paul.Clements@SteelEye.com


On Mon, 25 Mar 2002, Neil Brown wrote:

> On Friday March 22, Paul.Clements@SteelEye.com wrote:
> > 
> > The problems are, briefly:
> > 
> > 1) overuse of device_lock spin lock 
> > 
> > The device_lock was being used for two separate, unrelated purposes.
> > This was causing too much contention and caused a deadlock in one case.
> > The device_lock will be split into two separate locks by introducing a
> > new spin lock, "memory_lock".
> 
> I can believe that there could be extra contention because of the dual
> use of this spin lock.  Do you have lockmeter numbers at all?

No, I'm not familiar with that. How do I get those? Is it fairly simple?

I wasn't so much concerned about extra contention as the (in my mind) 
logical separation of these two different tasks, and the fact that 
the lack of separation had led to a deadlock.


> However I cannot see how it would cause a deadlock.  Could you please
> give details?

raid1_diskop() calls close_sync() -- close_sync() schedules itself out
to wait for pending I/O to quiesce so that the resync can end... 
meanwhile #CPUs (in my case, 2) tasks enter into any of the memory 
(de)allocation routines and spin on the device_lock forever...

> > 
> > 2) non-atomic memory allocation
> > 
> > Due to use of GFP_KERNEL rather than GFP_ATOMIC, certain threads of the
> > raid1 driver were scheduled out while holding a spin lock, causing a
> > deadlock to occur. Memory allocation during critical sections where a
> > spin lock is held will be changed to atomic allocations.
> 
> You are definately right that we should not be calling kmalloc with a
> spinlock held - my bad.
> However I don't think your fix is ideal.  The relevant code is
> "raid1_grow_buffers" which allocates a bunch of buffers and attaches
> them to the device structure.
> The lock is only realy needed for the attachment.  A better fix would
> be to build a separate list, and then just claim the lock while
> attaching that list to the structure.

Unfortunately, this won't work, because the segment_lock is also held
while this code is executing (see raid1_sync_request).

 
> > 
> > 3) incorrect enabling/disabling of interrupts during locking
> > 
> > In several cases, the wrong spin_lock* macros were being used. There
> > were a few cases where the irqsave/irqrestore versions of the macros
> > were needed, but were not used. The symptom of these problems was that
> > interrupts were enabled or disabled at inappropriate times, resulting in
> > deadlocks.
> 
> I don't believe that this is true.
> The save/restore versions are only needed if the code might be called
> from interrupt context.  However the routines where you made this
> change: raid1_grow_buffers, raid1_shrink_buffers, close_sync, 
> are only ever called from process context, with interrupts enabled.
> Or am I missing something?

please see my other e-mail reply to Andrew Morton regarding this...

 
> > 
> > 4) incorrect setting of conf->cnt_future and conf->phase resync counters
> > 
> > The symptoms of this problem were that, if I/O was occurring when a
> > resync ended (or was aborted), the resync would hang and never complete.
> > This eventually would cause all I/O to the md device to hang.
> 
> I'll have to look at this one a bit more closely.  I'll let you know 
> what I think of it.

OK. If you come up with something better, please let me know.

