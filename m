Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUH3LSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUH3LSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUH3LSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 07:18:47 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:51350 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267686AbUH3LRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 07:17:51 -0400
Message-ID: <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil> <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp> <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil>
Subject: [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)
Date: Mon, 30 Aug 2004 20:17:37 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_066C_01C48ECE.64C18DB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_066C_01C48ECE.64C18DB0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi Stephen, thanks for your comments.

> > Please wait for a patch, thanks.
> 
> Thanks for working on this.  Could you also supply updated performance
> data when you have a newer patch?  Thanks.

I fixed the take-3 patch according to your and Paul's suggestions.

The attached take-4 patches replace the avc_lock in security/selinux/avc.c
by the lock-less read access with RCU.

The patches consist of three parts as follows:
[1] selinux.rcu-2.6.8.1-take4.patch
     removed the spinlock (avc_lock) from security/selinux/avc.c,
     and applied RCU-approach for the lock-less read access to the AVC.
[2] list_replace_rcu-2.6.8.1.patch
     added list_replace_rcu() to include/linux/list.h for the atomic updating
     operations according to RCU-model.
[3] atomic_inc_return-2.6.8.1.patch
     added atomic_inc_return() and atomic_dec_return() to i386, x86_64 and ARM
     architectures. It's necessary for the [1] patch.


[Changes by these patches from original implementation]
- Some of the data structures are re-defined.
  (struct avc_entry/struct avc_node/struct avc_cache)
- The direct references from security-private member in inode, task_struct and so on
  were removed, since these references prevent from applying RCU.
  Currently, avc_entry_ref is not used.
- The pre-allocation semantics of avc_node structure was replaced by kmalloc()
  on demand, since it's necessary for applying RCU.
  (The number of nodes is adjusted by AVC_CACHE_THRESHOLD, but it's not a hard limit.)
- avc_update_node() can return -ENOMEM when kmalloc() returns NULL.
  But this is not a significant problem, since the function is actually called
  by only avc_has_perm_noaudit() for the control of the flood of audit-logs.

Signed-off-by: KaiGai, Kohei <kaigai@ak.jp.nec.com>
Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>

Thanks for all the comments and suggestions.


[Performance & Scalability results] --------------------------------------

2.6.8.1(disable/enable) : Original Stock Kernel
2.6.8.1.rwlock          : Improvement by rwlock(not disclosed)
2.6.8.1.rcu             : Improvement by RCU(attached take-4 patch)

o 500,000 times of write() syscall to the file on /dev/shm
 on Itanium2 x 1/2/4/8/16/32 + enough memory(needless to swap-out)
 *) The num of Processes equals the num of CPUs.
---------------- --1CPU--  --2CPU-- --4CPU-- -- 8CPU-- --16CPU-- --32CPU--
2.6.8.1(disable)   8.2959    8.0430   8.0158    8.0183    8.0146    8.0037
2.6.8.1(enable)   11.8427   14.0358  78.0957  319.0451 1322.0313  too long
2.6.8.1.rwlock    11.2485   13.8688  20.0100   49.0390   90.0200  177.0533
2.6.8.1.rcu       11.3754   11.2028  11.1743   11.1402   11.1216   11.2635
---------------- --------  -------- -------- --------- --------- ---------

o dbench (10 times mean results)
- Average[MB/s] -  -1proc- -2procs- -4procs-
2.6.8.1(disable)    247.43   473.11   891.51
2.6.8.1(enable)     218.99   434.97   761.06
2.6.8.1(+rwlock)    225.18   432.80   802.62
2.6.8.1(+RCU)       231.16   447.62   838.15
--------------------------------------------

o UNIX-bench

* INDEX value comparison ---------------------------------------------------
                                       2.6.8.1   2.6.8.1   2.6.8.1   2.6.8.1
                                     (Disable)  (Enable)  (rwlock)    (RCU) 
Dhrystone 2 using register variables    268.9     268.8     269.2     268.7 
Double-Precision Whetstone               94.2      94.2      94.2      94.2 
Execl Throughput                        388.3     379.0     377.8     377.0 
File Copy 1024 bufsize 2000 maxblocks   606.6     526.6     515.6     513.1 
File Copy 256 bufsize 500 maxblocks     508.9     417.0     410.4     402.9 
File Copy 4096 bufsize 8000 maxblocks   987.1     890.4     876.0     864.1 
Pipe Throughput                         525.1     406.4     404.5     356.2 
Process Creation                        321.2     317.8     315.9     316.5 
Shell Scripts (8 concurrent)           1312.8    1276.2    1278.8    1279.5 
System Call Overhead                    467.1     468.7     464.1     468.1 
                                    ========================================
     FINAL SCORE                        445.8     413.2     410.1     403.8 
----------------------------------------------------------------------------

--------
Kai Gai <kaigai@ak.jp.nec.com>


------=_NextPart_000_066C_01C48ECE.64C18DB0
Content-Type: application/octet-stream;
	name="selinux.rcu-2.6.8.1-take4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinux.rcu-2.6.8.1-take4.patch"

diff -rNU4 linux-2.6.8.1/security/selinux/avc.c =
linux-2.6.8.1.rcu/security/selinux/avc.c=0A=
--- linux-2.6.8.1/security/selinux/avc.c	2004-08-14 19:55:48.000000000 =
+0900=0A=
+++ linux-2.6.8.1.rcu/security/selinux/avc.c	2004-08-30 =
20:00:27.000000000 +0900=0A=
@@ -3,8 +3,11 @@=0A=
  *=0A=
  * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>=0A=
  *           James Morris <jmorris@redhat.com>=0A=
  *=0A=
+ * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>=0A=
+ *     Replaced the avc_lock spinlock by RCU.=0A=
+ *=0A=
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>=0A=
  *=0A=
  *	This program is free software; you can redistribute it and/or modify=0A=
  *	it under the terms of the GNU General Public License version 2,=0A=
@@ -35,28 +38,32 @@=0A=
 #include "av_perm_to_string.h"=0A=
 #include "objsec.h"=0A=
 =0A=
 #define AVC_CACHE_SLOTS		512=0A=
-#define AVC_CACHE_MAXNODES	410=0A=
+#define AVC_CACHE_THRESHOLD	410=0A=
+#define AVC_CACHE_RECLAIM	16=0A=
 =0A=
 struct avc_entry {=0A=
 	u32			ssid;=0A=
 	u32			tsid;=0A=
 	u16			tclass;=0A=
 	struct av_decision	avd;=0A=
-	int			used;	/* used recently */=0A=
+	atomic_t		used;	/* used recently */=0A=
 };=0A=
 =0A=
 struct avc_node {=0A=
 	struct avc_entry	ae;=0A=
-	struct avc_node		*next;=0A=
+	struct list_head	list;=0A=
+	struct rcu_head         rhead;=0A=
 };=0A=
 =0A=
 struct avc_cache {=0A=
-	struct avc_node	*slots[AVC_CACHE_SLOTS];=0A=
-	u32		lru_hint;	/* LRU hint for reclaim scan */=0A=
-	u32		active_nodes;=0A=
-	u32		latest_notif;	/* latest revocation notification */=0A=
+	struct list_head	slots[AVC_CACHE_SLOTS];=0A=
+	spinlock_t		slots_lock[AVC_CACHE_SLOTS];=0A=
+		/* lock for insert/update/delete and reset */=0A=
+	atomic_t		lru_hint;	/* LRU hint for reclaim scan */=0A=
+	atomic_t		active_nodes;=0A=
+	u32			latest_notif;	/* latest revocation notification */=0A=
 };=0A=
 =0A=
 struct avc_callback_node {=0A=
 	int (*callback) (u32 event, u32 ssid, u32 tsid,=0A=
@@ -69,10 +76,8 @@=0A=
 	u32 perms;=0A=
 	struct avc_callback_node *next;=0A=
 };=0A=
 =0A=
-static spinlock_t avc_lock =3D SPIN_LOCK_UNLOCKED;=0A=
-static struct avc_node *avc_node_freelist;=0A=
 static struct avc_cache avc_cache;=0A=
 static unsigned avc_cache_stats[AVC_NSTATS];=0A=
 static struct avc_callback_node *avc_callbacks;=0A=
 =0A=
@@ -187,23 +192,17 @@=0A=
  * Initialize the access vector cache.=0A=
  */=0A=
 void __init avc_init(void)=0A=
 {=0A=
-	struct avc_node	*new;=0A=
 	int i;=0A=
 =0A=
-	for (i =3D 0; i < AVC_CACHE_MAXNODES; i++) {=0A=
-		new =3D kmalloc(sizeof(*new), GFP_ATOMIC);=0A=
-		if (!new) {=0A=
-			printk(KERN_WARNING "avc:  only able to allocate "=0A=
-			       "%d entries\n", i);=0A=
-			break;=0A=
-		}=0A=
-		memset(new, 0, sizeof(*new));=0A=
-		new->next =3D avc_node_freelist;=0A=
-		avc_node_freelist =3D new;=0A=
-	}=0A=
-=0A=
+	for (i =3D0; i < AVC_CACHE_SLOTS; i++) {=0A=
+		INIT_LIST_HEAD(&avc_cache.slots[i]);=0A=
+		avc_cache.slots_lock[i] =3D SPIN_LOCK_UNLOCKED;=0A=
+	}=0A=
+	atomic_set(&avc_cache.active_nodes, 0);=0A=
+	atomic_set(&avc_cache.lru_hint, 0);=0A=
+	=0A=
 	audit_log(current->audit_context, "AVC INITIALIZED\n");=0A=
 }=0A=
 =0A=
 #if 0=0A=
@@ -212,27 +211,24 @@=0A=
 	int i, chain_len, max_chain_len, slots_used;=0A=
 	struct avc_node *node;=0A=
 	unsigned long flags;=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
+	rcu_read_lock();=0A=
 =0A=
 	slots_used =3D 0;=0A=
 	max_chain_len =3D 0;=0A=
 	for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {=0A=
-		node =3D avc_cache.slots[i];=0A=
-		if (node) {=0A=
+		if (!list_empty(&avc_cache.slots[i])) {=0A=
 			slots_used++;=0A=
 			chain_len =3D 0;=0A=
-			while (node) {=0A=
+			list_for_each_entry_rcu(node, &avc_cache.slots[i])=0A=
 				chain_len++;=0A=
-				node =3D node->next;=0A=
-			}=0A=
 			if (chain_len > max_chain_len)=0A=
 				max_chain_len =3D chain_len;=0A=
 		}=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 =0A=
 	printk(KERN_INFO "\n");=0A=
 	printk(KERN_INFO "%s avc:  %d entries and %d/%d buckets used, longest "=0A=
 	       "chain length %d\n", tag, avc_cache.active_nodes, slots_used,=0A=
@@ -242,188 +238,210 @@=0A=
 static inline void avc_hash_eval(char *tag)=0A=
 { }=0A=
 #endif=0A=
 =0A=
-static inline struct avc_node *avc_reclaim_node(void)=0A=
+static void avc_node_free(struct rcu_head *rhead) {=0A=
+	struct avc_node *node;=0A=
+	node =3D container_of(rhead, struct avc_node, rhead);=0A=
+	kfree(node);=0A=
+}=0A=
+=0A=
+static inline int avc_reclaim_node(void)=0A=
 {=0A=
-	struct avc_node *prev, *cur;=0A=
-	int hvalue, try;=0A=
+	struct avc_node *node;=0A=
+	int hvalue, try, ecx;=0A=
 =0A=
-	hvalue =3D avc_cache.lru_hint;=0A=
-	for (try =3D 0; try < 2; try++) {=0A=
-		do {=0A=
-			prev =3D NULL;=0A=
-			cur =3D avc_cache.slots[hvalue];=0A=
-			while (cur) {=0A=
-				if (!cur->ae.used)=0A=
-					goto found;=0A=
+	for (try =3D 0, ecx =3D 0; try < AVC_CACHE_SLOTS; try++ ) {=0A=
+		hvalue =3D atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;=0A=
 =0A=
-				cur->ae.used =3D 0;=0A=
+		if (!spin_trylock(&avc_cache.slots_lock[hvalue]))=0A=
+			continue;=0A=
 =0A=
-				prev =3D cur;=0A=
-				cur =3D cur->next;=0A=
+		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {=0A=
+			if (!atomic_dec_and_test(&node->ae.used)) {=0A=
+				/* Recently Unused */=0A=
+				list_del_rcu(&node->list);=0A=
+				call_rcu(&node->rhead, avc_node_free);=0A=
+				atomic_dec(&avc_cache.active_nodes);=0A=
+				ecx++;=0A=
+				if (ecx >=3D AVC_CACHE_RECLAIM) {=0A=
+					spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
+					goto out;=0A=
+				}=0A=
 			}=0A=
-			hvalue =3D (hvalue + 1) & (AVC_CACHE_SLOTS - 1);=0A=
-		} while (hvalue !=3D avc_cache.lru_hint);=0A=
+		}=0A=
+		spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
 	}=0A=
-=0A=
-	panic("avc_reclaim_node");=0A=
-=0A=
-found:=0A=
-	avc_cache.lru_hint =3D hvalue;=0A=
-=0A=
-	if (prev =3D=3D NULL)=0A=
-		avc_cache.slots[hvalue] =3D cur->next;=0A=
-	else=0A=
-		prev->next =3D cur->next;=0A=
-=0A=
-	return cur;=0A=
+out:=0A=
+	return ecx;=0A=
 }=0A=
 =0A=
-static inline struct avc_node *avc_claim_node(u32 ssid,=0A=
-                                              u32 tsid, u16 tclass)=0A=
+static inline struct avc_node *avc_get_node(void)=0A=
 {=0A=
 	struct avc_node *new;=0A=
-	int hvalue;=0A=
-=0A=
-	hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
-	if (avc_node_freelist) {=0A=
-		new =3D avc_node_freelist;=0A=
-		avc_node_freelist =3D avc_node_freelist->next;=0A=
-		avc_cache.active_nodes++;=0A=
-	} else {=0A=
-		new =3D avc_reclaim_node();=0A=
-		if (!new)=0A=
-			goto out;=0A=
-	}=0A=
+	int actives;=0A=
 =0A=
-	new->ae.used =3D 1;=0A=
-	new->ae.ssid =3D ssid;=0A=
-	new->ae.tsid =3D tsid;=0A=
-	new->ae.tclass =3D tclass;=0A=
-	new->next =3D avc_cache.slots[hvalue];=0A=
-	avc_cache.slots[hvalue] =3D new;=0A=
+	new =3D kmalloc(sizeof(struct avc_node), GFP_ATOMIC);=0A=
+	if (!new)=0A=
+		return NULL;=0A=
+=0A=
+	INIT_RCU_HEAD(&new->rhead);=0A=
+	INIT_LIST_HEAD(&new->list);=0A=
+=0A=
+	actives =3D atomic_inc_return(&avc_cache.active_nodes);=0A=
+	if (actives > AVC_CACHE_THRESHOLD)=0A=
+		avc_reclaim_node();=0A=
 =0A=
-out:=0A=
 	return new;=0A=
 }=0A=
 =0A=
 static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid,=0A=
                                                u16 tclass, int *probes)=0A=
 {=0A=
-	struct avc_node *cur;=0A=
+	struct avc_node *node, *ret =3D NULL;=0A=
 	int hvalue;=0A=
 	int tprobes =3D 1;=0A=
 =0A=
 	hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
-	cur =3D avc_cache.slots[hvalue];=0A=
-	while (cur !=3D NULL &&=0A=
-	       (ssid !=3D cur->ae.ssid ||=0A=
-		tclass !=3D cur->ae.tclass ||=0A=
-		tsid !=3D cur->ae.tsid)) {=0A=
+	list_for_each_entry_rcu(node, &avc_cache.slots[hvalue], list) {=0A=
+		if (ssid =3D=3D node->ae.ssid &&=0A=
+		    tclass =3D=3D node->ae.tclass &&=0A=
+		    tsid =3D=3D node->ae.tsid) {=0A=
+			ret =3D node;=0A=
+			break;=0A=
+		}=0A=
 		tprobes++;=0A=
-		cur =3D cur->next;=0A=
 	}=0A=
 =0A=
-	if (cur =3D=3D NULL) {=0A=
+	if (ret =3D=3D NULL) {=0A=
 		/* cache miss */=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
 	/* cache hit */=0A=
 	if (probes)=0A=
 		*probes =3D tprobes;=0A=
-=0A=
-	cur->ae.used =3D 1;=0A=
-=0A=
+	if (atomic_read(&ret->ae.used) !=3D 1)=0A=
+		atomic_set(&ret->ae.used, 1);=0A=
 out:=0A=
-	return cur;=0A=
+	return ret;=0A=
 }=0A=
 =0A=
 /**=0A=
  * avc_lookup - Look up an AVC entry.=0A=
  * @ssid: source security identifier=0A=
  * @tsid: target security identifier=0A=
  * @tclass: target security class=0A=
  * @requested: requested permissions, interpreted based on @tclass=0A=
- * @aeref:  AVC entry reference=0A=
  *=0A=
  * Look up an AVC entry that is valid for the=0A=
  * @requested permissions between the SID pair=0A=
  * (@ssid, @tsid), interpreting the permissions=0A=
  * based on @tclass.  If a valid AVC entry exists,=0A=
- * then this function updates @aeref to refer to the=0A=
- * entry and returns %0. Otherwise, this function=0A=
- * returns -%ENOENT.=0A=
+ * then this function return the avc_node.=0A=
+ * Otherwise, this function returns NULL.=0A=
  */=0A=
-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,=0A=
-               u32 requested, struct avc_entry_ref *aeref)=0A=
+struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 =
requested)=0A=
 {=0A=
 	struct avc_node *node;=0A=
-	int probes, rc =3D 0;=0A=
+	int probes;=0A=
 =0A=
 	avc_cache_stats_incr(AVC_CAV_LOOKUPS);=0A=
 	node =3D avc_search_node(ssid, tsid, tclass,&probes);=0A=
 =0A=
 	if (node && ((node->ae.avd.decided & requested) =3D=3D requested)) {=0A=
 		avc_cache_stats_incr(AVC_CAV_HITS);=0A=
 		avc_cache_stats_add(AVC_CAV_PROBES,probes);=0A=
-		aeref->ae =3D &node->ae;=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
+	node =3D NULL;=0A=
 	avc_cache_stats_incr(AVC_CAV_MISSES);=0A=
-	rc =3D -ENOENT;=0A=
 out:=0A=
-	return rc;=0A=
+	return node;=0A=
+}=0A=
+=0A=
+static int avc_latest_notif_update(int seqno, int is_insert)=0A=
+{=0A=
+	int ret =3D 0;=0A=
+	static spinlock_t notif_lock =3D SPIN_LOCK_UNLOCKED;=0A=
+	unsigned long flag;=0A=
+=0A=
+	spin_lock_irqsave(&notif_lock, flag);=0A=
+	if (is_insert) {=0A=
+		if (seqno < avc_cache.latest_notif) {=0A=
+			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",=0A=
+			       seqno, avc_cache.latest_notif);=0A=
+			ret =3D -EAGAIN;=0A=
+		}=0A=
+	} else {=0A=
+		if (seqno > avc_cache.latest_notif)=0A=
+			avc_cache.latest_notif =3D seqno;=0A=
+	}=0A=
+	spin_unlock_irqrestore(&notif_lock, flag);=0A=
+=0A=
+	return ret;=0A=
 }=0A=
 =0A=
 /**=0A=
  * avc_insert - Insert an AVC entry.=0A=
  * @ssid: source security identifier=0A=
  * @tsid: target security identifier=0A=
  * @tclass: target security class=0A=
  * @ae: AVC entry=0A=
- * @aeref:  AVC entry reference=0A=
  *=0A=
  * Insert an AVC entry for the SID pair=0A=
  * (@ssid, @tsid) and class @tclass.=0A=
  * The access vectors and the sequence number are=0A=
  * normally provided by the security server in=0A=
  * response to a security_compute_av() call.  If the=0A=
  * sequence number @ae->avd.seqno is not less than the latest=0A=
  * revocation notification, then the function copies=0A=
- * the access vectors into a cache entry, updates=0A=
- * @aeref to refer to the entry, and returns %0.=0A=
- * Otherwise, this function returns -%EAGAIN.=0A=
+ * the access vectors into a cache entry, returns=0A=
+ * avc_node inserted. Otherwise, this function returns NULL.=0A=
  */=0A=
-int avc_insert(u32 ssid, u32 tsid, u16 tclass,=0A=
-               struct avc_entry *ae, struct avc_entry_ref *aeref)=0A=
+struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct =
avc_entry *ae)=0A=
 {=0A=
-	struct avc_node *node;=0A=
-	int rc =3D 0;=0A=
+	struct avc_node *pos, *node =3D NULL;=0A=
+	int hvalue;=0A=
+	unsigned long flag;=0A=
 =0A=
-	if (ae->avd.seqno < avc_cache.latest_notif) {=0A=
-		printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",=0A=
-		       ae->avd.seqno, avc_cache.latest_notif);=0A=
-		rc =3D -EAGAIN;=0A=
+	if (avc_latest_notif_update(ae->avd.seqno, 1))=0A=
 		goto out;=0A=
-	}=0A=
 =0A=
-	node =3D avc_claim_node(ssid, tsid, tclass);=0A=
-	if (!node) {=0A=
-		rc =3D -ENOMEM;=0A=
-		goto out;=0A=
-	}=0A=
+	node =3D avc_get_node();=0A=
+=0A=
+	if (node) {=0A=
+		hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
 =0A=
-	node->ae.avd.allowed =3D ae->avd.allowed;=0A=
-	node->ae.avd.decided =3D ae->avd.decided;=0A=
-	node->ae.avd.auditallow =3D ae->avd.auditallow;=0A=
-	node->ae.avd.auditdeny =3D ae->avd.auditdeny;=0A=
-	node->ae.avd.seqno =3D ae->avd.seqno;=0A=
-	aeref->ae =3D &node->ae;=0A=
+		node->ae.ssid =3D ssid;=0A=
+		node->ae.tsid =3D tsid;=0A=
+		node->ae.tclass =3D tclass;=0A=
+		atomic_set(&node->ae.used, 1);=0A=
+=0A=
+		node->ae.avd.allowed =3D ae->avd.allowed;=0A=
+		node->ae.avd.decided =3D ae->avd.decided;=0A=
+		node->ae.avd.auditallow =3D ae->avd.auditallow;=0A=
+		node->ae.avd.auditdeny =3D ae->avd.auditdeny;=0A=
+		node->ae.avd.seqno =3D ae->avd.seqno;=0A=
+=0A=
+		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);=0A=
+		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {=0A=
+			if (pos->ae.ssid =3D=3D ssid &&=0A=
+			    pos->ae.tsid =3D=3D tsid &&=0A=
+			    pos->ae.tclass =3D=3D tclass) {=0A=
+				list_replace_rcu(&pos->list, &node->list);=0A=
+				call_rcu(&pos->rhead, avc_node_free);=0A=
+				atomic_dec(&avc_cache.active_nodes);=0A=
+				goto found;=0A=
+			}=0A=
+		}=0A=
+		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);=0A=
+found:=0A=
+		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);=0A=
+	}=0A=
 out:=0A=
-	return rc;=0A=
+	return node;=0A=
 }=0A=
 =0A=
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,=0A=
 				       struct in6_addr *addr, u16 port,=0A=
@@ -685,10 +703,51 @@=0A=
 {=0A=
 	return (x =3D=3D y || x =3D=3D SECSID_WILD || y =3D=3D SECSID_WILD);=0A=
 }=0A=
 =0A=
-static inline void avc_update_node(u32 event, struct avc_node *node, =
u32 perms)=0A=
+/**=0A=
+ * avc_update_node Update an AVC entry=0A=
+ * @event : Updating event=0A=
+ * @perms : Permission mask bits=0A=
+ * @ssid,@tsid,@tclass : identifier of an AVC entry=0A=
+ * =0A=
+ * if a valid AVC entry doesn't exist,this function returns -ENOENT.=0A=
+ * if kmalloc() called internal returns NULL, this function returns =
-ENOMEM.=0A=
+ * otherwise, this function update the AVC entry. The original =
AVC-entry object=0A=
+ * will release later by RCU.=0A=
+ */=0A=
+static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, =
u16 tclass)=0A=
 {=0A=
+	int hvalue, rc =3D 0;=0A=
+	unsigned long flag;=0A=
+	struct avc_node *pos, *node, *org =3D NULL;=0A=
+=0A=
+	/* Lock the target slot */=0A=
+	hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
+	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);=0A=
+=0A=
+	list_for_each_entry(pos, &avc_cache.slots[hvalue], list){=0A=
+		if ( ssid=3D=3Dpos->ae.ssid &&=0A=
+		     tsid=3D=3Dpos->ae.tsid &&=0A=
+		     tclass=3D=3Dpos->ae.tclass ){=0A=
+			org =3D pos;=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (!org) {=0A=
+		rc =3D -ENOENT;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	node =3D kmalloc(sizeof(struct avc_node), GFP_ATOMIC);=0A=
+	if (!node) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	/* Duplicate and Update */=0A=
+	memcpy(node, org, sizeof(struct avc_node));=0A=
 	switch (event) {=0A=
 	case AVC_CALLBACK_GRANT:=0A=
 		node->ae.avd.allowed |=3D perms;=0A=
 		break;=0A=
@@ -708,40 +767,41 @@=0A=
 	case AVC_CALLBACK_AUDITDENY_DISABLE:=0A=
 		node->ae.avd.auditdeny &=3D ~perms;=0A=
 		break;=0A=
 	}=0A=
+	list_replace_rcu(&org->list,&node->list);=0A=
+out:=0A=
+	spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);=0A=
+=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 static int avc_update_cache(u32 event, u32 ssid, u32 tsid,=0A=
                             u16 tclass, u32 perms)=0A=
 {=0A=
 	struct avc_node *node;=0A=
 	int i;=0A=
-	unsigned long flags;=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
+	rcu_read_lock();=0A=
 =0A=
 	if (ssid =3D=3D SECSID_WILD || tsid =3D=3D SECSID_WILD) {=0A=
 		/* apply to all matching nodes */=0A=
 		for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {=0A=
-			for (node =3D avc_cache.slots[i]; node;=0A=
-			     node =3D node->next) {=0A=
+			list_for_each_entry_rcu(node, &avc_cache.slots[i], list) {=0A=
 				if (avc_sidcmp(ssid, node->ae.ssid) &&=0A=
 				    avc_sidcmp(tsid, node->ae.tsid) &&=0A=
-				    tclass =3D=3D node->ae.tclass) {=0A=
-					avc_update_node(event,node,perms);=0A=
+				    tclass =3D=3D node->ae.tclass ) {=0A=
+					avc_update_node(event, perms, node->ae.ssid=0A=
+					                ,node->ae.tsid, node->ae.tclass);=0A=
 				}=0A=
 			}=0A=
 		}=0A=
 	} else {=0A=
 		/* apply to one node */=0A=
-		node =3D avc_search_node(ssid, tsid, tclass, NULL);=0A=
-		if (node) {=0A=
-			avc_update_node(event,node,perms);=0A=
-		}=0A=
+		avc_update_node(event, perms, ssid, tsid, tclass);=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -751,9 +811,8 @@=0A=
 {=0A=
 	struct avc_callback_node *c;=0A=
 	u32 tretained =3D 0, cretained =3D 0;=0A=
 	int rc =3D 0;=0A=
-	unsigned long flags;=0A=
 =0A=
 	/*=0A=
 	 * try_revoke only removes permissions from the cache=0A=
 	 * state if they are not retained by the object manager.=0A=
@@ -786,12 +845,9 @@=0A=
 		avc_update_cache(event,ssid,tsid,tclass,perms);=0A=
 		*out_retained =3D tretained;=0A=
 	}=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
-	if (seqno > avc_cache.latest_notif)=0A=
-		avc_cache.latest_notif =3D seqno;=0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	avc_latest_notif_update(seqno, 0);=0A=
 =0A=
 out:=0A=
 	return rc;=0A=
 }=0A=
@@ -856,34 +912,21 @@=0A=
 int avc_ss_reset(u32 seqno)=0A=
 {=0A=
 	struct avc_callback_node *c;=0A=
 	int i, rc =3D 0;=0A=
-	struct avc_node *node, *tmp;=0A=
-	unsigned long flags;=0A=
+	unsigned long flag;=0A=
+	struct avc_node *node;=0A=
 =0A=
 	avc_hash_eval("reset");=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
-=0A=
 	for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {=0A=
-		node =3D avc_cache.slots[i];=0A=
-		while (node) {=0A=
-			tmp =3D node;=0A=
-			node =3D node->next;=0A=
-			tmp->ae.ssid =3D tmp->ae.tsid =3D SECSID_NULL;=0A=
-			tmp->ae.tclass =3D SECCLASS_NULL;=0A=
-			tmp->ae.avd.allowed =3D tmp->ae.avd.decided =3D 0;=0A=
-			tmp->ae.avd.auditallow =3D tmp->ae.avd.auditdeny =3D 0;=0A=
-			tmp->ae.used =3D 0;=0A=
-			tmp->next =3D avc_node_freelist;=0A=
-			avc_node_freelist =3D tmp;=0A=
-			avc_cache.active_nodes--;=0A=
+		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);=0A=
+		list_for_each_entry(node, &avc_cache.slots[i], list){=0A=
+			list_del_rcu(&node->list);=0A=
+			call_rcu(&node->rhead, avc_node_free);=0A=
 		}=0A=
-		avc_cache.slots[i] =3D NULL;=0A=
+		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);=0A=
 	}=0A=
-	avc_cache.lru_hint =3D 0;=0A=
-=0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
 =0A=
 	for (i =3D 0; i < AVC_NSTATS; i++)=0A=
 		avc_cache_stats[i] =3D 0;=0A=
 =0A=
@@ -895,12 +938,9 @@=0A=
 				goto out;=0A=
 		}=0A=
 	}=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
-	if (seqno > avc_cache.latest_notif)=0A=
-		avc_cache.latest_notif =3D seqno;=0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	avc_latest_notif_update(seqno, 0);=0A=
 out:=0A=
 	return rc;=0A=
 }=0A=
 =0A=
@@ -949,9 +989,9 @@=0A=
  * @ssid: source security identifier=0A=
  * @tsid: target security identifier=0A=
  * @tclass: target security class=0A=
  * @requested: requested permissions, interpreted based on @tclass=0A=
- * @aeref:  AVC entry reference=0A=
+ * @aeref:  AVC entry reference(not in use)=0A=
  * @avd: access vector decisions=0A=
  *=0A=
  * Check the AVC to determine whether the @requested permissions are =
granted=0A=
  * for the SID pair (@ssid, @tsid), interpreting the permissions=0A=
@@ -968,72 +1008,44 @@=0A=
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,=0A=
                          u16 tclass, u32 requested,=0A=
                          struct avc_entry_ref *aeref, struct =
av_decision *avd)=0A=
 {=0A=
-	struct avc_entry *ae;=0A=
+	struct avc_node *node;=0A=
+	struct avc_entry entry, *p_ae;=0A=
 	int rc =3D 0;=0A=
-	unsigned long flags;=0A=
-	struct avc_entry entry;=0A=
 	u32 denied;=0A=
-	struct avc_entry_ref ref;=0A=
 =0A=
-	if (!aeref) {=0A=
-		avc_entry_ref_init(&ref);=0A=
-		aeref =3D &ref;=0A=
-	}=0A=
-=0A=
-	spin_lock_irqsave(&avc_lock, flags);=0A=
+	rcu_read_lock();=0A=
 	avc_cache_stats_incr(AVC_ENTRY_LOOKUPS);=0A=
-	ae =3D aeref->ae;=0A=
-	if (ae) {=0A=
-		if (ae->ssid =3D=3D ssid &&=0A=
-		    ae->tsid =3D=3D tsid &&=0A=
-		    ae->tclass =3D=3D tclass &&=0A=
-		    ((ae->avd.decided & requested) =3D=3D requested)) {=0A=
-			avc_cache_stats_incr(AVC_ENTRY_HITS);=0A=
-			ae->used =3D 1;=0A=
-		} else {=0A=
-			avc_cache_stats_incr(AVC_ENTRY_DISCARDS);=0A=
-			ae =3D NULL;=0A=
-		}=0A=
-	}=0A=
 =0A=
-	if (!ae) {=0A=
-		avc_cache_stats_incr(AVC_ENTRY_MISSES);=0A=
-		rc =3D avc_lookup(ssid, tsid, tclass, requested, aeref);=0A=
-		if (rc) {=0A=
-			spin_unlock_irqrestore(&avc_lock,flags);=0A=
-			rc =3D security_compute_av(ssid,tsid,tclass,requested,&entry.avd);=0A=
-			if (rc)=0A=
-				goto out;=0A=
-			spin_lock_irqsave(&avc_lock, flags);=0A=
-			rc =3D avc_insert(ssid,tsid,tclass,&entry,aeref);=0A=
-			if (rc) {=0A=
-				spin_unlock_irqrestore(&avc_lock,flags);=0A=
-				goto out;=0A=
-			}=0A=
-		}=0A=
-		ae =3D aeref->ae;=0A=
+	node =3D avc_lookup(ssid, tsid, tclass, requested);=0A=
+	if (!node) {=0A=
+		rcu_read_unlock();=0A=
+		rc =3D security_compute_av(ssid,tsid,tclass,requested,&entry.avd);=0A=
+		if (rc)=0A=
+			goto out;=0A=
+		rcu_read_lock();=0A=
+		node =3D avc_insert(ssid,tsid,tclass,&entry);=0A=
 	}=0A=
 =0A=
+	p_ae =3D node ? &node->ae : &entry;=0A=
+=0A=
 	if (avd)=0A=
-		memcpy(avd, &ae->avd, sizeof(*avd));=0A=
+		memcpy(avd, &p_ae->avd, sizeof(*avd));=0A=
 =0A=
-	denied =3D requested & ~(ae->avd.allowed);=0A=
+	denied =3D requested & ~(p_ae->avd.allowed);=0A=
 =0A=
 	if (!requested || denied) {=0A=
 		if (selinux_enforcing) {=0A=
-			spin_unlock_irqrestore(&avc_lock,flags);=0A=
 			rc =3D -EACCES;=0A=
-			goto out;=0A=
 		} else {=0A=
-			ae->avd.allowed |=3D requested;=0A=
-			spin_unlock_irqrestore(&avc_lock,flags);=0A=
-			goto out;=0A=
+			if (node)=0A=
+				avc_update_node(AVC_CALLBACK_GRANT,requested=0A=
+				                ,ssid,tsid,tclass);=0A=
 		}=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 out:=0A=
 	return rc;=0A=
 }=0A=
 =0A=
@@ -1042,9 +1054,9 @@=0A=
  * @ssid: source security identifier=0A=
  * @tsid: target security identifier=0A=
  * @tclass: target security class=0A=
  * @requested: requested permissions, interpreted based on @tclass=0A=
- * @aeref:  AVC entry reference=0A=
+ * @aeref:  AVC entry reference(not in use)=0A=
  * @auditdata: auxiliary audit data=0A=
  *=0A=
  * Check the AVC to determine whether the @requested permissions are =
granted=0A=
  * for the SID pair (@ssid, @tsid), interpreting the permissions=0A=
@@ -1061,8 +1073,8 @@=0A=
 {=0A=
 	struct av_decision avd;=0A=
 	int rc;=0A=
 =0A=
-	rc =3D avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, =
&avd);=0A=
+	rc =3D avc_has_perm_noaudit(ssid, tsid, tclass, requested, NULL, &avd);=0A=
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);=0A=
 	return rc;=0A=
 }=0A=
diff -rNU4 linux-2.6.8.1/security/selinux/include/avc.h =
linux-2.6.8.1.rcu/security/selinux/include/avc.h=0A=
--- linux-2.6.8.1/security/selinux/include/avc.h	2004-08-14 =
19:54:51.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/security/selinux/include/avc.h	2004-08-20 =
20:40:50.000000000 +0900=0A=
@@ -118,13 +118,11 @@=0A=
  */=0A=
 =0A=
 void __init avc_init(void);=0A=
 =0A=
-int avc_lookup(u32 ssid, u32 tsid, u16 tclass,=0A=
-               u32 requested, struct avc_entry_ref *aeref);=0A=
+struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 =
requested);=0A=
 =0A=
-int avc_insert(u32 ssid, u32 tsid, u16 tclass,=0A=
-               struct avc_entry *ae, struct avc_entry_ref *out_aeref);=0A=
+struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct =
avc_entry *ae);=0A=
 =0A=
 void avc_audit(u32 ssid, u32 tsid,=0A=
                u16 tclass, u32 requested,=0A=
                struct av_decision *avd, int result, struct =
avc_audit_data *auditdata);=0A=

------=_NextPart_000_066C_01C48ECE.64C18DB0
Content-Type: application/octet-stream;
	name="atomic_inc_return-2.6.8.1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atomic_inc_return-2.6.8.1.patch"

--- linux-2.6.8.1/include/asm-arm/atomic.h	2004-08-14 19:54:50.000000000 =
+0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-arm/atomic.h	2004-08-24 =
19:31:56.000000000 +0900=0A=
@@ -194,8 +194,10 @@=0A=
 #define atomic_dec(v)		atomic_sub(1, v)=0A=
 =0A=
 #define atomic_inc_and_test(v)	(atomic_add_return(1, v) =3D=3D 0)=0A=
 #define atomic_dec_and_test(v)	(atomic_sub_return(1, v) =3D=3D 0)=0A=
+#define atomic_inc_return(v)    (atomic_add_return(1, v))=0A=
+#define atomic_dec_return(v)    (atomic_sub_return(1, v))=0A=
 =0A=
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)=0A=
 =0A=
 /* Atomic operations are already serializing on ARM */=0A=
--- linux-2.6.8.1/include/asm-i386/atomic.h	2004-08-14 =
19:55:09.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-i386/atomic.h	2004-08-25 =
11:57:08.000000000 +0900=0A=
@@ -175,8 +175,34 @@=0A=
 		:"ir" (i), "m" (v->counter) : "memory");=0A=
 	return c;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * atomic_add_return - add and return=0A=
+ * @v: pointer of type atomic_t=0A=
+ * @i: integer value to add=0A=
+ *=0A=
+ * Atomically adds @i to @v and returns @i + @v=0A=
+ */=0A=
+static __inline__ int atomic_add_return(int i, atomic_t *v)=0A=
+{=0A=
+	/* NOTICE: This function can be used on i486+ */=0A=
+	int __i =3D i;=0A=
+	__asm__ __volatile__(=0A=
+		LOCK "xaddl %0, %1;"=0A=
+		:"=3Dr"(i)=0A=
+		:"m"(v->counter), "0"(i));=0A=
+	return i + __i;=0A=
+}=0A=
+=0A=
+static __inline__ int atomic_sub_return(int i, atomic_t *v)=0A=
+{=0A=
+	return atomic_add_return(-i,v);=0A=
+}=0A=
+=0A=
+#define atomic_inc_return(v)  (atomic_add_return(1,v))=0A=
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))=0A=
+=0A=
 /* These are x86-specific, used by some header files */=0A=
 #define atomic_clear_mask(mask, addr) \=0A=
 __asm__ __volatile__(LOCK "andl %0,%1" \=0A=
 : : "r" (~(mask)),"m" (*addr) : "memory")=0A=
