Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268833AbRHPVKT>; Thu, 16 Aug 2001 17:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRHPVKH>; Thu, 16 Aug 2001 17:10:07 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:1462 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S268022AbRHPVJl>;
	Thu, 16 Aug 2001 17:09:41 -0400
Message-ID: <3B7C36A0.A777DF35@candelatech.com>
Date: Thu, 16 Aug 2001 14:09:52 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 802.1Q VLAN 1.4 released.
Content-Type: multipart/mixed;
 boundary="------------84C952EDACA00023A1CA6768"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------84C952EDACA00023A1CA6768
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch adds 802.1Q VLAN support to the linux kernel.
You can learn more at: http://scry.wanfear.com/~greear/vlan.html

This patch fixes several bugs and removes a dependency on the
/proc interface.  It should be close to passing muster with the
network code maintainers, and so may be a cantidate for kernel
inclusion.  Please let me know if you have any suggestions or
corrections to the patch.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
--------------84C952EDACA00023A1CA6768
Content-Type: text/plain; charset=us-ascii;
 name="vlan_2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vlan_2.4.patch"

diff -u -r -N -X /home/greear/exclude.list linux/include/linux/if.h linux.dev/include/linux/if.h
--- linux/include/linux/if.h	Fri Aug 10 18:13:47 2001
+++ linux.dev/include/linux/if.h	Thu Aug 16 10:09:14 2001
@@ -22,7 +22,7 @@
 #include <linux/types.h>		/* for "__kernel_caddr_t" et al	*/
 #include <linux/socket.h>		/* for "struct sockaddr" et al	*/
 
-/* Standard interface flags. */
+/* Standard interface flags (netdevice->flags). */
 #define	IFF_UP		0x1		/* interface is up		*/
 #define	IFF_BROADCAST	0x2		/* broadcast address valid	*/
 #define	IFF_DEBUG	0x4		/* turn on debugging		*/
@@ -44,6 +44,11 @@
 #define IFF_PORTSEL	0x2000          /* can set media type		*/
 #define IFF_AUTOMEDIA	0x4000		/* auto media select active	*/
 #define IFF_DYNAMIC	0x8000		/* dialup device with changing addresses*/
+
+
+/* This defines netdevice->more_flags */
+#define IFF_802_1Q_VLAN 0x1             /* 802.1Q VLAN device.          */
+
 
 /*
  *	Device mapping structure. I'd just gone off and designed a 
diff -u -r -N -X /home/greear/exclude.list linux/include/linux/if_ether.h linux.dev/include/linux/if_ether.h
--- linux/include/linux/if_ether.h	Thu Apr 19 08:38:50 2001
+++ linux.dev/include/linux/if_ether.h	Wed Aug 15 22:25:03 2001
@@ -56,6 +56,7 @@
 #define ETH_P_RARP      0x8035		/* Reverse Addr Res packet	*/
 #define ETH_P_ATALK	0x809B		/* Appletalk DDP		*/
 #define ETH_P_AARP	0x80F3		/* Appletalk AARP		*/
+#define ETH_P_8021Q	0x8100          /* 802.1Q VLAN Extended Header  */
 #define ETH_P_IPX	0x8137		/* IPX over DIX			*/
 #define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
 #define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
diff -u -r -N -X /home/greear/exclude.list linux/include/linux/if_vlan.h linux.dev/include/linux/if_vlan.h
--- linux/include/linux/if_vlan.h	Wed Dec 31 17:00:00 1969
+++ linux.dev/include/linux/if_vlan.h	Thu Aug 16 10:41:56 2001
@@ -0,0 +1,290 @@
+/* -*- linux-c -*-
+ * VLAN		An implementation of 802.1Q VLAN tagging.
+ *
+ *  For some idea of the architecture, see the web page at (curently):
+ *    http://scry.wanfear.com/~greear/vlan.html
+ *
+ *  Also, I will put comments in this file to try to explain some general
+ *  architecture. --Ben
+ *
+ *
+ * Authors:	Ben Greear <greearb@candelatech.com>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef _LINUX_IF_VLAN_H_
+#define _LINUX_IF_VLAN_H_
+
+#ifdef __KERNEL__
+
+
+/* externally defined structs */
+struct vlan_group;
+struct net_device;
+struct sk_buff;
+struct packet_type;
+struct vlan_collection;
+struct vlan_dev_info;
+
+#include <linux/proc_fs.h> /* for proc_dir_entry */
+#include <linux/netdevice.h>
+
+
+#define VLAN_HLEN       4               /* The additional bytes (on top of the Ethernet header)
+                                         * that VLAN requires.
+                                         */
+
+#define VLAN_ETH_ALEN	6		/* Octets in one ethernet addr	 */
+#define VLAN_ETH_HLEN	18		/* Total octets in header.	 */
+#define VLAN_ETH_ZLEN	64		/* Min. octets in frame sans FCS */
+
+/*
+ * According to 802.3ac, the packet can be 4 bytes longer. --Klika Jan
+ */
+#define VLAN_ETH_DATA_LEN	1500	/* Max. octets in payload	 */
+#define VLAN_ETH_FRAME_LEN	1518	/* Max. octets in frame sans FCS */
+
+struct vlan_ethhdr {
+   unsigned char	h_dest[ETH_ALEN];	   /* destination eth addr	*/
+   unsigned char	h_source[ETH_ALEN];	   /* source ether addr	*/
+   unsigned short       h_vlan_proto;              /* Should always be 0x8100 */
+   unsigned short       h_vlan_TCI;                /* Encapsulates priority and VLAN ID */
+   unsigned short	h_vlan_encapsulated_proto; /* packet type ID field (or len) */
+};
+
+struct vlan_hdr {
+   unsigned short       h_vlan_TCI;                /* Encapsulates priority and VLAN ID */
+   unsigned short       h_vlan_encapsulated_proto; /* packet type ID field (or len) */
+};
+
+
+
+/*  Find a VLAN device by the MAC address of it's Ethernet device, and
+ *  it's VLAN ID.  The default configuration is to have VLAN's scope
+ *  to be box-wide, so the MAC will be ignored.  The mac will only be
+ *  looked at if we are configured to have a seperate set of VLANs per
+ *  each MAC addressable interface.  Note that this latter option does
+ *  NOT follow the spec for VLANs, but may be useful for doing very
+ *  large quantities of VLAN MUX/DEMUX onto FrameRelay or ATM PVCs.
+ */
+struct net_device *find_802_1Q_vlan_dev(struct net_device* real_dev,
+                                        unsigned short VID); /* vlan.c */
+
+
+/* found in netsyms.c */
+extern int (*vlan_ioctl_hook)(unsigned long arg);
+
+
+/* found in vlan_dev.c */
+struct net_device_stats* vlan_dev_get_stats(struct net_device* dev);
+int vlan_dev_rebuild_header(struct sk_buff *skb);
+int vlan_skb_recv(struct sk_buff *skb, struct net_device *dev,
+                  struct packet_type* ptype);
+int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
+                         unsigned short type, void *daddr, void *saddr,
+                         unsigned len);
+int vlan_dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev);
+int vlan_dev_change_mtu(struct net_device *dev, int new_mtu);
+int vlan_dev_set_mac_address(struct net_device *dev, void* addr);
+int vlan_dev_open(struct net_device* dev);
+int vlan_dev_stop(struct net_device* dev);
+int vlan_dev_init(struct net_device* dev);
+void vlan_dev_destruct(struct net_device* dev);
+/*  I'm ignorant of these right now. --BLG
+    int vlan_dev_header_cache(struct neighbour *neigh, struct hh_cache *hh);
+    void vlan_dev_header_cache_update(struct hh_cache *hh, struct device *dev,
+    unsigned char * haddr);
+*/
+void vlan_dev_copy_and_sum(struct sk_buff *dest, unsigned char *src,
+                           int length, int base);
+int vlan_dev_set_ingress_priority(char* dev_name, __u32 skb_prio, short vlan_prio);
+int vlan_dev_set_egress_priority(char* dev_name, __u32 skb_prio, short vlan_prio);
+int vlan_dev_set_vlan_flag(char* dev_name, __u32 flag, short flag_val);
+
+/* VLAN multicast stuff */
+/* Delete all of the MC list entries from this vlan device.  Also deals
+ * with the underlying device...
+ */
+void vlan_flush_mc_list(struct net_device* dev);
+/* copy the mc_list into the vlan_info structure. */
+void vlan_copy_mc_list(struct dev_mc_list* mc_list, struct vlan_dev_info* vlan_info);
+/** dmi is a single entry into a dev_mc_list, a single node.  mc_list is
+ *  an entire list, and we'll iterate through it.
+ */
+int vlan_should_add_mc(struct dev_mc_list *dmi, struct dev_mc_list *mc_list);
+/** Taken from Gleb + Lennert's VLAN code, and modified... */
+void vlan_dev_set_multicast_list(struct net_device *vlan_dev);
+
+
+int vlan_collection_add_vlan(struct vlan_collection* vc, unsigned short vlan_id,
+                             unsigned short flags);
+int vlan_collection_remove_vlan(struct vlan_collection* vc,
+                                struct net_device* vlan_dev);
+int vlan_collection_remove_vlan_id(struct vlan_collection* vc, unsigned short vlan_id);
+
+
+
+/* found in vlan.c */
+/* Our listing of VLAN group(s) */
+extern struct vlan_group* p802_1Q_vlan_list;
+
+
+#define VLAN_NAME "vlan"
+
+/* if this changes, algorithm will have to be reworked because this
+ * depends on completely exhausting the VLAN identifier space.  Thus
+ * it gives constant time look-up, but it many cases it wastes memory.
+ */
+#define VLAN_GROUP_ARRAY_LEN 4096
+
+struct vlan_group {
+        int real_dev_ifindex; /* The ifindex of the ethernet(like) device the vlan is attached to. */
+        struct net_device* vlan_devices[VLAN_GROUP_ARRAY_LEN];
+   
+        struct vlan_group* next; /* the next in the list */
+};
+
+
+struct vlan_priority_tci_mapping {
+        unsigned long priority;
+        unsigned short vlan_qos; /* This should be shifted when first set, so we only do it
+                                  * at provisioning time.
+                                  * ((skb->priority << 13) & 0xE000)
+                                  */
+        struct vlan_priority_tci_mapping* next;
+};
+
+
+
+/* Holds information that makes sense if this device is a VLAN device. */
+struct vlan_dev_info {
+        /** This will be the mapping that correlates skb->priority to
+         * 3 bits of VLAN QOS tags...
+         */
+        unsigned long ingress_priority_map[8];
+        struct vlan_priority_tci_mapping* egress_priority_map[16]; /* hash table */
+
+        unsigned short vlan_id;        /*  The VLAN Identifier for this interface. */
+        unsigned short flags;          /* (1 << 0) re_order_header   This option will cause the
+                                        *   VLAN code to move around the ethernet header on
+                                        *   ingress to make the skb look **exactly** like it
+                                        *   came in from an ethernet port.  This destroys some of
+                                        *   the VLAN information in the skb, but it fixes programs
+                                        *   like DHCP that use packet-filtering and don't understand
+                                        *   802.1Q
+                                        */
+        struct dev_mc_list* old_mc_list;  /* old multi-cast list for the VLAN interface..
+                                           * we save this so we can tell what changes were
+                                           * made, in order to feed the right changes down
+                                           * to the real hardware...
+                                           */
+        int old_allmulti;               /* similar to above. */
+        int old_promiscuity;            /* similar to above. */
+        struct net_device* real_dev;    /* the underlying device/interface */
+        struct proc_dir_entry* dent;    /* Holds the proc data */
+        unsigned long cnt_inc_headroom_on_tx; /* How many times did we have to grow the skb on TX. */
+        unsigned long cnt_encap_on_xmit;      /* How many times did we have to encapsulate the skb on TX. */
+        struct net_device_stats dev_stats; /* Device stats (rx-bytes, tx-pkts, etc...) */
+};
+
+
+#define VLAN_DEV_INFO(x) ((struct vlan_dev_info*)(x->priv))
+
+/* inline functions */
+
+/* Used in vlan_skb_recv */
+static inline struct sk_buff* vlan_check_reorder_header(struct sk_buff *skb) {
+        if (VLAN_DEV_INFO(skb->dev)->flags & 1) {
+                skb = skb_share_check(skb, GFP_ATOMIC);
+                if (skb) {
+                        /* Lifted from Gleb's VLAN code... */
+                        memmove(skb->data - ETH_HLEN, skb->data - VLAN_ETH_HLEN, 12);
+                        skb->mac.raw += VLAN_HLEN;
+                }
+        }
+
+        return skb;
+}/* vlan_check_reorder_header */
+
+static inline unsigned short vlan_dev_get_egress_qos_mask(struct net_device* dev, struct sk_buff* skb) {
+        struct vlan_priority_tci_mapping* mp = VLAN_DEV_INFO(dev)->egress_priority_map[(skb->priority & 0xF)];
+        while (mp) {
+                if (mp->priority == skb->priority) {
+                        return mp->vlan_qos; /* This should already be shifted to mask correctly with
+                                              * the VLAN's TCI
+                                              */
+                }
+                mp = mp->next;
+        }
+        return 0;
+}
+
+   
+static inline int vlan_dmi_equals(struct dev_mc_list *dmi1,
+                                  struct dev_mc_list *dmi2) {
+        return ((dmi1->dmi_addrlen == dmi2->dmi_addrlen) &&
+                (memcmp(dmi1->dmi_addr, dmi2->dmi_addr, dmi1->dmi_addrlen) == 0));
+}
+
+static inline void vlan_destroy_mc_list(struct dev_mc_list *mc_list) {
+        struct dev_mc_list *dmi = mc_list, *next;
+
+        while(dmi) {
+                next = dmi->next;
+                kfree(dmi);
+                dmi = next;
+        }
+}
+
+#endif /* __KERNEL__ */
+
+
+/* NOTE:  There is now only two VLAN IOCTLs, and they are found in sockios.h:   
+#define SIOCGIFVLAN	0x8982		 802.1Q VLAN support		
+#define SIOCSIFVLAN	0x8983		 Set 802.1Q VLAN options 	
+*/
+
+/* Passed in vlan_ioctl_args structure to determine behaviour. */
+enum vlan_ioctl_cmds {
+        ADD_VLAN_CMD,
+        DEL_VLAN_CMD,
+        SET_VLAN_INGRESS_PRIORITY_CMD,
+        SET_VLAN_EGRESS_PRIORITY_CMD,
+        GET_VLAN_INGRESS_PRIORITY_CMD,
+        GET_VLAN_EGRESS_PRIORITY_CMD,
+        SET_VLAN_NAME_TYPE_CMD,
+        SET_VLAN_FLAG_CMD
+}; /* vlan_ioctl_cmds enum */
+
+
+enum vlan_name_types {
+        VLAN_NAME_TYPE_PLUS_VID, /* Name will look like:  vlan0005 */
+        VLAN_NAME_TYPE_RAW_PLUS_VID, /* name will look like:  eth1.0005 */
+        VLAN_NAME_TYPE_PLUS_VID_NO_PAD, /* Name will look like:  vlan5 */
+        VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD, /* Name will look like:  eth0.5 */
+        VLAN_NAME_TYPE_HIGHEST
+};
+
+struct vlan_ioctl_args {
+        int cmd; /* Should be one of the vlan_ioctl_cmds enum above. */
+        char device1[24];
+
+        union {
+                char device2[24];
+                int VID;
+                unsigned long skb_priority;
+                unsigned long name_type;
+                unsigned long bind_type;
+                unsigned long flag; /* Matches vlan_dev_info flags */
+        } u;
+
+        short vlan_qos;   
+};
+
+
+#endif
diff -u -r -N -X /home/greear/exclude.list linux/include/linux/netdevice.h linux.dev/include/linux/netdevice.h
--- linux/include/linux/netdevice.h	Thu Aug 16 13:40:02 2001
+++ linux.dev/include/linux/netdevice.h	Thu Aug 16 10:09:14 2001
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #ifdef CONFIG_NET_PROFILE
 #include <net/profile.h>
