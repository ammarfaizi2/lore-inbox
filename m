Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945974AbWGOCFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbWGOCFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945976AbWGOCFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:05:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10461 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945974AbWGOCFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 22:05:10 -0400
Subject: Re: [PATCH] remove volatile from x86 cmos_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Jones <davej@redhat.com>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060714215007.GI24705@redhat.com>
References: <1152888523.27135.2.camel@localhost.localdomain>
	 <200607141653.35011.oliver@neukum.org>
	 <1152889765.27135.6.camel@localhost.localdomain>
	 <20060714215007.GI24705@redhat.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 22:04:54 -0400
Message-Id: <1152929094.27135.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 17:50 -0400, Dave Jones wrote:
> On Fri, Jul 14, 2006 at 11:09:25AM -0400, Steven Rostedt wrote:
>  > On Fri, 2006-07-14 at 16:53 +0200, Oliver Neukum wrote:
>  > > Am Freitag, 14. Juli 2006 16:48 schrieb Steven Rostedt:
>  > > > @@ -52,14 +54,16 @@ static inline void lock_cmos(unsigned ch
>  > > >  
>  > > >  static inline void unlock_cmos(void)
>  > > >  {
>  > > > -       cmos_lock = 0;
>  > > > +       set_wmb(cmos_lock, 0);
>  > > >  }
>  > > >  static inline int do_i_have_lock_cmos(void)
>  > > >  {
>  > > > +       barrier();
>  > > 
>  > > Shouldn't these be rmb() ?
>  > 
>  > I was thinking that too, but I'm still not sure when to use rmb or
>  > barrier.  wmb seems pretty straight forward though.  hmm, maybe this
>  > really should be a smb_rmb since I believe a barrier would be ok for UP.
> 
> I'm more puzzled why it's inventing its own locking primitives instead of
> using one of the many the kernel provides.  This stuff is prehistoric though.
> Hangover from the really early days ?
> 
> 		Dave
> 

Here's your answer:

from rtc.hinclude/asm-i386/mc146818rtc.h:

/*
 * This lock provides nmi access to the CMOS/RTC registers.  It has some
 * special properties.  It is owned by a CPU and stores the index register
 * currently being accessed (if owned).  The idea here is that it works
 * like a normal lock (normally).  However, in an NMI, the NMI code will
 * first check to see if its CPU owns the lock, meaning that the NMI
 * interrupted during the read/write of the device.  If it does, it goes ahead
 * and performs the access and then restores the index register.  If it does
 * not, it locks normally.
 *
 * Note that since we are working with NMIs, we need this lock even in
 * a non-SMP machine just to mark that the lock is owned.
 *
 * This only works with compare-and-swap.  There is no other way to
 * atomically claim the lock and set the owner.
 */

So it is dealing with NMIs.  Since we are dealing with a lock that can
be taken from NMI context, we can't just spin if it is locked.  We need
to check if the CPU that owns the lock is the same as the NMI CPU and if
so just go on and run, otherwise you deadlock.

So really the only thing missing here are the memory barriers since it
is not really protecting anything due to CPU reordering.

(I need to get rid of that set_wmb :P )

-- Steve


