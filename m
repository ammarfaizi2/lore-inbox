Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKOOMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKOOMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUKOOMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:12:41 -0500
Received: from ns.sbs.sk ([192.108.125.11]:61706 "EHLO alpha.sbs.sk")
	by vger.kernel.org with ESMTP id S261607AbUKOOKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:10:42 -0500
Message-ID: <4198B949.40504@siemens.com>
Date: Mon, 15 Nov 2004 15:12:25 +0100
From: Ferenci Daniel <Daniel.Ferenci@siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Subject: hdlc bridge
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Eis,
Hi linux folks,

excuse the newcommer, this is my first attempt to make a contribution.
I tried to keep all advices from the Documentation.

Change log:

HDLC bridge is kind of a stack for hdlc bridging.
It can be usefull for sniffing hdlc traffic (within two hdlc interface).

- why the kernel needed patching

I didn't find such functionality within the kernel tree.

 - the overall design approach in the patch

HDLC bridge is one of the network stacs.
Like other x25,lapb stacks also hdlc bridge stack is connected to the HW 
device via sethdlc command.

sethdlc hdlc0 hdlc-bridge
sethdlc hdlc1 hdlc-bridge

If you have two hdlc cards (like MOXA or TAHOE or any other) you can 
swith on bridging
via updated command sethdlc (new version is placed at 
htp://www.dafe.net/x25/) like:
and afterwards all traffic incoming to hdlc0 card is sent from hdlc1 
card and vice versa.
If you have switched #define DEBUG_PKT you can found all passing hdlc 
traffic in dmesg.

- implementation details

Principles of hdlc bridge stack is are the same like x25 or lapb stack.

- testing results

I tested it several times on several ATM maschines and CISCO devices and 
it worked without problem.

Signed-off-by: Daniel Ferenci <dafe@dafe.net>

---
diff --new-file -u --recursive linux-2.4.25/include/net/hdlcbridge.h 
linux-2.4.25.intel/include/net/hdlcbridge.h
--- linux-2.4.25/include/net/hdlcbridge.h    Thu Jan  1 01:00:00 1970
+++ linux-2.4.25.intel/include/net/hdlcbridge.h    Sat Nov 13 08:21:12 2004
@@ -0,0 +1,33 @@
+#ifndef _HDLCBRIDGE_H
+#define _HDLCBRIDGE_H
+
+/*
+    Definitions for hdlc bridge
+    
+    History
+    12.11.2004 Daniel Ferenci creation
+*/
+
+
+typedef enum {
+    PHYS_OK,
+    PHYS_NOK
+} STAT;
+
+typedef struct phys_bridge_register_struct {
+    int  (*tx)(struct sk_buff *skb, struct net_device *dev);
+} PHYS_BRIDGE_REGISTER_STRUCT;
+
+typedef struct bridge_pair
+{
+    hdlc_device *hdlc1;
+    struct phys_bridge_register_struct *cb1;
+    hdlc_device *hdlc2;
+    struct phys_bridge_register_struct *cb2;
+} BRIDGE_PAIR;
+
+int phys_bridge_register(hdlc_device *hdlc, struct 
phys_bridge_register_struct *callbacks);
+int phys_bridge_unregister(hdlc_device *hdlc);
+int phys_bridge_data_received(hdlc_device *hdlc, struct sk_buff *skb);
+
+#endif /* _HDLCBRIDGE_H */
--- linux-2.4.25/net/Config.in    Fri Nov 28 19:26:21 2003
+++ linux-2.4.25.intel/net/Config.in    Sat Nov 13 08:22:39 2004
@@ -1,6 +1,8 @@
 #
 # Network configuration
 #
+# 12.11.2004 Daniel Ferenci added parts for hdlcbridge
+
 mainmenu_option next_comment
 comment 'Networking options'
 tristate 'Packet socket' CONFIG_PACKET
@@ -9,6 +11,9 @@
 fi
 
 tristate 'Netlink device emulation' CONFIG_NETLINK_DEV
+tristate 'Netlink sockets' CONFIG_NETLINK
+
+tristate 'HDLC Bridging' CONFIG_HDLC_BRIDGE
 
 bool 'Network packet filtering (replaces ipchains)' CONFIG_NETFILTER
 if [ "$CONFIG_NETFILTER" = "y" ]; then
--- linux-2.4.25/net/Makefile    Fri Nov 28 19:26:21 2003
+++ linux-2.4.25.intel/net/Makefile    Sat Nov 13 08:22:14 2004
@@ -4,6 +4,9 @@
 # 2 Sep 2000, Christoph Hellwig <hch@infradead.org>
 # Rewritten to use lists instead of if-statements.
 #
+# 12.11.2004 Daniel Ferenci added hdlcbridge files
+
+
 
 O_TARGET :=    network.o
 
@@ -46,6 +49,7 @@
 subdir-$(CONFIG_DECNET)        += decnet
 subdir-$(CONFIG_ECONET)        += econet
 subdir-$(CONFIG_VLAN_8021Q)           += 8021q
+subdir-$(CONFIG_HDLC_BRIDGE)    += hdlcbridge
 
 ifeq ($(CONFIG_NETFILTER),y)
   mod-subdirs += ipv4/ipvs
diff --new-file -u --recursive linux-2.4.25/net/hdlcbridge/Makefile 
linux-2.4.25.intel/net/hdlcbridge/Makefile
--- linux-2.4.25/net/hdlcbridge/Makefile    Thu Jan  1 01:00:00 1970
+++ linux-2.4.25.intel/net/hdlcbridge/Makefile    Sat Nov 13 08:24:48 2004
@@ -0,0 +1,22 @@
+#
+# Makefile for the Linux HDLC Bridge
+#
+# History:
+#     12.11.2004 Daniel Ferenci creation
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now in the main makefile...
+
+
+O_TARGET := hdlcbridge.o
+
+export-objs := hdlc_bridge.o
+
+obj-y     := hdlc_bridge.o
+obj-m    := $(O_TARGET)
+
+include $(TOPDIR)/Rules.make
+
diff --new-file -u --recursive linux-2.4.25/net/hdlcbridge/hdlc_bridge.c 
linux-2.4.25.intel/net/hdlcbridge/hdlc_bridge.c
--- linux-2.4.25/net/hdlcbridge/hdlc_bridge.c    Thu Jan  1 01:00:00 1970
+++ linux-2.4.25.intel/net/hdlcbridge/hdlc_bridge.c    Sat Nov 13 
08:24:12 2004
@@ -0,0 +1,123 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/errno.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/pkt_sched.h>
+#include <linux/inetdevice.h>
+#include <linux/lapb.h>
+#include <linux/rtnetlink.h>
+#include <linux/hdlc.h>
+#include <net/hdlcbridge.h>
+/*    
+    Hdlc bridge main file
+    
+    hdlc bridge:
+    with sethdlc binary register first two hdlc devices
+    data will be bridged then
+    
+    History:
+    12.11.2004 Daniel Ferenci creation
+    
+*/
+
+
+/*
+    Register
+    register two first devices not more
+*/
+static struct bridge_pair my_pair = {NULL, NULL, NULL, NULL};
+
+int phys_bridge_register(hdlc_device *hdlc, struct 
phys_bridge_register_struct *callbacks)
+{
+    if (my_pair.hdlc1 == NULL )
+    {
+        /* register first device*/
+        my_pair.cb1 = (struct phys_bridge_register_struct *) 
kmalloc(sizeof(struct phys_bridge_register_struct), GFP_KERNEL);
+        my_pair.hdlc1 = hdlc;
+        my_pair.cb1->tx = callbacks->tx;
+        printk(KERN_ERR "First device %s registered.", 
hdlc_to_dev(hdlc)->name);
+    } else
+    if (my_pair.hdlc2 == NULL )
+    {
+        /* register second device*/
+        my_pair.cb2 = (struct phys_bridge_register_struct *) 
kmalloc(sizeof(struct phys_bridge_register_struct), GFP_KERNEL);
+        my_pair.hdlc2 = hdlc;
+        my_pair.cb2->tx = callbacks->tx;
+        printk(KERN_ERR "Second device %s registered.", 
hdlc_to_dev(hdlc)->name);
+    } else {
+        /* not more devices to register*/
+        printk(KERN_ERR "Not possible to register device %s.", 
hdlc_to_dev(hdlc)->name);
+        return PHYS_NOK;
+    }
+
+    return PHYS_OK;
+}
+
+int phys_bridge_unregister(hdlc_device *hdlc)
+{    
+    if (my_pair.hdlc1 == hdlc )
+    {
+        /* unregister first device*/
+        my_pair.hdlc1 = NULL;
+        kfree(my_pair.cb1);
+        my_pair.cb1 = NULL;
+        printk(KERN_ERR "First device %s unregistered.", 
hdlc_to_dev(hdlc)->name);
+    } else
+    if (my_pair.hdlc2 == hdlc )
+    {
+        /* unregister second device*/
+        my_pair.hdlc2 = NULL;
+        kfree(my_pair.cb2);
+        my_pair.cb2 = NULL;
+        printk(KERN_ERR "Second device %s unregistered.", 
hdlc_to_dev(hdlc)->name);
+    } else {
+        /* not more devices to register*/
+        printk(KERN_ERR "Not possible to unregister device %s.", 
hdlc_to_dev(hdlc)->name);
+        return PHYS_NOK;
+    }
+    return PHYS_OK;
+}
+
+int phys_bridge_data_received(hdlc_device *hdlc, struct sk_buff *skb)
+{
+    
+    printk(KERN_ERR "phys_bridge_data_received.");
+    
+    if (my_pair.hdlc1 == hdlc )
+    {
+        /* send the data to the side 2 */
+        my_pair.cb2->tx(skb, hdlc_to_dev(my_pair.hdlc2));
+    } else
+    if (my_pair.hdlc2 == hdlc )
+    {
+        /* send the data to the side 1 */
+        my_pair.cb1->tx(skb, hdlc_to_dev(my_pair.hdlc1));
+    } else {
+        /* not more devices to send */
+        return PHYS_NOK;
+    }
+    return PHYS_OK;
+}
+
+
+EXPORT_SYMBOL(phys_bridge_register);
+EXPORT_SYMBOL(phys_bridge_unregister);
+EXPORT_SYMBOL(phys_bridge_data_received);
+
+static char banner[] __initdata = KERN_ERR "HDLC Bridge for Linux 
version 0.0.1\n";
+
+static int __init bridge_init(void)
+{
+    printk(banner);
+    return 0;
+}
+
+MODULE_AUTHOR("Daniel Ferenci <dafe@dafe.net>");
+MODULE_DESCRIPTION("HDLC bridge");
+MODULE_LICENSE("GPL");
+
+module_init(bridge_init);
--- linux-2.4.25/drivers/net/wan/hdlc_bridge.c    Thu Jan  1 01:00:00 1970
+++ linux-2.4.25.intel/drivers/net/wan/hdlc_bridge.c    Sat Nov 13 
08:26:02 2004
@@ -0,0 +1,136 @@
+/*
+ * HDLC bridge support
+ *
+ * History:
+ * 12.11.2004 Daniel Ferenci creation
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/errno.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/pkt_sched.h>
+#include <linux/inetdevice.h>
+#include <linux/lapb.h>
+#include <linux/rtnetlink.h>
+#include <linux/hdlc.h>
+#include <net/hdlcbridge.h>
+
+/*static int bridge_xmit(struct sk_buff *skb, struct net_device *dev);
+static int bridge_open(hdlc_device *hdlc);
+static void bridge_close(hdlc_device *hdlc);
+static void bridge_rx(struct sk_buff *skb);*/
+
+/* These functions are callbacks called by PHYSICAL BRIDGE layer */
+static int bridge_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+    hdlc_device *hdlc = dev_to_hdlc(dev);
+    
+    printk(KERN_ERR "bridge_xmit device: %s", dev->name);
+    hdlc->xmit(skb, dev);
+    /*dev_kfree_skb(skb);*/
+    return 0;
+}
+
+
+
+static int bridge_open(hdlc_device *hdlc)
+{
+    struct phys_bridge_register_struct cb;
+    int result;
+    
+    printk(KERN_ERR "bridge_open device: %s", hdlc_to_dev(hdlc)->name);
+    cb.tx = bridge_xmit;
+    
+    result = phys_bridge_register(hdlc, &cb);
+    if (result != PHYS_NOK)
+        return result;
+    return 0;
+}
+
+
+
+static void bridge_close(hdlc_device *hdlc)
+{
+    printk(KERN_ERR "bridge_close device: %s", hdlc_to_dev(hdlc)->name);
+    phys_bridge_unregister(hdlc);
+}
+
+
+
+static void bridge_rx(struct sk_buff *skb)
+{
+    hdlc_device *hdlc = dev_to_hdlc(skb->dev);
+    
+    printk(KERN_ERR "bridge_rx device: %s", skb->dev->name);
+
+    if (phys_bridge_data_received(hdlc, skb) == PHYS_OK)
+        return;
+    hdlc->stats.rx_errors++;
+    dev_kfree_skb_any(skb);
+}
+
+
+
+int hdlc_bridge_ioctl(hdlc_device *hdlc, struct ifreq *ifr)
+{    
+    raw_hdlc_proto new_settings;
+    raw_hdlc_proto *raw_s = ifr->ifr_settings.ifs_ifsu.raw_hdlc;
+    const size_t size = sizeof(raw_hdlc_proto);
+    struct net_device *dev = hdlc_to_dev(hdlc);
+    int result;
+    
+    printk(KERN_DEBUG "hdlc_bridge_ioctl device: %s", 
hdlc_to_dev(hdlc)->name);
+    
+    switch (ifr->ifr_settings.type) {
+    case IF_GET_PROTO:
+        ifr->ifr_settings.type = IF_PROTO_X25;
+        return 0; /* return protocol only, no settable parameters */
+
+    case IF_PROTO_HDLC_BRIDGE:
+        if(!capable(CAP_NET_ADMIN))
+            return -EPERM;
+
+        if(dev->flags & IFF_UP)
+            return -EBUSY;
+        
+        if (copy_from_user(&new_settings, raw_s, size))
+            return -EFAULT;
+        
+        if (new_settings.encoding == ENCODING_DEFAULT)
+            new_settings.encoding = ENCODING_NRZ;
+
+        if (new_settings.parity == PARITY_DEFAULT)
+            new_settings.parity = PARITY_CRC16_PR1_CCITT;
+        
+        result = hdlc->attach(hdlc, new_settings.encoding,
+                      new_settings.parity);
+        if (result)
+            return result;
+        
+        hdlc_proto_detach(hdlc);
+
+        hdlc->open = bridge_open;
+        hdlc->stop = bridge_close;
+        hdlc->netif_rx = bridge_rx;
+        hdlc->type_trans = NULL;
+        hdlc->proto = IF_PROTO_HDLC;
+        dev->hard_start_xmit = bridge_xmit;
+        dev->hard_header = NULL;
+        dev->type = ARPHRD_RAWHDLC;
+        dev->addr_len = 0;
+    
+        return 0;
+    }
+
+    return -EINVAL;
+}
--- linux-2.4.25/drivers/net/wan/hdlc_generic.c    Wed Feb 18 14:36:31 2004
+++ linux-2.4.25.intel/drivers/net/wan/hdlc_generic.c    Sat Oct 30 
08:50:17 2004
@@ -107,6 +107,7 @@
     case IF_PROTO_CISCO:
     case IF_PROTO_FR:
     case IF_PROTO_X25:
