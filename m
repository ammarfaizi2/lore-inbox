Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291472AbSBHIfh>; Fri, 8 Feb 2002 03:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291473AbSBHIf1>; Fri, 8 Feb 2002 03:35:27 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:30952 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S291472AbSBHIfQ>;
	Fri, 8 Feb 2002 03:35:16 -0500
Message-ID: <3C638DB2.460179C0@dlr.de>
Date: Fri, 08 Feb 2002 09:34:58 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@transmeta.com,
        mingo@elte.hu, haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Some of the talk I've heard has been toward an adaptive lock.  These
> are locks like Solaris's that can spin or sleep, usually depending on
> the state of the lock's holder.  Another alternative, which I prefer
> since it is much less overhead, is a lock that spins-then-sleeps
> unconditionally.

Dave Hanson wrote:

> he spin-then-sleep lock could be interesting as a replacement for the 
> BKL in places where a semaphore causes performance degredation.  In 
> quite a few places where we replaced the BKL with a more finely grained 
> semapore (not a spinlock because we needed to sleep during the hold), 
> instead of spinning for a bit, it would schedule instead.  This was bad 
> :).  Spin-then-sleep would be great behaviour in this situation.


Wouldn't it be sufficient to include the following patch of code
at the beginning of __combi_wait(...):

        if (smp_processor_id() != owner->cpu) {
                int cnt=MAX_LOOP_CNT;
retry:
                spin_unlock(&x->wait.lock) 
                do {
                        barrier();
                while (--cnt && x->owner);
                spin_lock(&x->wait.lock);
                if (!x->owner)
                        return;
                if (cnt)
                        goto retry;
        }
       then the sleep code of __combi_wait(...)

If one fears that the owner (or current if the kernel is made
preemptible) migrated to the same cpu while we are spinning 
for x->owner and hence may
make no progress, one could let the waiting loop last about a typical
process switch time and add an outer loop that checks if the cpu
of the owner is still different.


  Martin Wirth
