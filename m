Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbSJGCUw>; Sun, 6 Oct 2002 22:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSJGCUw>; Sun, 6 Oct 2002 22:20:52 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:63156 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262436AbSJGCUq>; Sun, 6 Oct 2002 22:20:46 -0400
To: torvalds@transmeta.com
Subject: [PATCH] Bluetooth kbuild fix and config cleanup
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com, marcel@holtmann.org
Message-Id: <E17yNaO-0001Rs-00@pegasus>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 07 Oct 2002 04:25:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.772, 2002-10-07 04:18:58+02:00, marcel@holtmann.org
  Bluetooth kbuild fix and config cleanup
  
  This patch removes the obsolete O_TARGET and cleans up the Config.*
  and *.c files to have a unique CONFIG_BLUEZ prefix. Additional two
  missing help entries are added.


 drivers/bluetooth/Makefile       |    2 +-
 net/bluetooth/Config.help        |   28 +---------------------------
 net/bluetooth/Config.in          |    4 +++-
 net/bluetooth/Makefile           |   26 ++++++++------------------
 net/bluetooth/bnep/Config.help   |   21 +++++++++++++++++++++
 net/bluetooth/bnep/Config.in     |    6 ++++--
 net/bluetooth/bnep/Makefile      |    7 +++----
 net/bluetooth/bnep/core.c        |   10 +++++-----
 net/bluetooth/bnep/netdev.c      |   12 ++++++------
 net/bluetooth/bnep/sock.c        |    2 +-
 net/bluetooth/rfcomm/Config.help |   12 ++++++++++++
 net/bluetooth/rfcomm/Config.in   |    4 +++-
 net/bluetooth/rfcomm/Makefile    |   10 +++++-----
 net/bluetooth/rfcomm/core.c      |    8 +++++++-
 net/bluetooth/rfcomm/sock.c      |    4 ++--
 net/bluetooth/rfcomm/tty.c       |    2 +-
 16 files changed, 83 insertions(+), 75 deletions(-)


diff -Nru a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
--- a/drivers/bluetooth/Makefile	Mon Oct  7 04:20:16 2002
+++ b/drivers/bluetooth/Makefile	Mon Oct  7 04:20:16 2002
@@ -1,5 +1,5 @@
 #
-# Makefile for Bluetooth HCI device drivers.
+# Makefile for the Linux Bluetooth HCI device drivers.
 #
 
 obj-$(CONFIG_BLUEZ_HCIUSB)	+= hci_usb.o
diff -Nru a/net/bluetooth/Config.help b/net/bluetooth/Config.help
--- a/net/bluetooth/Config.help	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/Config.help	Mon Oct  7 04:20:16 2002
@@ -10,8 +10,8 @@
                BlueZ Core (HCI device and connection manager, scheduler)
                HCI Device drivers (interface to the hardware)
                L2CAP Module (L2CAP protocol)
-               RFCOMM Module (RFCOMM protocol)
                SCO Module (SCO links)
+               RFCOMM Module (RFCOMM protocol)  
                BNEP Module (BNEP protocol)
 
   Say Y here to enable Linux Bluetooth support and to build BlueZ Core
@@ -33,19 +33,6 @@
   Say Y here to compile L2CAP support into the kernel or say M to
   compile it as module (l2cap.o).
 
-RFCOMM protocol support
-CONFIG_BLUEZ_RFCOMM
-  RFCOMM provides connection oriented stream transport. RFCOMM
-  support is required for Dialup Networking, OBEX and other Bluetooth
-  applications.
-
-  Say Y here to compile RFCOMM support into the kernel or say M to
-  compile it as module (rfcomm.o).
-
-RFCOMM TTY emulation support
-CONFIG_RFCOMM_TTY
-  This options enables TTY emulation support for RFCOMM channels.
-
 SCO links support
 CONFIG_BLUEZ_SCO
   SCO link provides voice transport over Bluetooth. SCO support is
@@ -53,17 +40,4 @@
 
   Say Y here to compile SCO support into the kernel or say M to
   compile it as module (sco.o).
-
-BNEP protocol support
-CONFIG_BLUEZ_BNEP
-  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
-  emulation layer on top of Bluetooth. BNEP is required for Bluetooth
-  PAN (Personal Area Network).
-
-  To use BNEP, you will need user-space utilities provided in the 
-  BlueZ-PAN package.
-  For more information, see <http://bluez.sourceforge.net>.
-
-  Say Y here to compile BNEP support into the kernel or say M to
-  compile it as module (bnep.o).
 
