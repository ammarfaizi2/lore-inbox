Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWA3XRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWA3XRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWA3XRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:17:20 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:19061 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965037AbWA3XRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:17:19 -0500
X-IronPort-AV: i="4.01,236,1136188800"; 
   d="scan'208"; a="1771711061:sNHT34410440"
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.15-mm4] sem2mutex: infiniband, #2
X-Message-Flag: Warning: May contain useful information
References: <20060114150949.GA24284@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 30 Jan 2006 15:17:09 -0800
In-Reply-To: <20060114150949.GA24284@elte.hu> (Ingo Molnar's message of
 "Sat, 14 Jan 2006 16:09:49 +0100")
Message-ID: <adavew171ca.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Jan 2006 23:17:15.0396 (UTC) FILETIME=[4EAE3C40:01C625F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I finally got around to looking at this, and I applied the
infiniband/ulp/srp part of this to my tree.  However, I noticed some
fishy things in other parts of the patch.  First of all, the entire
user_mad.c diff you sent is:

 > --- linux.orig/drivers/infiniband/core/user_mad.c
 > +++ linux/drivers/infiniband/core/user_mad.c
 > @@ -47,7 +47,7 @@
 >  #include <linux/kref.h>
 >  
 >  #include <asm/uaccess.h>
 > -#include <asm/semaphore.h>
 > +#include <linux/mutex.h>
 >  
 >  #include <rdma/ib_mad.h>
 >  #include <rdma/ib_user_mad.h>

it seems that you're just getting lucky that struct semaphore is
getting defined implicitly, since you didn't remove the actual
semaphore use.

The semaphore usage in user_mad.c seems a little tricky to convert to
a mutex, if I understand things correctly.  The idea is that we create
a special file that turns on the "IsSM" bit on the InfiniBand port
when it's open (don't worry about what that means, really).  We use a
semaphore to prevent anyone else from opening the file and trying to
be a SM until the first file is closed -- but of course the last
reference to a file might be dropped by a different process than the
one that opened it, so the up() might be called from a different
process than the original down().

Second, in the mthca changes, you have

 > --- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h
 > +++ linux/drivers/infiniband/hw/mthca/mthca_dev.h
 > @@ -44,7 +44,9 @@
 >  #include <linux/pci.h>
 >  #include <linux/dma-mapping.h>
 >  #include <linux/timer.h>
 > -#include <asm/semaphore.h>
 > +#include <linux/mutex.h>

but again not all semaphore usages have been removed.

For example, a few lines later in the same file, we have:

 > @@ -111,7 +113,7 @@ enum {
 >  struct mthca_cmd {
 >  	struct pci_pool          *pool;
 >  	int                       use_events;
 > -	struct semaphore          hcr_sem;
 > +	struct mutex              hcr_mutex;
 >  	struct semaphore 	  poll_sem;
 >  	struct semaphore 	  event_sem;

so poll_sem and event_sem remain.

Again, these seem hard to convert to mutexes, especially event_sem.
The device firmware allows some number of commands to be queued up (64
is a typical number) and event_sem is used to keep track of when a
command slot is available.  I guess I could rewrite things so that I
use something like wait_event() to block until there is a free command
slot, but I'm not convinced that's an improvement.

Thanks,
  Roland
