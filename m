Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313509AbSC3Rtd>; Sat, 30 Mar 2002 12:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313512AbSC3RtR>; Sat, 30 Mar 2002 12:49:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33691 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S313509AbSC3RtC>;
	Sat, 30 Mar 2002 12:49:02 -0500
Date: Sat, 30 Mar 2002 18:46:18 +0100
Message-Id: <200203301746.g2UHkIh00410@dose.hogan.de>
From: Stefan Rompf <srompf@isg.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: Patch: Device operative state notification against 2.5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

attached you find a patch against Linux 2.5.7 that revives the
IFF_RUNNING flag in the dev->flags element. Some time ago, Alexey has
replaced IFF_RUNNING by a bit in dev->state, AFAIK because of locking
reasons.

When enabled, a thread is compiled into the kernel that scans the
network device list on every netif_carrier_on()/_off() called by a
device driver and mirrors the !LINK_STATE_NOCARRIER bit of dev->state
into IFF_RUNNING. If these values differ for a device, a netlink message
is broadcasted. This allows user processes to be notified about
operative state changes. Actually, I've written some patches for the
zebra routing daemon so that it stops using an interface while the
driver thinks that it is down.

There are still drivers left that play with IFF_RUNNING directly, but
I think they can be updated during 2.5 development cycle. The patch
seems to be stable, I've also submitted a 2.4 version for the -ac tree.

Cheers, Stefan


diff -X dontdiff -urN linux-2.5.7/include/linux/netdevice.h linux-2.5.7-stefan/include/linux/netdevice.h
--- linux-2.5.7/include/linux/netdevice.h	Mon Mar 18 21:37:18 2002
+++ linux-2.5.7-stefan/include/linux/netdevice.h	Sat Mar 30 16:08:34 2002
@@ -210,6 +210,12 @@
 	__LINK_STATE_RX_SCHED
 };
 
+/* This gets called by netif_carrier_on()/_off() whenever
+ * state of an interface changes
+ */
+#ifdef CONFIG_LINKWATCH
+extern void wake_linkwatch_thread(void);
+#endif
 
 /*
  * This structure holds at boot time configured netdevice settings. They
@@ -639,14 +645,24 @@
 
 static inline void netif_carrier_on(struct net_device *dev)
 {
+#ifdef CONFIG_LINKWATCH
+	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state))
+		wake_linkwatch_thread();
+#else
 	clear_bit(__LINK_STATE_NOCARRIER, &dev->state);
+#endif
 	if (netif_running(dev))
 		__netdev_watchdog_up(dev);
 }
 
 static inline void netif_carrier_off(struct net_device *dev)
 {
+#ifdef CONFIG_LINKWATCH
+	if (!test_and_set_bit(__LINK_STATE_NOCARRIER, &dev->state))
+		wake_linkwatch_thread();
+#else
 	set_bit(__LINK_STATE_NOCARRIER, &dev->state);
+#endif
 }
 
 /* Hot-plugging. */
diff -X dontdiff -urN linux-2.5.7/net/Config.help linux-2.5.7-stefan/net/Config.help
--- linux-2.5.7/net/Config.help	Mon Mar 18 21:37:07 2002
+++ linux-2.5.7-stefan/net/Config.help	Sat Mar 30 15:46:28 2002
@@ -385,6 +385,14 @@
   subnetwork boundaries. These shortcut connections bypass routers
   enhancing overall network performance.
 
+CONFIG_LINKWATCH
+  When this option is enabled, the kernel will forward changes in the
+  operative ("RUNNING") state of an interface via the netlink socket.
+  This is most useful when running linux as a router. Note that currently
+  not many drivers maintain an administrative state, a few even break this
+  option. Compliant drivers change the RUNNING flag in ifconfig output
+  depending on operative state. If unsure, say 'N'.
+
 CONFIG_ECONET
   Econet is a fairly old and slow networking protocol mainly used by
   Acorn computers to access file and print servers. It uses native
diff -X dontdiff -urN linux-2.5.7/net/Config.in linux-2.5.7-stefan/net/Config.in
--- linux-2.5.7/net/Config.in	Mon Mar 18 21:37:08 2002
+++ linux-2.5.7-stefan/net/Config.in	Sat Mar 30 15:45:38 2002
@@ -46,6 +46,9 @@
    fi
 fi
 tristate '802.1Q VLAN Support' CONFIG_VLAN_8021Q
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+    bool 'Device link state notification (EXPERIMENTAL)' CONFIG_LINKWATCH
+fi
 
 comment ' '
 tristate 'The IPX protocol' CONFIG_IPX
diff -X dontdiff -urN linux-2.5.7/net/core/Makefile linux-2.5.7-stefan/net/core/Makefile
--- linux-2.5.7/net/core/Makefile	Mon Mar 18 21:37:13 2002
+++ linux-2.5.7-stefan/net/core/Makefile	Sat Mar 30 15:42:35 2002
@@ -30,4 +30,6 @@
 # Ugly. I wish all wireless drivers were moved in drivers/net/wireless
 obj-$(CONFIG_NET_PCMCIA_RADIO) += wireless.o
 
+obj-$(CONFIG_LINKWATCH) += link_watch.o
+
 include $(TOPDIR)/Rules.make
