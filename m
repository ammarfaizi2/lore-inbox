Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCTTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCTTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCTTX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:23:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261172AbVCTTWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:22:53 -0500
Date: Sun, 20 Mar 2005 20:22:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] net/atm/: possible cleanups
Message-ID: <20050320192250.GN4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- lec.c: remove the unused global function get_dev_lec

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/atm/common.c    |    2 -
 net/atm/lec.c       |   83 +++++++++++++++++++++++---------------------
 net/atm/lec.h       |    9 ----
 net/atm/lec_arpc.h  |   24 ------------
 net/atm/mpc.c       |    6 +--
 net/atm/mpc.h       |    4 --
 net/atm/pppoatm.c   |    2 -
 net/atm/protocols.h |    2 -
 net/atm/raw.c       |    2 -
 9 files changed, 51 insertions(+), 83 deletions(-)

--- linux-2.6.11-mm3-full/net/atm/common.c.old	2005-03-13 05:06:33.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/common.c	2005-03-13 05:06:53.000000000 +0100
@@ -41,7 +41,7 @@
 struct hlist_head vcc_hash[VCC_HTABLE_SIZE];
 DEFINE_RWLOCK(vcc_sklist_lock);
 
-void __vcc_insert_socket(struct sock *sk)
+static void __vcc_insert_socket(struct sock *sk)
 {
 	struct atm_vcc *vcc = atm_sk(sk);
 	struct hlist_head *head = &vcc_hash[vcc->vci &
--- linux-2.6.11-mm3-full/net/atm/lec.h.old	2005-03-13 05:08:02.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/lec.h	2005-03-13 05:19:21.000000000 +0100
@@ -146,14 +146,5 @@
 
 #define LEC_VCC_PRIV(vcc)	((struct lec_vcc_priv *)((vcc)->user_back))
 
-int lecd_attach(struct atm_vcc *vcc, int arg);
-int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg);
-int lec_mcast_attach(struct atm_vcc *vcc, int arg);
-struct net_device *get_dev_lec(int itf);
-int send_to_lecd(struct lec_priv *priv,
-                 atmlec_msg_type type, unsigned char *mac_addr,
-                 unsigned char *atm_addr, struct sk_buff *data);
-void lec_push(struct atm_vcc *vcc, struct sk_buff *skb);
-
 #endif /* _LEC_H_ */
 
--- linux-2.6.11-mm3-full/net/atm/lec_arpc.h.old	2005-03-13 05:09:21.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/lec_arpc.h	2005-03-13 05:18:30.000000000 +0100
@@ -89,28 +89,4 @@
 #define LEC_REMOTE_FLAG      0x0001
 #define LEC_PERMANENT_FLAG   0x0002
 
-/* Protos */
-void lec_arp_init(struct lec_priv *priv);
-int lec_mcast_make(struct lec_priv *priv, struct atm_vcc *vcc);
-void lec_arp_destroy(struct lec_priv *priv);
-void lec_vcc_close(struct lec_priv *priv, struct atm_vcc *vcc);
-
-struct atm_vcc *lec_arp_resolve(struct lec_priv *priv,
-                                unsigned char *mac_to_addr,
-                                int is_rdesc,
-                                struct lec_arp_table **ret_entry);
-void lec_vcc_added(struct lec_priv *dev,
-                   struct atmlec_ioc *ioc_data, struct atm_vcc *vcc,
-                   void (*old_push)(struct atm_vcc *vcc, struct sk_buff *skb));
-void lec_arp_check_empties(struct lec_priv *priv,
-                           struct atm_vcc *vcc, struct sk_buff *skb);
-int lec_addr_delete(struct lec_priv *priv,
-                    unsigned char *mac_addr, unsigned long permanent);
-void lec_flush_complete(struct lec_priv *priv, unsigned long tran_id);
-void lec_arp_update(struct lec_priv *priv,
-                    unsigned char *mac_addr, unsigned char *atm_addr,
-                    unsigned long remoteflag, unsigned int targetless_le_arp);
-void lec_set_flush_tran_id(struct lec_priv *priv,
-                           unsigned char *mac_addr, unsigned long tran_id);
-
 #endif
--- linux-2.6.11-mm3-full/net/atm/lec.c.old	2005-03-13 05:07:11.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/lec.c	2005-03-13 05:19:26.000000000 +0100
@@ -83,6 +83,29 @@
 static int lane2_associate_req (struct net_device *dev, u8 *lan_dst,
                          u8 *tlvs, u32 sizeoftlvs);
 
+static int lec_addr_delete(struct lec_priv *priv, unsigned char *atm_addr, 
+			   unsigned long permanent);
+static void lec_arp_check_empties(struct lec_priv *priv,
+				  struct atm_vcc *vcc, struct sk_buff *skb);
+static void lec_arp_destroy(struct lec_priv *priv);
+static void lec_arp_init(struct lec_priv *priv);
+static struct atm_vcc* lec_arp_resolve(struct lec_priv *priv,
+				       unsigned char *mac_to_find,
+				       int is_rdesc,
+				       struct lec_arp_table **ret_entry);
+static void lec_arp_update(struct lec_priv *priv, unsigned char *mac_addr,
+			   unsigned char *atm_addr, unsigned long remoteflag,
+			   unsigned int targetless_le_arp);
+static void lec_flush_complete(struct lec_priv *priv, unsigned long tran_id);
+static int lec_mcast_make(struct lec_priv *priv, struct atm_vcc *vcc);
+static void lec_set_flush_tran_id(struct lec_priv *priv,
+				  unsigned char *atm_addr,
+				  unsigned long tran_id);
+static void lec_vcc_added(struct lec_priv *priv, struct atmlec_ioc *ioc_data,
+			  struct atm_vcc *vcc,
+			  void (*old_push)(struct atm_vcc *vcc, struct sk_buff *skb));
+static void lec_vcc_close(struct lec_priv *priv, struct atm_vcc *vcc);
+
 static struct lane2_ops lane2_ops = {
 	lane2_resolve,         /* resolve,             spec 3.1.3 */
 	lane2_associate_req,   /* associate_req,       spec 3.1.4 */
@@ -94,21 +117,6 @@
 /* Device structures */
 static struct net_device *dev_lec[MAX_LEC_ITF];
 
-/* This will be called from proc.c via function pointer */
-struct net_device *get_dev_lec(int itf)
-{
-	struct net_device *dev;
-
-	if (itf >= MAX_LEC_ITF)
-		return NULL;
-	rtnl_lock();
-	dev = dev_lec[itf];
-	if (dev)
-		dev_hold(dev);
-	rtnl_unlock();
-	return dev;
-}
-
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
 {
@@ -155,7 +163,7 @@
  * and returns NULL.
  */
 #ifdef CONFIG_TR
-unsigned char *get_tr_dst(unsigned char *packet, unsigned char *rdesc)
+static unsigned char *get_tr_dst(unsigned char *packet, unsigned char *rdesc)
 {
         struct trh_hdr *trh;
         int riflen, num_rdsc;
@@ -599,7 +607,7 @@
  * LANE2: new argument struct sk_buff *data contains
  * the LE_ARP based TLVs introduced in the LANE2 spec
  */
-int 
+static int 
 send_to_lecd(struct lec_priv *priv, atmlec_msg_type type, 
              unsigned char *mac_addr, unsigned char *atm_addr,
              struct sk_buff *data)
@@ -681,7 +689,7 @@
         0x01,
         0x01 };
 
-void 
+static void 
 lec_push(struct atm_vcc *vcc, struct sk_buff *skb)
 {
         struct net_device *dev = (struct net_device *)vcc->proto_data;
@@ -764,7 +772,7 @@
         }
 }
 
-void
+static void
 lec_pop(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
@@ -784,7 +792,7 @@
 	}
 }
 
-int 
+static int 
 lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 {
 	struct lec_vcc_priv *vpriv;
@@ -813,7 +821,7 @@
         return 0;
 }
 
-int 
+static int 
 lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
         if (arg <0 || arg >= MAX_LEC_ITF || !dev_lec[arg])
@@ -823,7 +831,7 @@
 }
 
 /* Initialize device. */