+    case IF_PROTO_HDLC_BRIDGE:
         proto = ifr->ifr_settings.type;
         break;
 
@@ -121,6 +122,8 @@
     case IF_PROTO_CISCO:    return hdlc_cisco_ioctl(hdlc, ifr);
     case IF_PROTO_FR:    return hdlc_fr_ioctl(hdlc, ifr);
     case IF_PROTO_X25:    return hdlc_x25_ioctl(hdlc, ifr);
+    case IF_PROTO_LAPB:    return hdlc_x25_ioctl(hdlc, ifr);
+    case IF_PROTO_HDLC_BRIDGE: return hdlc_bridge_ioctl(hdlc, ifr);
     default:        return -EINVAL;
     }
 }
--- linux-2.4.25/include/linux/if.h    Fri Nov 28 19:26:21 2003
+++ linux-2.4.25.intel/include/linux/if.h    Sat Oct  2 08:09:35 2004
@@ -23,7 +23,9 @@
 #include <linux/socket.h>        /* for "struct sockaddr" et al    */
 
 #define    IFNAMSIZ    16
+
 #include <linux/hdlc/ioctl.h>
+#include <linux/lapb/ioctl.h>
 
 /* Standard interface flags (netdevice->flags). */
 #define    IFF_UP        0x1        /* interface is up        */