diff -Nru a/net/bluetooth/Config.in b/net/bluetooth/Config.in
--- a/net/bluetooth/Config.in	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/Config.in	Mon Oct  7 04:20:16 2002
@@ -1,8 +1,9 @@
 #
-# Bluetooth configuration
+# Bluetooth subsystem configuration
 #
 
 if [ "$CONFIG_NET" != "n" ]; then
+
    mainmenu_option next_comment
    comment 'Bluetooth support'
    dep_tristate 'Bluetooth subsystem support' CONFIG_BLUEZ $CONFIG_NET
@@ -14,6 +15,7 @@
       source net/bluetooth/bnep/Config.in
       source drivers/bluetooth/Config.in
    fi
+
    endmenu
 fi
 
diff -Nru a/net/bluetooth/Makefile b/net/bluetooth/Makefile
--- a/net/bluetooth/Makefile	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/Makefile	Mon Oct  7 04:20:16 2002
@@ -1,25 +1,15 @@
 #
-# Makefile for the Bluetooth subsystem
+# Makefile for the Linux Bluetooth subsystem.
 #
 
-export-objs	:= syms.o
+export-objs := syms.o
 
-obj-$(CONFIG_BLUEZ) += bluez.o
-obj-$(CONFIG_BLUEZ_L2CAP) += l2cap.o
-obj-$(CONFIG_BLUEZ_SCO) += sco.o
+obj-$(CONFIG_BLUEZ)		+= bluez.o
+obj-$(CONFIG_BLUEZ_L2CAP)	+= l2cap.o
+obj-$(CONFIG_BLUEZ_SCO)		+= sco.o
+obj-$(CONFIG_BLUEZ_RFCOMM)	+= rfcomm/
+obj-$(CONFIG_BLUEZ_BNEP)	+= bnep/
 
-subdir-$(CONFIG_BLUEZ_BNEP) += bnep
-
-ifeq ($(CONFIG_BLUEZ_BNEP),y)
-obj-y += bnep/bnep.o
-endif
-
-subdir-$(CONFIG_BLUEZ_RFCOMM) += rfcomm
-
-ifeq ($(CONFIG_BLUEZ_RFCOMM),y)
-obj-y += rfcomm/rfcomm.o
-endif
-
-bluez-objs	:= af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o lib.o syms.o
+bluez-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o lib.o syms.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Config.help b/net/bluetooth/bnep/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/bnep/Config.help	Mon Oct  7 04:20:16 2002
@@ -0,0 +1,21 @@
+BNEP protocol support
+CONFIG_BLUEZ_BNEP
+  BNEP (Bluetooth Network Encapsulation Protocol) is Ethernet
+  emulation layer on top of Bluetooth. BNEP is required for Bluetooth
+  PAN (Personal Area Network).
+
+  To use BNEP, you will need user-space utilities provided in the 
+  BlueZ-PAN package.
+  For more information, see <http://bluez.sourceforge.net>.
+
+  Say Y here to compile BNEP support into the kernel or say M to
+  compile it as module (bnep.o).
+
+BNEP multicast filter support
+CONFIG_BLUEZ_BNEP_MC_FILTER
+  This option enables the multicast filter support for BNEP.
+
+BNEP protocol filter support
+CONFIG_BLUEZ_BNEP_PROTO_FILTER
+  This option enables the protocol filter support for BNEP.
+
diff -Nru a/net/bluetooth/bnep/Config.in b/net/bluetooth/bnep/Config.in
--- a/net/bluetooth/bnep/Config.in	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/bnep/Config.in	Mon Oct  7 04:20:16 2002
@@ -1,6 +1,8 @@
 
 dep_tristate 'BNEP protocol support' CONFIG_BLUEZ_BNEP $CONFIG_BLUEZ_L2CAP
+
 if [ "$CONFIG_BLUEZ_BNEP" != "n" ]; then
-   bool '  Multicast filter support' CONFIG_BNEP_MC_FILTER
-   bool '  Protocol filter support'  CONFIG_BNEP_PROTO_FILTER
+   bool '  Multicast filter support' CONFIG_BLUEZ_BNEP_MC_FILTER
+   bool '  Protocol filter support'  CONFIG_BLUEZ_BNEP_PROTO_FILTER
 fi