+
 #endif
 
 struct divert_blk;
@@ -183,12 +184,16 @@
 {
 	struct hh_cache *hh_next;	/* Next entry			     */
 	atomic_t	hh_refcnt;	/* number of users                   */
-	unsigned short  hh_type;	/* protocol identifier, f.e ETH_P_IP */
+	unsigned short  hh_type;	/* protocol identifier, f.e ETH_P_IP
+                                         *  NOTE:  For VLANs, this will be the
+                                         *  encapuslated type. --BLG
+                                         */
 	int		hh_len;		/* length of header */
 	int		(*hh_output)(struct sk_buff *skb);
 	rwlock_t	hh_lock;
 	/* cached hardware header; allow for machine alignment needs.        */
-	unsigned long	hh_data[16/sizeof(unsigned long)];
+
+  	unsigned long	hh_data[16/sizeof(unsigned long)];
 };
 
 /* These flag bits are private to the generic network queueing
@@ -285,8 +290,19 @@
 	unsigned long		trans_start;	/* Time (in jiffies) of last Tx	*/
 	unsigned long		last_rx;	/* Time of last Rx	*/
 
-	unsigned short		flags;	/* interface flags (a la BSD)	*/
+        unsigned short		flags; /* defined in if.h */
 	unsigned short		gflags;
+        unsigned short          more_flags; /* defined in if.h  We already have 16 flags defined for the
+                                             * 'flags' 2-byte variable above.  I tried changing it to 32
+                                             * bits, but when you 'ifconfig vlanXX 2.2.2.2 up', for instance,
+                                             * the high flags are re-set to zero.  I'm sure that someone,
+                                             * somewhere, is AND-ing the flags with 0xFFFF, and it may be
+                                             * user-space.
+                                             */
+        unsigned short          unused_alignment_fixer; /* Because we need more_flags,
+                                                         * and we want to be 32-bit aligned.
+                                                         */
+
 	unsigned		mtu;	/* interface MTU value		*/
 	unsigned short		type;	/* interface hardware type	*/
 	unsigned short		hard_header_len;	/* hardware hdr length	*/
@@ -393,6 +409,7 @@
 
 	/* open/release and usage marking */
 	struct module *owner;
+
 
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
diff -u -r -N -X /home/greear/exclude.list linux/include/linux/sockios.h linux.dev/include/linux/sockios.h
--- linux/include/linux/sockios.h	Tue Jul 31 10:34:02 2001
+++ linux.dev/include/linux/sockios.h	Thu Aug 16 10:09:08 2001
@@ -102,6 +102,10 @@
 #define SIOCADDDLCI	0x8980		/* Create new DLCI device	*/
 #define SIOCDELDLCI	0x8981		/* Delete DLCI device		*/
 
