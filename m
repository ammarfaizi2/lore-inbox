Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWCQUUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWCQUUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCQUUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:20:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751288AbWCQUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:20:10 -0500
Date: Fri, 17 Mar 2006 21:20:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] disallow unloading of ibmphp
Message-ID: <20060317202009.GY3914@stusta.de>
References: <20060314224700.41242.qmail@web52612.mail.yahoo.com> <20060315000212.GB6533@kroah.com> <20060314162104.5370b20d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314162104.5370b20d@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 04:21:04PM -0800, Stephen Hemminger wrote:
> On Tue, 14 Mar 2006 16:02:12 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Wed, Mar 15, 2006 at 09:47:00AM +1100, Srihari Vijayaraghavan wrote:
> > > Before (in 2.6.16-rc*):
> > > $ egrep 'ibmphp' /proc/modules
> > > ibmphp 67809 4294967295 - Live 0xf8910000
> > >              ^^^^^^^^^^
> > > 
> > > After [1]:
> > > ibmphp 64224 0 - Live 0xf8965000
> > >              ^
> > > 
> > > Of course, now I'm able to successfully unload ibmphp
> > > (& subsequently load it too :)) without any
> > > observeable problems.
> > > 
> > > It'd seem, thro struct hotplug_slot_ops, module ref
> > > count for ibmphp is taken care of. No?
> > 
> > No.  I don't think this driver likes to be unloaded due to the
> > instability of the hardware if that happens.  So let's just let it not
> > be unloaded, and hope that the hardware can die in peace and never get
> > put into any new machines...
> > 
> > thanks,
> > 
> > greg k-h
> 
> The proper way to prevent unloading is just not to have a module exit routine,
> rather than causing ref count to be off. The the module subsystem will
> mark it as unsafe to unload. Unless it wants to allow unsafe forced unload.
> But IMHO either it needs to be safe to unload or not allow it.
>...


What about the patch below that also adds a comment and removes some 
more code?

I'll send a "diff -uwp" for better readability of the ibmphp_hpc.c 
changes in a reply.


<--  snip  -->


The ibmphp driver shouldn't be unloaded.

This patch replaces the module_exit() with a comment why it shouldn't 
happen and removes some now no longer needed code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/hotplug/ibmphp.h      |    1 
 drivers/pci/hotplug/ibmphp_core.c |   24 +---
 drivers/pci/hotplug/ibmphp_hpc.c  |  178 +++++++++++-------------------
 3 files changed, 76 insertions(+), 127 deletions(-)

--- linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp_core.c.old	2006-03-17 20:51:09.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp_core.c	2006-03-17 21:00:52.000000000 +0100
@@ -736,7 +736,7 @@ static struct pci_func *ibm_slot_find(u8
  * the pointers to pci_func, bus, hotplug_slot, controller,
  * and deregistering from the hotplug core
  *************************************************************/
-static void free_slots(void)
+static __init void free_slots(void)
 {
 	struct slot *slot_cur;
 	struct list_head * tmp;
@@ -1328,7 +1328,7 @@ struct hotplug_slot_ops ibmphp_hotplug_s
 */
 };
 
-static void ibmphp_unload(void)
+static void __init ibmphp_unload(void)
 {
 	free_slots();
 	debug("after slots\n");
@@ -1398,10 +1398,6 @@ static int __init ibmphp_init(void)
 		goto error;
 	}
 
-	/* lock ourselves into memory with a module 
-	 * count of -1 so that no one can unload us. */
-	module_put(THIS_MODULE);
-
 exit:
 	return rc;
 
@@ -1410,13 +1406,11 @@ error:
 	goto exit;
 }
 
-static void __exit ibmphp_exit(void)
-{
-	ibmphp_hpc_stop_poll_thread();
-	debug("after polling\n");
-	ibmphp_unload();
-	debug("done\n");
-}
-
 module_init(ibmphp_init);