--- linux-2.6.8.1/include/asm-x86_64/atomic.h	2004-08-14 =
19:56:23.000000000 +0900=0A=
+++ linux-2.6.8.1.rcu/include/asm-x86_64/atomic.h	2004-08-25 =
11:57:36.000000000 +0900=0A=
@@ -177,8 +177,33 @@=0A=
 		:"ir" (i), "m" (v->counter) : "memory");=0A=
 	return c;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * atomic_add_return - add and return=0A=
+ * @v: pointer of type atomic_t=0A=
+ * @i: integer value to add=0A=
+ *=0A=
+ * Atomically adds @i to @v and returns @i + @v=0A=
+ */=0A=
+static __inline__ int atomic_add_return(int i, atomic_t *v)=0A=
+{=0A=
+	int __i =3D i;=0A=
+	__asm__ __volatile__(=0A=
+		LOCK "xaddl %0, %1;"=0A=
+		:"=3Dr"(i)=0A=
+		:"m"(v->counter), "0"(i));=0A=
+	return i + __i;=0A=
+}=0A=
+=0A=
+static __inline__ int atomic_sub_return(int i, atomic_t *v)=0A=
+{=0A=
+	return atomic_add_return(-i,v);=0A=
+}=0A=
+=0A=
+#define atomic_inc_return(v)  (atomic_add_return(1,v))=0A=
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))=0A=
+=0A=
 /* These are x86-specific, used by some header files */=0A=
 #define atomic_clear_mask(mask, addr) \=0A=
 __asm__ __volatile__(LOCK "andl %0,%1" \=0A=
 : : "r" (~(mask)),"m" (*addr) : "memory")=0A=