-int 
+static int 
 lecd_attach(struct atm_vcc *vcc, int arg)
 {  
         int i;
@@ -1383,7 +1391,6 @@
 
 static void lec_arp_check_expire(unsigned long data);
 static void lec_arp_expire_arp(unsigned long data);
-void dump_arp_table(struct lec_priv *priv);
 
 /* 
  * Arp table funcs
@@ -1394,7 +1401,7 @@
 /*
  * Initialization of arp-cache
  */
-void 
+static void 
 lec_arp_init(struct lec_priv *priv)
 {
         unsigned short i;
@@ -1410,7 +1417,7 @@
         add_timer(&priv->lec_arp_timer);
 }
 
-void
+static void
 lec_arp_clear_vccs(struct lec_arp_table *entry)
 {
         if (entry->vcc) {
@@ -1539,7 +1546,7 @@
 }
 #endif
 
-void
+static void
 dump_arp_table(struct lec_priv *priv)
 {
 #if DEBUG_ARP_TABLE
@@ -1691,7 +1698,7 @@
 /*
  * Destruction of arp-cache
  */
-void
+static void
 lec_arp_destroy(struct lec_priv *priv)
 {
 	unsigned long flags;
@@ -1953,9 +1960,9 @@
  * Try to find vcc where mac_address is attached.
  * 
  */
-struct atm_vcc*
-lec_arp_resolve(struct lec_priv *priv, unsigned char *mac_to_find, int is_rdesc,
-                struct lec_arp_table **ret_entry)
+static struct atm_vcc*
+lec_arp_resolve(struct lec_priv *priv, unsigned char *mac_to_find,
+		int is_rdesc, struct lec_arp_table **ret_entry)
 {
 	unsigned long flags;
         struct lec_arp_table *entry;
@@ -2034,7 +2041,7 @@
 	return found;
 }
 
-int
+static int
 lec_addr_delete(struct lec_priv *priv, unsigned char *atm_addr, 
                 unsigned long permanent)
 {
@@ -2064,7 +2071,7 @@
 /*
  * Notifies:  Response to arp_request (atm_addr != NULL) 
  */
-void
+static void
 lec_arp_update(struct lec_priv *priv, unsigned char *mac_addr,
                unsigned char *atm_addr, unsigned long remoteflag,
                unsigned int targetless_le_arp)
@@ -2176,7 +2183,7 @@
 /*
  * Notifies: Vcc setup ready 
  */
-void
+static void
 lec_vcc_added(struct lec_priv *priv, struct atmlec_ioc *ioc_data,
               struct atm_vcc *vcc,
               void (*old_push)(struct atm_vcc *vcc, struct sk_buff *skb))
@@ -2320,7 +2327,7 @@
 	spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
 }
 
-void
+static void
 lec_flush_complete(struct lec_priv *priv, unsigned long tran_id)
 {
 	unsigned long flags;
@@ -2346,7 +2353,7 @@
         dump_arp_table(priv);
 }
 
-void
+static void
 lec_set_flush_tran_id(struct lec_priv *priv,
                       unsigned char *atm_addr, unsigned long tran_id)
 {
@@ -2364,7 +2371,7 @@
 	spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
 }
 
-int 
+static int 
 lec_mcast_make(struct lec_priv *priv, struct atm_vcc *vcc)
 {
 	unsigned long flags;
@@ -2401,7 +2408,7 @@
         return err;
 }
 
-void
+static void
 lec_vcc_close(struct lec_priv *priv, struct atm_vcc *vcc)
 {
 	unsigned long flags;
@@ -2476,7 +2483,7 @@
 	dump_arp_table(priv);
 }
 
-void
+static void
 lec_arp_check_empties(struct lec_priv *priv,
                       struct atm_vcc *vcc, struct sk_buff *skb)
 {
--- linux-2.6.11-mm3-full/net/atm/mpc.h.old	2005-03-13 05:20:07.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/mpc.h	2005-03-13 05:20:22.000000000 +0100
@@ -11,10 +11,6 @@
 /* kernel -> mpc-daemon */
 int msg_to_mpoad(struct k_message *msg, struct mpoa_client *mpc);
 
-/* Functions for ioctl(ATMMPC_*) operations */
-int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg);
-int atm_mpoa_vcc_attach(struct atm_vcc *vcc, void __user *arg);
-
 struct mpoa_client {
         struct mpoa_client *next;
         struct net_device *dev;      /* lec in question                     */
--- linux-2.6.11-mm3-full/net/atm/mpc.c.old	2005-03-13 05:19:38.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/mpc.c	2005-03-13 05:20:29.000000000 +0100
@@ -564,7 +564,7 @@
 	return retval;
 }
 
-int atm_mpoa_vcc_attach(struct atm_vcc *vcc, void __user *arg)
+static int atm_mpoa_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 {
 	int bytes_left;
 	struct mpoa_client *mpc;
@@ -753,7 +753,7 @@
 	/* members not explicitly initialised will be 0 */
 };
 
-int atm_mpoa_mpoad_attach (struct atm_vcc *vcc, int arg)
+static int atm_mpoa_mpoad_attach (struct atm_vcc *vcc, int arg)
 {
 	struct mpoa_client *mpc;
 	struct lec_priv *priv;
@@ -1460,7 +1460,7 @@
 	return 0;
 }
 
-void __exit atm_mpoa_cleanup(void)
+static void __exit atm_mpoa_cleanup(void)
 {
 	struct mpoa_client *mpc, *tmp;
 	struct atm_mpoa_qos *qos, *nextqos;
--- linux-2.6.11-mm3-full/net/atm/pppoatm.c.old	2005-03-13 05:20:41.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/pppoatm.c	2005-03-13 05:20:50.000000000 +0100
@@ -345,7 +345,7 @@
 	return -ENOIOCTLCMD;
 }
 
-struct atm_ioctl pppoatm_ioctl_ops = {
+static struct atm_ioctl pppoatm_ioctl_ops = {
 	.owner	= THIS_MODULE,
 	.ioctl	= pppoatm_ioctl,
 };
--- linux-2.6.11-mm3-full/net/atm/protocols.h.old	2005-03-13 05:21:05.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/protocols.h	2005-03-13 05:21:19.000000000 +0100
@@ -6,8 +6,6 @@
 #ifndef NET_ATM_PROTOCOLS_H
 #define NET_ATM_PROTOCOLS_H
 
-void atm_push_raw(struct atm_vcc *vcc,struct sk_buff *skb);
-
 int atm_init_aal0(struct atm_vcc *vcc);	/* "raw" AAL0 */
 int atm_init_aal34(struct atm_vcc *vcc);/* "raw" AAL3/4 transport */
 int atm_init_aal5(struct atm_vcc *vcc);	/* "raw" AAL5 transport */
--- linux-2.6.11-mm3-full/net/atm/raw.c.old	2005-03-13 05:21:26.000000000 +0100
+++ linux-2.6.11-mm3-full/net/atm/raw.c	2005-03-13 05:21:37.000000000 +0100
@@ -25,7 +25,7 @@
  * SKB == NULL indicates that the link is being closed
  */
 
-void atm_push_raw(struct atm_vcc *vcc,struct sk_buff *skb)
+static void atm_push_raw(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	if (skb) {
 		struct sock *sk = sk_atm(vcc);

