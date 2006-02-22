Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWBVQIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWBVQIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBVQIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:08:39 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:7068 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932306AbWBVQIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:08:38 -0500
Date: Wed, 22 Feb 2006 11:08:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
In-Reply-To: <20060221152811.1b065752.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602221041490.5164-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Some atomic notifier chains require registrations to take place in atomic
> >  context.  An example is the die_notifier, which on some architectures may
> >  be accessed very early during the boot-up procedure, before task-switching
> >  is legal.  To accomodate these chains, this patch (as655) replaces the
> >  mutex in the atomic_notifier_head structure with a spinlock.
> 
> I think that's a good change, however x86_64 still crashes.
> 
> At great personal expense (ie: using winxp hyperterminal (I now understand
> why some of the traces we get are so crappy)) I have a trace.  It's still
> bugging out in the BUG_ON(!irqs_disabled());

I hate to keep asking you to test this since you're so busy.  If you know
anyone else with an x86_64 who could investigate instead, don't hesitate
to pass this on.

The only reason this patch set could cause interrupts to get enabled (when
they weren't enabled before) would be if some code was using one of the
blocking notifier chains.  If one of the down_read() or down_write() calls
blocked, the scheduler would enable interrupts.  On the other hand, if
there is only a single task running, how could a down_read() or
down_write() call manage to block?

The diagnostic patch below is a heavy-handed approach, but it ought to
indicate the source of the problem.  Doing anything to a blocking notifier
chain at a time when task switching is not legal should be a no-no.  
Maybe this means that a chain got misclassified as blocking when it
really should be atomic -- or maybe it means there has always been a more
serious problem that has never been detected before.

Alan Stern

P.S. (off-topic): Would it be possible to make the -mm series visible
through the web interface at <http://www.kernel.org/git/>?



Index: usb-2.6/kernel/sys.c
===================================================================
--- usb-2.6.orig/kernel/sys.c
+++ usb-2.6/kernel/sys.c
@@ -249,7 +249,11 @@ int blocking_notifier_chain_register(str
 {
 	int ret;
 
-	down_write(&nh->rwsem);
+	if (!down_write_trylock(&nh->rwsem)) {
+		printk(KERN_WARNING "%s\n", __FUNCTION__);
+		dump_stack();
+		down_write(&nh->rwsem);
+	}
 	ret = notifier_chain_register(&nh->head, n);
 	up_write(&nh->rwsem);
 	return ret;
@@ -272,7 +276,11 @@ int blocking_notifier_chain_unregister(s
 {
 	int ret;
 
-	down_write(&nh->rwsem);
+	if (!down_write_trylock(&nh->rwsem)) {
+		printk(KERN_WARNING "%s\n", __FUNCTION__);
+		dump_stack();
+		down_write(&nh->rwsem);
+	}
 	ret = notifier_chain_unregister(&nh->head, n);
 	up_write(&nh->rwsem);
 	return ret;
@@ -302,7 +310,11 @@ int blocking_notifier_call_chain(struct 
 {
 	int ret;
 
-	down_read(&nh->rwsem);
+	if (!down_read_trylock(&nh->rwsem)) {
+		printk(KERN_WARNING "%s\n", __FUNCTION__);
+		dump_stack();
+		down_read(&nh->rwsem);
+	}
 	ret = notifier_call_chain(&nh->head, val, v);
 	up_read(&nh->rwsem);
 	return ret;

