Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTIOXMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTIOXML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:12:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53697 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261695AbTIOXLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:11:20 -0400
Message-ID: <3F66466A.35188299@us.ibm.com>
Date: Mon, 15 Sep 2003 16:08:26 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Greg KH <greg@kroah.com>,
       Randy Dunlap <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>
CC: David Brownell <david-b@pacbell.net>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] Net device error logging, revised
References: <3F4A8027.6FE3F594@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------12687B8D205259EF1DA1A6C4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------12687B8D205259EF1DA1A6C4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch extends the concept of Linux 2.6's dev_* logging macros to
support network devices.  This is a modification of a patch posted
last month, and addresses the issues raised since then, namely:

1. To minimize stack usage, the msg[] buffer in __netdev_printk() has been
made static and protected by a spinlock.  (The spinlock shouldn't be a big
performance hit because we're about to serialize on printk's lock anyway.)

2. It is no longer possible to omit the msglevel arg.  For example,
        netdev_err(dev,, "NIC fried!\n");
no longer works.  This must be expressed as
        netdev_err(dev, ALL, "NIC fried!\n");
or (see #3 below) something like
        netdev_fatal(dev, HW, "NIC fried!\n");

3. A new macro, netdev_fatal, is included.  Given the call
        netdev_fatal(dev, HW, "NIC fried!\n");
the indicated message is always logged: the msglevel arg (HW, in this
case) is NOT consulted.  In fact, the msglevel arg to netdev_fatal
is ignored in this implementation.  (As previously discussed, in some
future implementation, the msglevel could be logged to help indicate
the circumstances under which the event was logged.)

4. It was suggested that the netdev_* macros should support message
filtering via simple message levels -- e.g.,
        if (dev->msg_enable > 5) printk(KERN_INFO "Received a packet.\n");
-- in addition to (or instead of) via the NETIF_MSG_* bit masks.  But
Jeff Garzik reiterated his desire to standardize on NETIF_MSG_*, so
I'm leaving things unchanged in that respect.

5. It was suggested that netdev_dbg is not flexible enough to handle all
debugging situations.  This is probably true.  Because of the special
nature of debugging messages, I'd expect the developer to use other
approaches in debug code if netdev_dbg doesn't fill the bill.  But the
netdev_dbg approach appears to be reasonably useful.  (For comparison,
there are currently 188 calls to dev_dbg in Linux drivers.)  No change
here.

6. Certain comments seemed to imply that you should be able to
suppress all messages (even those with a msglevel of ALL) by setting the
msg_enable field to 0.  I chose not to support this, because it seemed
counterintuitive and inconsistent with existing practice.

Jim Keniston
IBM Linux Technology Center
--------------12687B8D205259EF1DA1A6C4
Content-Type: text/plain; charset=us-ascii;
 name="netdev-2.6.0-test5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.0-test5.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Mon Sep 15 15:58:06 2003
+++ linux.netdev.patched/include/linux/netdevice.h	Mon Sep 15 15:58:06 2003
@@ -467,6 +467,9 @@
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
 
+	/* NETIF_MSG_* flags to control the types of events we log */
+	int msg_enable;
+
 	/* class/net/name entry */
 	struct class_device	class_dev;
 };
