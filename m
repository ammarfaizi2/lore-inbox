Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbRHBRov>; Thu, 2 Aug 2001 13:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRHBRob>; Thu, 2 Aug 2001 13:44:31 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:12039 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S267500AbRHBRo3>; Thu, 2 Aug 2001 13:44:29 -0400
Message-ID: <3B699178.78889F3B@freesoft.org>
Date: Thu, 02 Aug 2001 13:44:24 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: enhanced spinlock debugging code for intel
In-Reply-To: <3B68FAF4.2B3C9064@freesoft.org> <8zh2vnqc.wl@nisaaru.open.nm.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tachino Nobuhiro wrote:
> 
> Hello,
> 
> At Thu, 02 Aug 2001 03:02:12 -0400,
> Brent Baccala wrote:
> >
> > Hi -
> >
> > I'm having a problem with my USB CD burner that involves spinlocks - in
> > particular, some code that trys to grab a spinlock that's already locked
> > (this on a uni-processor machine).
> >
> > The existing spinlock debug code on intel only checked for unlocking an
> > unlocked spinlock, so I added code to check for locking a locked
> > spinlock as well - it now catches my problem.
> 
>    I think your code has a race. See following sequence.

You're right.  And I thought this code was simple :-)

I guess what suggests itself to me is something like:

  static inline void spin_unlock(spinlock_t *lock)
  {
  #if SPINLOCK_DEBUG
          if (lock->magic != SPINLOCK_MAGIC)
                  BUG();
          if (!spin_is_locked(lock))
                  BUG();
+         lock->last_lock_processor = -1;
  #endif
          __asm__ __volatile__(
                  spin_unlock_string
                  :"=m" (lock->lock) : : "memory");
  }

No longer any race (right?) and we don't lose anything since the one
processor is about to drop the lock it (presumably) held.  I wonder if
it should check to make sure the same processor that grabbed the lock is
releasing it.  Not exactly a bug, and somebody might write code like
that, but it seems suspicious.  Comments?

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
