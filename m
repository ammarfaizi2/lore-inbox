Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVDBWTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDBWTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVDBWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:17:29 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:8082 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261308AbVDBWPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:15:55 -0500
Subject: Re: kernel stack size
From: Steven Rostedt <rostedt@goodmis.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <424EFD2A.6060305@colorfullife.com>
References: <424EFD2A.6060305@colorfullife.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 02 Apr 2005 17:15:32 -0500
Message-Id: <1112480132.27149.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 22:14 +0200, Manfred Spraul wrote:
> Steven Rostedt wrote:
> 
> >I admit you really need to know what you're doing to use this method. If
> >I believe that a kmalloc would be too expensive, then I use the locking
> >of static variables. But each situation is different and I try to use
> >the best method for the occasion.
> >  
> >
> Have you benchmarked your own memory manager?
> kmalloc(1024, GFP_KERNEL) is something like 17 instructions on i386 
> uniprocessor.

Where did you get that? I'm looking at the assembly of it right now and
it's much larger than 17 instructions. Not to mention that it calls the
slab functions which might have to invoke the buddy system.

Also, I don't use my own memory manager. My memory manager would be the
statically allocated globals (allocated automatically when the kernel
loads at boot up) and spin_locks (which are much smaller than kmalloc)
or sems. Now if kmalloc didn't have a free slab available, and needed to
go to the buddy list, this gets expensive, especially if you have to
contend with other processes doing the same.

With the static global variable method, you only have to worry about
processes (and interrupts) that are contending for your data. This can
be very efficient, especially if the data IS shared with an interrupt
handler. And if you want to be more efficient, just use the normal
spin_lock after disabling just your interrupt. Now you don't stop other
interrupts coming in, and still can work with your own global data. 

Since the original poster was talking about local data, and I'm talking
about global, I sometimes use global variables for just local use, but
you need to lock the data so that on SMP, or PREEMPT you don't worry
about reentry.  I haven't clocked the speed of sem compared to kmalloc.
But I would think that the sem functions are still quicker.

Like I mentioned before, each case is different.  I do use kmalloc when
I find that there will be too much contention with the data, or that I
would need to lock the data for long periods of time. Then again, a sem
may work too.

-- Steve


