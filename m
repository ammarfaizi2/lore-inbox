Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTKNRqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTKNRqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:46:22 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:51879 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264539AbTKNRpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:45:55 -0500
Date: Fri, 14 Nov 2003 11:45:35 -0600
From: Jack Steiner <steiner@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031114174535.GA30388@sgi.com>
References: <20031110215844.GC21632@sgi.com> <20031111082915.GC1130@llm08.in.ibm.com> <20031111115804.4aaafd28.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111115804.4aaafd28.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 11:58:04AM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> >
> > On Mon, Nov 10, 2003 at 03:58:44PM -0600, Jack Steiner wrote:
> > > 
> > > I dont know the background on note_interrupt() in arch/ia64/kernel/irq.c, 
> > > but I had to disable the function on our large systems (IA64).
> > > 
> > > The function updates a counter in the irq_desc_t table. An entry in this table
> > > is shared by all cpus that take a specific interrupt #. For most interrupt #'s,
> > > this is a problem but it is prohibitive for the timer tick on big systems.
> > > 
> > > Updating the counter causes a cache line to be bounced between
> > > cpus at a rate of at least HZ*active_cpus. (The number of bus transactions
> > 
> > The answer to this is probably alloc_percpu for the counters.
> 
> Or just make noirqdebug the default.
> 
> The note_interrupt() stuff is only useful for diagnosing mysterious lockups
> (and hasn't proven useful for that, actually).  It should be disabled for
> production use.
> 


Probably too late for 2.6.0, but here is a patch that disables noirqdebug:



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1438  -> 1.1439 
#	arch/i386/kernel/irq.c	1.45    -> 1.46   
#	arch/mips/kernel/irq.c	1.14    -> 1.15   
#	arch/ppc64/kernel/irq.c	1.36    -> 1.37   
#	arch/ia64/kernel/irq.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/14	steiner@attica.americas.sgi.com	1.1439
# Change the default value for "irqdebug" so that it is disabled.
# Rename option from "noirqdebug" to "irqdebug".
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Fri Nov 14 11:18:07 2003
+++ b/arch/i386/kernel/irq.c	Fri Nov 14 11:18:07 2003
@@ -259,16 +259,16 @@
 	}
 }
 
-static int noirqdebug;
+static int irqdebug;
 
-static int __init noirqdebug_setup(char *str)
+static int __init irqdebug_setup(char *str)
 {
-	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	irqdebug = 1;
+	printk("IRQ lockup detection enabled\n");
 	return 1;
 }
 
-__setup("noirqdebug", noirqdebug_setup);
+__setup("irqdebug", irqdebug_setup);
 
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled then
@@ -484,7 +484,7 @@
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, &regs, action);
 		spin_lock(&desc->lock);
-		if (!noirqdebug)
+		if (irqdebug)
 			note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
diff -Nru a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	Fri Nov 14 11:18:07 2003
+++ b/arch/ia64/kernel/irq.c	Fri Nov 14 11:18:07 2003
@@ -283,16 +283,16 @@
 	}
 }
 
-static int noirqdebug;
+static int irqdebug;
 
-static int __init noirqdebug_setup(char *str)
+static int __init irqdebug_setup(char *str)
 {
-	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	irqdebug = 1;
+	printk("IRQ lockup detection enabled\n");
 	return 1;
 }
 
-__setup("noirqdebug", noirqdebug_setup);
+__setup("irqdebug", irqdebug_setup);
 
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled then
@@ -457,7 +457,7 @@
 		desc->handler->ack(irq);
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
 		desc->handler->end(irq);
-		if (!noirqdebug)
+		if (irqdebug)
 			note_interrupt(irq, desc, action_ret);
 	} else {
 		spin_lock(&desc->lock);
@@ -504,7 +504,7 @@
 			spin_unlock(&desc->lock);
 			action_ret = handle_IRQ_event(irq, regs, action);
 			spin_lock(&desc->lock);
-			if (!noirqdebug)
+			if (irqdebug)
 				note_interrupt(irq, desc, action_ret);
 			if (!(desc->status & IRQ_PENDING))
 				break;
diff -Nru a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	Fri Nov 14 11:18:07 2003
+++ b/arch/mips/kernel/irq.c	Fri Nov 14 11:18:07 2003
@@ -191,16 +191,16 @@
 	}
 }
 
-static int noirqdebug;
+static int irqdebug;
 
-static int __init noirqdebug_setup(char *str)
+static int __init irqdebug_setup(char *str)
 {
-	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	irqdebug = 1;
+	printk("IRQ lockup detection enabled\n");
 	return 1;
 }
 
-__setup("noirqdebug", noirqdebug_setup);
+__setup("irqdebug", irqdebug_setup);
 
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled then
@@ -396,7 +396,7 @@
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
-		if (!noirqdebug)
+		if (irqdebug)
 			note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;
diff -Nru a/arch/ppc64/kernel/irq.c b/arch/ppc64/kernel/irq.c
--- a/arch/ppc64/kernel/irq.c	Fri Nov 14 11:18:07 2003
+++ b/arch/ppc64/kernel/irq.c	Fri Nov 14 11:18:07 2003
@@ -416,16 +416,16 @@
 	}
 }
 
-static int noirqdebug;
+static int irqdebug;
 
-static int __init noirqdebug_setup(char *str)
+static int __init irqdebug_setup(char *str)
 {
-	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	irqdebug = 1;
+	printk("IRQ lockup detection enabled\n");
 	return 1;
 }
 
-__setup("noirqdebug", noirqdebug_setup);
+__setup("irqdebug", irqdebug_setup);
 
 /*
  * If 99,900 of the previous 100,000 interrupts have not been handled then
@@ -538,7 +538,7 @@
 		spin_unlock(&desc->lock);
 		action_ret = handle_irq_event(irq, regs, action);
 		spin_lock(&desc->lock);
-		if (!noirqdebug)
+		if (irqdebug)
 			note_interrupt(irq, desc, action_ret);
 		if (likely(!(desc->status & IRQ_PENDING)))
 			break;

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


