Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbULLUTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbULLUTC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbULLUQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:16:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3603 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262122AbULLUL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:11:29 -0500
Date: Sun, 12 Dec 2004 21:11:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: acme@conectiva.com.br
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/802/: some cleanups
Message-ID: <20041212201115.GU22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make some needlessly global code static
- net/802/hippi.c: remove the unused global function hippi_net_init
- net/8021q/vlan.c: remove the global variable vlan_default_dev_flags
                    that was never changed
- drivers/net/net_init.c: remove four unneeded #include's


diffstat output:
 drivers/net/fc/iph5526_ip.h |    1 -
 drivers/net/net_init.c      |    4 ----
 include/linux/fcdevice.h    |    4 ----
 include/linux/fddidevice.h  |    7 -------
 include/linux/hippidevice.h |   21 ---------------------
 include/linux/trdevice.h    |    4 ----
 net/802/fc.c                |    7 ++++---
 net/802/fddi.c              |    7 ++++---
 net/802/hippi.c             |   19 ++++---------------
 net/802/tr.c                |    7 ++++---
 net/8021q/vlan.c            |    9 +++------
 net/8021q/vlan.h            |    1 -
 net/8021q/vlanproc.c        |    2 +-
 13 files changed, 20 insertions(+), 73 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/fcdevice.h.old	2004-12-12 18:03:19.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/fcdevice.h	2004-12-12 18:06:57.000000000 +0100
@@ -27,10 +27,6 @@
 #include <linux/if_fc.h>
 
 #ifdef __KERNEL__
-extern int		fc_header(struct sk_buff *skb, struct net_device *dev,
-				   unsigned short type, void *daddr,
-				   void *saddr, unsigned len);
-extern int		fc_rebuild_header(struct sk_buff *skb);
 extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
 
 extern struct net_device *alloc_fcdev(int sizeof_priv);
--- linux-2.6.10-rc2-mm4-full/net/802/fc.c.old	2004-12-12 18:03:56.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/802/fc.c	2004-12-12 18:04:53.000000000 +0100
@@ -35,8 +35,9 @@
  *	Put the headers on a Fibre Channel packet. 
  */
  
