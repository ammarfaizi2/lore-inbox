Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbUKVPSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUKVPSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUKVPRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:17:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:62915 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262136AbUKVPPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:15:38 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:14:22 -0800
Message-Id: <20041122714.AyIOvRY195EGFTaO@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:14:27.0524 (UTC) FILETIME=[F5344040:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add files to Documentation/infiniband that describe the tree under
/sys/class/infiniband, the IPoIB driver and the userspace MAD access driver.

Signed-off-by: Roland Dreier <roland@topspin.com>


Index: linux-bk/Documentation/infiniband/ipoib.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/Documentation/infiniband/ipoib.txt	2004-11-21 21:25:58.205565918 -0800
@@ -0,0 +1,55 @@
+IP OVER INFINIBAND
+
+  The ib_ipoib driver is an implementation of the IP over InfiniBand
+  protocol as specified by the latest Internet-Drafts issued by the
+  IETF ipoib working group.  It is a "native" implementation in the
+  sense of setting the interface type to ARPHRD_INFINIBAND and the
+  hardware address length to 20 (earlier proprietary implementations
+  masqueraded to the kernel as ethernet interfaces).
+
+Partitions and P_Keys
+
+  When the IPoIB driver is loaded, it creates one interface for each
+  port using the P_Key at index 0.  To create an interface with a
+  different P_Key, write the desired P_Key into the main interface's
+  /sys/class/net/<intf name>/create_child file.  For example:
+
+    echo 0x8001 > /sys/class/net/ib0/create_child
+
+  This will create an interface named ib0.8001 with P_Key 0x8001.  To
+  remove a subinterface, use the "delete_child" file:
+
+    echo 0x8001 > /sys/class/net/ib0/delete_child
+
+  The P_Key for any interface is given by the "pkey" file, and the
+  main interface for a subinterface is in "parent."
+
+Debugging Information
+
+  By compiling the IPoIB driver with CONFIG_INFINIBAND_IPOIB_DEBUG set
+  to 'y', tracing messages are compiled into the driver.  They are
+  turned on by setting the module parameters debug_level and
+  mcast_debug_level to 1.  These parameters can be controlled at
+  runtime through files in /sys/module/ib_ipoib/.
+
+  CONFIG_INFINIBAND_IPOIB_DEBUG also enables the "ipoib_debugfs"
+  virtual filesystem.  By mounting this filesystem, for example with
+
+    mkdir -p /ipoib_debugfs
+    mount -t ipoib_debugfs none /ipoib_debufs
+
+  it is possible to get statistics about multicast groups from the
+  files /ipoib_debugfs/ib0_mcg and so on.
+
+  The performance impact of this option is negligible, so it
+  is safe to enable this option with debug_level set to 0 for normal
+  operation.
+
+  CONFIG_INFINIBAND_IPOIB_DEBUG_DATA enables even more debug output
+  in the data path when debug_level is set to 2.  However, even with
+  the output disabled, this option will affect performance.
+
+References
+
+  IETF IP over InfiniBand (ipoib) Working Group
+    http://ietf.org/html.charters/ipoib-charter.html
Index: linux-bk/Documentation/infiniband/sysfs.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/Documentation/infiniband/sysfs.txt	2004-11-21 21:25:58.231562062 -0800
@@ -0,0 +1,63 @@
+SYSFS FILES
+
+  For each InfiniBand device, the InfiniBand drivers create the
+  following files under /sys/class/infiniband/<device name>:
+
+    node_guid      - Node GUID
+    sys_image_guid - System image GUID
+
+  In addition, there is a "ports" subdirectory, with one subdirectory
+  for each port.  For example, if mthca0 is a 2-port HCA, there will
+  be two directories:
+
+    /sys/class/infiniband/mthca0/ports/1
+    /sys/class/infiniband/mthca0/ports/2
+
+  (A switch will only have a single "0" subdirectory for switch port
+  0; no subdirectory is created for normal switch ports)
+
+  In each port subdirectory, the following files are created:
+
+    cap_mask       - Port capability mask
+    lid            - Port LID
+    lid_mask_count - Port LID mask count
+    sm_lid         - Subnet manager LID for port's subnet
+    sm_sl          - Subnet manager SL for port's subnet
+    state          - Port state (DOWN, INIT, ARMED, ACTIVE or ACTIVE_DEFER)
+
+  There is also a "counters" subdirectory, with files
+
+    VL15_dropped
+    excessive_buffer_overrun_errors
+    link_downed
+    link_error_recovery
+    local_link_integrity_errors
+    port_rcv_constraint_errors
+    port_rcv_data
+    port_rcv_errors
+    port_rcv_packets
+    port_rcv_remote_physical_errors
+    port_rcv_switch_relay_errors
+    port_xmit_constraint_errors
+    port_xmit_data
+    port_xmit_discards
+    port_xmit_packets
+    symbol_error
+
+  Each of these files contains the corresponding value from the port's
+  Performance Management PortCounters attribute, as described in
+  section 16.1.3.5 of the InfiniBand Architecture Specification.
+
+  The "pkeys" and "gids" subdirectories contain one file for each
+  entry in the port's P_Key or GID table respectively.  For example,
+  ports/1/pkeys/10 contains the value at index 10 in port 1's P_Key
+  table.
+
+MTHCA
+
+  The Mellanox HCA driver also creates the files:
+
+    hw_rev   - Hardware revision number
+    fw_ver   - Firmware version
+    hca_type - HCA type: "MT23108", "MT25208 (MT23108 compat mode)",
+               or "MT25208"
Index: linux-bk/Documentation/infiniband/user_mad.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/Documentation/infiniband/user_mad.txt	2004-11-21 21:25:58.258558058 -0800
@@ -0,0 +1,77 @@
+USERSPACE MAD ACCESS
+
+Device files
+
+  Each port of each InfiniBand device has a "umad" device attached.
+  For example, a two-port HCA will have two devices, while a switch
+  will have one device (for switch port 0).
+
+Creating MAD agents
+
+  A MAD agent can be created by filling in a struct ib_user_mad_reg_req
+  and then calling the IB_USER_MAD_REGISTER_AGENT ioctl on a file
+  descriptor for the appropriate device file.  If the registration
+  request succeeds, a 32-bit id will be returned in the structure.
+  For example:
+
+	struct ib_user_mad_reg_req req = { /* ... */ };
+	ret = ioctl(fd, IB_USER_MAD_REGISTER_AGENT, (char *) &req);
+        if (!ret)
+		my_agent = req.id;
+	else
+		perror("agent register");
+
+  Agents can be unregistered with the IB_USER_MAD_UNREGISTER_AGENT
+  ioctl.  Also, all agents registered through a file descriptor will
+  be unregistered when the descriptor is closed.
+
+Receiving MADs
+
+  MADs are received using read().  The buffer passed to read() must be
+  large enough to hold at least one struct ib_user_mad.  For example:
+
+	struct ib_user_mad mad;
+	ret = read(fd, &mad, sizeof mad);
+	if (ret != sizeof mad)
+		perror("read");
+
+  In addition to the actual MAD contents, the other struct ib_user_mad
+  fields will be filled in with information on the received MAD.  For
+  example, the remote LID will be in mad.lid.
+
+  If a send times out, a receive will be generated with mad.status set
+  to ETIMEDOUT.  Otherwise when a MAD has been successfully received,
+  mad.status will be 0.
+
+  poll()/select() may be used to wait until a MAD can be read.
+
+Sending MADs
+
+  MADs are sent using write().  The agent ID for sending should be
+  filled into the id field of the MAD, the destination LID should be
+  filled into the lid field, and so on.  For example:
+
+	struct ib_user_mad mad;
+
+	/* fill in mad.data */
+
+	mad.id  = my_agent;	/* req.id from agent registration */
+	mad.lid = my_dest;	/* in network byte order... */
+	/* etc. */
+
+	ret = write(fd, &mad, sizeof mad);
+	if (ret != sizeof mad)
+		perror("write");
+
+/dev files
+
+  To create the appropriate character device files automatically with
+  udev, a rule like
+
+    KERNEL="umad*", NAME="infiniband/%s{ibdev}/ports/%s{port}/mad"
+
+  can be used.  This will create a device node named
+
+    /dev/infiniband/mthca0/ports/1/mad
+
+  for port 1 of device mthca0, and so on.

