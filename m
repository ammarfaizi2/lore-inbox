Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUASUam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUASUam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:30:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55962 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263101AbUASUaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:30:22 -0500
Message-ID: <400C3D3E.BFCC25CE@us.ibm.com>
Date: Mon, 19 Jan 2004 12:25:34 -0800
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       jkenisto <jkenisto@us.ibm.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>
Subject: [PATCH 2.6.1] Net device error logging
Content-Type: multipart/mixed;
 boundary="------------89C1EB0B57D52339805CC03D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------89C1EB0B57D52339805CC03D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The enclosed patch implements the netdev_* error-logging macros for
network drivers.  These macros have been discussed at length on the
linux-kernel and linux-netdev lists.  All issues that reviewers have
raised were addressed previously.  This is just an update for v2.6.1.

In December, Jeff Garzik indicated his intention to merge this into the
net-drivers-2.5-exp queue, but he apparently never got around to it.
As previously discussed, these macros are in demand now (e.g., for
the e1000 driver) and have essentially no impact on drivers that don't
use them.

RECAP (from previous posts):
Calls to the netdev_* macros (netdev_printk and wrappers such as
netdev_err) are intended to replace calls to printk in network device
drivers.  These macros have the following characteristics:
- The first arg is a pointer to the net_device struct.
- The second arg, which is a NETIF_MSG_* message level, can be used to
implement verbosity control.
- The remaining format + args are the same as in the corresponding
printk call.
- Standard message prefixes: verbose (interface name, driver name, bus ID)
during probe, or just the interface name once the device is registered.
- The current implementation just calls printk.  However, the netdev_*
interface and availability of the net_device pointer open the door
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
v2.6.1 e100, e1000, and tg3 drivers are available on request.

LINUX v2.4 SUPPORT
Since there is no v2.6-style struct device underlying the net_device,
a v2.4.24-compatible version of netdev_printk would always log the
interface name as the message prefix:

#define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
do {									\
	if (NETIF_MSG_##msglevel == NETIF_MSG_ALL			\
	    || (netdev->msg_enable & NETIF_MSG_##msglevel)) {		\
		printk(sevlevel "%s: " format , netdev->name , ## arg);	\
	}								\
} while (0)

Jim Keniston
IBM Linux Technology Center
--------------89C1EB0B57D52339805CC03D
Content-Type: text/plain; charset=us-ascii;
 name="netdev-2.6.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.1.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Fri Jan 16 14:26:19 2004
+++ linux.netdev.patched/include/linux/netdevice.h	Fri Jan 16 14:26:19 2004
@@ -467,6 +467,9 @@
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
 
+	/* NETIF_MSG_* flags to control the types of events we log */
+	int msg_enable;
+
 	/* class/net/name entry */
 	struct class_device	class_dev;
 	struct net_device_stats* (*last_stats)(struct net_device *);
@@ -749,6 +752,7 @@
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+	NETIF_MSG_ALL		= -1,		/* always log message */
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
@@ -910,6 +914,41 @@
 #ifdef CONFIG_SYSCTL
 extern char *net_sysctl_strdup(const char *s);
 #endif
+
+/* debugging and troubleshooting/diagnostic helpers. */
+/**
+ * netdev_printk() - Log message with interface name, gated by message level
+ * @sevlevel: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @msglevel: a standard message-level flag with the NETIF_MSG_ prefix removed.
+ *	Unless msglevel is ALL, log the message only if that flag is set in
+ *	netdev->msg_enable.
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
--- linux.org/net/core/dev.c	Fri Jan 16 14:26:19 2004
+++ linux.netdev.patched/net/core/dev.c	Fri Jan 16 14:26:19 2004
@@ -3049,6 +3049,79 @@
 
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

--------------89C1EB0B57D52339805CC03D--