+#define SIOCGIFVLAN	0x8982		/* 802.1Q VLAN support		*/
+#define SIOCSIFVLAN	0x8983		/* Set 802.1Q VLAN options 	*/
+
+
 /* Device private ioctl calls */
 
 /*
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/Makefile linux.dev/net/8021q/Makefile
--- linux/net/8021q/Makefile	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/Makefile	Wed Aug 15 22:25:03 2001
@@ -0,0 +1,19 @@
+#
+# Makefile for the Linux VLAN layer.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now in the main makefile...
+
+O_TARGET := 8021q.o
+
+obj-y := vlan.o vlanproc.o vlan_dev.o
+obj-m := $(O_TARGET)
+obj-$(CONFIG_SYSCTL) += sysctl_net_vlan.o
+
+include $(TOPDIR)/Rules.make
+
+tar:
+	tar -cvf /dev/f1 .
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/sysctl_net_vlan.c linux.dev/net/8021q/sysctl_net_vlan.c
--- linux/net/8021q/sysctl_net_vlan.c	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/sysctl_net_vlan.c	Wed Aug 15 22:25:03 2001
@@ -0,0 +1,20 @@
+/* 
+ * sysctl_net_vlan.c: sysctl interface to net Ethernet VLAN subsystem.
+ *
+ * Begun Dec 20, 1998, Ben Greear
+ *
+ * TODO:  What, if anything, should this do??
+ */
+
+#include <linux/module.h>
+
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+   
+#include <linux/mm.h>
+#include <linux/sysctl.h>
+
+ctl_table ether_vlan_table[] = {
+	{0}
+};
+
+#endif
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlan.c linux.dev/net/8021q/vlan.c
--- linux/net/8021q/vlan.c	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/vlan.c	Thu Aug 16 10:25:17 2001
@@ -0,0 +1,643 @@
+/* -*- linux-c -*-
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		Ethernet-type device handling.
+ *
+ * Version:	@(#)vlan.c	started	12/21/98
+ *                              
+ * Authors:	Ben Greear <greearb@candelatech.com>, <greearb@agcs.com>
+ * 
+ * Fixes:
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/uaccess.h> /* for copy_from_user */
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/datalink.h>
+#include <linux/mm.h>
+#include <linux/in.h>
+#include <linux/init.h>
+#include <net/p8022.h>
+#include <net/arp.h>
+#include <linux/rtnetlink.h>
+#include <linux/brlock.h>
+#include <linux/notifier.h>
+
+#include <linux/if_vlan.h>
+#include "vlan.h"
+#include "vlanproc.h"
+
+
+/* Global VLAN variables */
+
+/* Our listing of VLAN group(s) */
+struct vlan_group *p802_1Q_vlan_list = NULL;
+
+static char vlan_fullname[] = "802.1Q VLAN Support";
+static unsigned int vlan_version = 1;
+static unsigned int vlan_release = 4;
+static char vlan_copyright[] = " Ben Greear <greearb@candelatech.com>";
+
+static int vlan_device_event(struct notifier_block *unused, unsigned long event, void *ptr);
+
+struct notifier_block vlan_notifier_block =
+{
+        vlan_device_event,
+        NULL,
+        0
+};
+
+/** These may be changed at run-time through IOCTLs */
+unsigned short vlan_name_type = VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD; /* determines interface naming scheme */
+unsigned long vlan_bad_proto_recvd = 0; /* Counter for how many NON-VLAN protos we've received on a VLAN. */
+
+
+static struct packet_type vlan_packet_type = 
+{
+        type: __constant_htons(ETH_P_8021Q),
+        dev:  NULL,
+        func: vlan_skb_recv, /* VLAN receive method */
+        data: (void *)(-1),   /* Set here '(void *)1' when this code can SHARE SKBs */
+        next: NULL
+};
+
+/* End of global variables definitions. */
+
+
+/*
+ * Function vlan_proto_init (pro)
+ *
+ *    Initialize VLAN protocol layer, 
+ *
+ */
+static int vlan_proto_init(void);
+static int __init vlan_proto_init(void) {
+
+        int err;
+        printk(VLAN_INF "%s v%u.%u %s\n",
+               vlan_fullname, vlan_version, vlan_release, vlan_copyright);
+
+        /* proc file system initialization */
+        err = vlan_proc_init();
+        if (err < 0) {
+                printk(KERN_ERR __FUNCTION__
+                       "%s: can't create entry in proc filesystem!\n",
+                       VLAN_NAME);
+                return 1;
+        }
+
+        dev_add_pack(&vlan_packet_type);
+
+        /* Register us to receive netdevice events */
+        register_netdevice_notifier(&vlan_notifier_block);
+
+        vlan_ioctl_hook = vlan_ioctl_handler;
+        
+        printk(VLAN_INF "%s Initialization complete.\n", VLAN_NAME);
+        return 0;
+}
+
+/*
+ *     Module 'remove' entry point.
+ *     o delete /proc/net/router directory and static entries.
+ */ 
+static void __exit vlan_cleanup_module (void) {
+        /* Un-register us from receiving netdevice events */
+        unregister_netdevice_notifier(&vlan_notifier_block);
+
+        dev_remove_pack(&vlan_packet_type);
+        vlan_proc_cleanup();
+
+        vlan_ioctl_hook = NULL;
+}
+
+module_init(vlan_proto_init);
+module_exit(vlan_cleanup_module);
+
+
+/**  Will search linearly for now, based on device index.  Could
+ * hash, or directly link, this some day. --Ben
+ * TODO:  Potential performance issue here.  Linear search where N is
+ *        the number of 'real' devices used by VLANs.
+ */
+struct vlan_group* vlan_find_group(int real_dev_ifindex) {
+        struct vlan_group* grp = NULL;
+
+        br_read_lock_bh(BR_NETPROTO_LOCK);
+        for (grp = p802_1Q_vlan_list;
+             ((grp != NULL) && (grp->real_dev_ifindex != real_dev_ifindex));
+             grp = grp->next) {
+           ;
+        } /* for */
+        br_read_unlock_bh(BR_NETPROTO_LOCK);
+        
+        return grp;
+}
+
+/*  Find the protocol handler.  Assumes VID < 0xFFF.
+ */
+struct net_device *find_802_1Q_vlan_dev(struct net_device* real_dev,
+                                        unsigned short VID) {
+
+        struct vlan_group* grp = vlan_find_group(real_dev->ifindex);
+
+        /*  When here, we have found the correct group, if it exists. */
+
+        if (grp) { /* then we found one */
+                return grp->vlan_devices[VID]; /* return the vlan device */
+        }//if
+   
+        return NULL;
+}/* find_802_1Q_vlan_client */
+
+
+/** This method will explicitly do a dev_put on the device if do_dev_put
+ * is TRUE.  This gets around a difficulty with reference counting, and
+ * the unregister-by-name (below).  If do_locks is true, it will grab
+ * a lock before un-registering.  If do_locks is false, it is assumed that
+ * the lock has already been grabbed externally...  --Ben
+ */
+int unregister_802_1Q_vlan_dev(int real_dev_ifindex, unsigned short vlan_id,
+                               int do_dev_put, int do_locks) {
+        struct vlan_group* grp;
+        struct net_device* dev = NULL;
+
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": VID: %i\n", vlan_id);
+#endif
+   
+        /* sanity check */
+        if ((vlan_id >= 0xFFF) || (vlan_id <= 0)) {
+                return -EINVAL;
+        }
+
+        grp = vlan_find_group(real_dev_ifindex);
+        /*  When here, we have found the correct group, if it exists. */
+
+        if (grp) {
+                dev = grp->vlan_devices[vlan_id];
+                if (dev) {
+
+                        /* Remove proc entry */
+                        vlan_proc_rem_dev(dev);
+         
+                        /* take it out of our own structures */
+                        grp->vlan_devices[vlan_id] = NULL;
+
+                        /* Take it out of the global list of devices.
+                         *  NOTE:  This deletes dev, don't access it again!!
+                         */
+
+                        if (do_dev_put) {
+                                dev_put(dev);
+                        }
+
+                        /* TODO:  Please review this code. */
+                        if (do_locks) {
+                                rtnl_lock();
+                                unregister_netdevice(dev);
+                                rtnl_unlock();
+                        }
+                        else {
+                                unregister_netdevice(dev);
+                        }
+
+                        MOD_DEC_USE_COUNT;
+         
+                }/* if */
+        }/* if */
+        
+        return 0;
+}/* unregister vlan device */
+
+
+
+int unregister_802_1Q_vlan_device(const char* vlan_IF_name) {
+        struct net_device* dev = NULL;
+
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": unregister VLAN by name, name -:%s:-\n",
+               vlan_IF_name);
+#endif
+   
+        dev = dev_get_by_name(vlan_IF_name);
+
+        if (dev) {
+                if (dev->more_flags & IFF_802_1Q_VLAN) {
+                        return unregister_802_1Q_vlan_dev(VLAN_DEV_INFO(dev)->real_dev->ifindex,
+                                                          (unsigned short)(VLAN_DEV_INFO(dev)->vlan_id),
+                                                          1 /* do dev_put */, 1 /* do locking */);
+                }
+                else {
+                        printk(VLAN_ERR __FUNCTION__ ": ERROR:  Tried to remove a non-vlan device with VLAN code, name: %s  more_flags: %hX\n",
+                               dev->name, dev->more_flags);
+                        dev_put(dev);
+                        return -EPERM;
+                }
+        }
+        else {
+#ifdef VLAN_DEBUG
+                printk(VLAN_DBG __FUNCTION__ ": WARNING: Could not find dev.\n");
+#endif
+                return -EINVAL;
+        }
+}/* unregister vlan device */
+
+
+/*  Attach a VLAN device to a mac address (ie Ethernet Card).
+ *  Returns the device that was created, or NULL if there was
+ *  an error of some kind.
+ */
+struct net_device *register_802_1Q_vlan_device(const char* eth_IF_name,
+                                               unsigned short VLAN_ID) {
+        struct vlan_group* grp;
+        struct net_device *new_dev;
+        struct net_device *real_dev; /* the ethernet device */
+        int malloc_size = 0;
+   
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": if_name -:%s:-  vid: %i\n",
+               eth_IF_name, VLAN_ID);
+#endif
+
+        /* find the device relating to eth_IF_name. */
+        real_dev = dev_get_by_name(eth_IF_name);
+
+        if (real_dev != NULL) {
+                /* printk(KERN_ALERT "Found real_dev"); */
+
+                /* TODO:  Make sure this device can really handle having a VLAN attached
+                 * to it...
+                 */
+                
+                if ((VLAN_ID > 0) && (VLAN_ID < 0xFFF)) {
+
+                        /* printk(KERN_ALERT "VID is in range"); */
+
+                        if (find_802_1Q_vlan_dev(real_dev, VLAN_ID)) {
+                                /* was already registered. */
+                                printk(VLAN_DBG __FUNCTION__ ": ALREADY had VLAN registered\n");
+                                dev_put(real_dev);
+                                return NULL;
+                        }
+
+                        malloc_size = (sizeof(struct net_device));
+
+                        new_dev = (struct net_device*) kmalloc(malloc_size, GFP_KERNEL);
+                        VLAN_MEM_DBG("net_device malloc, addr: %p  size: %i\n", new_dev, malloc_size);
+         
+                        if (new_dev != NULL) {
+                                /* printk(KERN_ALERT "Got a new device.."); */
+            
+                                memset(new_dev, 0, malloc_size); /* zero everything out */
+
+                                /* set us up to not use a Qdisc, as the underlying Hardware device
+                                 * can do all the queueing we could want.
+                                 */
+                                /* new_dev->qdisc_sleeping = &noqueue_qdisc;   Not needed it seems. */
+                                new_dev->tx_queue_len = 0; /* This should effectively give us no queue. */
+
+                                /* Gotta set up the fields for the device. */
+            
+#ifdef VLAN_DEBUG
+                                printk(VLAN_DBG "About to allocate name, vlan_name_type: %i\n", vlan_name_type);
+#endif
+
+                                switch (vlan_name_type) {
+                                   case VLAN_NAME_TYPE_RAW_PLUS_VID:
+                                        /* name will look like:  eth1.0005 */
+                                        sprintf(new_dev->name, "%s.%.4i", real_dev->name, VLAN_ID);
+                                        break;
+                                   case VLAN_NAME_TYPE_PLUS_VID_NO_PAD:
+                                        /* Put our vlan.VID in the name.
+                                           Name will look like:  vlan5 */
+                                        sprintf(new_dev->name, "vlan%i", VLAN_ID);
+                                        break;
+                                   case VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD:
+                                        /* Put our vlan.VID in the name.
+                                           Name will look like:  eth0.5 */
+                                        sprintf(new_dev->name, "%s.%i", real_dev->name, VLAN_ID);
+                                        break;
+                                   case VLAN_NAME_TYPE_PLUS_VID:
+                                        /* Put our vlan.VID in the name.
+                                           Name will look like:  vlan0005 */
+                                   default:
+                                        /* default case */
+                                        sprintf(new_dev->name, "vlan%.4i", VLAN_ID);
+                                }/* switch */
+                    
+#ifdef VLAN_DEBUG
+                                printk(VLAN_DBG "Allocated new name -:%s:-\n", new_dev->name);
+#endif
+                                /* set up method calls */
+                                new_dev->init = vlan_dev_init;
+                                new_dev->destructor = vlan_dev_destruct;
+            
+                                /* new_dev->ifindex = 0;  it will be set when added to
+                                 * the global list.
+                                 * iflink is set as well. */
+            
+                                new_dev->get_stats = vlan_dev_get_stats;
+            
+                                /* IFF_BROADCAST|IFF_MULTICAST; ??? */
+                                new_dev->flags = real_dev->flags;
+                                new_dev->flags &= ~IFF_UP;
+
+                                /* Make this thing known as a VLAN device */
+                                new_dev->more_flags |= IFF_802_1Q_VLAN;
+                                
+                                /* need 4 bytes for extra VLAN header info,
+                                 * hope the underlying device can handle it. */
+                                new_dev->mtu = real_dev->mtu;
+                                new_dev->change_mtu = vlan_dev_change_mtu;
+                                
+                                new_dev->type = real_dev->type; /* TODO: maybe just assign it to be ETHERNET? */
+
+                                /* Regular ethernet + 4 bytes (18 total). */
+                                new_dev->hard_header_len = VLAN_HLEN + real_dev->hard_header_len;
+
+                                new_dev->priv = kmalloc(sizeof(struct vlan_dev_info),
+                                                        GFP_KERNEL);
+                                VLAN_MEM_DBG("new_dev->priv malloc, addr: %p  size: %i\n", new_dev->priv,
+                                             sizeof(struct vlan_dev_info));
+            
+                                if (new_dev->priv) {
+                                        memset(new_dev->priv, 0, sizeof(struct vlan_dev_info));
+                                }//if
+
+                                memcpy(new_dev->broadcast, real_dev->broadcast, real_dev->addr_len);
+                                memcpy(new_dev->dev_addr, real_dev->dev_addr, real_dev->addr_len);
+                                new_dev->addr_len = real_dev->addr_len;
+
+                                new_dev->open = vlan_dev_open;
+                                new_dev->stop = vlan_dev_stop;
+                                new_dev->hard_header = vlan_dev_hard_header;
+
+                                new_dev->hard_start_xmit = vlan_dev_hard_start_xmit;
+                                new_dev->rebuild_header = vlan_dev_rebuild_header;
+                                new_dev->hard_header_parse = real_dev->hard_header_parse;
+                                new_dev->set_mac_address = vlan_dev_set_mac_address;
+                                new_dev->set_multicast_list = vlan_dev_set_multicast_list;
+
+                                VLAN_DEV_INFO(new_dev)->vlan_id = VLAN_ID; /* 1 through 0xFFF */
+
+                                VLAN_DEV_INFO(new_dev)->real_dev = real_dev;
+                                VLAN_DEV_INFO(new_dev)->dent = NULL;
+
+#ifdef VLAN_DEBUG
+                                printk(VLAN_DBG "About to go find the group for idx: %i\n", real_dev->ifindex);
+#endif
+
+            
+                                /* So, got the sucker initialized, now lets place
+                                 * it into our local structure.
+                                 */
+
+                                grp = vlan_find_group(real_dev->ifindex);
+
+                                /*  When here, we have found the correct group, if it exists. */
+
+                                if (!grp) { /* need to add a new group */
+                                        /* printk(VLAN_DBG "VLAN REGISTER: "
+                                           "Need to add new vlan group.\n");*/
+
+                                        grp = kmalloc(sizeof(struct vlan_group), GFP_KERNEL);
+                                        VLAN_MEM_DBG("grp malloc, addr: %p  size: %i\n", grp, sizeof(struct vlan_group));
+                                        
+                                        if (!grp) {
+                                                kfree(new_dev->priv);
+                                                VLAN_FMEM_DBG("new_dev->priv free, addr: %p\n", new_dev->priv);
+                                                kfree(new_dev);
+                                                VLAN_FMEM_DBG("new_dev free, addr: %p\n", new_dev);
+                                                dev_put(real_dev);
+                                                return NULL;
+                                        }
+                                        
+                                        printk(KERN_ALERT "VLAN REGISTER:  Allocated new group.\n");
+                                        memset(grp, 0, sizeof(struct vlan_group));
+                                        grp->real_dev_ifindex = real_dev->ifindex;
+
+                                        br_write_lock_bh(BR_NETPROTO_LOCK);
+                                        grp->next = p802_1Q_vlan_list;
+                                        p802_1Q_vlan_list = grp;
+                                        br_write_unlock_bh(BR_NETPROTO_LOCK);
+                                }/* if */
+            
+                                grp->vlan_devices[VLAN_ID] = new_dev;
+
+                                vlan_proc_add_dev(new_dev); /* create it's proc entry */
+
+                                /*  Now, add it to the global list of devices. */
+                                /* printk(KERN_ALERT "Registering new device."); */
+
+                                /* TODO: Please check this: RTNL   --Ben */
+                                rtnl_lock();
+                                register_netdevice(new_dev);
+                                rtnl_unlock();
+            
+                                /* NOTE:  We have a reference to the real device,
+                                 * so hold on to the reference.
+                                 */
+                                MOD_INC_USE_COUNT; /* Add was a success!! */
+
+#ifdef VLAN_DEBUG
+                                printk(VLAN_DBG "Allocated new device successfully, returning.\n");
+#endif
+
+                                return new_dev;
+                        }
+                }//if
+                /* If we are here, then something is wrong, so release the real_dev
+                 */
+                dev_put(real_dev);
+        }//if we found real_dev
+
+        return NULL;
+}/* register (create) VLAN device */
+
+
+static int vlan_device_event(struct notifier_block *unused, unsigned long event, void *ptr)
+{
+	struct net_device *dev = (struct net_device*)(ptr);
+	struct vlan_group* grp = NULL;
+	int i = 0;
+        struct net_device* vlandev = NULL;
+        
+	switch (event)
+	{
+	case NETDEV_CHANGEADDR:
+                /* Ignore for now */
+		break;
+
+	case NETDEV_GOING_DOWN:
+                /* Ignore for now */
+		break;
+
+	case NETDEV_DOWN:
+                /* TODO:  Please review this code. */
+		/* put all related VLANs in the down state too. */
+                for (grp = p802_1Q_vlan_list; grp != NULL; grp = grp->next) {
+                        /* loop through all devices for this device */
+                        int flgs = 0;
+                        for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+                                vlandev = grp->vlan_devices[i];
+                                if (!vlandev || (VLAN_DEV_INFO(vlandev)->real_dev != dev)
+                                    || (!(vlandev->flags & IFF_UP))) {
+                                        continue;
+                                }
+
+                                flgs = vlandev->flags;
+                                flgs &= ~IFF_UP;
+                                dev_change_flags(vlandev, flgs);
+                        }/* for all VLANs in that group */
+		}/* for all groups */
+		break;
+
+	case NETDEV_UP:
+                /* TODO:  Please review this code. */
+		/* put all related VLANs in the down state too. */
+                for (grp = p802_1Q_vlan_list; grp != NULL; grp = grp->next) {
+                        /* loop through all devices for this device */
+                        int flgs;
+                        for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+                                vlandev = grp->vlan_devices[i];
+                                if (!vlandev || (VLAN_DEV_INFO(vlandev)->real_dev != dev)
+                                    || (vlandev->flags & IFF_UP)) {
+                                        continue;
+                                }
+                                
+                                flgs = vlandev->flags;
+                                flgs |= IFF_UP;
+                                dev_change_flags(vlandev, flgs);
+                        }/* for all VLANs in that group */
+		}/* for all groups */
+		break;
+                
+	case NETDEV_UNREGISTER:
+
+                /* TODO:  Please review this code. */
+		/* delete all related VLANs. */
+                for (grp = p802_1Q_vlan_list; grp != NULL; grp = grp->next) {
+                        /* loop through all devices for this device */
+                        for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+                                vlandev = grp->vlan_devices[i];
+                                if (!vlandev || (VLAN_DEV_INFO(vlandev)->real_dev != dev)) {
+                                        continue;
+                                }
+
+                                unregister_802_1Q_vlan_dev(VLAN_DEV_INFO(vlandev)->real_dev->ifindex,
+                                                           VLAN_DEV_INFO(vlandev)->vlan_id,
+                                                           0, 0);
+                                vlandev = NULL;
+                        }/* for all VLANs in that group */
+		}/* for all groups */
+		break;
+	}
+
+	return NOTIFY_DONE;
+}/* vlan_device_event */
+
+
+
+/*
+ *	VLAN IOCTL handler.
+ *	o execute requested action or pass command to the device driver
+ *   arg is really a void* to a vlan_ioctl_args structure.
+ */
+int vlan_ioctl_handler(unsigned long arg) {
+	int err = 0;
+	struct vlan_ioctl_args args;
+        
+	/* everything here needs root permissions, except aguably the
+	* hack ioctls for sending packets.  However, I know _I_ don't
+	* want users running that on my network! --BLG
+	*/
+	if (!capable(CAP_NET_ADMIN)){
+		return -EPERM;
+	}
+		
+	if (copy_from_user(&args, (void*)arg,
+                           sizeof(struct vlan_ioctl_args)))
+		return -EFAULT;
+
+	/* Null terminate this sucker, just in case. */
+	args.device1[23] = 0;
+	args.u.device2[23] = 0;
+
+#ifdef VLAN_DEBUG
+	printk(VLAN_DBG __FUNCTION__ ": args.cmd: %x\n", args.cmd);
+#endif
+        
+	switch (args.cmd) {
+        case SET_VLAN_INGRESS_PRIORITY_CMD:
+                err = vlan_dev_set_ingress_priority(args.device1, args.u.skb_priority, args.vlan_qos);
+                break;
+
+        case SET_VLAN_EGRESS_PRIORITY_CMD:
+                err = vlan_dev_set_egress_priority(args.device1, args.u.skb_priority, args.vlan_qos);
+                break;
+           
+        case SET_VLAN_FLAG_CMD:
+                err = vlan_dev_set_vlan_flag(args.device1, args.u.flag, args.vlan_qos);
+                break;
+
+        case SET_VLAN_NAME_TYPE_CMD:
+                if ((args.u.name_type >= 0) && (args.u.name_type < VLAN_NAME_TYPE_HIGHEST)) {
+                        vlan_name_type = args.u.name_type;
+                        /* printk(VLAN_INF "VLAN_SET_NAME_TYPE: new type: %i\n", (int)(args.u.name_type)); */
+                        err = 0;
+                }
+                else {
+                        /* printk(VLAN_INF "VLAN_SET_NAME_TYPE, type: %i is invalid.\n", (int)(args.u.name_type)); */
+                        err = -EINVAL;
+                }
+                break;
+         
+                /* TODO:  Figure out how to pass info back...
+                   case GET_VLAN_INGRESS_PRIORITY_IOCTL:
+                   err = vlan_dev_get_ingress_priority(args);
+                   break;
+
+                   case GET_VLAN_EGRESS_PRIORITY_IOCTL:
+                   err = vlan_dev_get_egress_priority(args);
+                   break;
+                */
+         
+	case ADD_VLAN_CMD:
+		/* we have been given the name of the Ethernet Device we want to
+		 * talk to:  args.dev1   We also have the
+		 * VLAN ID:  args.u.VID
+		 */
+		if (register_802_1Q_vlan_device(args.device1, args.u.VID)) {
+			err = 0;
+		} else {
+			err = -EINVAL;
+		}
+		break;
+
+	case DEL_VLAN_CMD:
+		/* Here, the args.dev1 is the actual VLAN we want
+		 * to get rid of.
+		 */
+		err = unregister_802_1Q_vlan_device(args.device1);
+		break;
+
+	default:
+		/* pass on to underlying device instead?? */
+		printk(VLAN_DBG __FUNCTION__ ": Unknown VLAN CMD: %x \n",
+                       args.cmd);
+		return -EINVAL;
+	}
+
+	return err;
+}/* vlan_ioctl_handler */
+
+
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlan.h linux.dev/net/8021q/vlan.h
--- linux/net/8021q/vlan.h	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/vlan.h	Thu Aug 16 10:42:23 2001
@@ -0,0 +1,43 @@
+#ifndef __BEN_VLAN_802_1Q_INC__
+#define __BEN_VLAN_802_1Q_INC__
+
+#include <linux/if_vlan.h>
+
+
+/*  Uncomment this if you want debug traces to be shown. */
+/* #define VLAN_DEBUG */
+
+
+#define VLAN_ERR KERN_ERR
+#define VLAN_INF KERN_ALERT
+#define VLAN_DBG KERN_ALERT /* change these... to debug, having a hard time
+                             * changing the log level at run-time..for some reason.
+                             */
+
+/*
+
+These I use for memory debugging.  I feared a leak at one time, but
+I never found it..and the problem seems to have dissappeared.  Still,
+I'll bet they might prove useful again... --Ben
+
+
+#define VLAN_MEM_DBG(x, y, z) printk(VLAN_DBG __FUNCTION__ ":  "  x, y, z);
+#define VLAN_FMEM_DBG(x, y) printk(VLAN_DBG __FUNCTION__  ":  " x, y);
+*/
+
+/* This way they don't do anything! */
+#define VLAN_MEM_DBG(x, y, z) 
+#define VLAN_FMEM_DBG(x, y)
+
+
+extern unsigned short vlan_name_type;
+extern unsigned long vlan_bad_proto_recvd; /* Counter for how many NON-VLAN protos we've received on a VLAN. */
+
+int vlan_ioctl_handler(unsigned long arg);
+
+/* Add some headers for the public VLAN methods. */
+int unregister_802_1Q_vlan_device(const char* vlan_IF_name);
+struct net_device *register_802_1Q_vlan_device(const char* eth_IF_name,
+                                               unsigned short VID);
+
+#endif
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlan_dev.c linux.dev/net/8021q/vlan_dev.c
--- linux/net/8021q/vlan_dev.c	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/vlan_dev.c	Thu Aug 16 10:29:02 2001
@@ -0,0 +1,778 @@
+/* -*- linux-c -*-
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX
+ *		operating system.  INET is implemented using the  BSD Socket
+ *		interface as the means of communication with the user level.
+ *
+ *		Ethernet-type device handling.
+ *
+ * Version:	@(#)vlan_dev.c	Started	3/29/99
+ *
+ * Authors:	Ben Greear <greearb@candelatech.com>, <greearb@agcs.com>
+ * 
+ * Fixes:       Mar 22 2001: Martin Bokaemper <mbokaemper@unispherenetworks.com>
+ *                - reset skb->pkt_type on incoming packets when MAC was changed
+ *                - see that changed MAC is saddr for outgoing packets
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/in.h>
+#include <linux/init.h>
+#include <asm/uaccess.h> /* for copy_from_user */
+/* #include <asm/unaligned.h> */
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/datalink.h>
+#include <net/p8022.h>
+#include <net/arp.h>
+#include <linux/brlock.h>
+
+
+#include "vlan.h"
+#include "vlanproc.h"
+#include <linux/if_vlan.h>
+#include <net/ip.h>
+
+
+struct net_device_stats* vlan_dev_get_stats(struct net_device* dev) {
+        return &(((struct vlan_dev_info*)(dev->priv))->dev_stats);
+}
+
+
+/*
+ *	Rebuild the Ethernet MAC header. This is called after an ARP
+ *	(or in future other address resolution) has completed on this
+ *	sk_buff. We now let ARP fill in the other fields.
+ *
+ *	This routine CANNOT use cached dst->neigh!
+ *	Really, it is used only when dst->neigh is wrong.
+ *
+ * TODO:  This needs a checkup, I'm ignorant here. --BLG
+ */
+int vlan_dev_rebuild_header(struct sk_buff *skb) {
+
+        struct net_device *dev = skb->dev;
+        struct vlan_ethhdr *veth = (struct vlan_ethhdr*)(skb->data);
+
+        switch (veth->h_vlan_encapsulated_proto)
+        {
+#ifdef CONFIG_INET
+        case __constant_htons(ETH_P_IP):
+
+                /* TODO:  Confirm this will work with VLAN headers... */
+                return arp_find(veth->h_dest, skb);
+#endif	
+        default:
+                printk(VLAN_DBG
+                       "%s: unable to resolve type %X addresses.\n", 
+                       dev->name, (int)veth->h_vlan_encapsulated_proto);
+         
+                memcpy(veth->h_source, dev->dev_addr, ETH_ALEN);
+                break;
+        }/* switch */
+
+        return 0;
+}/* vlan_dev_rebuild_header */
+
+
+
+/*
+ *	Determine the packet's protocol ID. The rule here is that we 
+ *	assume 802.3 if the type field is short enough to be a length.
+ *	This is normal practice and works for any 'now in use' protocol.
+ *
+ *  Also, at this point we assume that we ARE dealing exclusively with
+ *  VLAN packets, or packets that should be made into VLAN packets based
+ *  on a default VLAN ID.
+ *
+ *  NOTE:  Should be similar to ethernet/eth.c.
+ *
+ *  SANITY NOTE:  This method is called when a packet is moving up the stack
+ *                towards userland.  To get here, it would have already passed
+ *                through the ethernet/eth.c eth_type_trans() method.
+ *  SANITY NOTE 2: We are referencing to the VLAN_HDR frields, which MAY be
+ *                 stored UNALIGNED in the memory.  RISC systems don't like
+ *                 such cases very much...
+ *  SANITY NOTE 2a:  According to Dave Miller & Alexey, it will always be aligned,
+ *                 so there doesn't need to be any of the unaligned stuff.  It has
+ *                 been commented out now...  --Ben
+ *
+ */
+int vlan_skb_recv(struct sk_buff *skb, struct net_device *dev,
+                  struct packet_type* ptype) {
+        unsigned char* rawp = NULL;
+        struct vlan_hdr *vhdr = (struct vlan_hdr*)(skb->data);
+        unsigned short vid;
+        struct net_device_stats* stats;
+
+        unsigned short vlan_TCI;
+        unsigned short proto;
+        
+        /* vlan_TCI = ntohs(get_unaligned(&vhdr->h_vlan_TCI)); */
+        vlan_TCI = ntohs(vhdr->h_vlan_TCI);
+        
+        vid = (vlan_TCI & 0xFFF);
+        
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": skb: %p vlan_id: %hx\n",
+               skb, vid);
+#endif
+   
+        /*  Ok, we will find the correct VLAN device, strip the header,
+            and then go on as usual.
+        */
+
+        /* we have 12 bits of vlan ID. */
+        /* If it's NULL, we will tag it to be junked below */
+        skb->dev = find_802_1Q_vlan_dev(dev, vid);
+
+        if (!skb->dev) {
+#ifdef VLAN_DEBUG
+                printk(VLAN_DBG __FUNCTION__ ": ERROR:  No net_device for VID: %i on dev: %s [%i]\n",
+                       (unsigned int)(vid), dev->name, dev->ifindex);
+#endif
+                kfree_skb(skb);
+                return -1;
+        }
+
+        /* Bump the rx counters for the VLAN device. */
+        stats = vlan_dev_get_stats(skb->dev);
+        stats->rx_packets++;
+        stats->rx_bytes += skb->len;
+      
+        skb_pull(skb, VLAN_HLEN); /* take off the VLAN header (4 bytes currently) */
+        
+        /**  Ok, lets check to make sure the device (dev) we
+         * came in on is what this VLAN is attached to.
+         */
+        if (dev != VLAN_DEV_INFO(skb->dev)->real_dev) {
+#ifdef VLAN_DEBUG
+                printk(VLAN_DBG __FUNCTION__ ": dropping skb: %p because came in on wrong device, dev: %s  real_dev: %s, skb_dev: %s\n",
+                       skb, dev->name, VLAN_DEV_INFO(skb->dev)->real_dev->name, skb->dev->name);
+#endif
+                kfree_skb(skb);
+                stats->rx_errors++;
+                return -1;
+        }
+   
+        /*
+         * Deal with ingress priority mapping.
+         */
+        skb->priority = VLAN_DEV_INFO(skb->dev)->ingress_priority_map[(ntohs(vhdr->h_vlan_TCI) >> 13) & 0x7];
+         
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": priority: %lu  for TCI: %hu (hbo)\n",
+               (unsigned long)(skb->priority), ntohs(vhdr->h_vlan_TCI));
+#endif
+   
+        /* The ethernet driver already did the pkt_type calculations
+         * for us...
+         */
+        switch (skb->pkt_type) {
+            case PACKET_BROADCAST: /* Yeah, stats collect these together.. */
+                // stats->broadcast ++; // no such counter :-(
+            case PACKET_MULTICAST:
+                stats->multicast++;
+                break;
+            case PACKET_OTHERHOST: 
+                /* Our lower layer thinks this is not local, let's make sure.
+                 * This allows the VLAN to have a different MAC than the underlying
+                 * device, and still route correctly.
+                 */
+                if (memcmp(skb->mac.ethernet->h_dest, skb->dev->dev_addr, ETH_ALEN) == 0) {
+                        /* It is for our (changed) MAC-address! */
+                        skb->pkt_type = PACKET_HOST;
+                }
+                break;
+            default:
+                break;
+        }
+ 
+        /*  Was a VLAN packet, grab the encapsulated protocol, which the layer
+         * three protocols care about.
+         */
+        /* proto = get_unaligned(&vhdr->h_vlan_encapsulated_proto); */
+        proto = vhdr->h_vlan_encapsulated_proto;
+        
+        skb->protocol = proto;
+        if (ntohs(proto) >= 1536) {
+                
+                /* place it back on the queue to be handled by
+                 * true layer 3 protocols.
+                 */
+                
+                /* See if we are configured to re-write the VLAN header
+                 * to make it look like ethernet...
+                 */
+                skb = vlan_check_reorder_header(skb);
+
+                /* Can be null if skb-clone fails when re-ordering */
+                if (skb) {
+                        netif_rx(skb);
+                }
+                else {
+                        /* TODO:  Add a more specific counter here. */
+                        stats->rx_errors++;
+                }
+                return 0;
+        }
+
+        rawp = skb->data;
+	
+        /*
+         * This is a magic hack to spot IPX packets. Older Novell breaks
+         * the protocol design and runs IPX over 802.3 without an 802.2 LLC
+         * layer. We look for FFFF which isn't a used 802.2 SSAP/DSAP. This
+         * won't work for fault tolerant netware but does for the rest.
+         */
+        if (*(unsigned short *)rawp == 0xFFFF) {
+                skb->protocol = __constant_htons(ETH_P_802_3);
+                /* place it back on the queue to be handled by true layer 3 protocols.
+                 */
+
+                /* See if we are configured to re-write the VLAN header
+                 * to make it look like ethernet...
+                 */
+                skb = vlan_check_reorder_header(skb);
+
+                /* Can be null if skb-clone fails when re-ordering */
+                if (skb) {
+                        netif_rx(skb);
+                }
+                else {
+                        /* TODO:  Add a more specific counter here. */
+                        stats->rx_errors++;
+                }
+                return 0;
+        }
+		
+        /*
+         *	Real 802.2 LLC
+         */
+        skb->protocol = __constant_htons(ETH_P_802_2);
+        /* place it back on the queue to be handled by upper layer protocols.
+         */
+
+        /* See if we are configured to re-write the VLAN header
+         * to make it look like ethernet...
+         */
+        skb = vlan_check_reorder_header(skb);
+
+        /* Can be null if skb-clone fails when re-ordering */
+        if (skb) {
+                netif_rx(skb);
+        }
+        else {
+                /* TODO:  Add a more specific counter here. */
+                stats->rx_errors++;
+        }
+        return 0;
+} /* vlan_skb_recv */
+
+
+/*
+ *	Create the VLAN header for an arbitrary protocol layer 
+ *
+ *	saddr=NULL	means use device source address
+ *	daddr=NULL	means leave destination address (eg unresolved arp)
+ *
+ *  This is called when the SKB is moving down the stack towards the
+ *  physical devices.
+ */
+int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
+                         unsigned short type, void *daddr, void *saddr,
+                         unsigned len) {
+        struct vlan_hdr *vhdr;
+        unsigned short veth_TCI = 0;
+        int rc;
+        struct net_device* vdev = dev; /* save this for the bottom of the method */
+        
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": skb: %p type: %hx len: %x vlan_id: %hx, daddr: %p\n",
+               skb, type, len, VLAN_DEV_INFO(dev)->vlan_id, daddr);
+#endif
+   
+        vhdr = (struct vlan_hdr*)skb_push(skb, VLAN_HLEN);
+
+        /* build the four bytes that make this a VLAN header. */
+
+        /* Now, construct the second two bytes. This field looks something
+         * like:
+         * usr_priority: 3 bits  (high bits)
+         * CFI           1 bit
+         * VLAN ID       12 bits (low bits)
+         *
+         */
+        veth_TCI = VLAN_DEV_INFO(dev)->vlan_id;
+        veth_TCI |= vlan_dev_get_egress_qos_mask(dev, skb);
+   
+        /* put_unaligned(htons(veth_TCI), &vhdr->h_vlan_TCI); */
+        vhdr->h_vlan_TCI = htons(veth_TCI);
+
+        /* 
+         *  Set the protocol type.
+         *  For a packet of type ETH_P_802_3 we put the length in here instead.
+         *  It is up to the 802.2 layer to carry protocol information.
+         */
+
+        if (type != ETH_P_802_3) {
+                /* put_unaligned(htons(type), &vhdr->h_vlan_encapsulated_proto); */
+                vhdr->h_vlan_encapsulated_proto = htons(type);
+        }
+        else {
+                /* put_unaligned(htons(len), &vhdr->h_vlan_encapsulated_proto); */
+                vhdr->h_vlan_encapsulated_proto = htons(len);
+        }
+
+        /* Before delegating work to the lower layer, enter our MAC-address */
+        if (saddr == NULL) {
+                saddr = dev->dev_addr;
+        }
+
+        dev = VLAN_DEV_INFO(dev)->real_dev;
+
+        /* MPLS can send us skbuffs w/out enough space.  This check will grow the
+         * skb if it doesn't have enough headroom.  Not a beautiful solution, so
+         * I'll tick a counter so that users can know it's happening...  If they
+         * care...
+         */
+
+        /* NOTE:  This may still break if the underlying device is not the final
+         * device (and thus there are more headers to add...)  It should work for
+         * good-ole-ethernet though.
+         */
+        if (skb_headroom(skb) < dev->hard_header_len) {
+                struct sk_buff* sk_tmp = skb;
+                skb = skb_realloc_headroom(sk_tmp, dev->hard_header_len);
+                kfree_skb(sk_tmp);
+                if (skb == NULL) {
+                        struct net_device_stats* stats = vlan_dev_get_stats(vdev);
+                        stats->tx_dropped++;
+                        return -ENOMEM;
+                }
+                VLAN_DEV_INFO(vdev)->cnt_inc_headroom_on_tx++;
+#ifdef VLAN_DEBUG
+                printk(VLAN_DBG __FUNCTION__ ": %s: had to grow skb.\n", vdev->name);
+#endif
+        }/* If we needed to grow the skb header room */
+        
+        /* Now make the underlying real hard header */        
+        rc = dev->hard_header(skb, dev, ETH_P_8021Q, daddr, saddr, len + VLAN_HLEN);
+
+        if (rc > 0) {
+                rc += VLAN_HLEN;
+        }
+        else if (rc < 0) {
+                rc -= VLAN_HLEN;
+        }
+        
+        return rc;
+} /* vlan_hard_header, put on the VLAN hardware header */
+
+
+int vlan_dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev) {
+        struct net_device_stats* stats = vlan_dev_get_stats(dev);
+        struct vlan_ethhdr *veth = (struct vlan_ethhdr*)(skb->data);
+
+        /* Handle non-VLAN frames if they are sent to us, for example by DHCP.
+         *
+         * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
+         * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
+         */
+                
+        if (veth->h_vlan_proto != __constant_htons(ETH_P_8021Q)) {
+                /* This is not a VLAN frame...but we can fix that! */
+                unsigned short veth_TCI = 0;
+                VLAN_DEV_INFO(dev)->cnt_encap_on_xmit++;
+
+#ifdef VLAN_DEBUG
+                printk(VLAN_DBG __FUNCTION__ ": proto to encap: 0x%hx (hbo)\n", htons(veth->h_vlan_proto));
+#endif
+
+                if (skb_headroom(skb) < VLAN_HLEN) {
+                        struct sk_buff* sk_tmp = skb;
+                        skb = skb_realloc_headroom(sk_tmp, VLAN_HLEN);
+                        kfree_skb(sk_tmp);
+                        if (skb == NULL) {
+                                stats->tx_dropped++;
+                                return -ENOMEM;
+                        }
+                        VLAN_DEV_INFO(dev)->cnt_inc_headroom_on_tx++;
+                }
+                else {
+                        if( !(skb = skb_unshare(skb, GFP_ATOMIC)) ) {
+                                printk(KERN_ERR "vlan: failed to unshare skbuff\n");
+                                stats->tx_dropped++;
+                                return -ENOMEM;
+                        }
+                }
+                veth = (struct vlan_ethhdr*)skb_push(skb, VLAN_HLEN);
+
+                /* Move the mac addresses to the beginning of the new header. */
+                memmove(skb->data, skb->data + VLAN_HLEN, 12);
+
+                /* first, the ethernet type */
+                /* put_unaligned(__constant_htons(ETH_P_8021Q), &veth->h_vlan_proto); */
+                veth->h_vlan_proto = __constant_htons(ETH_P_8021Q);
+                
+                /* Now, construct the second two bytes. This field looks something
+                 * like:
+                 * usr_priority: 3 bits  (high bits)
+                 * CFI           1 bit
+                 * VLAN ID       12 bits (low bits)
+                 *
+                 */
+                veth_TCI = VLAN_DEV_INFO(dev)->vlan_id;
+                veth_TCI |= vlan_dev_get_egress_qos_mask(dev, skb);
+
+                /* Evidently, this is not needed...
+                put_unaligned(htons(veth_TCI), &veth->h_vlan_TCI);
+                */
+                veth->h_vlan_TCI = htons(veth_TCI);
+        }/* If we needed to encapsulate the frame */
+
+        skb->dev = VLAN_DEV_INFO(dev)->real_dev;
+        
+#ifdef VLAN_DEBUG
+        printk(VLAN_DBG __FUNCTION__ ": about to send skb: %p to dev: %s\n", skb, skb->dev->name);
+        printk(VLAN_DBG "  %2hx.%2hx.%2hx.%2xh.%2hx.%2hx %2hx.%2hx.%2hx.%2hx.%2hx.%2hx %4hx %4hx %4hx\n",
+               veth->h_dest[0], veth->h_dest[1], veth->h_dest[2], veth->h_dest[3], veth->h_dest[4], veth->h_dest[5],
+               veth->h_source[0], veth->h_source[1], veth->h_source[2], veth->h_source[3], veth->h_source[4], veth->h_source[5],
+               veth->h_vlan_proto, veth->h_vlan_TCI, veth->h_vlan_encapsulated_proto);
+#endif
+
+        dev_queue_xmit(skb);
+        stats->tx_packets++; /* for statics only */
+        stats->tx_bytes += skb->len;
+        return 0;
+}/* vlan_dev_hard_start_xmit */
+
+
+int vlan_dev_change_mtu(struct net_device *dev, int new_mtu) {
+        /* TODO: gotta make sure the underlying layer can handle it,
+         * maybe an IFF_VLAN_CAPABLE flag for devices?
+         */
+        if (VLAN_DEV_INFO(dev)->real_dev->mtu < new_mtu) {
+                return -ERANGE;
+        }
+        
+        dev->mtu = new_mtu;
+        
+        return new_mtu;
+}
+
+int vlan_dev_open(struct net_device* dev) {
+        if (! VLAN_DEV_INFO(dev)->real_dev->flags & IFF_UP) {
+                return -ENETDOWN;
+        }
+   
+        return 0;
+}
+
+int vlan_dev_stop(struct net_device* dev) {
+        vlan_flush_mc_list(dev);
+        return 0;
+}
+
+int vlan_dev_init(struct net_device* dev) {
+        /* TODO:  figure this out, maybe do nothing?? */
+        return 0;
+}
+
+void vlan_dev_destruct(struct net_device* dev) {
+
+        if (dev) {
+                if (dev->priv) {
+                        dev_put(VLAN_DEV_INFO(dev)->real_dev); /* release our reference */
+
+                        if (VLAN_DEV_INFO(dev)->dent) {
+                                printk(KERN_ERR __FUNCTION__ ": dent is NOT NULL!\n");
+                                /* If we ever get here, there is a serious bug that must be fixed. */
+                        }
+                        
+                        kfree(dev->priv);
+
+                        VLAN_FMEM_DBG("dev->priv free, addr: %p\n", dev->priv);
+                        dev->priv = NULL;
+                }
+      
+                kfree(dev);
+                VLAN_FMEM_DBG("net_device free, addr: %p\n", dev);
+                dev = NULL;
+        }
+        return;
+}
+
+
+int vlan_dev_set_ingress_priority(char* dev_name, __u32 skb_prio, short vlan_prio) {
+        struct net_device* dev = dev_get_by_name(dev_name);
+   
+        if (dev) {
+                if (dev->more_flags & IFF_802_1Q_VLAN) {
+                        /* see if a priority mapping exists.. */
+                        VLAN_DEV_INFO(dev)->ingress_priority_map[vlan_prio & 0x7] = skb_prio;
+                        dev_put(dev);
+                        return 0;
+                }
+
+                dev_put(dev);
+        }
+        return -EINVAL;
+}
+
+int vlan_dev_set_egress_priority(char* dev_name, __u32 skb_prio, short vlan_prio) {
+        struct net_device* dev = dev_get_by_name(dev_name);
+        struct vlan_priority_tci_mapping* mp = NULL;
+        struct vlan_priority_tci_mapping* np;
+   
+        if (dev) {
+                if (dev->more_flags & IFF_802_1Q_VLAN) {
+                        /* see if a priority mapping exists.. */
+                        mp = VLAN_DEV_INFO(dev)->egress_priority_map[skb_prio & 0xF];
+                        while (mp) {
+                                if (mp->priority == skb_prio) {
+                                        mp->vlan_qos = ((vlan_prio << 13) & 0xE000);
+                                        dev_put(dev);
+                                        return 0;
+                                }
+                        }
+                        /* create a new mapping then. */
+                        mp = VLAN_DEV_INFO(dev)->egress_priority_map[skb_prio & 0xF];
+                        np = kmalloc(sizeof(struct vlan_priority_tci_mapping), GFP_KERNEL);
+                        if (np) {
+                                np->next = mp;
+                                np->priority = skb_prio;
+                                np->vlan_qos = ((vlan_prio << 13) & 0xE000);
+                                VLAN_DEV_INFO(dev)->egress_priority_map[skb_prio & 0xF] = np;
+                                dev_put(dev);
+                                return 0;
+                        }
+                        else {
+                                dev_put(dev);
+                                return -ENOBUFS;
+                        }
+                }
+                dev_put(dev);
+        }
+        return -EINVAL;
+}
+
+/* Flags are defined in the vlan_dev_info class in include/linux/if_vlan.h file. */
+int vlan_dev_set_vlan_flag(char* dev_name, __u32 flag, short flag_val) {
+        struct net_device* dev = dev_get_by_name(dev_name);
+   
+        if (dev) {
+                if (dev->more_flags & IFF_802_1Q_VLAN) {
+                        /* verify flag is supported */
+                        if (flag == 1) {
+                                if (flag_val) {
+                                        VLAN_DEV_INFO(dev)->flags |= 1;
+                                }
+                                else {
+                                        VLAN_DEV_INFO(dev)->flags &= ~1;
+                                }
+                                dev_put(dev);
+                                return 0;
+                        }
+                        else {
+                                printk(KERN_ERR __FUNCTION__ ": flag %i is not valid.\n", (int)(flag));
+                                dev_put(dev);
+                                return -EINVAL;
+                        }
+                }
+                else {
+                        printk(KERN_ERR __FUNCTION__ ": %s is not a vlan device, more_flags: %hX.\n",
+                               dev->name, dev->more_flags);
+                        dev_put(dev);
+                }
+        }
+        else {
+                printk(KERN_ERR __FUNCTION__ ": Could not find device: %s\n", dev_name);
+        }
+                
+        return -EINVAL;
+}/* vlan_dev_set_vlan_flag */
+
+
+int vlan_dev_set_mac_address(struct net_device *dev, void* addr_struct_p) {
+        int i;
+        struct sockaddr *addr = (struct sockaddr*)(addr_struct_p);
+
+        if (netif_running(dev)) {
+                return -EBUSY;
+        }
+	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+        
+        printk("%s: Setting MAC address to ", dev->name);
+        for (i = 0; i < 6; i++) {
+                printk(" %2.2x", dev->dev_addr[i]);
+        }
+        printk(".\n");
+
+        if (memcmp(VLAN_DEV_INFO(dev)->real_dev->dev_addr, dev->dev_addr, dev->addr_len) != 0) {
+                if (VLAN_DEV_INFO(dev)->real_dev->flags & IFF_PROMISC) {
+                        /* Already promiscious...leave it alone. */
+                        printk("VLAN (%s):  Good, underlying device (%s) is already promiscious.\n",
+                               dev->name, VLAN_DEV_INFO(dev)->real_dev->name);
+                }
+                else {
+                        int flgs = VLAN_DEV_INFO(dev)->real_dev->flags;
+
+                        /* Increment our in-use promiscuity counter */
+                        dev_set_promiscuity(VLAN_DEV_INFO(dev)->real_dev, 1);
+
+                        /* Make PROMISC visible to the user. */
+                        flgs |= IFF_PROMISC;
+                        printk("VLAN (%s):  Setting underlying device (%s) to promiscious mode.\n",
+                               dev->name, VLAN_DEV_INFO(dev)->real_dev->name);
+                        dev_change_flags(VLAN_DEV_INFO(dev)->real_dev, flgs);
+
+                }
+        }
+        else {
+                printk("VLAN (%s):  Underlying device (%s) has same MAC, not checking promiscious mode.\n",
+                       dev->name, VLAN_DEV_INFO(dev)->real_dev->name);
+        }           
+
+        return 0;
+}
+
+
+/** Taken from Gleb + Lennert's VLAN code, and modified... */
+void vlan_dev_set_multicast_list(struct net_device *vlan_dev) {
+        struct dev_mc_list *dmi;
+        struct net_device *real_dev;
+        int inc;
+
+        if (vlan_dev && (vlan_dev->more_flags & IFF_802_1Q_VLAN)) {
+                /* Then it's a real vlan device, as far as we can tell.. */
+                real_dev = VLAN_DEV_INFO(vlan_dev)->real_dev;
+
+                /* compare the current promiscuity to the last promisc we had.. */
+                inc = vlan_dev->promiscuity - VLAN_DEV_INFO(vlan_dev)->old_promiscuity;
+   
+                if (inc) {
+                        printk(KERN_INFO "%s: dev_set_promiscuity(master, %d)\n", vlan_dev->name, inc);
+                        dev_set_promiscuity(real_dev, inc); /* found in dev.c */
+                        VLAN_DEV_INFO(vlan_dev)->old_promiscuity = vlan_dev->promiscuity;
+                }
+   
+                inc = vlan_dev->allmulti - VLAN_DEV_INFO(vlan_dev)->old_allmulti;
+   
+                if (inc) {
+                        printk(KERN_INFO "%s: dev_set_allmulti(master, %d)\n", vlan_dev->name, inc);
+                        dev_set_allmulti(real_dev, inc); /* dev.c */
+                        VLAN_DEV_INFO(vlan_dev)->old_allmulti = vlan_dev->allmulti;
+                }
+   
+                /* looking for addresses to add to master's list */
+                for (dmi = vlan_dev->mc_list; dmi!=NULL; dmi=dmi->next) {
+                        if (vlan_should_add_mc(dmi, VLAN_DEV_INFO(vlan_dev)->old_mc_list)) {
+                                dev_mc_add(real_dev, dmi->dmi_addr, dmi->dmi_addrlen, 0);
+                                printk(KERN_INFO "%s: add %.2x:%.2x:%.2x:%.2x:%.2x:%.2x mcast address to master interface\n",
+                                       vlan_dev->name,
+                                       dmi->dmi_addr[0],
+                                       dmi->dmi_addr[1],
+                                       dmi->dmi_addr[2],
+                                       dmi->dmi_addr[3],
+                                       dmi->dmi_addr[4],
+                                       dmi->dmi_addr[5]);
+                        }
+                }
+   
+                /* looking for addresses to delete from master's list */
+                for (dmi = vlan_dev->mc_list; dmi!=NULL; dmi=dmi->next) {
+                        if (vlan_should_add_mc(dmi, vlan_dev->mc_list)) {
+                                /* if we think we should add it to the new list, then we should really
+                                 * delete it from the real list on the underlying device.
+                                 */
+                                dev_mc_delete(real_dev, dmi->dmi_addr, dmi->dmi_addrlen, 0);
+                                printk(KERN_INFO "%s: del %.2x:%.2x:%.2x:%.2x:%.2x:%.2x mcast address from master interface\n",
+                                       vlan_dev->name,
+                                       dmi->dmi_addr[0],
+                                       dmi->dmi_addr[1],
+                                       dmi->dmi_addr[2],
+                                       dmi->dmi_addr[3],
+                                       dmi->dmi_addr[4],
+                                       dmi->dmi_addr[5]);
+                        }
+                }
+   
+                /* save multicast list */
+                vlan_copy_mc_list(vlan_dev->mc_list, VLAN_DEV_INFO(vlan_dev));
+        }/* if we were sent a valid device */
+}/* vlan_dev_set_multicast */
+
+
+/** dmi is a single entry into a dev_mc_list, a single node.  mc_list is
+ *  an entire list, and we'll iterate through it.
+ */
+int vlan_should_add_mc(struct dev_mc_list *dmi, struct dev_mc_list *mc_list) {
+        struct dev_mc_list *idmi; /* iterator */
+
+        for (idmi=mc_list; idmi!=NULL;) {
+                if (vlan_dmi_equals(dmi, idmi)) {
+                        if (dmi->dmi_users > idmi->dmi_users)
+                                return 1;
+                        else
+                                return 0;
+                }
+                else {
+                        idmi = idmi->next;
+                }
+        }
+   
+        return 1;
+}
+
+
+void vlan_copy_mc_list(struct dev_mc_list *mc_list, struct vlan_dev_info *vlan_info) {
+        struct dev_mc_list *dmi, *new_dmi;
+   
+        vlan_destroy_mc_list(vlan_info->old_mc_list);
+        vlan_info->old_mc_list = NULL;
+
+        for (dmi=mc_list; dmi!=NULL; dmi=dmi->next) {
+                new_dmi = kmalloc(sizeof(*new_dmi), GFP_ATOMIC);
+                if (new_dmi == NULL) {
+                        printk(KERN_ERR "vlan: cannot allocate memory. Multicast may not work properly from now.\n");
+                        return;
+                }
+
+                
+                /* Copy whole structure, then make new 'next' pointer */
+                
+                *new_dmi = *dmi;
+                
+                new_dmi->next = vlan_info->old_mc_list;
+                vlan_info->old_mc_list = new_dmi;
+        }
+}
+
+void vlan_flush_mc_list(struct net_device *dev) {
+        struct dev_mc_list *dmi = dev->mc_list;
+
+        while (dmi) {
+                dev_mc_delete(dev, dmi->dmi_addr, dmi->dmi_addrlen, 0);
+                printk(KERN_INFO "%s: del %.2x:%.2x:%.2x:%.2x:%.2x:%.2x mcast address from master interface\n",
+                       dev->name,
+                       dmi->dmi_addr[0],
+                       dmi->dmi_addr[1],
+                       dmi->dmi_addr[2],
+                       dmi->dmi_addr[3],
+                       dmi->dmi_addr[4],
+                       dmi->dmi_addr[5]);
+                dmi = dev->mc_list;
+        }
+   
+        /* dev->mc_list is NULL by the time we get here. */
+        
+        vlan_destroy_mc_list(VLAN_DEV_INFO(dev)->old_mc_list);
+        VLAN_DEV_INFO(dev)->old_mc_list = NULL;
+}/* vlan_flush_mc_list */
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlanproc.c linux.dev/net/8021q/vlanproc.c
--- linux/net/8021q/vlanproc.c	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/vlanproc.c	Thu Aug 16 11:08:02 2001
@@ -0,0 +1,521 @@
+/* -*- linux-c -*-
+******************************************************************************
+* vlanproc.c	VLAN Module. /proc filesystem interface.
+*
+*		This module is completely hardware-independent and provides
+*		access to the router using Linux /proc filesystem.
+*
+* Author:	Ben Greear, <greearb@candelatech.com> coppied from wanproc.c
+*               by: Gene Kozin	<genek@compuserve.com>
+*
+* Copyright:	(c) 1998 Ben Greear
+*
+*		This program is free software; you can redistribute it and/or
+*		modify it under the terms of the GNU General Public License
+*		as published by the Free Software Foundation; either version
+*		2 of the License, or (at your option) any later version.
+* ============================================================================
+* Jan 20, 1998        Ben Greear     Initial Version
+*****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/stddef.h>	/* offsetof(), etc. */
+#include <linux/errno.h>	/* return codes */
+#include <linux/kernel.h>
+#include <linux/malloc.h>	/* kmalloc(), kfree() */
+#include <linux/mm.h>		/* verify_area(), etc. */
+#include <linux/string.h>	/* inline mem*, str* functions */
+#include <linux/init.h>		/* __initfunc et al. */
+#include <asm/segment.h>	/* kernel <-> user copy */
+#include <asm/byteorder.h>	/* htons(), etc. */
+#include <asm/uaccess.h>	/* copy_to_user */
+#include <asm/io.h>
+#include <linux/proc_fs.h>
+#include <linux/fs.h>
+#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+#include "vlanproc.h"
+#include "vlan.h"
+
+/****** Defines and Macros **************************************************/
+
+#ifndef	min
+#define min(a,b) (((a)<(b))?(a):(b))
+#endif
+#ifndef	max
+#define max(a,b) (((a)>(b))?(a):(b))
+#endif
+
+
+/****** Function Prototypes *************************************************/
+
+#ifdef CONFIG_PROC_FS
+
+/* Proc filesystem interface */
+static ssize_t vlan_proc_read(struct file* file, char* buf, size_t count,
+                              loff_t *ppos);
+
+/* Methods for preparing data for reading proc entries */
+
+static int vlan_config_get_info(char* buf, char** start, off_t offs, int len);
+static int vlandev_get_info(char* buf, char** start, off_t offs, int len);
+
+
+/* Miscellaneous */
+
+/*
+ *	Global Data
+ */
+
+/*
+ *	Names of the proc directory entries 
+ */
+
+static char name_root[]	 = "vlan";
+static char name_conf[]	 = "config";
+static char term_msg[]   = "***KERNEL:  Out of buffer space!***\n";
+
+
+/*
+ *	Structures for interfacing with the /proc filesystem.
+ *	VLAN creates its own directory /proc/net/vlan with the folowing
+ *	entries:
+ *	config		device status/configuration
+ *	<device>	entry for each  device
+ */
+
+/*
+ *	Generic /proc/net/vlan/<file> file and inode operations 
+ */
+
+static struct file_operations vlan_fops = {
+        read:	vlan_proc_read,
+        ioctl: NULL, /* vlan_proc_ioctl */
+};
+
+/*
+ *	/proc/net/vlan/<device> file and inode operations
+ */
+
+static struct file_operations vlandev_fops = {
+        read:	vlan_proc_read,
+        ioctl:	NULL, /* vlan_proc_ioctl */
+};
+
+
+/*
+ * Proc filesystem derectory entries.
+ */
+
+/*
+ *	/proc/net/vlan 
+ */
+
+static struct proc_dir_entry* proc_vlan_dir = NULL;
+
+/*
+ *	/proc/net/vlan/config 
+ */
+ 
+static struct proc_dir_entry* proc_vlan_conf = NULL;
+
+
+/* Strings */
+static char conf_hdr[] = "VLAN Dev name  | VLAN ID\n";
+	
+
+/*
+ *	Interface functions
+ */
+
+/*
+ *	Clean up /proc/net/vlan entries
+ */
+
+void __exit vlan_proc_cleanup (void) {
+	if (proc_vlan_conf) {
+                remove_proc_entry(name_conf, proc_vlan_dir);
+        }
+	if (proc_vlan_dir) {
+                proc_net_remove(name_root);
+        }
+
+        /* Dynamically added entries should be cleaned up as their vlan_device
+         * is removed, so we should not have to take care of it here...
+         */
+}
+
+/*
+ *	Create /proc/net/vlan entries
+ */
+
+int __init vlan_proc_init (void)
+{
+	proc_vlan_dir = proc_mkdir(name_root, proc_net);
+	if (proc_vlan_dir) {
+		proc_vlan_conf = create_proc_entry(name_conf,
+                                                   S_IFREG|S_IRUSR|S_IWUSR,
+                                                   proc_vlan_dir);
+		if (proc_vlan_conf) {
+                        proc_vlan_conf->proc_fops = &vlan_fops;
+                        proc_vlan_conf->get_info = vlan_config_get_info;
+                        return 0;
+		}
+	}
+	vlan_proc_cleanup();
+	return -ENOBUFS;
+}
+
+/*
+ *	Add directory entry for VLAN device.
+ */
+
+int vlan_proc_add_dev (struct net_device* vlandev)
+{
+        struct vlan_dev_info* dev_info = VLAN_DEV_INFO(vlandev);
+	if (!vlandev->more_flags & IFF_802_1Q_VLAN) {
+		printk(KERN_ERR
+                       "ERROR:  vlan_proc_add, device -:%s:- is NOT a VLAN\n",
+                       vlandev->name);
+		return -EINVAL;
+	}
+   
+	dev_info->dent = create_proc_entry(vlandev->name,
+                                           S_IFREG|S_IRUSR|S_IWUSR,
+                                           proc_vlan_dir);
+	if (!dev_info->dent) {
+		return -ENOBUFS;
+	}
+   
+	dev_info->dent->proc_fops = &vlandev_fops;
+	dev_info->dent->get_info = &vlandev_get_info;
+	dev_info->dent->data = vlandev;
+
+#ifdef VLAN_DEBUG
+	printk(KERN_ERR "vlan_proc_add, device -:%s:- being added.\n",
+               vlandev->name);
+#endif
+	return 0;
+}
+
+
+/*
+ *	Delete directory entry for VLAN device.
+ */
+int vlan_proc_rem_dev(struct net_device* vlandev)
+{
+	if (!vlandev) {
+		printk(VLAN_ERR __FUNCTION__ ": invalid argument: %p\n",
+                       vlandev);
+		return -EINVAL;
+	}
+
+        if (!(vlandev->more_flags & IFF_802_1Q_VLAN)) {
+		printk(VLAN_DBG __FUNCTION__ ": invalid argument, device: %s is not a VLAN device, more_flags: 0x%4hX.\n",
+                       vlandev->name, vlandev->more_flags);
+		return -EINVAL;
+	}
+
+#ifdef VLAN_DEBUG
+	printk(VLAN_DBG __FUNCTION__ ": dev: %p\n", vlandev);
+#endif
+
+	/** NOTE:  This will consume the memory pointed to by dent, it seems. */
+	remove_proc_entry(vlandev->name, proc_vlan_dir);
+	VLAN_DEV_INFO(vlandev)->dent = NULL;
+
+	return 0;
+}
+
+
+/****** Proc filesystem entry points ****************************************/
+
+/*
+ *	Read VLAN proc directory entry.
+ *	This is universal routine for reading all entries in /proc/net/vlan
+ *	directory.  Each directory entry contains a pointer to the 'method' for
+ *	preparing data for that entry.
+ *	o verify arguments
+ *	o allocate kernel buffer
+ *	o call get_info() to prepare data
+ *	o copy data to user space
+ *	o release kernel buffer
+ *
+ *	Return:	number of bytes copied to user space (0, if no data)
+ *		<0	error
+ */
+static ssize_t vlan_proc_read(
+	struct file* file,
+	char* buf,
+	size_t count,
+	loff_t *ppos
+        ) {
+	struct inode *inode = file->f_dentry->d_inode;
+	struct proc_dir_entry* dent;
+	char* page;
+	int pos, offs, len;
+
+	if (count <= 0)
+		return 0;
+		
+	dent = inode->u.generic_ip;
+	if ((dent == NULL) || (dent->get_info == NULL))
+		return 0;
+		
+	page = kmalloc(VLAN_PROC_BUFSZ, GFP_KERNEL);
+	VLAN_MEM_DBG("page malloc, addr: %p  size: %i\n",
+                     page, VLAN_PROC_BUFSZ);
+   
+	if (page == NULL)
+		return -ENOBUFS;
+		
+	pos = dent->get_info(page, dent->data, 0, 0);
+	offs = file->f_pos;
+	if (offs < pos) {
+		len = min(pos - offs, count);
+		if (copy_to_user(buf, (page + offs), len)) {
+			return -EFAULT;
+		}
+		file->f_pos += len;
+	} else {
+		len = 0;
+	}
+
+	kfree(page);
+	VLAN_FMEM_DBG("page free, addr: %p\n", page);
+	return len;
+}/* vlan_proc_read */
+
+/*
+ * The following few functions build the content of /proc/net/vlan/config
+ */
+
+static int vlan_proc_get_vlan_info(char* buf, unsigned int cnt) {
+	struct net_device* vlandev = NULL;
+	struct vlan_group* grp = NULL;
+	int i = 0;
+        char* nm_type = NULL;
+        struct vlan_dev_info* dev_info = NULL;
+        
+
+#ifdef VLAN_DEBUG
+	printk(VLAN_DBG __FUNCTION__ ": cnt == %i\n", cnt);
+#endif
+        
+        if (vlan_name_type == VLAN_NAME_TYPE_RAW_PLUS_VID) {
+                nm_type = "VLAN_NAME_TYPE_RAW_PLUS_VID";
+        }
+        else if (vlan_name_type == VLAN_NAME_TYPE_PLUS_VID_NO_PAD) {
+                nm_type = "VLAN_NAME_TYPE_PLUS_VID_NO_PAD";
+        }
+        else if (vlan_name_type == VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD) {
+                nm_type = "VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD";
+        }
+        else if (vlan_name_type == VLAN_NAME_TYPE_PLUS_VID) {
+                nm_type = "VLAN_NAME_TYPE_PLUS_VID";
+        }
+        else {
+                nm_type = "UNKNOWN";
+        }
+   
+        cnt += sprintf(buf + cnt, "Name-Type: %s  bad_proto_recvd: %lu\n",
+                       nm_type, vlan_bad_proto_recvd);
+
+	for (grp = p802_1Q_vlan_list; grp != NULL; grp = grp->next) {
+		/* loop through all devices for this device */
+#ifdef VLAN_DEBUG
+		printk(VLAN_DBG __FUNCTION__ ": found a group, addr: %p\n",grp);
+#endif
+		for (i = 0; i < VLAN_GROUP_ARRAY_LEN; i++) {
+			vlandev = grp->vlan_devices[i];
+			if (!vlandev)
+				continue;
+#ifdef VLAN_DEBUG
+			printk(VLAN_DBG __FUNCTION__
+                               ": found a vlan_dev, addr: %p\n", vlandev);
+#endif
+			if ((cnt + 100) > VLAN_PROC_BUFSZ) {
+				if ((cnt+strlen(term_msg)) < VLAN_PROC_BUFSZ) {
+					cnt += sprintf(buf+cnt, "%s", term_msg);
+				}
+				return cnt;
+			}
+			if (!vlandev->priv) {
+				printk(KERN_ERR __FUNCTION__
+                                       ": ERROR: vlandev->priv is NULL\n");
+				continue;
+			}
+
+                        dev_info = VLAN_DEV_INFO(vlandev);
+                        
+#ifdef VLAN_DEBUG
+			printk(VLAN_DBG __FUNCTION__
+                               ": got a good vlandev, addr: %p\n",
+                               VLAN_DEV_INFO(vlandev));
+#endif
+			cnt += sprintf(buf + cnt, "%-15s| %d  | %s\n",
+                                       vlandev->name, dev_info->vlan_id, dev_info->real_dev->name);
+		}
+	}
+	return cnt;
+}
+
+/*
+ *	Prepare data for reading 'Config' entry.
+ *	Return length of data.
+ */
+
+static int vlan_config_get_info(
+	char* buf,
+	char** start,
+	off_t offs,
+	int len
+        ) {
+	strcpy(buf, conf_hdr);
+	return vlan_proc_get_vlan_info(buf, (unsigned int)(strlen(conf_hdr)));
+}
+
+
+/*
+ *	Prepare data for reading <device> entry.
+ *	Return length of data.
+ *
+ *	On entry, the 'start' argument will contain a pointer to VLAN device
+ *	data space.
+ */
+
+static int vlandev_get_info(
+	char* buf,
+	char** start,
+	off_t offs,
+	int len
+        ) {
+	struct net_device* vlandev = (void*)start;
+	struct net_device_stats* stats = NULL;
+        struct vlan_dev_info* dev_info = NULL;
+        
+	int cnt = 0;
+        struct vlan_priority_tci_mapping* mp;
+        int i;
+        
+#ifdef VLAN_DEBUG
+	printk(VLAN_DBG __FUNCTION__ ": vlandev: %p\n", vlandev);
+#endif
+   
+	if ((vlandev == NULL) || (!vlandev->more_flags & IFF_802_1Q_VLAN)) {
+		return 0;
+	}
+
+        dev_info = VLAN_DEV_INFO(vlandev);
+        
+	cnt += sprintf(buf + cnt, "%s  VID: %d   REORDER_HDR: %i  dev->more_flags: %hx\n",
+                       vlandev->name, dev_info->vlan_id,
+                       (int)(dev_info->flags & 1), vlandev->more_flags);
+        
+        stats = vlan_dev_get_stats(vlandev);
+        
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "total frames received", stats->rx_packets);
+        
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "total bytes received", stats->rx_bytes);
+        
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "Broadcast/Multicast Rcvd", stats->multicast);
+        
+        cnt += sprintf(buf + cnt, "\n%30s: %12lu\n",
+                       "total frames transmitted", stats->tx_packets);
+        
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "total bytes transmitted", stats->tx_bytes);
+
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "total headroom inc", dev_info->cnt_inc_headroom_on_tx);
+
+        cnt += sprintf(buf + cnt, "%30s: %12lu\n",
+                       "total encap on xmit", dev_info->cnt_encap_on_xmit);
+
+        cnt += sprintf(buf + cnt, "Device: %s", dev_info->real_dev->name);
+        
+
+        /* now show all PRIORITY mappings relating to this VLAN */
+        cnt += sprintf(buf + cnt, "\nINGRESS priority mappings: 0:%lu  1:%lu  2:%lu  3:%lu  4:%lu  5:%lu  6:%lu 7:%lu\n",
+                       dev_info->ingress_priority_map[0],
+                       dev_info->ingress_priority_map[1],
+                       dev_info->ingress_priority_map[2],
+                       dev_info->ingress_priority_map[3],
+                       dev_info->ingress_priority_map[4],
+                       dev_info->ingress_priority_map[5],
+                       dev_info->ingress_priority_map[6],
+                       dev_info->ingress_priority_map[7]);
+
+        if ((cnt + 100) > VLAN_PROC_BUFSZ) {
+                if ((cnt + strlen(term_msg)) >= VLAN_PROC_BUFSZ) {
+                        /* should never get here */
+                        return cnt;
+                }
+                else {
+                        cnt += sprintf(buf + cnt, "%s", term_msg);
+                        return cnt;
+                }
+        }/* if running out of buffer space */
+   
+        cnt += sprintf(buf + cnt, "EGRESSS priority Mappings: ");
+        
+        for (i = 0; i<16; i++) {
+                mp = dev_info->egress_priority_map[i];
+                while (mp) {
+                        cnt += sprintf(buf + cnt, "%lu:%hu ", mp->priority, ((mp->vlan_qos >> 13) & 0x7));
+                  
+                        if ((cnt + 100) > VLAN_PROC_BUFSZ) {
+                                if ((cnt + strlen(term_msg)) >= VLAN_PROC_BUFSZ) {
+                                        /* should never get here */
+                                        return cnt;
+                                }
+                                else {
+                                        cnt += sprintf(buf + cnt, "%s", term_msg);
+                                        return cnt;
+                                }
+                        }/* if running out of buffer space */
+                        mp = mp->next;
+                }
+        }/* for */
+
+        cnt += sprintf(buf + cnt, "\n");
+
+        return cnt;
+}
+
+
+/*
+ *	End
+ */
+ 
+#else /* No CONFIG_PROC_FS */
+
+/*
+ *	No /proc - output stubs
+ */
+ 
+int __init vlan_proc_init (void)
+{
+	return 0;
+}
+
+void __exit vlan_proc_cleanup(void)
+{
+	return;
+}
+
+
+int vlan_proc_add_dev(struct net_device *vlandev)
+{
+	return 0;
+}
+
+int vlan_proc_rem_dev(struct net_device *vlandev)
+{
+	return 0;
+}
+
+#endif /* No CONFIG_PROC_FS */
diff -u -r -N -X /home/greear/exclude.list linux/net/8021q/vlanproc.h linux.dev/net/8021q/vlanproc.h
--- linux/net/8021q/vlanproc.h	Wed Dec 31 17:00:00 1969
+++ linux.dev/net/8021q/vlanproc.h	Wed Aug 15 22:25:03 2001
@@ -0,0 +1,27 @@
+
+#ifndef __BEN_VLAN_PROC_INC__
+#define __BEN_VLAN_PROC_INC__
+
+
+int vlan_proc_init(void);
+
+int vlan_proc_rem_dev(struct net_device* vlandev);
+int vlan_proc_add_dev (struct net_device* vlandev);
+void vlan_proc_cleanup (void);
+
+
+#define	VLAN_PROC_BUFSZ	(4096)	/* buffer size for printing proc info */
+
+/****** Data Types **********************************************************/
+
+/*
+typedef struct vlan_stat_entry {
+   struct vlan_stat_entry *	next;
+   char *description;		* description string *
+   void *data;			* -> data *
+   unsigned data_type;		* data type *
+} vlan_stat_entry_t;
+*/
+
+
+#endif
diff -u -r -N -X /home/greear/exclude.list linux/net/Config.in linux.dev/net/Config.in
--- linux/net/Config.in	Tue Mar  6 23:44:15 2001
+++ linux.dev/net/Config.in	Wed Aug 15 22:25:03 2001
@@ -46,6 +46,9 @@
 	 tristate '    Multi-Protocol Over ATM (MPOA) support' CONFIG_ATM_MPOA
       fi
    fi
