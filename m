Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVCBRtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVCBRtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVCBRsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:48:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57342 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262382AbVCBRom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:44:42 -0500
Date: Wed, 2 Mar 2005 11:44:38 -0600
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302174438.GH1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <422524B1.10405@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422524B1.10405@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:28:01AM +0900, Hidetoshi Seto was heard to remark:
> 
> Note that here is a difficulty: the MCA handler on some arch would run on
> special context - MCA environment. In other words, since some MCA handler
> would be called by non-maskable interrupt(e.g. NMI), so it's difficult to
> call some driver's callback using protected kernel locks from MCA context.
> 
> Therefore what MCA handler could do is just indicates a error was there,
> by something like status flag which drivers can refer. And after possible
> deley, we would be able to call callbacks.

FWIW, many device drivers do I/O in an interrupt context (e.g. from
timer interrupts), which is why error recovery needs to run in a
separate thread from error detection.

On ppc64, here's what I currently do:
-- check for pci error (call firmware & ask it)
-- if (error) put event on a workqueue
-- workqueue handler sends out a notifier_call_chain 
   to anyone who cares.

Thus, the error recovery thread runs in its own thread.
Right now, the above code is arch-specific, but I don't see any
reason we couldn't make the event, the workqueue and the
notifier_call chain arch-generic. 

Below is some "pseudocode" version (mentally substitute 
"pci error event" for every occurance of "eeh").  Its got some
ppc64-specific crud in there that we have to fix to make it 
truly generic (I just cut and pasted from current code).

Would a cleaned up version of this code be suitable for a 
arch-generic pci error recovery framework?  Seto, would 
this be useful to you?

--linas

===================================================
Header file:

/**
 * EEH Notifier event flags.
 * Freeze -- pci slot is frozen, no i/o is possible
 */
#define EEH_NOTIFY_FREEZE  1

/** EEH event -- structure holding pci slot data that describes
 *  a change in the isolation status of a PCI slot.  A pointer
 *  to this struct is passed as the data pointer in a notify callback.
 */
struct eeh_event {
   struct list_head     list;
   struct pci_dev       *dev;
   int                  reset_state;
   int                  time_unavail;
};

/** Register to find out about EEH events. */
int eeh_register_notifier(struct notifier_block *nb);
int eeh_unregister_notifier(struct notifier_block *nb);


===================================================
C file:

/* EEH event workqueue setup. */
static spinlock_t eeh_eventlist_lock = SPIN_LOCK_UNLOCKED;
LIST_HEAD(eeh_eventlist);
static void eeh_event_handler(void *);
DECLARE_WORK(eeh_event_wq, eeh_event_handler, NULL);

static struct notifier_block *eeh_notifier_chain;


/**
 * eeh_register_notifier - Register to find out about EEH events.
 * @nb: notifier block to callback on events
 */
int eeh_register_notifier(struct notifier_block *nb)
{
   return notifier_chain_register(&eeh_notifier_chain, nb);
}

/**
 * eeh_unregister_notifier - Unregister to an EEH event notifier.
 * @nb: notifier block to callback on events
 */
int eeh_unregister_notifier(struct notifier_block *nb)
{
   return notifier_chain_unregister(&eeh_notifier_chain, nb);
}


/**
 * queue up a pci error event to be dispatched to all listeners
 * of the pci error notifier call chain.  This routine is safe to call
 * within an interrupt context.  The actual event delivery
 * will be from a workque thread.
 */

void eeh_queue_failure(struct pci_dev *dev) 
{
	struct eeh_event  *event;

   event = kmalloc(sizeof(*event), GFP_ATOMIC);
   if (event == NULL) {
      printk (KERN_ERR "EEH: out of memory, event not handled\n");
      return 1;
   }

   event->dev = dev;
   event->reset_state = rets[0];
   event->time_unavail = rets[2];

   /* We may be called in an interrupt context */
   spin_lock_irqsave(&eeh_eventlist_lock, flags);
   list_add(&event->list, &eeh_eventlist);
   spin_unlock_irqrestore(&eeh_eventlist_lock, flags);

   /* Most EEH events are due to device driver bugs.  Having
    * a stack trace will help the device-driver authors figure
    * out what happened.  So print that out. */
   if (rets[0] != 5) dump_stack();
   schedule_work(&eeh_event_wq);
}

/**
 * eeh_event_handler - dispatch EEH events.  The detection of a frozen
 * slot can occur inside an interrupt, where it can be hard to do
 * anything about it.  The goal of this routine is to pull these
 * detection events out of the context of the interrupt handler, and
 * re-dispatch them for processing at a later time in a normal context.
 *
 * @dummy - unused
 */
static void eeh_event_handler(void *dummy)
{
   unsigned long flags;
   struct eeh_event  *event;

   while (1) {
      spin_lock_irqsave(&eeh_eventlist_lock, flags);
      event = NULL;
      if (!list_empty(&eeh_eventlist)) {
         event = list_entry(eeh_eventlist.next, struct eeh_event, list);
         list_del(&event->list);
      }
      spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
      if (event == NULL)
         break;

      if (event->reset_state != 5) {
         printk(KERN_INFO "EEH: MMIO failure (%d), notifiying device "
                "%s %s\n", event->reset_state,
                pci_name(event->dev), pci_pretty_name(event->dev));
      }

      __get_cpu_var(slot_resets)++;
      notifier_call_chain (&eeh_notifier_chain,
                 EEH_NOTIFY_FREEZE, event);

      pci_dev_put(event->dev);
      kfree(event);
   }
}