------=_NextPart_000_066C_01C48ECE.64C18DB0
Content-Type: application/octet-stream;
	name="list_replace_rcu-2.6.8.1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="list_replace_rcu-2.6.8.1.patch"

--- linux-2.6.8.1/include/linux/list.h	2004-08-14 19:55:33.000000000 =
+0900=0A=
+++ linux-2.6.8.1.rcu/include/linux/list.h	2004-08-20 18:04:10.000000000 =
+0900=0A=
@@ -194,8 +194,23 @@=0A=
 	__list_del(entry->prev, entry->next);=0A=
 	entry->prev =3D LIST_POISON2;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * list_replace_rcu - replace old entry by new onw from list=0A=
+ * @old : the element to be replaced from the list.=0A=
+ * @new : the new element to insert to the list.=0A=
+ * =0A=
+ * The old entry will be replaced to the new entry atomically.=0A=
+ */=0A=
+static inline void list_replace_rcu(struct list_head *old, struct =
list_head *new){=0A=
+	new->next =3D old->next;=0A=
+	new->prev =3D old->prev;=0A=
+	smp_wmb();=0A=
+	new->next->prev =3D new;=0A=
+	new->prev->next =3D new;=0A=
+}=0A=
+=0A=
 /**=0A=
  * list_del_init - deletes entry from list and reinitialize it.=0A=
  * @entry: the element to delete from the list.=0A=
  */=0A=

------=_NextPart_000_066C_01C48ECE.64C18DB0--