diff -X dontdiff -urN linux-2.5.7/net/core/dev.c linux-2.5.7-stefan/net/core/dev.c
--- linux-2.5.7/net/core/dev.c	Mon Mar 18 21:37:15 2002
+++ linux-2.5.7-stefan/net/core/dev.c	Sat Mar 30 15:42:35 2002
@@ -720,6 +720,12 @@
 		 */
 		dev->flags |= IFF_UP;
 
+		if (netif_carrier_ok(dev)) {
+			dev->flags |= IFF_RUNNING;
+		} else {
+			dev->flags &= ~IFF_RUNNING;
+		}
+
 		set_bit(__LINK_STATE_START, &dev->state);
 
 		/*
@@ -826,7 +832,7 @@
 	 *	Device is now down.
 	 */
 
-	dev->flags &= ~IFF_UP;
+	dev->flags &= ~(IFF_UP | IFF_RUNNING);
 #ifdef CONFIG_NET_FASTROUTE
 	dev_clear_fastroute(dev);
 #endif
@@ -2668,7 +2674,9 @@
 #ifdef CONFIG_NET_DIVERT
 extern void dv_init(void);
 #endif /* CONFIG_NET_DIVERT */
-
+#ifdef CONFIG_LINKWATCH
+extern void linkwatch_init(void);
+#endif /* CONFIG_LINKWATCH */
 
 /*
  *       Callers must hold the rtnl semaphore.  See the comment at the
@@ -2811,6 +2819,10 @@
 	 */
 	 
 	net_device_init();
+
+#ifdef CONFIG_LINKWATCH
+	linkwatch_init();
+#endif /* CONFIG_LINKWATCH */
 
 	return 0;
 }
diff -X dontdiff -urN linux-2.5.7/net/core/link_watch.c linux-2.5.7-stefan/net/core/link_watch.c
--- linux-2.5.7/net/core/link_watch.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.7-stefan/net/core/link_watch.c	Sat Mar 30 16:58:51 2002
@@ -0,0 +1,106 @@
+/*
+ * Linux network device state notifaction
+ *
+ * Author:
+ *     Stefan Rompf <sux@isg.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/if.h>
+#include <linux/rtnetlink.h>
+#include <asm/bitops.h>
+#include <asm/types.h>
+
+/* Used by wake_linkwatch_thread() */
+static wait_queue_head_t linkwatch_wqh;
+static unsigned long linkwatch_nowait;
+
+static int linkwatch_thread(void *dummy)
+{
+        struct net_device *dev;
+	DECLARE_WAITQUEUE(linkwatch_wq, current);
+	
+	daemonize();
+	spin_lock_irq(&current->sigmask_lock);
+	sigfillset(&current->blocked);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sigmask_lock);
+
+	strcpy(current->comm, "linkwatchd");
+
+	while(1) {
+		clear_bit(0, &linkwatch_nowait);
+		rtnl_lock();
+		for (dev=dev_base; dev; dev = dev->next) {
+
+			/* State of netif_carrier_ok() is reflected
+			   into dev_flags by this loop, and a netlink
+			   message is omitted whenever the state
+			   changes */
+
+			if (!(dev->flags & IFF_UP)) continue;
+
+			if (dev->flags & IFF_RUNNING) {
+				if (!netif_carrier_ok(dev)) {
+					write_lock(&dev_base_lock);
+					dev->flags &= ~IFF_RUNNING;
+					write_unlock(&dev_base_lock);
+					netdev_state_change(dev);
+				}
+			} else {
+				if (netif_carrier_ok(dev)) {
+					write_lock(&dev_base_lock);
+					dev->flags |= IFF_RUNNING;
+					write_unlock(&dev_base_lock);
+					netdev_state_change(dev);
+				}
+			}
+		}
+		rtnl_unlock();
+
+		/* Prevent runaway on rapid state changes */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (test_bit(0, &linkwatch_nowait)) {
+			set_current_state(TASK_RUNNING);
+		} else {
+			add_wait_queue(&linkwatch_wqh, &linkwatch_wq);
+			schedule();
+			remove_wait_queue(&linkwatch_wqh, &linkwatch_wq);
+		}
+	}
+		
+	return 0; /* Not reached */
+}
+
+
+void wake_linkwatch_thread() {
+	set_bit(0, &linkwatch_nowait);
+	wake_up(&linkwatch_wqh);
+}
+
+
+void __init linkwatch_init(void) {
+	pid_t me;
+
+	init_waitqueue_head(&linkwatch_wqh);
+	linkwatch_nowait = 0;
+	me = kernel_thread(linkwatch_thread, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+
+	if (!me) {
+		printk(KERN_INFO "Failed to init linkwatch thread, continuing without\n");
+	}
+}
+
diff -X dontdiff -urN linux-2.5.7/net/netsyms.c linux-2.5.7-stefan/net/netsyms.c
--- linux-2.5.7/net/netsyms.c	Mon Mar 18 21:37:13 2002
+++ linux-2.5.7-stefan/net/netsyms.c	Sat Mar 30 15:42:35 2002
@@ -596,4 +596,8 @@
 EXPORT_SYMBOL(wireless_send_event);
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
 
+#ifdef CONFIG_LINKWATCH
+EXPORT_SYMBOL(wake_linkwatch_thread);
+#endif
+
 #endif  /* CONFIG_NET */
