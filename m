Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311907AbSCXWk3>; Sun, 24 Mar 2002 17:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312093AbSCXWkU>; Sun, 24 Mar 2002 17:40:20 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2184 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S311907AbSCXWkE>; Sun, 24 Mar 2002 17:40:04 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul Clements <Paul.Clements@SteelEye.com>
Date: Mon, 25 Mar 2002 09:42:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15518.22081.287786.88466@notabene.cse.unsw.edu.au>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 raid1 - fix SMP locking/interrupt errors, fix resync 
 counter errors
In-Reply-To: message from Paul Clements on Friday March 22
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 22, Paul.Clements@SteelEye.com wrote:
> 
> The following patch addresses several critical problems in the raid1
> driver. Please apply.

I would have thought that the "please apply" request should wait until
*after* you have asked for an received comments...

>                       We've tested these patches pretty thoroughly
> against the 2.4.9-21 Red Hat kernel.

"We've tested" is a long way different to "these patches have been
around for a while, and several people have used them without
problems, and there has been independant review" which I would have
thought was the benchmark for the "stable" kernel.

>                                      The source for raid1 is nearly
> identical from 2.4.9-21 to 2.4.18. The patch is against 2.4.18. If you
> have any questions, concerns, or comments, please send them to me.
> 
......
> 
> The problems are, briefly:
> 
> 1) overuse of device_lock spin lock 
> 
> The device_lock was being used for two separate, unrelated purposes.
> This was causing too much contention and caused a deadlock in one case.
> The device_lock will be split into two separate locks by introducing a
> new spin lock, "memory_lock".

I can believe that there could be extra contention because of the dual
use of this spin lock.  Do you have lockmeter numbers at all?

However I cannot see how it would cause a deadlock.  Could you please
give details?


> 
> 2) non-atomic memory allocation
> 
> Due to use of GFP_KERNEL rather than GFP_ATOMIC, certain threads of the
> raid1 driver were scheduled out while holding a spin lock, causing a
> deadlock to occur. Memory allocation during critical sections where a
> spin lock is held will be changed to atomic allocations.

You are definately right that we should not be calling kmalloc with a
spinlock held - my bad.
However I don't think your fix is ideal.  The relevant code is
"raid1_grow_buffers" which allocates a bunch of buffers and attaches
them to the device structure.
The lock is only realy needed for the attachment.  A better fix would
be to build a separate list, and then just claim the lock while
attaching that list to the structure.

> 
> 3) incorrect enabling/disabling of interrupts during locking
> 
> In several cases, the wrong spin_lock* macros were being used. There
> were a few cases where the irqsave/irqrestore versions of the macros
> were needed, but were not used. The symptom of these problems was that
> interrupts were enabled or disabled at inappropriate times, resulting in
> deadlocks.

I don't believe that this is true.
The save/restore versions are only needed if the code might be called
from interrupt context.  However the routines where you made this
change: raid1_grow_buffers, raid1_shrink_buffers, close_sync, 
are only ever called from process context, with interrupts enabled.
Or am I missing something?


> 
> 4) incorrect setting of conf->cnt_future and conf->phase resync counters
> 
> The symptoms of this problem were that, if I/O was occurring when a
> resync ended (or was aborted), the resync would hang and never complete.
> This eventually would cause all I/O to the md device to hang.

I'll have to look at this one a bit more closely.  I'll let you know 
what I think of it.

NeilBrown