+
diff -Nru a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
--- a/net/bluetooth/bnep/Makefile	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/bnep/Makefile	Mon Oct  7 04:20:16 2002
@@ -1,10 +1,9 @@
 #
-# Makefile for BNEP protocol
+# Makefile for the Linux Bluetooth BNEP layer.
 #
 
-O_TARGET := bnep.o
+obj-$(CONFIG_BLUEZ_BNEP) += bnep.o
 
-obj-y	 := core.o sock.o netdev.o crc32.o
-obj-m    += $(O_TARGET)
+bnep-objs := core.o sock.o netdev.o crc32.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
--- a/net/bluetooth/bnep/core.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/bnep/core.c	Mon Oct  7 04:20:16 2002
@@ -58,7 +58,7 @@
 
 #include "bnep.h"
 
-#ifndef CONFIG_BNEP_DEBUG
+#ifndef CONFIG_BLUEZ_BNEP_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
@@ -129,7 +129,7 @@
 
 	BT_DBG("filter len %d", n);
 
-#ifdef CONFIG_BNEP_PROTO_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_PROTO_FILTER
 	n /= 4;
 	if (n <= BNEP_MAX_PROTO_FILTERS) {
 		struct bnep_proto_filter *f = s->proto_filter;
@@ -171,7 +171,7 @@
 
 	BT_DBG("filter len %d", n);
 
-#ifdef CONFIG_BNEP_MC_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_MC_FILTER
 	n /= (ETH_ALEN * 2);
 
 	if (n > 0) {
@@ -545,12 +545,12 @@
 	
 	s->msg.msg_flags = MSG_NOSIGNAL;
 
-#ifdef CONFIG_BNEP_MC_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_MC_FILTER
 	/* Set default mc filter */
 	set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
 #endif
 	
-#ifdef CONFIG_BNEP_PROTO_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_PROTO_FILTER
 	/* Set default protocol filter */
 
 	/* (IPv4, ARP)  */
diff -Nru a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
--- a/net/bluetooth/bnep/netdev.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/bnep/netdev.c	Mon Oct  7 04:20:16 2002
@@ -46,7 +46,7 @@
 
 #include "bnep.h"
 
-#ifndef CONFIG_BNEP_DEBUG
+#ifndef CONFIG_BLUEZ_BNEP_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
 #endif
@@ -73,7 +73,7 @@
 
 static void bnep_net_set_mc_list(struct net_device *dev)
 {
-#ifdef CONFIG_BNEP_MC_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_MC_FILTER
 	struct bnep_session *s = dev->priv;
 	struct sock *sk = s->sock->sk;
 	struct bnep_set_filter_req *r;
@@ -143,7 +143,7 @@
 	return -EINVAL;
 }
 
-#ifdef CONFIG_BNEP_MC_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_MC_FILTER
 static inline int bnep_net_mc_filter(struct sk_buff *skb, struct bnep_session *s)
 {
 	struct ethhdr *eh = (void *) skb->data;
@@ -154,7 +154,7 @@
 }
 #endif
 
-#ifdef CONFIG_BNEP_PROTO_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_PROTO_FILTER
 /* Determine ether protocol. Based on eth_type_trans. */
 static inline u16 bnep_net_eth_proto(struct sk_buff *skb)
 {
@@ -192,14 +192,14 @@
 
 	BT_DBG("skb %p, dev %p", skb, dev);
 
-#ifdef CONFIG_BNEP_MC_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_MC_FILTER
 	if (bnep_net_mc_filter(skb, s)) {
 		kfree_skb(skb);
 		return 0;
 	}
 #endif
 	
-#ifdef CONFIG_BNEP_PROTO_FILTER
+#ifdef CONFIG_BLUEZ_BNEP_PROTO_FILTER
 	if (bnep_net_proto_filter(skb, s)) {
 		kfree_skb(skb);
 		return 0;
diff -Nru a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
--- a/net/bluetooth/bnep/sock.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/bnep/sock.c	Mon Oct  7 04:20:16 2002
@@ -50,7 +50,7 @@
 
 #include "bnep.h"
 
-#ifndef CONFIG_BNEP_DEBUG
+#ifndef CONFIG_BLUEZ_BNEP_DEBUG
 #undef  BT_DBG
 #define BT_DBG( A... )
 #endif
diff -Nru a/net/bluetooth/rfcomm/Config.help b/net/bluetooth/rfcomm/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/rfcomm/Config.help	Mon Oct  7 04:20:16 2002
@@ -0,0 +1,12 @@
+RFCOMM protocol support
+CONFIG_BLUEZ_RFCOMM
+  RFCOMM provides connection oriented stream transport. RFCOMM
+  support is required for Dialup Networking, OBEX and other Bluetooth
+  applications.
+
+  Say Y here to compile RFCOMM support into the kernel or say M to
+  compile it as module (rfcomm.o).
+
+RFCOMM TTY emulation support
+CONFIG_BLUEZ_RFCOMM_TTY
+  This option enables TTY emulation support for RFCOMM channels.
diff -Nru a/net/bluetooth/rfcomm/Config.in b/net/bluetooth/rfcomm/Config.in
--- a/net/bluetooth/rfcomm/Config.in	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/rfcomm/Config.in	Mon Oct  7 04:20:16 2002
@@ -1,5 +1,7 @@
 
 dep_tristate 'RFCOMM protocol support' CONFIG_BLUEZ_RFCOMM $CONFIG_BLUEZ_L2CAP
+
 if [ "$CONFIG_BLUEZ_RFCOMM" != "n" ]; then
-   bool '  RFCOMM TTY support' CONFIG_RFCOMM_TTY
+   bool '  RFCOMM TTY support' CONFIG_BLUEZ_RFCOMM_TTY
 fi
+
diff -Nru a/net/bluetooth/rfcomm/Makefile b/net/bluetooth/rfcomm/Makefile
--- a/net/bluetooth/rfcomm/Makefile	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/rfcomm/Makefile	Mon Oct  7 04:20:16 2002
@@ -1,11 +1,11 @@
 #
-# Makefile for BNEP protocol
+# Makefile for the Linux Bluetooth RFCOMM layer.
 #
 
-O_TARGET := rfcomm.o
+obj-$(CONFIG_BLUEZ_RFCOMM) += rfcomm.o
 
-obj-y	 := core.o sock.o crc.o
-obj-$(CONFIG_RFCOMM_TTY) += tty.o
-obj-m    += $(O_TARGET)
+rfcomm-y				:= core.o sock.o crc.o
+rfcomm-$(CONFIG_BLUEZ_RFCOMM_TTY)	+= tty.o
+rfcomm-objs				:= $(rfcomm-y)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/rfcomm/core.c	Mon Oct  7 04:20:16 2002
@@ -52,7 +52,7 @@
 
 #define VERSION "0.3"
 
-#ifndef CONFIG_RFCOMM_DEBUG
+#ifndef CONFIG_BLUEZ_RFCOMM_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
@@ -1679,7 +1679,10 @@
 	kernel_thread(rfcomm_run, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 
 	rfcomm_init_sockets();
+
+#ifdef CONFIG_BLUEZ_RFCOMM_TTY
 	rfcomm_init_ttys();
+#endif
 
 	BT_INFO("BlueZ RFCOMM ver %s", VERSION);
 	BT_INFO("Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>");
@@ -1698,7 +1701,10 @@
 	while (atomic_read(&running))
 		schedule();
 
+#ifdef CONFIG_BLUEZ_RFCOMM_TTY
 	rfcomm_cleanup_ttys();
+#endif
+
 	rfcomm_cleanup_sockets();
 	return;
 }
diff -Nru a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
--- a/net/bluetooth/rfcomm/sock.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/rfcomm/sock.c	Mon Oct  7 04:20:16 2002
@@ -53,7 +53,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/rfcomm.h>
 
-#ifndef CONFIG_RFCOMM_DEBUG
+#ifndef CONFIG_BLUEZ_RFCOMM_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
@@ -704,7 +704,7 @@
 
 	lock_sock(sk);
 
-#ifdef CONFIG_RFCOMM_TTY
+#ifdef CONFIG_BLUEZ_RFCOMM_TTY
 	err = rfcomm_dev_ioctl(sk, cmd, arg);
 #else
 	err = -EOPNOTSUPP;
diff -Nru a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c	Mon Oct  7 04:20:16 2002
+++ b/net/bluetooth/rfcomm/tty.c	Mon Oct  7 04:20:16 2002
@@ -40,7 +40,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/rfcomm.h>
 
-#ifndef CONFIG_RFCOMM_DEBUG
+#ifndef CONFIG_BLUEZ_RFCOMM_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch5505
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
D:M4A"@=Z":)TSORKEOY(^=?9='QH!T*XF$KKO]]&F_7G.0``
`
end
