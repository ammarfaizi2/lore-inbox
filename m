Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJFXz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 19:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJFXz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 19:55:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31978 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261667AbTJFXzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 19:55:17 -0400
Message-ID: <3F820028.D931E08E@us.ibm.com>
Date: Mon, 06 Oct 2003 16:52:08 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>, acme@conectiva.com.br
CC: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>
Subject: Re: [PATCH] Net device error logging
References: <3F7C967F.A06A512E@us.ibm.com> <1065141377.6667.27.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------5CE61AD8F61413DF96A43406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5CE61AD8F61413DF96A43406
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

acme@conectiva.com.br wrote:
>
> net/netsyms.c is gone, please export that symbol just after its
> implementation.

Done.  The enclosed patch works with v2.6.0-test6-bk8.

Joe Perches wrote:
> ...
> While I agree with the completely with the concept and nearly completely
> with the implementation,

... Thanks...

> can I suggest that this should be done in the
> 2.7 series?

I would like to see it in v2.6 because it's in demand now [1] and its
impact is negligible on drivers that don't use it [2].

[1] Scott Feldman has indicated that he wants to incorporate netdev_*
calls into the e1000 driver (along the lines of the patches we published
previously) and the e100-3.0.0 driver (where the only change needed is
a redefinition of that driver's DPRINTK macro).

[2] For drivers that haven't converted to netdev_*, no changes are
needed.  struct net_device grows a bit (adding the msg_enable member),
but a driver that has a msg_enable member in its private struct can
continue to use it.

Jim Keniston
--------------5CE61AD8F61413DF96A43406
Content-Type: text/plain; charset=us-ascii;
 name="netdev-bk8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-bk8.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Mon Oct  6 16:13:12 2003
+++ linux.netdev.patched/include/linux/netdevice.h	Mon Oct  6 16:13:12 2003
@@ -467,6 +467,9 @@
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
 
+	/* NETIF_MSG_* flags to control the types of events we log */
+	int msg_enable;
+
 	/* class/net/name entry */
 	struct class_device	class_dev;
 };
@@ -746,6 +749,7 @@
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+	NETIF_MSG_ALL		= -1,		/* always log message */
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
@@ -904,6 +908,40 @@
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
--- linux.org/net/core/dev.c	Mon Oct  6 16:13:12 2003
+++ linux.netdev.patched/net/core/dev.c	Mon Oct  6 16:13:12 2003
@@ -3028,6 +3028,79 @@
 
 subsys_initcall(net_dev_init);
 
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
+
+EXPORT_SYMBOL(__netdev_printk);
 EXPORT_SYMBOL(__dev_get);
 EXPORT_SYMBOL(__dev_get_by_flags);
 EXPORT_SYMBOL(__dev_get_by_index);

--------------5CE61AD8F61413DF96A43406--