-module_exit(ibmphp_exit);
+
+/* Greg KH <greg@kroah.com>:
+ * I don't think this driver likes to be unloaded due to the
+ * instability of the hardware if that happens.  So let's just let it not
+ * be unloaded, and hope that the hardware can die in peace and never get
+ * put into any new machines...
+ */
--- linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp.h.old	2006-03-17 20:52:49.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp.h	2006-03-17 20:52:55.000000000 +0100
@@ -398,7 +398,6 @@ extern int ibmphp_hpc_writeslot (struct 
 extern void ibmphp_lock_operations (void);
 extern void ibmphp_unlock_operations (void);
 extern int ibmphp_hpc_start_poll_thread (void);
-extern void ibmphp_hpc_stop_poll_thread (void);
 
 //----------------------------------------------------------------------------
 
--- linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp_hpc.c.old	2006-03-17 20:53:02.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/pci/hotplug/ibmphp_hpc.c	2006-03-17 20:58:49.000000000 +0100
@@ -101,12 +101,10 @@ static int to_debug = FALSE;
 //----------------------------------------------------------------------------
 // global variables
 //----------------------------------------------------------------------------
-static int ibmphp_shutdown;
 static int tid_poll;
 static struct mutex sem_hpcaccess;	// lock access to HPC
 static struct semaphore semOperations;	// lock all operations and
 					// access to data structures
-static struct semaphore sem_exit;	// make sure polling thread goes away
 //----------------------------------------------------------------------------
 // local function prototypes
 //----------------------------------------------------------------------------
@@ -135,9 +133,7 @@ void __init ibmphp_hpc_initvars (void)
 
 	mutex_init(&sem_hpcaccess);
 	init_MUTEX (&semOperations);
-	init_MUTEX_LOCKED (&sem_exit);
 	to_debug = FALSE;
-	ibmphp_shutdown = FALSE;
 	tid_poll = 0;
 
 	debug ("%s - Exit\n", __FUNCTION__);
@@ -833,87 +829,78 @@ static void poll_hpc (void)
 
 	debug ("%s - Entry\n", __FUNCTION__);
 
-	while (!ibmphp_shutdown) {
-		if (ibmphp_shutdown) 
-			break;
-		
-		/* try to get the lock to do some kind of hardware access */
-		down (&semOperations);
+	/* try to get the lock to do some kind of hardware access */
+	down (&semOperations);
 
-		switch (poll_state) {
-		case POLL_LATCH_REGISTER: 
-			oldlatchlow = curlatchlow;
-			ctrl_count = 0x00;
-			list_for_each (pslotlist, &ibmphp_slot_head) {
-				if (ctrl_count >= ibmphp_get_total_controllers())
-					break;
-				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
-					ctrl_count++;
-					if (READ_SLOT_LATCH (pslot->ctrl)) {
-						rc = ibmphp_hpc_readslot (pslot,
-									  READ_SLOTLATCHLOWREG,
-									  &curlatchlow);
-						if (oldlatchlow != curlatchlow)
-							process_changeinlatch (oldlatchlow,
-									       curlatchlow,
-									       pslot->ctrl);
-					}
-				}
-			}
-			++poll_count;
-			poll_state = POLL_SLEEP;
-			break;
-		case POLL_SLOTS:
-			list_for_each (pslotlist, &ibmphp_slot_head) {
-				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-				// make a copy of the old status
-				memcpy ((void *) &myslot, (void *) pslot,
-					sizeof (struct slot));
-				rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
-				if ((myslot.status != pslot->status)
-				    || (myslot.ext_status != pslot->ext_status))
-					process_changeinstatus (pslot, &myslot);
-			}
-			ctrl_count = 0x00;
-			list_for_each (pslotlist, &ibmphp_slot_head) {
-				if (ctrl_count >= ibmphp_get_total_controllers())
-					break;
-				pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
-				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
-					ctrl_count++;
-					if (READ_SLOT_LATCH (pslot->ctrl))
-						rc = ibmphp_hpc_readslot (pslot,
-									  READ_SLOTLATCHLOWREG,
-									  &curlatchlow);
+	switch (poll_state) {
+	case POLL_LATCH_REGISTER: 
+		oldlatchlow = curlatchlow;
+		ctrl_count = 0x00;
+		list_for_each (pslotlist, &ibmphp_slot_head) {
+			if (ctrl_count >= ibmphp_get_total_controllers())
+				break;
+			pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+			if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
+				ctrl_count++;
+				if (READ_SLOT_LATCH (pslot->ctrl)) {
+					rc = ibmphp_hpc_readslot (pslot,
+								  READ_SLOTLATCHLOWREG,
+								  &curlatchlow);
+					if (oldlatchlow != curlatchlow)
+						process_changeinlatch (oldlatchlow,
+								       curlatchlow,
+								       pslot->ctrl);
 				}
 			}
-			++poll_count;
-			poll_state = POLL_SLEEP;
-			break;
-		case POLL_SLEEP:
-			/* don't sleep with a lock on the hardware */
-			up (&semOperations);
-			msleep(POLL_INTERVAL_SEC * 1000);
-
-			if (ibmphp_shutdown) 
+		}
+		++poll_count;
+		poll_state = POLL_SLEEP;
+		break;
+	case POLL_SLOTS:
+		list_for_each (pslotlist, &ibmphp_slot_head) {
+			pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+			// make a copy of the old status
+			memcpy ((void *) &myslot, (void *) pslot,
+				sizeof (struct slot));
+			rc = ibmphp_hpc_readslot (pslot, READ_ALLSTAT, NULL);
+			if ((myslot.status != pslot->status)
+			    || (myslot.ext_status != pslot->ext_status))
+				process_changeinstatus (pslot, &myslot);
+		}
+		ctrl_count = 0x00;
+		list_for_each (pslotlist, &ibmphp_slot_head) {
+			if (ctrl_count >= ibmphp_get_total_controllers())
 				break;
-			
-			down (&semOperations);
-			
-			if (poll_count >= POLL_LATCH_CNT) {
-				poll_count = 0;
-				poll_state = POLL_SLOTS;
-			} else
-				poll_state = POLL_LATCH_REGISTER;
-			break;
-		}	
-		/* give up the hardware semaphore */
+			pslot = list_entry (pslotlist, struct slot, ibm_slot_list);
+			if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
+				ctrl_count++;
+				if (READ_SLOT_LATCH (pslot->ctrl))
+					rc = ibmphp_hpc_readslot (pslot,
+								  READ_SLOTLATCHLOWREG,
+								  &curlatchlow);
+			}
+		}
+		++poll_count;
+		poll_state = POLL_SLEEP;
+		break;
+	case POLL_SLEEP:
+		/* don't sleep with a lock on the hardware */
 		up (&semOperations);
-		/* sleep for a short time just for good measure */
-		msleep(100);
-	}
-	up (&sem_exit);
+		msleep(POLL_INTERVAL_SEC * 1000);
+		
+		down (&semOperations);
+		
+		if (poll_count >= POLL_LATCH_CNT) {
+			poll_count = 0;
+			poll_state = POLL_SLOTS;
+		} else
+			poll_state = POLL_LATCH_REGISTER;
+		break;
+	}	
+	/* give up the hardware semaphore */
+	up (&semOperations);
+	/* sleep for a short time just for good measure */
+	msleep(100);
 	debug ("%s - Exit\n", __FUNCTION__);
 }
 
