Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSC1Am4>; Wed, 27 Mar 2002 19:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311242AbSC1Ams>; Wed, 27 Mar 2002 19:42:48 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:62615 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S311180AbSC1AmZ>;
	Wed, 27 Mar 2002 19:42:25 -0500
Message-ID: <3CA265B6.2042717F@isg.de>
Date: Thu, 28 Mar 2002 01:37:10 +0100
From: Stefan Rompf <srompf@isg.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Patch: Device operative state notification against 2.4.18ac2
Content-Type: multipart/mixed;
 boundary="------------9797D0D8F53C861C2C011242"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9797D0D8F53C861C2C011242
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

attached you find a patch against Linux 2.4.18ac2 that revives the
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

The thread worked fine for me as a once-per-second polling module for
several weeks, and I hope I've found all gotchas to make it a "real"
part of the kernel. There are problems left with obsolete drivers that
are still playing with IFF_RUNNING directly, so I don't think this stuff
is ready for the official 2.4 tree. Anyway, I'd like to have some
testers and of course feedback.

Alan, please consider applying to your -ac tree.

Cheers, Stefan
--------------9797D0D8F53C861C2C011242
Content-Type: text/plain; charset=us-ascii;
 name="diff-24ac"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-24ac"

diff -X dontdiff -urN linux-2.4.18ac2/Documentation/Configure.help linux-2.4.18ac2-stefan/Documentation/Configure.help
--- linux-2.4.18ac2/Documentation/Configure.help	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/Documentation/Configure.help	Sun Mar 24 20:12:08 2002
@@ -24594,6 +24594,15 @@
   information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
   you can safely say 'N'.
 
+Device link state notification
+CONFIG_LINKWATCH
+  When this option is enabled, the kernel will forward changes in the
+  operative ("RUNNING") state of an interface via the netlink socket.
+  This is most useful when running linux as a router. Note that currently
+  not many drivers maintain an administrative state, a few even break this
+  option. Compliant drivers change the RUNNING flag in ifconfig output
+  depending on operative state. If unsure, say 'N'.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -X dontdiff -urN linux-2.4.18ac2/include/linux/netdevice.h linux-2.4.18ac2-stefan/include/linux/netdevice.h
--- linux-2.4.18ac2/include/linux/netdevice.h	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/include/linux/netdevice.h	Mon Mar 25 23:29:37 2002
@@ -208,6 +208,12 @@
 	__LINK_STATE_NOCARRIER
 };
 
+/* This gets called by netif_carrier_on()/_off() whenever
+ * state of an interface changes
+ */
+#ifdef CONFIG_LINKWATCH
+extern void wake_linkwatch_thread(void);
+#endif
 
 /*
  * This structure holds at boot time configured netdevice settings. They
@@ -611,14 +617,24 @@
 
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
diff -X dontdiff -urN linux-2.4.18ac2/net/Config.in linux-2.4.18ac2-stefan/net/Config.in
--- linux-2.4.18ac2/net/Config.in	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/net/Config.in	Sun Mar 24 19:58:20 2002
@@ -46,6 +46,7 @@
    fi
 
    dep_tristate '802.1Q VLAN Support (EXPERIMENTAL)' CONFIG_VLAN_8021Q $CONFIG_EXPERIMENTAL
+   bool 'Device link state notification (EXPERIMENTAL)' CONFIG_LINKWATCH
 
 fi
 
diff -X dontdiff -urN linux-2.4.18ac2/net/core/dev.c linux-2.4.18ac2-stefan/net/core/dev.c
--- linux-2.4.18ac2/net/core/dev.c	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/net/core/dev.c	Wed Mar 27 00:32:17 2002
@@ -719,6 +719,12 @@
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
@@ -812,7 +818,7 @@
 	 *	Device is now down.
 	 */
 
-	dev->flags &= ~IFF_UP;
+	dev->flags &= ~(IFF_UP | IFF_RUNNING);
 #ifdef CONFIG_NET_FASTROUTE
 	dev_clear_fastroute(dev);
 #endif
@@ -2740,7 +2746,9 @@
 #ifdef CONFIG_NET_DIVERT
 extern void dv_init(void);
 #endif /* CONFIG_NET_DIVERT */
-
+#ifdef CONFIG_LINKWATCH
+extern void linkwatch_init(void);
+#endif /* CONFIG_LINKWATCH */
 
 /*
  *       Callers must hold the rtnl semaphore.  See the comment at the
@@ -2877,6 +2885,10 @@
 	 */
 	 
 	net_device_init();
+
+#ifdef CONFIG_LINKWATCH
+	linkwatch_init();
+#endif /* CONFIG_LINKWATCH */
 
 	return 0;
 }
diff -X dontdiff -urN linux-2.4.18ac2/net/core/link_watch.c linux-2.4.18ac2-stefan/net/core/link_watch.c
--- linux-2.4.18ac2/net/core/link_watch.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.18ac2-stefan/net/core/link_watch.c	Thu Mar 28 00:18:43 2002
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
+	recalc_sigpending(current);
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
diff -X dontdiff -urN linux-2.4.18ac2/net/netsyms.c linux-2.4.18ac2-stefan/net/netsyms.c
--- linux-2.4.18ac2/net/netsyms.c	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/net/netsyms.c	Mon Mar 25 21:55:34 2002
@@ -588,4 +588,8 @@
 EXPORT_SYMBOL(net_call_rx_atomic);
 EXPORT_SYMBOL(softnet_data);
 
+#ifdef CONFIG_LINKWATCH
+EXPORT_SYMBOL(wake_linkwatch_thread);
+#endif
+
 #endif  /* CONFIG_NET */
--- linux-2.4.18ac2/net/core/Makefile	Wed Mar 27 00:06:54 2002
+++ linux-2.4.18ac2-stefan/net/core/Makefile	Mon Mar 25 21:54:26 2002
@@ -27,4 +27,6 @@
 obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PROFILE) += profile.o
 
+obj-$(CONFIG_LINKWATCH) += link_watch.o
+
 include $(TOPDIR)/Rules.make

--------------9797D0D8F53C861C2C011242--



