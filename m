Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVCVAn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVCVAn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVCVAle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:41:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28656 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262225AbVCVAjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:39:01 -0500
Message-ID: <423F691E.200@mvista.com>
Date: Mon, 21 Mar 2005 16:38:54 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, frowand@mvista.com
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu>
In-Reply-To: <20050316100914.GA16012@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> hi Frank - sorry about the late reply, was busy with other things. Your

My turn to be late, but now I'm back from vacation :-).


> ppc patches look mostly mergeable, with some small details still open:
> 
> * Frank Rowand <frowand@mvista.com> wrote:
> 
> 
>>The patches are:
>>
>> 1/5 ppc_rt.patch          - the core realtime functionality for PPC
> 
> 
> what is the rationale behind the rt_lock.h changes? The #ifdef
> CONFIG_PPC32 changes in generic code are not really acceptable, the -RT
> tree tries to keep a single spinlock definition and debugging
> primitives, across all architectures.

The first "#ifdef CONFIG_PPC32" adds some debug fields to raw_spinlock_t.
The debug fields are only used in the pre-existing arch/ppc/lib/locks.c,
and are disabled unless CONFIG_DEBUG_SPINLOCK is defined.
CONFIG_DEBUG_SPINLOCK is commented out in lib/Kconfig.debug as "# broken,
disable for now".  If CONFIG_DEBUG_SPINLOCK is ever enabled it will quickly
become apparent that there are conflicts between arch/ppc/lib/locks.c and
rt_lock.h (compile errors will occur) and the debug fields can easily be
removed from locks.c.
Thus it is OK that you left this chunk out of your patch.

The second "#ifdef CONFIG_PPC32" is in raw_rwlock_t, making the lock
field signed instead of unsigned.  The PPC code uses the value of
-1 to mean write locked, 0 to mean unlocked, and >0 to mean read
locked.  With one minor exception, all of the PPC raw_rwlock_t related
code will work properly with an unsigned type because the code that
checks the value of lock is assembly and treats lock as signed.  The
one non-assembly code that examines lock as a signed object is in
arch/ppc/lib/locks.c and is disabled unless CONFIG_DEBUG_SPINLOCK is
defined.  If CONFIG_DEBUG_SPINLOCK is ever enabled this will be
very evident as each call to __raw_write_unlock() will result in a
printk() warning.  The strongest reason I could advance for making
lock signed for PPC32 is that any future C code that checks for a
lock value less than zero will not function correctly and might not
be very obvious.
Thus it is also OK that you left this chunk out of your patch.


> 
> to drive things forward, i've applied the first 3 patches (except the
> rt_lock.h chunk from the first patch), and released it as part of the
> 40-03 patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> so that you can send followup patches based on this. Patches #4 and #5
> are routed via the upstream PPC tree, so -RT should not carry them,
> right?

Yes, -RT should not carry them.  Patch #4 went in via the PPC tree.
Patch #5 is a temporary hack that is only for someone with an IBM 405gp
reference platform who might want to test real-time with an SMP turned on.


-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