@@ -1094,37 +1081,6 @@ int __init ibmphp_hpc_start_poll_thread 
 }
 
 /*----------------------------------------------------------------------
-* Name:    ibmphp_hpc_stop_poll_thread
-*
-* Action:  stop polling thread and cleanup
-*---------------------------------------------------------------------*/
-void __exit ibmphp_hpc_stop_poll_thread (void)
-{
-	debug ("%s - Entry\n", __FUNCTION__);
-
-	ibmphp_shutdown = TRUE;
-	debug ("before locking operations \n");
-	ibmphp_lock_operations ();
-	debug ("after locking operations \n");
-	
-	// wait for poll thread to exit
-	debug ("before sem_exit down \n");
-	down (&sem_exit);
-	debug ("after sem_exit down \n");
-
-	// cleanup
-	debug ("before free_hpc_access \n");
-	free_hpc_access ();
-	debug ("after free_hpc_access \n");
-	ibmphp_unlock_operations ();
-	debug ("after unlock operations \n");
-	up (&sem_exit);
-	debug ("after sem exit up\n");
-
-	debug ("%s - Exit\n", __FUNCTION__);
-}
-
-/*----------------------------------------------------------------------
 * Name:    hpc_wait_ctlr_notworking
 *
 * Action:  wait until the controller is in a not working state

