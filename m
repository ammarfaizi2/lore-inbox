Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUJZQFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUJZQFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUJZQFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:05:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261205AbUJZQCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:02:10 -0400
Date: Tue, 26 Oct 2004 12:01:41 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] SELinux: fix netif bugs and simplify.
Message-ID: <Xine.LNX.4.44.0410261127160.3811-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes and simplifies locking in the SELiunux netif cache.

An old problem (which I forgot about) is fixed where a netif lookup can be 
followed by a preemption, causing a race against sel_netif_put().  Kaigai 
Kohei discovered a problem where netif lookups were also not protected 
against races with sel_netif_flush().

The code has now been reworked to fix these problems, eliminate the
refcounting and remove atomic operations entirely from the read path
(generally making better use of RCU).  The avc entry ref has been removed
as part of this simplification in anticipation of an RCU scalability patch
which removes them in general.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

---

 security/selinux/hooks.c          |   43 ++++---------
 security/selinux/include/netif.h  |   11 ---
 security/selinux/include/objsec.h |    1 
 security/selinux/netif.c          |  120 +++++++++++++++++++++++---------------
 4 files changed, 89 insertions(+), 86 deletions(-)


diff -purN -X dontdiff linux-2.6.9-mm1.p/security/selinux/hooks.c linux-2.6.9-mm1.w/security/selinux/hooks.c
--- linux-2.6.9-mm1.p/security/selinux/hooks.c	2004-10-22 11:11:49.000000000 -0400
+++ linux-2.6.9-mm1.w/security/selinux/hooks.c	2004-10-22 11:43:22.762886984 -0400
@@ -3243,13 +3243,11 @@ static int selinux_socket_sock_rcv_skb(s
 	u16 family;
 	char *addrp;
 	int len, err = 0;
-	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
+	u32 netif_perm, node_perm, node_sid, if_sid, recv_perm = 0;
 	u32 sock_sid = 0;
 	u16 sock_class = 0;
 	struct socket *sock;
 	struct net_device *dev;
-	struct sel_netif *netif;
-	struct netif_security_struct *nsec;
 	struct avc_audit_data ad;
 
 	family = sk->sk_family;
@@ -3280,13 +3278,9 @@ static int selinux_socket_sock_rcv_skb(s
 	if (!dev)
 		goto out;
 
-	netif = sel_netif_lookup(dev);
-	if (IS_ERR(netif)) {
-		err = PTR_ERR(netif);
+	err = sel_netif_sids(dev, &if_sid, NULL);
+	if (err)
 		goto out;
-	}
-	
-	nsec = &netif->nsec;
 
 	switch (sock_class) {
 	case SECCLASS_UDP_SOCKET:
@@ -3312,14 +3306,11 @@ static int selinux_socket_sock_rcv_skb(s
 	ad.u.net.family = family;
 
 	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1);
-	if (err) {
-		sel_netif_put(netif);
+	if (err)
 		goto out;
-	}
 
-	err = avc_has_perm(sock_sid, nsec->if_sid, SECCLASS_NETIF,
-	                   netif_perm, &nsec->avcr, &ad);
-	sel_netif_put(netif);
+	err = avc_has_perm(sock_sid, if_sid, SECCLASS_NETIF,
+	                   netif_perm, NULL, &ad);
 	if (err)
 		goto out;
 	
@@ -3435,13 +3426,11 @@ static unsigned int selinux_ip_postroute
 {
 	char *addrp;
 	int len, err = NF_ACCEPT;
-	u32 netif_perm, node_perm, node_sid, send_perm = 0;
+	u32 netif_perm, node_perm, node_sid, if_sid, send_perm = 0;
 	struct sock *sk;
 	struct socket *sock;
 	struct inode *inode;
-	struct sel_netif *netif;
 	struct sk_buff *skb = *pskb;
-	struct netif_security_struct *nsec;
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 	struct net_device *dev = (struct net_device *)out;
@@ -3458,13 +3447,10 @@ static unsigned int selinux_ip_postroute
 	if (!inode)
 		goto out;
 
-	netif = sel_netif_lookup(dev);
-	if (IS_ERR(netif)) {
-		err = NF_DROP;
+	err = sel_netif_sids(dev, &if_sid, NULL);
+	if (err)
 		goto out;
-	}
-	
-	nsec = &netif->nsec;
+
 	isec = inode->i_security;
 	
 	switch (isec->sclass) {
@@ -3493,14 +3479,11 @@ static unsigned int selinux_ip_postroute
 
 	err = selinux_parse_skb(skb, &ad, &addrp,
 				&len, 0) ? NF_DROP : NF_ACCEPT;
-	if (err != NF_ACCEPT) {
-		sel_netif_put(netif);
+	if (err != NF_ACCEPT)
 		goto out;
-	}
 
-	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
-	                   netif_perm, &nsec->avcr, &ad) ? NF_DROP : NF_ACCEPT;
-	sel_netif_put(netif);
+	err = avc_has_perm(isec->sid, if_sid, SECCLASS_NETIF,
+	                   netif_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
 	if (err != NF_ACCEPT)
 		goto out;
 		
diff -purN -X dontdiff linux-2.6.9-mm1.p/security/selinux/include/netif.h linux-2.6.9-mm1.w/security/selinux/include/netif.h
--- linux-2.6.9-mm1.p/security/selinux/include/netif.h	2004-08-14 01:36:58.000000000 -0400
+++ linux-2.6.9-mm1.w/security/selinux/include/netif.h	2004-10-22 11:43:22.788883032 -0400
@@ -15,16 +15,7 @@
 #ifndef _SELINUX_NETIF_H_
 #define _SELINUX_NETIF_H_
 
-struct sel_netif
-{
-	struct list_head list;
-	atomic_t users;
-	struct netif_security_struct nsec;
-	struct rcu_head rcu_head;
-};
-
-struct sel_netif *sel_netif_lookup(struct net_device *dev);
-void sel_netif_put(struct sel_netif *netif);
+int sel_netif_sids(struct net_device *dev, u32 *if_sid, u32 *msg_sid);
 
 #endif	/* _SELINUX_NETIF_H_ */
 
diff -purN -X dontdiff linux-2.6.9-mm1.p/security/selinux/include/objsec.h linux-2.6.9-mm1.w/security/selinux/include/objsec.h
--- linux-2.6.9-mm1.p/security/selinux/include/objsec.h	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-mm1.w/security/selinux/include/objsec.h	2004-10-22 11:43:23.021847616 -0400
@@ -99,7 +99,6 @@ struct netif_security_struct {
 	struct net_device *dev;		/* back pointer */
 	u32 if_sid;			/* SID for this interface */
 	u32 msg_sid;			/* default SID for messages received on this interface */
-	struct avc_entry_ref avcr;	/* reference to permissions */
 };
 
 struct sk_security_struct {
diff -purN -X dontdiff linux-2.6.9-mm1.p/security/selinux/netif.c linux-2.6.9-mm1.w/security/selinux/netif.c
--- linux-2.6.9-mm1.p/security/selinux/netif.c	2004-08-14 01:36:58.000000000 -0400
+++ linux-2.6.9-mm1.w/security/selinux/netif.c	2004-10-22 11:43:23.023847312 -0400
@@ -36,10 +36,17 @@
 #define DEBUGP(format, args...)
 #endif
 
+struct sel_netif
+{
+	struct list_head list;
+	struct netif_security_struct nsec;
+	struct rcu_head rcu_head;
+};
+
 static u32 sel_netif_total;
 static LIST_HEAD(sel_netif_list);
 static spinlock_t sel_netif_lock = SPIN_LOCK_UNLOCKED;
-static struct sel_netif sel_netif_hash[SEL_NETIF_HASH_SIZE];
+static struct list_head sel_netif_hash[SEL_NETIF_HASH_SIZE];
 
 static inline u32 sel_netif_hasfn(struct net_device *dev)
 {
@@ -50,12 +57,12 @@ static inline u32 sel_netif_hasfn(struct
  * All of the devices should normally fit in the hash, so we optimize
  * for that case.
  */
-static struct sel_netif *sel_netif_find(struct net_device *dev)
+static inline struct sel_netif *sel_netif_find(struct net_device *dev)
 {
 	struct list_head *pos;
 	int idx = sel_netif_hasfn(dev);
 
-	__list_for_each_rcu(pos, &sel_netif_hash[idx].list) {
+	__list_for_each_rcu(pos, &sel_netif_hash[idx]) {
 		struct sel_netif *netif = list_entry(pos,
 		                                     struct sel_netif, list);
 		if (likely(netif->nsec.dev == dev))
@@ -74,25 +81,38 @@ static int sel_netif_insert(struct sel_n
 	}
 	
 	idx = sel_netif_hasfn(netif->nsec.dev);
-	list_add_rcu(&netif->list, &sel_netif_hash[idx].list);
-	atomic_set(&netif->users, 1);
+	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
 	sel_netif_total++;
 out:
 	return ret;
 }
 
-struct sel_netif *sel_netif_lookup(struct net_device *dev)
+static void sel_netif_free(struct rcu_head *p)
+{
+	struct sel_netif *netif = container_of(p, struct sel_netif, rcu_head);
+	
+	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
+	kfree(netif);
+}
+
+static void sel_netif_destroy(struct sel_netif *netif)
+{
+	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
+
+	list_del_rcu(&netif->list);
+	sel_netif_total--;
+	call_rcu(&netif->rcu_head, sel_netif_free);
+}
+
+static struct sel_netif *sel_netif_lookup(struct net_device *dev)
 {
 	int ret;
 	struct sel_netif *netif, *new;
 	struct netif_security_struct *nsec;
 
-	rcu_read_lock();
 	netif = sel_netif_find(dev);
-	rcu_read_unlock();
-	
 	if (likely(netif != NULL))
-		goto out_hold;
+		goto out;
 	
 	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new) {
@@ -118,76 +138,86 @@ struct sel_netif *sel_netif_lookup(struc
 	if (netif) {
 		spin_unlock_bh(&sel_netif_lock);
 		kfree(new);
-		goto out_hold;
+		goto out;
 	}
 	
-	sel_netif_insert(new);
+	ret = sel_netif_insert(new);
 	spin_unlock_bh(&sel_netif_lock);
 	
+	if (ret) {
+		kfree(new);
+		netif = ERR_PTR(ret);
+		goto out;
+	}
+	
 	netif = new;
 	
 	DEBUGP("new: ifindex=%u name=%s if_sid=%u msg_sid=%u\n", dev->ifindex, dev->name,
 	        nsec->if_sid, nsec->msg_sid);
-out_hold:
-	atomic_inc(&netif->users);
 out:
 	return netif;
 }
 
-static void sel_netif_free(struct rcu_head *p)
+static void sel_netif_assign_sids(u32 if_sid_in, u32 msg_sid_in, u32 *if_sid_out, u32 *msg_sid_out)
 {
-	struct sel_netif *netif = container_of(p, struct sel_netif, rcu_head);
-	
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
-	kfree(netif);
+	if (if_sid_out)
+		*if_sid_out = if_sid_in;
+	if (msg_sid_out)
+		*msg_sid_out = msg_sid_in;
 }
 
-static void sel_netif_destroy(struct sel_netif *netif)
+static int sel_netif_sids_slow(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
 {
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
+	int ret = 0;
+	u32 tmp_if_sid, tmp_msg_sid;
 	
-	spin_lock_bh(&sel_netif_lock);
-	list_del_rcu(&netif->list);
-	sel_netif_total--;
-	spin_unlock_bh(&sel_netif_lock);
-
-	call_rcu(&netif->rcu_head, sel_netif_free);
+	ret = security_netif_sid(dev->name, &tmp_if_sid, &tmp_msg_sid);
+	if (!ret)
+		sel_netif_assign_sids(tmp_if_sid, tmp_msg_sid, if_sid, msg_sid);
+	return ret;
 }
 
-void sel_netif_put(struct sel_netif *netif)
+int sel_netif_sids(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
 {
-	if (atomic_dec_and_test(&netif->users))
-		sel_netif_destroy(netif);
+	int ret = 0;
+	struct sel_netif *netif;
+
+	rcu_read_lock();
+	netif = sel_netif_lookup(dev);
+	if (IS_ERR(netif)) {
+		rcu_read_unlock();
+		ret = sel_netif_sids_slow(dev, if_sid, msg_sid);
+		goto out;
+	}
+	sel_netif_assign_sids(netif->nsec.if_sid, netif->nsec.msg_sid, if_sid, msg_sid);
+	rcu_read_unlock();
+out:	
+	return ret;
 }
 
 static void sel_netif_kill(struct net_device *dev)
 {
 	struct sel_netif *netif;
-	
-	rcu_read_lock();
-	netif = sel_netif_find(dev);
-	rcu_read_unlock();
 
-	/* Drop internal reference */
+	spin_lock_bh(&sel_netif_lock);
+	netif = sel_netif_find(dev);
 	if (netif)
-		sel_netif_put(netif);
+		sel_netif_destroy(netif);
+	spin_unlock_bh(&sel_netif_lock);
 }
 
 static void sel_netif_flush(void)
 {
 	int idx;
 
+	spin_lock_bh(&sel_netif_lock);
 	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++) {
-		struct list_head *pos;
+		struct sel_netif *netif;
 		
-		list_for_each_rcu(pos, &sel_netif_hash[idx].list) {
-			struct sel_netif *netif;
-			
-			netif = list_entry(pos, struct sel_netif, list);
-			if (netif)
-				sel_netif_put(netif);
-		}
+		list_for_each_entry(netif, &sel_netif_hash[idx], list)
+			sel_netif_destroy(netif);
 	}
+	spin_unlock_bh(&sel_netif_lock);
 }
 
 static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
@@ -223,7 +253,7 @@ static __init int sel_netif_init(void)
 		goto out;
 
 	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
-		INIT_LIST_HEAD(&sel_netif_hash[i].list);
+		INIT_LIST_HEAD(&sel_netif_hash[i]);
 
 	register_netdevice_notifier(&sel_netif_netdev_notifier);
 	





