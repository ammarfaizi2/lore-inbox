Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSGVA3R>; Sun, 21 Jul 2002 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSGVA3R>; Sun, 21 Jul 2002 20:29:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:65482 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315282AbSGVA3P>;
	Sun, 21 Jul 2002 20:29:15 -0400
Date: Mon, 22 Jul 2002 02:31:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
In-Reply-To: <Pine.LNX.4.44.0207211619480.9993-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Linus Torvalds wrote:

> Looks good. Merged into my BK tree now, so please do future patches
> against this one..

i've done a minor comment update in softirq.c, plus i've written a
cli-sti-removal.txt guide to help driver writers do the transition:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-C2

(also attached)

	Ingo

--- linux/Documentation/cli-sti-removal.txt.orig	Mon Jul 22 02:25:53 2002
+++ linux/Documentation/cli-sti-removal.txt	Mon Jul 22 02:31:47 2002
@@ -0,0 +1,115 @@
+
+#### cli()/sti() removal guide, started by Ingo Molnar <mingo@redhat.com>
+
+
+as of 2.5.28, four popular macros have been removed on SMP, and
+are being phased out on UP:
+
+ cli(), sti(), save_flags(flags), restore_flags(flags)
+
+until now it was possible to protect driver code against interrupt
+handlers via a cli(), but from now on other, more lightweight methods
+have to be used for synchronization, such as spinlocks or semaphores.
+
+for example, driver code that used to do something like:
+
+	struct driver_data;
+
+	irq_handler (...)
+	{
+		....
+		driver_data.finish = 1;
+		driver_data.new_work = 0;
+		....
+	}
+
+	...
+
+	ioctl_func (...)
+	{
+		...
+		cli();
+		...
+		driver_data.finish = 0;
+		driver_data.new_work = 2;
+		...
+		sti();
+		...
+	}
+
+was SMP-correct because the cli() function ensured that no
+interrupt handler (amongst them the above irq_handler()) function
+would execute while the cli()-ed section is executing.
+
+but from now on a more direct method of locking has to be used:
+
+	spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+	struct driver_data;
+
+	irq_handler (...)
+	{
+		unsigned long flags;
+		....
+		spin_lock_irqsave(&driver_lock, flags);
+		....
+		driver_data.finish = 1;
+		driver_data.new_work = 0;
+		....
+		spin_unlock_irqrestore(&driver_lock, flags);
+		....
+	}
+
+	...
+
+	ioctl_func (...)
+	{
+		...
+		spin_lock_irq(&driver_lock);
+		...
+		driver_data.finish = 0;
+		driver_data.new_work = 2;
+		...
+		spin_unlock_irq(&driver_lock);
+		...
+	}
+
+the above code has a number of advantages:
+
+- the locking relation is easier to understand - actual lock usage
+  pinpoints the critical sections. cli() usage is too opaque.
+  Easier to understand means it's easier to debug.
+
+- it's faster, because spinlocks are faster to acquire than the
+  potentially heavily-used IRQ lock. Furthermore, your driver does
+  not have to wait eg. for a big heavy SCSI interrupt to finish,
+  because the driver_lock spinlock is only used by your driver.
+  cli() on the other hand was used by many drivers, and extended
+  the critical section to the whole IRQ handler function - creating
+  serious lock contention.
+ 
+
+to make the transition easier, we've still kept the cli(), sti(),
+save_flags() and restore_flags() macros defined on UP systems - but
+their usage will be phased out until the 2.6 kernel is released.
+
+drivers that want to disable local interrupts (interrupts on the
+current CPU), can use the following four macros:
+
+  __cli(), __sti(), __save_flags(flags), __restore_flags(flags)
+
+but beware, their meaning and semantics are much simpler, far from
+that of cli(), sti(), save_flags(flags) and restore_flags(flags).
+
+
+another related change is that synchronize_irq() now takes a parameter:
+synchronize_irq(irq). This change too has the purpose of making SMP
+synchronization more lightweight - this way you can wait for your own
+interrupt handler to finish, no need to wait for other IRQ sources.
+
+
+why were these changes done? The main reason was the architectural burden
+of maintaining the cli()/sti() interface - it became a real problem. The
+new interrupt system is much more streamlined, easier to understand, debug,
+and it's also a bit faster - the same happened to it that will happen to
+cli()/sti() using drivers once they convert to spinlocks :-)
+
--- linux/kernel/softirq.c.orig	Mon Jul 22 01:37:31 2002
+++ linux/kernel/softirq.c	Mon Jul 22 01:38:18 2002
@@ -26,10 +26,6 @@
      execution. Hence, we get something sort of weak cpu binding.
      Though it is still not clear, will it result in better locality
      or will not.
-   - These softirqs are not masked by global cli() and start_bh_atomic()
-     (by clear reasons). Hence, old parts of code still using global locks
-     MUST NOT use softirqs, but insert interfacing routines acquiring
-     global locks. F.e. look at BHs implementation.
 
    Examples:
    - NET RX softirq. It is multithreaded and does not require

