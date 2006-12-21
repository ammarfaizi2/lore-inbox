Return-Path: <linux-kernel-owner+w=401wt.eu-S1423092AbWLUVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423092AbWLUVMq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWLUVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:12:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40417 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423092AbWLUVMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:12:45 -0500
Date: Thu, 21 Dec 2006 15:12:42 -0600
To: Ingo Molnar <mingo@redhat.com>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061221211242.GG16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com> <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com> <1166650134.6673.9.camel@localhost.localdomain> <20061220230342.GC16860@austin.ibm.com> <1166656195.6673.23.camel@localhost.localdomain> <20061220234647.GD16860@austin.ibm.com> <20061221003658.GB3048@krispykreme> <20061221010319.GE16860@austin.ibm.com> <1166712099.8869.16.camel@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166712099.8869.16.camel@earth>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 03:41:39PM +0100, Ingo Molnar wrote:
> On Wed, 2006-12-20 at 19:03 -0600, Linas Vepstas wrote:
> > Same kernel runs fine on power5. Although it does have patches
> > applied, those very same patches boot fine when applied to a slightly
> > older kernel (2.6.19-rc4).  I haven't been messing with buids or 
> > pci config space (at least not intentionaly).
> > 
> > I'll try again with an unpatched, unmodified kernel.
> 
> there have been a number of fixes to lockdep recently - could you try
> the kernel/lockdep.c file from latest -mm, does that fail too?
> 
> one possibility would be a chain-hash collision.

I see the same problem on linux-2.6.20-rc1-mm1 

The patch below fixes this, although I don't understand why 
this has become an issue just now:

Index: linux-2.6.20-rc1-mm1/kernel/mutex.c
===================================================================
--- linux-2.6.20-rc1-mm1.orig/kernel/mutex.c    2006-12-19
16:19:34.000000000 -0600
+++ linux-2.6.20-rc1-mm1/kernel/mutex.c 2006-12-21 14:31:33.000000000
-0600
@@ -249,7 +249,7 @@ __mutex_unlock_common_slowpath(atomic_t
                wake_up_process(waiter->task);
        }

-       debug_mutex_clear_owner(lock);
+       // debug_mutex_clear_owner(lock);

        spin_unlock_mutex(&lock->wait_lock, flags);
 }


It obvious that this is the proximal cause of the failure of 
the double_unlock_mutex() mutex self-test.  However, both
the double-unlock test, and this clear_owner() call, are 
in linux-2.6.19-git7, which doesn't fail this test. So I conclude
that __mutex_unlock_common_slowpath() is never taken in 2.6.19
but is always taken on 2.6.20-rc1 (in particular, is taken
during the double-unlock test).

I don't know why that would be. 

It might be wise to add a test to make sure the slowpath
is taken only when it should be taken? Its sort of scary 
to think that it might be always taken, and that no one 
notices the problem...

I'm gonna be out until after Christmas. -- and so, 

Merry Christmas! 
 
--linas


