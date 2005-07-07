Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVGGPA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVGGPA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVGGO7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:59:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:28862 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261476AbVGGO4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:56:34 -0400
Date: Thu, 7 Jul 2005 10:56:29 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <20050706100451.GA7336@elte.hu>
Message-ID: <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I've just downloaded 51-09 and tried running it here on a normal intel
pentium4 box here at my customers site.  It included some hotplug PCI
modules (I don't know why since it's doesn't have hotplug devices) and I
got some init_MUTEX_LOCKED bugs on them.  Below you will find the patch (I
assume that compat_semaphore is still used).

Anyway, I also want to let you know that the e100 does not work.  It's
detected, but it wont bring up DHCP, and when I manually configued it, it
just froze (the process not the machine). But when I did a sysrq-t, the
machine froze up after it completed with some RT yeilding bug. Here's what
was last to spit out:

NETDEV WATCHDOG: eth0: transmit timed out
BUG: events/0:10 RT task yield()-ing!
 [<c01042ef>] dump_stack+0x1f/0x30 (20)
 [<c02e8b1a>] yield+0x5a/0x60 (20)
 [<c029bec5>] dev_deactivate+0x65/0x70 (20)
 [<c0296ae8>] linkwatch_run_queue+0xf8/0x110 (40)
 [<c0296b31>] linkwatch_event+0x31/0x70 (16)
 [<c013081b>] worker_thread+0x17b/0x230 (124)
 [<c01353de>] kthread+0xae/0xc0 (48)
 [<c0101445>] kernel_thread_helper+0x5/0x10 (814882844)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c014007a>] .... add_preempt_count+0x1a/0x20
.....[<c0140fcd>] ..   ( <= print_traces+0x1d/0x60)

------------------------------
| showing all locks held by: |  (events/0/10 [cf6ca030,  98]):
------------------------------

#001:             [c0390684] {rtnl_sem.lock}
... acquired at:  linkwatch_event+0x2c/0x70


This was right after the trace and all else froze. Anyway, I'll debug it
tomorrow since I'm about to go home for the day. And here's the patch for
the hotplug stuff (sorry about the -p0).

Index: drivers/pci/hotplug/ibmphp_hpc.c
===================================================================
--- drivers/pci/hotplug/ibmphp_hpc.c	(revision 237)
+++ drivers/pci/hotplug/ibmphp_hpc.c	(working copy)
@@ -104,7 +104,7 @@
 static struct semaphore sem_hpcaccess;	// lock access to HPC
 static struct semaphore semOperations;	// lock all operations and
 					// access to data structures
-static struct semaphore sem_exit;	// make sure polling thread goes away
+static struct compat_semaphore sem_exit;	// make sure polling thread goes away
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
Index: drivers/pci/hotplug/cpqphp_ctrl.c
===================================================================
--- drivers/pci/hotplug/cpqphp_ctrl.c	(revision 237)
+++ drivers/pci/hotplug/cpqphp_ctrl.c	(working copy)
@@ -45,8 +45,8 @@
 			u8 behind_bridge, struct resource_lists *resources);
 static void interrupt_event_handler(struct controller *ctrl);

-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */

Index: drivers/pci/hotplug/shpchp_ctrl.c
===================================================================
--- drivers/pci/hotplug/shpchp_ctrl.c	(revision 237)
+++ drivers/pci/hotplug/shpchp_ctrl.c	(working copy)
@@ -47,8 +47,8 @@
 	u8 behind_bridge, struct resource_lists *resources, u8 bridge_bus, u8 bridge_dev);
 static void interrupt_event_handler(struct controller *ctrl);

-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */

Index: drivers/pci/hotplug/cpci_hotplug_core.c
===================================================================
--- drivers/pci/hotplug/cpci_hotplug_core.c	(revision 237)
+++ drivers/pci/hotplug/cpci_hotplug_core.c	(working copy)
@@ -60,8 +60,8 @@
 static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
 static int thread_finished = 1;

 static int enable_slot(struct hotplug_slot *slot);
Index: drivers/pci/hotplug/pciehp_ctrl.c
===================================================================
--- drivers/pci/hotplug/pciehp_ctrl.c	(revision 237)
+++ drivers/pci/hotplug/pciehp_ctrl.c	(working copy)
@@ -48,8 +48,8 @@
 	u8 behind_bridge, struct resource_lists *resources, u8 bridge_bus, u8 bridge_dev);
 static void interrupt_event_handler(struct controller *ctrl);

-static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
-static struct semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
+static struct compat_semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct compat_semaphore event_exit;		/* guard ensure thread has exited before calling it quits */
 static int event_finished;
 static unsigned long pushbutton_pending;	/* = 0 */
 static unsigned long surprise_rm_pending;	/* = 0 */