@@ -54,6 +56,7 @@
 
 #define IF_GET_IFACE    0x0001        /* for querying only */
 #define IF_GET_PROTO    0x0002
+#define IF_GET_ST3    0x0003
 
 /* For definitions see hdlc.h */
 #define IF_IFACE_V35    0x1000        /* V.35 serial interface    */
@@ -76,6 +79,9 @@
 #define IF_PROTO_FR_DEL_ETH_PVC 0x2009    /*  Delete FR 
Ethernet-bridged PVC */
 #define IF_PROTO_FR_PVC    0x200A        /* for reading PVC status    */
 #define IF_PROTO_FR_ETH_PVC 0x200B
+#define IF_PROTO_HDLC_BRIDGE 0x200C     /* hdlc bridge stack */
+#define IF_PROTO_HDLC_SEND 0x200D     /* hdlc bridge stack */
+#define IF_PROTO_LAPB 0x200E     /* lapb stack */
 
 
 /*
@@ -110,10 +116,13 @@
         fr_proto        *fr;
         fr_proto_pvc        *fr_pvc;
         fr_proto_pvc_info    *fr_pvc_info;
-
+        struct lapb_parms_struct    *lapb_stuff;
         /* interface settings */
         sync_serial_settings    *sync;
         te1_settings        *te1;
+        st3_status        *st3;
+        
+        buffer            *data;
     } ifs_ifsu;
 };
 
--- linux-2.4.25/drivers/net/wan/Makefile    Sat Nov 13 09:14:24 2004
+++ linux-2.4.25.intel/drivers/net/wan/Makefile    Sat Oct  2 08:04:28 2004
@@ -82,6 +82,9 @@
 obj-$(CONFIG_N2)        += n2.o
 obj-$(CONFIG_C101)        += c101.o
 obj-$(CONFIG_PCI200SYN)        += pci200syn.o
+obj-$(CONFIG_TAHOE9XX)        += tahoe9xx.o
+obj-$(CONFIG_X25TAP)        += x25tap.o
+
 
 include $(TOPDIR)/Rules.make
 