+
+   tristate '802.1Q VLAN Support (EXPERIMENTAL)' CONFIG_VLAN_8021Q
+
 fi
 
 comment ' '
diff -u -r -N -X /home/greear/exclude.list linux/net/Makefile linux.dev/net/Makefile
--- linux/net/Makefile	Mon Jun 11 19:15:27 2001
+++ linux.dev/net/Makefile	Wed Aug 15 22:25:03 2001
@@ -45,6 +45,7 @@
 subdir-$(CONFIG_ATM)		+= atm
 subdir-$(CONFIG_DECNET)		+= decnet
 subdir-$(CONFIG_ECONET)		+= econet
+subdir-$(CONFIG_VLAN_8021Q)           += 8021q
 
 
 obj-y	:= socket.o $(join $(subdir-y), $(patsubst %,/%.o,$(notdir $(subdir-y))))
diff -u -r -N -X /home/greear/exclude.list linux/net/core/dev.c linux.dev/net/core/dev.c
--- linux/net/core/dev.c	Tue Jul 31 10:34:02 2001
+++ linux.dev/net/core/dev.c	Wed Aug 15 22:25:03 2001
@@ -1,4 +1,4 @@
-/*
+/* -*- linux-c -*-
  * 	NET3	Protocol independent device support routines.
  *
  *		This program is free software; you can redistribute it and/or
@@ -107,6 +107,7 @@
 extern int plip_init(void);
 #endif
 
+
 /* This define, if set, will randomly drop a packet when congestion
  * is more than moderate.  It helps fairness in the multi-interface
  * case when one of them is a hog, but it kills performance for the
@@ -137,9 +138,17 @@
  *	and the routines to invoke.
  *
  *	Why 16. Because with 16 the only overlap we get on a hash of the
- *	low nibble of the protocol value is RARP/SNAP/X.25. 
+ *	low nibble of the protocol value is RARP/SNAP/X.25.
+ *
+ *      NOTE:  That is no longer true with the addition of VLAN tags.  Not
+ *             sure which should go first, but I bet it won't make much
+ *             difference if we are running VLANs.  The good news is that
+ *             this protocol won't be in the list unless compiled in, so
+ *             the average user (w/out VLANs) will not be adversly affected.
+ *             --BLG
  *
  *		0800	IP
+ *		8100    802.1Q VLAN
  *		0001	802.3
  *		0002	AX.25
  *		0004	802.2
diff -u -r -N -X /home/greear/exclude.list linux/net/ethernet/eth.c linux.dev/net/ethernet/eth.c
--- linux/net/ethernet/eth.c	Fri Mar  2 12:02:15 2001
+++ linux.dev/net/ethernet/eth.c	Wed Aug 15 22:25:03 2001
@@ -82,7 +82,7 @@
 	 *	in here instead. It is up to the 802.2 layer to carry protocol information.
 	 */
 	
