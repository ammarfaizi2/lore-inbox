Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbTHYVeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbTHYVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:34:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29910 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262216AbTHYVeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:34:11 -0400
Message-ID: <3F4A8027.6FE3F594@us.ibm.com>
Date: Mon, 25 Aug 2003 14:31:19 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>
CC: Jeff Garzik <jgarzik@pobox.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Greg KH <greg@kroah.com>,
       Randy Dunlap <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>
Subject: [PATCH 1/4] Net device error logging, revised
Content-Type: multipart/mixed;
 boundary="------------0907E3D825C8371F67E79D17"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0907E3D825C8371F67E79D17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch extends the concept of Linux 2.6's dev_* logging macros to
support network devices.  Analogous netdev_* macros are defined.  This
feature is part of an effort to simplify error-log analysis by providing
more consistent and informative messages.

This is a modification of a proposal from May.  The changes reflect
suggestions made on LKML, at the Kernel Summit, and at OLS.

Calls to the netdev_* macros (netdev_printk and wrappers such as
netdev_err) are intended to replace calls to printk in network device
drivers.  These macros have the following characteristics:
- Same format + args as the corresponding printk call.
- Approximately the same amount of text as the corresponding printk call.
- The first arg is a pointer to the net_device struct.
- The second (optional) arg, which is a NETIF_MSG_* message level, can be
used to implement verbosity control.
- Standard message prefixes: verbose (see below) during probe, or just the
interface name once the device is registered.
- The current implementation just calls printk.  However, the netdev_*
interface (and availability of the net_device pointer) opens the door
for logging additional information (via printk, via evlog/netlink, etc.)
as desired, with no change to driver code.

Examples:
        netdev_err(netdev, RX_ERR, "No mem: dropped packet\n");
logs a message such as the following if the NETIF_MSG_RX_ERR bit is set
in netdev->msg_enable.
        eth2: No mem: dropped packet

        netdev_err(netdev,, "The EEPROM Checksum Is Not Valid\n");
unconditionally logs a message such as:
        eth%d (e1000 0000:00:03.0): The EEPROM Checksum Is Not Valid
The message's prefix includes the driver name and bus ID because the
message is logged at probe time, before netdev is registered.

Note that the netdev_* interface can be used in v2.4 drivers as well,
but in a v2.4 implementation, the message prefix would always be just
the interface name.

Three other patches are included in subsequent emails.  These patch
the e100, e1000, and tg3 Ethernet drivers to use the netdev_* macros.
(For e100 and e1000, they also add the necessary scaffolding for verbosity
control via the NETIF_MSG_* message levels).

Jim Keniston
IBM Linux Technology Center
-----
--------------0907E3D825C8371F67E79D17
Content-Type: text/plain; charset=us-ascii;
 name="netdev-2.6.0-test4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.0-test4.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Mon Aug 25 13:29:38 2003
+++ linux.netdev.patched/include/linux/netdevice.h	Mon Aug 25 13:29:38 2003
@@ -470,6 +470,9 @@
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
 
+	/* NETIF_MSG_* flags to control the types of events we log */
+	int msg_enable;
+
 	/* class/net/name entry */
 	struct class_device	class_dev;
 };
@@ -743,6 +746,8 @@
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+	NETIF_MSG_ALL		= -1,		/* always log message */
+	NETIF_MSG_		= -1		/* always log message */
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
@@ -869,6 +874,36 @@
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+/* debugging and troubleshooting/diagnostic helpers. */
+/**
+ * netdev_printk() - Log message with interface name, gated by message level
+ * @sevlevel: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @msglevel: a standard message-level flag with the NETIF_MSG_ prefix removed.
+ *	Unless msglevel is NETIF_MSG_ALL, or omitted, log the message only if
+ *	that flag is set in netdev->msg_enable.
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
 
 #endif /* __KERNEL__ */
 
diff -Naur linux.org/net/core/dev.c linux.netdev.patched/net/core/dev.c
--- linux.org/net/core/dev.c	Mon Aug 25 13:29:38 2003
+++ linux.netdev.patched/net/core/dev.c	Mon Aug 25 13:29:38 2003
@@ -3116,5 +3116,71 @@
 out:
 	return rc;
 }
-
 subsys_initcall(net_dev_init);
+
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
+		char msg[512];
+		va_list args;
+		struct device *dev = netdev->class_dev.dev;
+		
+		va_start(args, format);
+		vsnprintf(msg, 512, format, args);
+		va_end(args);
+
+		if (!sevlevel) {
+			sevlevel = "";
+		}
+		if (netdev->reg_state == NETREG_REGISTERED || !dev) {
+			printk("%s%s: %s", sevlevel, netdev->name, msg);
+		} else {
+			printk("%s%s (%s %s): %s", sevlevel, netdev->name,
+				dev->driver->name, dev->bus_id, msg);
+		}
+	}
+	return 0;
+}
diff -Naur linux.org/net/netsyms.c linux.netdev.patched/net/netsyms.c
--- linux.org/net/netsyms.c	Mon Aug 25 13:29:38 2003
+++ linux.netdev.patched/net/netsyms.c	Mon Aug 25 13:29:38 2003
@@ -210,6 +210,7 @@
 EXPORT_SYMBOL(net_ratelimit);
 EXPORT_SYMBOL(net_random);
 EXPORT_SYMBOL(net_srandom);
+EXPORT_SYMBOL(__netdev_printk);
 
 /* Needed by smbfs.o */
 EXPORT_SYMBOL(__scm_destroy);

--------------0907E3D825C8371F67E79D17--

