Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWIZFwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWIZFwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWIZFwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:52:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:50657 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751315AbWIZFin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:43 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/47] PM: define PM_EVENT_PRETHAW
Date: Mon, 25 Sep 2006 22:37:33 -0700
Message-Id: <1159249124371-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491211162-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This adds a new pm_message_t event type to use when preparing to restore a
swsusp snapshot.  Devices that have been initialized by Linux after resume
(rather than left in power-up-reset state) may need to be reset; this new
event type give drivers the chance to do that.

The drivers that will care about this are those which understand more hardware
states than just "on" and "reset", relying on hardware state during resume()
methods to be either the state left by the preceding suspend(), or a
power-lost reset.  The best current example of this class of drivers are USB
host controller drivers, which currently do not work through swsusp when
they're statically linked.

When the swsusp freeze/thaw mechanism kicks in, a troublesome third state
could exist: one state set up by a different kernel instance, before a
snapshot image is resumed.  This mechanism lets drivers prevent that state.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/pm.h |   62 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 096fb6f..6b27e07 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -142,29 +142,61 @@ typedef struct pm_message {
 } pm_message_t;
 
 /*
- * There are 4 important states driver can be in:
- * ON     -- driver is working
- * FREEZE -- stop operations and apply whatever policy is applicable to a
- *           suspended driver of that class, freeze queues for block like IDE
- *           does, drop packets for ethernet, etc... stop DMA engine too etc...
- *           so a consistent image can be saved; but do not power any hardware
- *           down.
- * SUSPEND - like FREEZE, but hardware is doing as much powersaving as
- *           possible. Roughly pci D3.
+ * Several driver power state transitions are externally visible, affecting
+ * the state of pending I/O queues and (for drivers that touch hardware)
+ * interrupts, wakeups, DMA, and other hardware state.  There may also be
+ * internal transitions to various low power modes, which are transparent
+ * to the rest of the driver stack (such as a driver that's ON gating off
+ * clocks which are not in active use).
  *
- * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3
- * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all different
- * defines is intentional, and will go away as soon as drivers are fixed.  Also
- * note that typedef is neccessary, we'll probably want to switch to
- *   typedef struct pm_message_t { int event; int flags; } pm_message_t
- * or something similar soon.
+ * One transition is triggered by resume(), after a suspend() call; the
+ * message is implicit:
+ *
+ * ON		Driver starts working again, responding to hardware events
+ * 		and software requests.  The hardware may have gone through
+ * 		a power-off reset, or it may have maintained state from the
+ * 		previous suspend() which the driver will rely on while
+ * 		resuming.  On most platforms, there are no restrictions on
+ * 		availability of resources like clocks during resume().
+ *
+ * Other transitions are triggered by messages sent using suspend().  All
+ * these transitions quiesce the driver, so that I/O queues are inactive.
+ * That commonly entails turning off IRQs and DMA; there may be rules
+ * about how to quiesce that are specific to the bus or the device's type.
+ * (For example, network drivers mark the link state.)  Other details may
+ * differ according to the message:
+ *
+ * SUSPEND	Quiesce, enter a low power device state appropriate for
+ * 		the upcoming system state (such as PCI_D3hot), and enable
+ * 		wakeup events as appropriate.
+ *
+ * FREEZE	Quiesce operations so that a consistent image can be saved;
+ * 		but do NOT otherwise enter a low power device state, and do
+ * 		NOT emit system wakeup events.
+ *
+ * PRETHAW	Quiesce as if for FREEZE; additionally, prepare for restoring
+ * 		the system from a snapshot taken after an earlier FREEZE.
+ * 		Some drivers will need to reset their hardware state instead
+ * 		of preserving it, to ensure that it's never mistaken for the
+ * 		state which that earlier snapshot had set up.
+ *
+ * A minimally power-aware driver treats all messages as SUSPEND, fully
+ * reinitializes its device during resume() -- whether or not it was reset
+ * during the suspend/resume cycle -- and can't issue wakeup events.
+ *
+ * More power-aware drivers may also use low power states at runtime as
+ * well as during system sleep states like PM_SUSPEND_STANDBY.  They may
+ * be able to use wakeup events to exit from runtime low-power states,
+ * or from system low-power states such as standby or suspend-to-RAM.
  */
 
 #define PM_EVENT_ON 0
 #define PM_EVENT_FREEZE 1
 #define PM_EVENT_SUSPEND 2
+#define PM_EVENT_PRETHAW 3
 
 #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
+#define PMSG_PRETHAW	((struct pm_message){ .event = PM_EVENT_PRETHAW, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
 #define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
 
-- 
1.4.2.1