@@ -741,6 +744,7 @@
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+	NETIF_MSG_ALL		= -1,		/* always log message */
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
@@ -899,6 +903,40 @@
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+/* debugging and troubleshooting/diagnostic helpers. */
+/**
+ * netdev_printk() - Log message with interface name, gated by message level
+ * @sevlevel: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @msglevel: a standard message-level flag with the NETIF_MSG_ prefix removed.
+ *	Unless msglevel is NETIF_MSG_ALL, log the message only if that flag
+ *	is set in netdev->msg_enable.
+ * @format: as with printk
+ * @args: as with printk
+ */
+extern int __netdev_printk(const char *sevlevel,
+	const struct net_device *netdev, int msglevel, const char *format, ...);
+#define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
+	__netdev_printk(sevlevel , netdev , NETIF_MSG_##msglevel ,	\
+	format , ## arg)
+
+#ifdef DEBUG
+#define netdev_dbg(netdev, msglevel, format, arg...)		\
+	netdev_printk(KERN_DEBUG , netdev , msglevel , format , ## arg)
+#else
+#define netdev_dbg(netdev, msglevel, format, arg...) do {} while (0)
+#endif
+
+#define netdev_err(netdev, msglevel, format, arg...)		\
+	netdev_printk(KERN_ERR , netdev , msglevel , format , ## arg)
+#define netdev_info(netdev, msglevel, format, arg...)		\
+	netdev_printk(KERN_INFO , netdev , msglevel , format , ## arg)
+#define netdev_warn(netdev, msglevel, format, arg...)		\
+	netdev_printk(KERN_WARNING , netdev , msglevel , format , ## arg)
+
+/* report fatal error unconditionally; msglevel ignored for now */
+#define netdev_fatal(netdev, msglevel, format, arg...)		\
+	netdev_printk(KERN_ERR , netdev , ALL , format , ## arg)
 
 #endif /* __KERNEL__ */
 
diff -Naur linux.org/net/core/dev.c linux.netdev.patched/net/core/dev.c
--- linux.org/net/core/dev.c	Mon Sep 15 15:58:07 2003
+++ linux.netdev.patched/net/core/dev.c	Mon Sep 15 15:58:07 2003
@@ -3035,3 +3035,75 @@
 }
 
 subsys_initcall(net_dev_init);
+
+static spinlock_t netdev_printk_lock = SPIN_LOCK_UNLOCKED;
+/**
+ * __netdev_printk() - Log message with interface name, gated by message level
+ * @sevlevel: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @msglevel: a standard message-level flag such as NETIF_MSG_PROBE.
+ *	Unless msglevel is NETIF_MSG_ALL, log the message only if
+ *	that flag is set in netdev->msg_enable.
+ * @format: as with printk
+ * @args: as with printk
+ *
+ * Does the work for the netdev_printk macro.
+ * For a lot of network drivers, the probe function looks like
+ *	...
+ *	netdev = alloc_netdev(...);	// or alloc_etherdev(...)
+ *	SET_NETDEV_DEV(netdev, dev);
+ *	...
+ *	register_netdev(netdev);
+ *	...
+ * netdev_printk and its wrappers (e.g., netdev_err) can be used as
+ * soon as you have a valid net_device pointer -- e.g., from alloc_netdev,
+ * alloc_etherdev, or init_etherdev.  (Before that, use dev_printk and
+ * its wrappers to report device errors.)  It's common for an interface to
+ * have a name like "eth%d" until the device is successfully configured,
+ * and the call to register_netdev changes it to a "real" name like "eth0".
+ *
+ * If the interface's reg_state is NETREG_REGISTERED, we assume that it has
+ * been successfully set up in sysfs, and we prepend only the interface name
+ * to the message -- e.g., "eth0: NIC Link is Down".  The interface
+ * name can be used to find eth0's driver, bus ID, etc. in sysfs.
+ *
+ * For any other value of reg_state, we prepend the driver name and bus ID
+ * as well as the (possibly incomplete) interface name -- e.g.,
+ * "eth%d (e100 0000:00:03.0): Failed to map PCI address..."
+ *
+ * Probe functions that alloc and register in one step (via init_etherdev),
+ * or otherwise register the device before the probe completes successfully,
+ * may need to take other steps to ensure that the failing device is clearly
+ * identified.
+ */
+int __netdev_printk(const char *sevlevel, const struct net_device *netdev,
+	int msglevel, const char *format, ...)
+{
+	if (!netdev || !format) {
+		return -EINVAL;
+	}
+	if (msglevel == NETIF_MSG_ALL || (netdev->msg_enable & msglevel)) {
+		static char msg[512];	/* protected by netdev_printk_lock */
+		unsigned long flags;
+		va_list args;
+		struct device *dev = netdev->class_dev.dev;
+		
+		spin_lock_irqsave(&netdev_printk_lock, flags);
+		va_start(args, format);
+		vsnprintf(msg, 512, format, args);
+		va_end(args);
+
+		if (!sevlevel) {
+			sevlevel = "";
+		}
+
+		if (netdev->reg_state == NETREG_REGISTERED || !dev) {
+			printk("%s%s: %s", sevlevel, netdev->name, msg);
+		} else {
+			printk("%s%s (%s %s): %s", sevlevel, netdev->name,
+				dev->driver->name, dev->bus_id, msg);
+		}
+		spin_unlock_irqrestore(&netdev_printk_lock, flags);
+	}
+	return 0;
+}
diff -Naur linux.org/net/netsyms.c linux.netdev.patched/net/netsyms.c
--- linux.org/net/netsyms.c	Mon Sep 15 15:58:07 2003
+++ linux.netdev.patched/net/netsyms.c	Mon Sep 15 15:58:07 2003
@@ -210,6 +210,7 @@
 EXPORT_SYMBOL(net_ratelimit);
 EXPORT_SYMBOL(net_random);
 EXPORT_SYMBOL(net_srandom);
+EXPORT_SYMBOL(__netdev_printk);
 
 /* Needed by smbfs.o */
 EXPORT_SYMBOL(__scm_destroy);

--------------12687B8D205259EF1DA1A6C4--

