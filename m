Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVLWVcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVLWVcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVLWVcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:32:24 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24286 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161058AbVLWVcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:32:23 -0500
Date: Fri, 23 Dec 2005 15:32:16 -0600
From: Jack Steiner <steiner@sgi.com>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051223213216.GA29541@sgi.com>
References: <20051223163816.GA30906@sgi.com> <20051223204822.GC24601@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223204822.GC24601@pb15.lixom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 02:48:22PM -0600, Olof Johansson wrote:
> On Fri, Dec 23, 2005 at 10:38:16AM -0600, Jack Steiner wrote:
> > 
> > Here is a fix for a ugly race condition that occurs in wake_futex() on IA64.
> > 
> > On IA64, locks are released using a "st.rel" instruction. This ensures that
> > preceding "stores" are visible before the lock is released but does NOT prevent
> > a "store" that follows the "st.rel" from becoming visible before the "st.rel".
> > The result is that the task that owns the futex_q continues prematurely. 
> > 
> > The failure I saw is the task that owned the futex_q resumed prematurely and
> > was context-switch off of the cpu. The task's switch_stack occupied the same
> > space of the futex_q. The store to q->lock_ptr overwrote the ar.bspstore in the
> > switch_stack. When the task resumed, it ran with a corrupted ar.bspstore.
> > Things went downhill from there.
> > 
> > Without the fix, the application fails roughly every 10 minutes. With
> > the fix, it ran 16 hours without a failure.
> 
> So what happened to what the comment 10 lines above your patch says?
> 
>         /*
>          * The lock in wake_up_all() is a crucial memory barrier after
>          * the list_del_init() and also before assigning to q->lock_ptr.
>          */
> 
> On PPC64, the spinlock unlock path has a sync in there for the very
> purpose of adding the write barrier. Maybe the ia64 unlock path is
> missing something similar?

On IA64, the "sync" instructions are actually part of the ld.acq ot st.rel
instructions that are used to set/clear spinlocks.

The program order of the instructions is:

        cmpxchg.acq             // set lock
          ..
          .. do things
          ..
        st.rel                  // release lock

        st NULL -> lock_ptr     // set flag to allow futex_q to be freed


IA64 implements fencing of ld.acq or st.rel instructions as one-directional
barriers.

For example, st.rel allows stores that FOLLOW the st.rel to be reordered
and become visible before the st.rel
(I hope this picture survives the various mailers)


        ld      |
        st      |   |        ^     ^
               - fence  -    |     |
        st.rel --------------|-----|------------------- fence
                             |     |
        ld                   |     |
        st                         |

I don't understand PPC64 but I suspect it has different memory ordering semantics.

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


