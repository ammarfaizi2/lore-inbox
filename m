Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVK1BU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVK1BU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 20:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVK1BU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 20:20:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43744 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751164AbVK1BUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 20:20:25 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, paulmck@us.ibm.com, greg@kroah.com,
       Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Sun, 27 Nov 2005 11:56:40 -0800."
             <20051127115640.3073f8e3.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 28 Nov 2005 12:19:44 +1100
Message-ID: <5069.1133140784@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005 11:56:40 -0800, 
Andrew Morton <akpm@osdl.org> wrote:
>We're saying that kernel/sys.c:notifier_lock should be removed and that all
>callers of notifier_chain_register(), notifier_chain_unregister() and
>notifier_call_chain() should be changed to define and use their own lock.

We are arguing past each other's assumptions, so I am laying out my
assumptions in the hope that it will clear the air.

* Traversal of the notifier callback chain can race against
  registration and unregistration on the same chain, some form of
  protection is required to remove this race.  The only reason that it
  has not bitten us so far is that registration and unregistration of
  notifier callbacks are rare events.

* There are two major classes of notifier callbacks.  One class calls
  routines that need to sleep, the other class is called in a context
  where it cannot sleep.  There is no one size that fits all types of
  notifier callbacks, nor do the suggested patches claim that one size
  fits all.

* If the callbacks can sleep then clearly the lock type for that class
  must be a sleeping lock.  This class is not a problem.

* The callbacks that are called from non-sleeping contexts vary in
  their requirements, but the hardest problem is callbacks from
  non-maskable interrupts.  By definition, no amount of locking can
  protect against NMI, so the list traversal for this class must be
  lock free.  RCU is only one example of lock free code, any lock free
  algorithm would do the job.

* Lock free list traversal has to be different from normal list
  traversal.  IOW it is not enough to push the responsibility for
  locking onto the caller of notifier_chain_{un,}register, we need a
  different version of notifier_call_chain() as well, therefore
  kernel/sys.c has to know what type of chain it is traversing.

* Once all the work has been done for the hard case of NMI, it makes
  sense to reuse that lock free code for all the other chains which are
  traversed in non-sleeping contexts.  IOW, adding list traversal code
  for different variants of spinlock, preempt disable etc. is just
  adding more code for no benefit.  This applies whether the locking
  (if any) is done in the caller or in kernel/sys.c, in either case it
  just duplicates code.

* If you accept that the lock free list traversal should not be
  duplicated across several callers (and several architectures) then
  the same argument applies to the class of callbacks that can sleep.
  Why duplicate that code or distribute the locks when a single lock in
  one place will do?  I have not seen any performance data that says
  that the lock for the sleeping notifier chains is any sort of
  bottleneck, which would be the only justfication for splitting the
  sleeping lock.

* You could argue (and I might even agree) that folding the two classes
  of callback into a single set of registration routines is confusing
  and there should be separate routines for
    notifier_chain_blocking_register, notifier_chain_blocking_unregister,
    notifier_call_blocking_chain,
    notifier_chain_atomic_register,  notifier_chain_atomic_unregister,
    notifier_call_atomic_chain.
  However that is an implementation detail.  Adding the type flag to
  the notifier chain head minimizes the changes to the existing code.
  I could live with separate routines for blocking and atomic notifier
  chains, even though it requires more work to patch it.

