Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWBWWg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWBWWg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWBWWg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:36:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:31369 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751796AbWBWWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:36:58 -0500
Date: Thu, 23 Feb 2006 17:36:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060223110350.49c8b869.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602231728300.4579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as660) changes the registration and unregistration routines 
for blocking notifier chains.  During system startup, when task switching 
is illegal, the routines will avoid calling down_write().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Thu, 23 Feb 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> >  The calls to register_cpu_notifier are harder.  That chain really does 
> >  need to be blocking
> 
> Why?

Because its callouts invoke blocking functions.  For example,
drivers/base/topology.c:topology_cpu_callback() calls
sysfs_create_group().  In drivers/cpufreq/cpufreq.c,
cpufreq_cpu_callback() calls cpufreq_add_dev(), which does kzalloc with
GFP_KERNEL.

> > which means we can't avoid calling down_write.  The 
> >  only solution I can think of is to use down_write_trylock in the 
> >  blocking_notifier_chain_register and unregister routines, even though 
> >  doing that is a crock.
> > 
> >  Or else change __down_read and __down_write to use spin_lock_irqsave 
> >  instead of spin_lock_irq.  What do you think would be best?
> 
> Nothing's pretty.  Perhaps look at system_state and not do any locking at all
> in early boot?

Okay.  Here's a patch to do that.  It only affects the registration 
routines; the actual call-out function still acquires the lock.  That's 
because (1) I didn't want to add extra overhead to a frequently-used 
routine, and (2) if this notifier chain gets called while interrupts are 
disabled then there's something badly wrong.

Combined with the previous patch, maybe you'll find that everything works
perfectly now...  :-)

Please revert those two debugging patches (the one I sent you and the one 
you wrote) before applying this.

Alan Stern

Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -249,6 +249,14 @@ int blocking_notifier_chain_register(str
 {
 	int ret;
 
+	/*
+	 * This code gets used during boot-up, when task switching is
+	 * not yet working and interrupts must remain disabled.  At
+	 * such times we must not call down_write().
+	 */
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return notifier_chain_register(&nh->head, n);
+
 	down_write(&nh->rwsem);
 	ret = notifier_chain_register(&nh->head, n);
 	up_write(&nh->rwsem);
@@ -272,6 +280,14 @@ int blocking_notifier_chain_unregister(s
 {
 	int ret;
 
+	/*
+	 * This code gets used during boot-up, when task switching is
+	 * not yet working and interrupts must remain disabled.  At
+	 * such times we must not call down_write().
+	 */
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return notifier_chain_unregister(&nh->head, n);
+
 	down_write(&nh->rwsem);
 	ret = notifier_chain_unregister(&nh->head, n);
 	up_write(&nh->rwsem);

