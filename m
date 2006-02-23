Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWBWRPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWBWRPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWBWRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:15:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:10400 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751749AbWBWRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:15:10 -0500
Date: Thu, 23 Feb 2006 12:15:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
In-Reply-To: <20060222182601.1d628a01.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602231145300.5204-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Andrew Morton wrote:

> See, we avoid doing down_write() if the lock is uncontended.  And x86_64's
> uncontended down_write() unconditionally enables interrupts.

Not just x86_64; that's part of the general rw-semaphore implementation in
lib/rwsem-spinlock.c.  down_write() and down_read() always enable
interrupts, whether contended or not.

>  This evaded
> notice because might_sleep() warnings are disabled early in boot due to
> various horrid things.
> 
> Maybe we should enable the might_sleep() warnings because of this nasty
> rwsem trap.  We tried to do that a couple of weeks ago but we needed a pile
> of nasty workarounds to avoid false positives.

The situation is prone to bugs.  Special-case situations (like not
allowing task switching during system start-up) are always hard to handle.

> Applying this:
> 
> --- 25/kernel/sys.c~notifier-sleep-debug-update	2006-02-22 18:23:26.000000000 -0800
> +++ 25-akpm/kernel/sys.c	2006-02-22 18:25:45.000000000 -0800
> @@ -249,6 +249,8 @@ int blocking_notifier_chain_register(str
>  {
>  	int ret;
>  
> +	if (irqs_disabled())
> +		dump_stack();
>  	if (!down_write_trylock(&nh->rwsem)) {
>  		printk(KERN_WARNING "%s\n", __FUNCTION__);
>  		dump_stack();
> @@ -276,6 +278,8 @@ int blocking_notifier_chain_unregister(s
>  {
>  	int ret;
>  
> +	if (irqs_disabled())
> +		dump_stack();
>  	if (!down_write_trylock(&nh->rwsem)) {
>  		printk(KERN_WARNING "%s\n", __FUNCTION__);
>  		dump_stack();
> @@ -310,6 +314,8 @@ int blocking_notifier_call_chain(struct 
>  {
>  	int ret;
>  
> +	if (irqs_disabled())
> +		dump_stack();
>  	if (!down_read_trylock(&nh->rwsem)) {
>  		printk(KERN_WARNING "%s\n", __FUNCTION__);
>  		dump_stack();
> _
> 
> Gives:

... a bunch of calls to register_cpu_notifier and __exit_idle ...

> We're using blocking notifier chains in places where it's really risky, such as
> __exit_idle().  Time for a rethink, methinks.

Yes, that was clearly a mistake in the notifier-chain patch.  In x86_64,
the idle_notifier chain should be atomic, not blocking.  I missed the fact
that it gets invoked during an interrupt handler.

On the other hand, nothing in the vanilla kernel uses that notifier chain, 
and there doesn't seem to be any equivalent in other architectures.  
Perhaps it should just go away entirely?

The calls to register_cpu_notifier are harder.  That chain really does 
need to be blocking, which means we can't avoid calling down_write.  The 
only solution I can think of is to use down_write_trylock in the 
blocking_notifier_chain_register and unregister routines, even though 
doing that is a crock.

Or else change __down_read and __down_write to use spin_lock_irqsave 
instead of spin_lock_irq.  What do you think would be best?

> I'd suggest that in further development, you enable might_sleep() in early
> boot - that would have caught such things..

Not a bad idea.  I presume that removing the "system_state == 
SYSTEM_RUNNING" test in __might_sleep will have that effect?

Alan Stern

