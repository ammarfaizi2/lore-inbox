Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbVLXDpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbVLXDpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 22:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbVLXDpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 22:45:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3518 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161165AbVLXDpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 22:45:16 -0500
Date: Fri, 23 Dec 2005 21:45:04 -0600
From: Jack Steiner <steiner@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051224034504.GC24614@sgi.com>
References: <43AC78CF.9090407@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AC78CF.9090407@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 11:23:11PM +0100, Manfred Spraul wrote:
> Jack wrote:
> 
> >On IA64, locks are released using a "st.rel" instruction. This ensures that
> >preceding "stores" are visible before the lock is released but does NOT 
> >prevent
> >a "store" that follows the "st.rel" from becoming visible before the 
> >"st.rel".
> >The result is that the task that owns the futex_q continues prematurely. 
> >
> >The failure I saw is the task that owned the futex_q resumed prematurely 
> >and
> >was context-switch off of the cpu. The task's switch_stack occupied the 
> >same
> >space of the futex_q. The store to q->lock_ptr overwrote the ar.bspstore 
> >in the
> >switch_stack.
> >
> Bad race.
> Unfortuantely the scenario that you describe is quite frequent:
> - autoremove_wake_function()
> - ipc/sem.c (search for IN_WAKEUP)
> - ipc/msg.c appears to be correct, there are smp_wmb() calls.

Yuck. I agree - both of these look incorrect.

Also, I should have used smp_wmb(), not wmb(). Thanks for
pointing that out.

I wonder how many other spots have the same problem. IIRC, we ran into
similar problems in the tty driver a few years ago but I have not
seen any problems recently.

> 
> --
>    Manfred

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