-int fc_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
-              void *daddr, void *saddr, unsigned len) 
+static int fc_header(struct sk_buff *skb, struct net_device *dev,
+		     unsigned short type,
+		     void *daddr, void *saddr, unsigned len) 
 {
 	struct fch_hdr *fch;
 	int hdr_len;
@@ -81,7 +82,7 @@
  *	can now send the packet.
  */
  
-int fc_rebuild_header(struct sk_buff *skb) 
+static int fc_rebuild_header(struct sk_buff *skb) 
 {
 	struct fch_hdr *fch=(struct fch_hdr *)skb->data;
 	struct fcllc *fcllc=(struct fcllc *)(skb->data+sizeof(struct fch_hdr));
--- linux-2.6.10-rc2-mm4-full/drivers/net/fc/iph5526_ip.h.old	2004-12-12 18:07:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/fc/iph5526_ip.h	2004-12-12 18:07:21.000000000 +0100
@@ -18,7 +18,6 @@
 
 static void rx_net_packet(struct fc_info *fi, u_char *buff_addr, int payload_size);
 static void rx_net_mfs_packet(struct fc_info *fi, struct sk_buff *skb);
-unsigned short fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
 static int tx_ip_packet(struct sk_buff *skb, unsigned long len, struct fc_info *fi);
 static int tx_arp_packet(char *data, unsigned long len, struct fc_info *fi);
 #endif
--- linux-2.6.10-rc2-mm4-full/drivers/net/net_init.c.old	2004-12-12 18:07:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/net_init.c	2004-12-12 18:14:20.000000000 +0100
@@ -43,10 +43,6 @@
 #include <linux/string.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/fddidevice.h>
-#include <linux/hippidevice.h>
-#include <linux/trdevice.h>
-#include <linux/fcdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_ltalk.h>
 #include <linux/rtnetlink.h>
--- linux-2.6.10-rc2-mm4-full/include/linux/fddidevice.h.old	2004-12-12 18:08:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/fddidevice.h	2004-12-12 18:10:20.000000000 +0100
@@ -25,13 +25,6 @@
 #include <linux/if_fddi.h>
 
 #ifdef __KERNEL__
-extern int		fddi_header(struct sk_buff *skb,
-				    struct net_device *dev,
-				    unsigned short type,
-				    void *daddr,
-				    void *saddr,
-				    unsigned len);
-extern int		fddi_rebuild_header(struct sk_buff *skb);
 extern unsigned short	fddi_type_trans(struct sk_buff *skb,
 				struct net_device *dev);
 extern struct net_device *alloc_fddidev(int sizeof_priv);
--- linux-2.6.10-rc2-mm4-full/net/802/fddi.c.old	2004-12-12 18:08:41.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/802/fddi.c	2004-12-12 18:10:15.000000000 +0100
@@ -52,8 +52,9 @@
  * daddr=NULL	means leave destination address (eg unresolved arp)
  */
 
-int fddi_header(struct sk_buff	*skb, struct net_device *dev, unsigned short type,
-		void *daddr, void *saddr, unsigned len)
+static int fddi_header(struct sk_buff *skb, struct net_device *dev,
+		       unsigned short type,
+		       void *daddr, void *saddr, unsigned len)
 {
 	int hl = FDDI_K_SNAP_HLEN;
 	struct fddihdr *fddi;
@@ -96,7 +97,7 @@
  * this sk_buff.  We now let ARP fill in the other fields.
  */
  
-int fddi_rebuild_header(struct sk_buff	*skb)
+static int fddi_rebuild_header(struct sk_buff	*skb)
 {
 	struct fddihdr *fddi = (struct fddihdr *)skb->data;
 
--- linux-2.6.10-rc2-mm4-full/include/linux/hippidevice.h.old	2004-12-12 18:10:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/hippidevice.h	2004-12-12 18:11:56.000000000 +0100
@@ -26,30 +26,9 @@
 #include <linux/if_hippi.h>
 
 #ifdef __KERNEL__
-extern int hippi_header(struct sk_buff *skb,
-			struct net_device *dev,
-			unsigned short type,
-			void *daddr,
-			void *saddr,
-			unsigned len);
-
-extern int hippi_rebuild_header(struct sk_buff *skb);
-
 extern unsigned short hippi_type_trans(struct sk_buff *skb,
 				       struct net_device *dev);
 
-extern void hippi_header_cache_bind(struct hh_cache ** hhp,
-				    struct net_device *dev,
-				    unsigned short htype,
-				    __u32 daddr);
-
-extern void hippi_header_cache_update(struct hh_cache *hh,
-				      struct net_device *dev,
-				      unsigned char * haddr);
-extern int hippi_header_parse(struct sk_buff *skb, unsigned char *haddr);
-
-extern void hippi_net_init(void);
-
 extern struct net_device *alloc_hippi_dev(int sizeof_priv);
 #endif
 
--- linux-2.6.10-rc2-mm4-full/net/802/hippi.c.old	2004-12-12 18:12:42.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/802/hippi.c	2004-12-12 18:13:32.000000000 +0100
@@ -40,26 +40,15 @@
 #include <asm/system.h>
 
 /*
- * hippi_net_init()
- *
- * Do nothing, this is just to pursuade the stupid linker to behave.
- */
-
-void hippi_net_init(void)
-{
-	return;
-}
-
-/*
  * Create the HIPPI MAC header for an arbitrary protocol layer 
  *
  * saddr=NULL	means use device source address
  * daddr=NULL	means leave destination address (eg unresolved arp)
  */
 
-int hippi_header(struct sk_buff *skb, struct net_device *dev,
-		 unsigned short type, void *daddr, void *saddr,
-		 unsigned len)
+static int hippi_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, void *daddr, void *saddr,
+			unsigned len)
 {
 	struct hippi_hdr *hip = (struct hippi_hdr *)skb_push(skb, HIPPI_HLEN);
 
@@ -107,7 +96,7 @@
  * completed on this sk_buff. We now let ARP fill in the other fields.
  */
 
-int hippi_rebuild_header(struct sk_buff *skb)
+static int hippi_rebuild_header(struct sk_buff *skb)
 {
 	struct hippi_hdr *hip = (struct hippi_hdr *)skb->data;
 
--- linux-2.6.10-rc2-mm4-full/include/linux/trdevice.h.old	2004-12-12 18:14:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/trdevice.h	2004-12-12 18:16:00.000000000 +0100
@@ -28,10 +28,6 @@
 #include <linux/if_tr.h>
 
 #ifdef __KERNEL__
-extern int		tr_header(struct sk_buff *skb, struct net_device *dev,
-				   unsigned short type, void *daddr,
-				   void *saddr, unsigned len);
-extern int		tr_rebuild_header(struct sk_buff *skb);
 extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device *dev);
 extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
 extern struct net_device *alloc_trdev(int sizeof_priv);
--- linux-2.6.10-rc2-mm4-full/net/802/tr.c.old	2004-12-12 18:14:51.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/802/tr.c	2004-12-12 18:15:28.000000000 +0100
@@ -98,8 +98,9 @@
  *	makes this a little more exciting than on ethernet.
  */
  
-int tr_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
-              void *daddr, void *saddr, unsigned len) 
+static int tr_header(struct sk_buff *skb, struct net_device *dev,
+		     unsigned short type,
+		     void *daddr, void *saddr, unsigned len) 
 {
 	struct trh_hdr *trh;
 	int hdr_len;
@@ -153,7 +154,7 @@
  *	can now send the packet.
  */
  
-int tr_rebuild_header(struct sk_buff *skb) 
+static int tr_rebuild_header(struct sk_buff *skb) 
 {
 	struct trh_hdr *trh=(struct trh_hdr *)skb->data;
 	struct trllc *trllc=(struct trllc *)(skb->data+sizeof(struct trh_hdr));
--- linux-2.6.10-rc2-mm4-full/net/8021q/vlan.h.old	2004-12-12 18:17:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/8021q/vlan.h	2004-12-12 18:17:06.000000000 +0100
@@ -33,7 +33,6 @@
 #define VLAN_GRP_HASH_SHIFT	5
 #define VLAN_GRP_HASH_SIZE	(1 << VLAN_GRP_HASH_SHIFT)
 #define VLAN_GRP_HASH_MASK	(VLAN_GRP_HASH_SIZE - 1)
-extern struct  hlist_head vlan_group_hash[VLAN_GRP_HASH_SIZE];
 
 /*  Find a VLAN device by the MAC address of its Ethernet device, and
  *  it's VLAN ID.  The default configuration is to have VLAN's scope
--- linux-2.6.10-rc2-mm4-full/net/8021q/vlan.c.old	2004-12-12 18:16:08.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/8021q/vlan.c	2004-12-12 18:17:20.000000000 +0100
@@ -40,7 +40,7 @@
 /* Global VLAN variables */
 
 /* Our listing of VLAN group(s) */
-struct hlist_head vlan_group_hash[VLAN_GRP_HASH_SIZE];
+static struct hlist_head vlan_group_hash[VLAN_GRP_HASH_SIZE];
 #define vlan_grp_hashfn(IDX)	((((IDX) >> VLAN_GRP_HASH_SHIFT) ^ (IDX)) & VLAN_GRP_HASH_MASK)
 
 static char vlan_fullname[] = "802.1Q VLAN Support";
@@ -52,7 +52,7 @@
 static int vlan_ioctl_handler(void __user *);
 static int unregister_vlan_dev(struct net_device *, unsigned short );
 
-struct notifier_block vlan_notifier_block = {
+static struct notifier_block vlan_notifier_block = {
 	.notifier_call = vlan_device_event,
 };
 
@@ -61,9 +61,6 @@
 /* Determines interface naming scheme. */
 unsigned short vlan_name_type = VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD;
 
-/* DO reorder the header by default */
-unsigned short vlan_default_dev_flags = 1;
-
 static struct packet_type vlan_packet_type = {
 	.type = __constant_htons(ETH_P_8021Q),
 	.func = vlan_skb_recv, /* VLAN receive method */
@@ -490,7 +487,7 @@
 	VLAN_DEV_INFO(new_dev)->vlan_id = VLAN_ID; /* 1 through VLAN_VID_MASK */
 	VLAN_DEV_INFO(new_dev)->real_dev = real_dev;
 	VLAN_DEV_INFO(new_dev)->dent = NULL;
-	VLAN_DEV_INFO(new_dev)->flags = vlan_default_dev_flags;
+	VLAN_DEV_INFO(new_dev)->flags = 1;
 
 #ifdef VLAN_DEBUG
 	printk(VLAN_DBG "About to go find the group for idx: %i\n",
--- linux-2.6.10-rc2-mm4-full/net/8021q/vlanproc.c.old	2004-12-12 18:17:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/8021q/vlanproc.c	2004-12-12 18:17:42.000000000 +0100
@@ -239,7 +239,7 @@
  */
 
 /* starting at dev, find a VLAN device */
-struct net_device *vlan_skip(struct net_device *dev) 
+static struct net_device *vlan_skip(struct net_device *dev) 
 {
 	while (dev && !(dev->priv_flags & IFF_802_1Q_VLAN)) 
 		dev = dev->next;

