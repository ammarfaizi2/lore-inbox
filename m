Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTEXGL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 02:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTEXGL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 02:11:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:13797 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264002AbTEXGL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 02:11:26 -0400
Message-ID: <3ECF0F64.AAD25389@us.ibm.com>
Date: Fri, 23 May 2003 23:21:24 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Anton Blanchard <anton@samba.org>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>, Phil Cayton <phil.cayton@intel.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: [RFC] [PATCH] Net device error logging (revised)
Content-Type: multipart/mixed;
 boundary="------------60908C773F8A441759937571"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------60908C773F8A441759937571
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch extends the concept of Linux 2.5's dev_* logging macros to
support network devices.  Analogous netdev_* macros are defined.  This
feature is part of an effort to simplify error-log analysis by programs
(such as health/configuration monitors) and by ordinary people who need
clearer error reporting.

This is a modification of a proposal from earlier this month.  The
changes reflect suggestions and recent changes in the net-driver
infrastructure:

- With Steve Hemminger's creation of the "net" device class a few days
ago, the network device's interface name is now sufficient to find the
information about the underlying device in sysfs (even without running
ethtool).  So these macros no longer log the device's driver name and
bus ID.

- Several people have recommended that the netdev_* macros should
support screening of messages using the NETIF_MSG_* message levels.
In response, I've added an optional arg to the macros by which the caller
can indicate under what circumstances the message is to be logged.

MESSAGE-LEVEL SUPPORT
Drivers that currently use the NETIF_MSG_* message levels to screen
messages include a bitmap called msg_enable in their driver-private
data.  Then they do something like
	if (netif_msg_rx_err(privdata)) {
		printk(KERN_ERR "%s: No mem: dropped packet\n", netdev->name);
	}
Using these new macros, this could be expressed as
	netdev_err(netdev, RX_ERR, "No mem: dropped packet\n");

To log a message unconditionally, omit the message-level arg or specify
ALL:
	netdev_err(netdev,, "Fatal bus error...\n");
or
	netdev_err(netdev, ALL, "Fatal bus error...\n");

This feature requires the msg_enable bitmap to be moved to the net_device
struct.  (This also means that the ETHTOOL_GMSGLVL and ETHTOOL_SMSGLVL
ioctl requests can be coded once rather than copied and pasted from driver
to driver.  This goes for 4 other ETHTOOL_* requests as well.  Code for
ethtool_common_request(), which implements these 6 requests, is available
on request.)

Jim Keniston
IBM Linux Technology Center
-----
--------------60908C773F8A441759937571
Content-Type: text/plain; charset=us-ascii;
 name="netdev_printk-2.5.69.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev_printk-2.5.69.patch"

diff -Naur linux.org/include/linux/netdevice.h linux.netdev_printk.patched/include/linux/netdevice.h
--- linux.org/include/linux/netdevice.h	Fri May 23 21:35:22 2003
+++ linux.netdev_printk.patched/include/linux/netdevice.h	Fri May 23 21:35:22 2003
@@ -444,6 +444,9 @@
 	struct divert_blk	*divert;
 #endif /* CONFIG_NET_DIVERT */
 
+	/* NETIF_MSG_* flags to control the types of events we log */
+	int msg_enable;
+
 	/* generic object representation */
 	struct kobject kobj;
 };
@@ -708,6 +711,8 @@
 	NETIF_MSG_PKTDATA	= 0x1000,
 	NETIF_MSG_HW		= 0x2000,
 	NETIF_MSG_WOL		= 0x4000,
+	NETIF_MSG_ALL		= -1,		/* always log message */
+	NETIF_MSG_		= -1		/* always log message */
 };
 
 #define netif_msg_drv(p)	((p)->msg_enable & NETIF_MSG_DRV)
@@ -835,6 +840,35 @@
 extern void		dev_clear_fastroute(struct net_device *dev);
 #endif
 
+/* debugging and troubleshooting/diagnostic helpers. */
+/**
+ * netdev_printk() - Log message with interface name, driver name, bus ID.
+ * @sevlevel: severity level -- e.g., KERN_INFO
+ * @netdev: net_device pointer
+ * @msglevel: a standard message-level flag with the NETIF_MSG_ prefix removed.
+ *	Unless msglevel is NETIF_MSG_ALL, or omitted, log the message only if
+ *	that flag is set in netdev->msg_enable.
+ * @format: as with printk
+ * @args: as with printk
+ */
+#define netdev_printk(sevlevel, netdev, msglevel, format, arg...)	\
+	(void) ( (NETIF_MSG_##msglevel == NETIF_MSG_ALL			\
+		|| ((netdev)->msg_enable & NETIF_MSG_##msglevel)) &&	\
+		printk(sevlevel "%s: " format , (netdev)->name , ## arg) )
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
 

--------------60908C773F8A441759937571--