-	if(type!=ETH_P_802_3) 
+	if (type != ETH_P_802_3) 
 		eth->h_proto = htons(type);
 	else
 		eth->h_proto = htons(len);
@@ -92,9 +92,9 @@
 	 */
 	 
 	if(saddr)
-		memcpy(eth->h_source,saddr,dev->addr_len);
+		memcpy(eth->h_source, saddr, dev->addr_len);
 	else
-		memcpy(eth->h_source,dev->dev_addr,dev->addr_len);
+		memcpy(eth->h_source, dev->dev_addr, dev->addr_len);
 
 	/*
 	 *	Anyway, the loopback-device should never use this function... 
@@ -159,11 +159,12 @@
 {
 	struct ethhdr *eth;
 	unsigned char *rawp;
-	
-	skb->mac.raw=skb->data;
-	skb_pull(skb,dev->hard_header_len);
-	eth= skb->mac.ethernet;
-	
+
+      skb->mac.raw = skb->data;
+      skb_pull(skb, dev->hard_header_len);
+      eth = skb->mac.ethernet;
+        
+
 	if(*eth->h_dest&1)
 	{
 		if(memcmp(eth->h_dest,dev->broadcast, ETH_ALEN)==0)
@@ -198,12 +199,12 @@
 	 *	won't work for fault tolerant netware but does for the rest.
 	 */
 	if (*(unsigned short *)rawp == 0xFFFF)
