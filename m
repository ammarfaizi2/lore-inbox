Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTJBVWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTJBVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:22:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:1249 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263494AbTJBVWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:22:43 -0400
Message-ID: <3F7C967F.A06A512E@us.ibm.com>
Date: Thu, 02 Oct 2003 14:19:59 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>, jkenisto <jkenisto@us.ibm.com>
Subject: [PATCH] Net device error logging
Content-Type: multipart/mixed;
 boundary="------------01B433A7898C00D9C9065A8C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------01B433A7898C00D9C9065A8C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The enclosed patch, updated for v2.6.0-test6, implements the previously
discussed netdev_* error-logging macros for network drivers.  Please apply.

RECAP (from previous posts):
Calls to the netdev_* macros (netdev_printk and wrappers such as
netdev_err) are intended to replace calls to printk in network device
drivers.  These macros have the following characteristics:
- Same format + args as the corresponding printk call.
- Approximately the same amount of text as the corresponding printk call.
- The first arg is a pointer to the net_device struct.
- The second arg, which is a NETIF_MSG_* message level, can be used to
implement verbosity control.
- Standard message prefixes: verbose (interface name, driver name, bus ID)
during probe, or just the interface name once the device is registered.
- The current implementation just calls printk.  However, the netdev_*
interface (and availability of the net_device pointer) opens the door
for logging additional information (via printk, via evlog/netlink, etc.)
as desired, with no change to driver code.

Examples:
        netdev_err(netdev, RX_ERR, "No mem: dropped packet\n");
logs a message such as the following if the NETIF_MSG_RX_ERR bit is set
in netdev->msg_enable.
        eth2: No mem: dropped packet

        netdev_fatal(netdev, PROBE, "The EEPROM Checksum Is Not Valid\n");
or
        netdev_err(netdev, ALL, "The EEPROM Checksum Is Not Valid\n");
unconditionally logs a message such as:
        eth%d (e1000 0000:00:03.0): The EEPROM Checksum Is Not Valid
The message's prefix includes the driver name and bus ID because the
message is logged at probe time, before netdev is registered.

SAMPLE DRIVERS
As examples of how the netdev_* macros could be used, patches for the
v2.6.0-test6 e100, e1000, and tg3 drivers are available on request.

LINUX v2.4 SUPPORT
Since there is no v2.6-style struct device underlying the net_device,
the v2.4.22 version of netdev_printk always logs the interface name
as the message prefix:

#define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
do {									\
	if (NETIF_MSG_##msglevel == NETIF_MSG_ALL			\
	    || (netdev->msg_enable & NETIF_MSG_##msglevel)) {		\
		printk(sevlevel "%s: " format , netdev->name , ## arg);	\
	}								\
} while (0)

Full patch for v2.4.22 available on request.

Jim Keniston
IBM Linux Technology Center
--------------01B433A7898C00D9C9065A8C
Content-Type: text/plain; charset=us-ascii;
 name="netdev-2.6.0-test6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.0-test6.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Tue Sep 30 16:21:21 2003
+++ linux.netdev.patched/include/linux/netdevice.h	Tue Sep 30 16:21:21 2003
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
--- linux.org/net/core/dev.c	Tue Sep 30 16:21:21 2003
+++ linux.netdev.patched/net/core/dev.c	Tue Sep 30 16:21:21 2003
@@ -3036,3 +3036,75 @@
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
--- linux.org/net/netsyms.c	Tue Sep 30 16:21:21 2003
+++ linux.netdev.patched/net/netsyms.c	Tue Sep 30 16:21:21 2003
@@ -210,6 +210,7 @@
 EXPORT_SYMBOL(net_ratelimit);
 EXPORT_SYMBOL(net_random);
 EXPORT_SYMBOL(net_srandom);
+EXPORT_SYMBOL(__netdev_printk);
 
 /* Needed by smbfs.o */
 EXPORT_SYMBOL(__scm_destroy);

--------------01B433A7898C00D9C9065A8C--