-		return htons(ETH_P_802_3);
+		return __constant_htons(ETH_P_802_3);
 		
 	/*
 	 *	Real 802.2 LLC
 	 */
-	return htons(ETH_P_802_2);
+	return __constant_htons(ETH_P_802_2);
 }
 
 int eth_header_parse(struct sk_buff *skb, unsigned char *haddr)
diff -u -r -N -X /home/greear/exclude.list linux/net/ipv4/af_inet.c linux.dev/net/ipv4/af_inet.c
--- linux/net/ipv4/af_inet.c	Tue Aug  7 08:30:50 2001
+++ linux.dev/net/ipv4/af_inet.c	Thu Aug 16 09:47:35 2001
@@ -143,6 +143,10 @@
 int (*br_ioctl_hook)(unsigned long);
 #endif
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+int (*vlan_ioctl_hook)(unsigned long arg);
+#endif
+
 /* The inetsw table contains everything that inet_create needs to
  * build a new socket.
  */
@@ -879,6 +883,18 @@
 #endif
 			if (br_ioctl_hook != NULL)
 				return br_ioctl_hook(arg);
+#endif
+			return -ENOPKG;
+
+                case SIOCGIFVLAN:
+                case SIOCSIFVLAN:
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#ifdef CONFIG_KMOD
+			if (vlan_ioctl_hook == NULL)
+				request_module("8021q");
+#endif
+			if (vlan_ioctl_hook != NULL)
+				return vlan_ioctl_hook(arg);
 #endif
 			return -ENOPKG;
 
diff -u -r -N -X /home/greear/exclude.list linux/net/netsyms.c linux.dev/net/netsyms.c
--- linux/net/netsyms.c	Tue Aug  7 08:30:50 2001
+++ linux.dev/net/netsyms.c	Thu Aug 16 10:41:11 2001
@@ -30,6 +30,7 @@
 #include <net/pkt_sched.h>
 #include <net/scm.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/random.h>
 #ifdef CONFIG_NET_DIVERT
 #include <linux/divert.h>
@@ -212,6 +213,15 @@
 EXPORT_SYMBOL(make_EII_client);
 EXPORT_SYMBOL(destroy_EII_client);
 #endif
+
+
+/* for 801q VLAN support */
+#if defined(CONFIG_VLAN_8021Q_MODULE) || defined(CONFIG_VLAN_8021Q)
+EXPORT_SYMBOL(dev_change_flags);
+EXPORT_SYMBOL(vlan_ioctl_hook);
+#endif
+
+
 
 EXPORT_SYMBOL(sklist_destroy_socket);
 EXPORT_SYMBOL(sklist_insert_socket);

--------------84C952EDACA00023A1CA6768--

