Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUHXH2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUHXH2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHXH2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:28:02 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:53721 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266569AbUHXH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:26:00 -0400
Message-ID: <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Tue, 24 Aug 2004 16:25:32 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0428_01C489F6.FA5DFC00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0428_01C489F6.FA5DFC00
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

Hi Stephen, Thanks for your comments.

> I'm not overly familiar with RCU myself, but the comments in list.h for
> list_add_rcu suggest that you still need to hold a lock to avoid racing
> with another list_add_rcu or list_del_rcu call on the same list.  But
> avc_insert is calling list_add_rcu without holding any lock; can't it
> race with another avc_insert on the same hash bucket?  Do I just
> misunderstand, or is this unsafe?  Thanks for clarifying.

You are right. Indeed, the lock for hash bucket is also necessary
when avc_insert() is called. I fixed them.

> I think we can likely eliminate the mutation of the node in the
> !selinux_enforcing case in avc_has_perm_noaudit, i.e. eliminate the
> entire else clause and just fall through with rc still 0.  Adding the
> requested permissions to the node was simply to avoid flooding denials
> in permissive mode on the same permission check, but this can be
> addressed separately using the audit ratelimit mechanism.

I have another opinion.
This simple mechanism against the flood of audit log is necessary,
because it prevents the depletion of the system log buffer and denied log
all over the console when we are debugging the security policy in permissive mode.
So, I improved the avc_update_node() function and avc_node data structure.
It does not need kmalloc() when avc_update_node(). 

This approach is good for durability and compatibility of original implementation,
but double area of avc_nodes is needed for updating without kmalloc().
This approach can apply to any kinds of updating of avc_entry.
This idea is pretty complexer, though.

I modified the following points:
- We hold the lock for hash backet when avc_insert() and avc_ss_reset() are
  called for safety.
- list_for_each_rcu() and list_entry() are replaced by list_for_entry().
- avc_node_dual structure which contains two avc_node objects is defined. 
  It allows to do avc_update_node() without kmalloc() or any locks.

Any comments please. Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>

------=_NextPart_000_0428_01C489F6.FA5DFC00
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

------=_NextPart_000_0428_01C489F6.FA5DFC00
Content-Type: application/octet-stream;
	name="selinux.rcu-2.6.8.1-take2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="selinux.rcu-2.6.8.1-take2.patch"

diff -rNU4 linux-2.6.8.1/security/selinux/avc.c =
linux-2.6.8.1.rcu/security/selinux/avc.c=0A=
--- linux-2.6.8.1/security/selinux/avc.c	2004-08-14 19:55:48.000000000 =
+0900=0A=
+++ linux-2.6.8.1.rcu/security/selinux/avc.c	2004-08-24 =
13:30:56.000000000 +0900=0A=
@@ -35,28 +35,40 @@=0A=
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
+struct avc_node_dual;=0A=
 struct avc_node {=0A=
+	struct list_head	list;=0A=
 	struct avc_entry	ae;=0A=
-	struct avc_node		*next;=0A=
+	struct avc_node		*reserved;=0A=
+	struct avc_node_dual	*container;=0A=
+};=0A=
+=0A=
+/* dual avc_node is necessary for update */=0A=
+struct avc_node_dual {=0A=
+	struct rcu_head         rhead;=0A=
+	struct avc_node         node[2];=0A=
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
@@ -69,10 +81,8 @@=0A=
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
@@ -187,52 +197,44 @@=0A=
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
 static void avc_hash_eval(char *tag)=0A=
 {=0A=
 	int i, chain_len, max_chain_len, slots_used;=0A=
 	struct avc_node *node;=0A=
+	struct list_head *pos;=0A=
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
+			list_for_each_rcu(pos, &avc_cache.slots[i])=0A=
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
@@ -242,188 +244,208 @@=0A=
 static inline void avc_hash_eval(char *tag)=0A=
 { }=0A=
 #endif=0A=
 =0A=
-static inline struct avc_node *avc_reclaim_node(void)=0A=
-{=0A=
-	struct avc_node *prev, *cur;=0A=
-	int hvalue, try;=0A=
+static void avc_node_free(struct rcu_head *rhead) {=0A=
+	struct avc_node_dual *dual_node;=0A=
+	dual_node =3D container_of(rhead, struct avc_node_dual, rhead);=0A=
+	kfree(dual_node);=0A=
+}=0A=
 =0A=
-	hvalue =3D avc_cache.lru_hint;=0A=
-	for (try =3D 0; try < 2; try++) {=0A=
-		do {=0A=
-			prev =3D NULL;=0A=
-			cur =3D avc_cache.slots[hvalue];=0A=
-			while (cur) {=0A=
-				if (!cur->ae.used)=0A=
-					goto found;=0A=
+static inline void avc_reclaim_node(void)=0A=
+{=0A=
+	struct avc_node *node;=0A=
+	int hvalue, try, ecx;=0A=
 =0A=
-				cur->ae.used =3D 0;=0A=
+	for (try =3D 0, ecx =3D 0; try < AVC_CACHE_SLOTS; try++ ) {=0A=
+		hvalue =3D atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;=0A=
 =0A=
-				prev =3D cur;=0A=
-				cur =3D cur->next;=0A=
+		if (spin_trylock(&avc_cache.slots_lock[hvalue])) {=0A=
+			list_for_each_entry(node, &avc_cache.slots[hvalue], list) {=0A=
+				if (!atomic_dec_and_test(&node->ae.used)) {=0A=
+					/* Recently Unused */=0A=
+					list_del_rcu(&node->list);=0A=
+					call_rcu(&node->container->rhead, avc_node_free);=0A=
+					atomic_dec(&avc_cache.active_nodes);=0A=
+					ecx++;=0A=
+					if (ecx >=3D AVC_CACHE_RECLAIM) {=0A=
+						spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
+						goto out;=0A=
+					}=0A=
+				}=0A=
 			}=0A=
-			hvalue =3D (hvalue + 1) & (AVC_CACHE_SLOTS - 1);=0A=
-		} while (hvalue !=3D avc_cache.lru_hint);=0A=
+			spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
+		}=0A=
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
+	return;=0A=
 }=0A=
 =0A=
-static inline struct avc_node *avc_claim_node(u32 ssid,=0A=
-                                              u32 tsid, u16 tclass)=0A=
+static inline struct avc_node *avc_get_node(void)=0A=
 {=0A=
-	struct avc_node *new;=0A=
-	int hvalue;=0A=
+	struct avc_node_dual *new;=0A=
+	int actives;=0A=
 =0A=
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
+	new =3D kmalloc(sizeof(struct avc_node_dual), GFP_ATOMIC);=0A=
+	if (!new)=0A=
+		return NULL;=0A=
 =0A=
-	new->ae.used =3D 1;=0A=
-	new->ae.ssid =3D ssid;=0A=
-	new->ae.tsid =3D tsid;=0A=
-	new->ae.tclass =3D tclass;=0A=
-	new->next =3D avc_cache.slots[hvalue];=0A=
-	avc_cache.slots[hvalue] =3D new;=0A=
+	INIT_RCU_HEAD(&new->rhead);=0A=
+	INIT_LIST_HEAD(&new->node[0].list);=0A=
+	INIT_LIST_HEAD(&new->node[1].list);=0A=
+	new->node[0].container =3D new;=0A=
+	new->node[1].container =3D new;=0A=
+	new->node[0].reserved =3D &new->node[1];=0A=
+	new->node[1].reserved =3D &new->node[0];=0A=
 =0A=
-out:=0A=
-	return new;=0A=
+	actives =3D atomic_inc_return(&avc_cache.active_nodes);=0A=
+	if (actives > AVC_CACHE_THRESHOLD)=0A=
+		avc_reclaim_node();=0A=
+=0A=
+	return &new->node[0];=0A=
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
+	list_for_each_entry(node, &avc_cache.slots[hvalue], list) {=0A=
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
+=0A=
+	spin_lock(&notif_lock);=0A=
+	if (seqno < avc_cache.latest_notif) {=0A=
+		if (is_insert) {=0A=
+			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",=0A=
+			       seqno, avc_cache.latest_notif);=0A=
+			ret =3D -EAGAIN;=0A=
+		} else {=0A=
+			avc_cache.latest_notif =3D seqno;=0A=
+		}=0A=
+	}=0A=
+	spin_unlock(&notif_lock);=0A=
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
 =0A=
-	node->ae.avd.allowed =3D ae->avd.allowed;=0A=
-	node->ae.avd.decided =3D ae->avd.decided;=0A=
-	node->ae.avd.auditallow =3D ae->avd.auditallow;=0A=
-	node->ae.avd.auditdeny =3D ae->avd.auditdeny;=0A=
-	node->ae.avd.seqno =3D ae->avd.seqno;=0A=
-	aeref->ae =3D &node->ae;=0A=
+	if (node) {=0A=
+		hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
+=0A=
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
+		spin_lock(&avc_cache.slots_lock[hvalue]);=0A=
+		list_for_each_entry(pos, &avc_cache.slots[hvalue], list){=0A=
+			if( pos->ae.ssid =3D=3D ssid &&=0A=
+			    pos->ae.tsid =3D=3D tsid &&=0A=
+			    pos->ae.tclass =3D=3D tclass ){=0A=
+				atomic_dec(&avc_cache.active_nodes);=0A=
+				kfree(node->container);=0A=
+				goto duplicate;=0A=
+			}=0A=
+		}=0A=
+		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);=0A=
+duplicate:=0A=
+		spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
+	}=0A=
 out:=0A=
-	return rc;=0A=
+	return node;=0A=
 }=0A=
 =0A=
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,=0A=
 				       struct in6_addr *addr, u16 port,=0A=
@@ -685,10 +707,32 @@=0A=
 {=0A=
 	return (x =3D=3D y || x =3D=3D SECSID_WILD || y =3D=3D SECSID_WILD);=0A=
 }=0A=
 =0A=
-static inline void avc_update_node(u32 event, struct avc_node *node, =
u32 perms)=0A=
+static void avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, =
u16 tclass)=0A=
 {=0A=
+	int hvalue;=0A=
+	struct avc_node *pos, *node, *org =3D NULL;=0A=
+=0A=
+	/* Lock the target slot */=0A=
+	hvalue =3D avc_hash(ssid, tsid, tclass);=0A=
+	spin_lock(&avc_cache.slots_lock[hvalue]);=0A=
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
+	if (!org)=0A=
+		goto out;=0A=
+=0A=
+	node =3D org->reserved;=0A=
+	/* Duplicate and Update */=0A=
+	memcpy(node, org, sizeof(struct avc_node));=0A=
 	switch (event) {=0A=
 	case AVC_CALLBACK_GRANT:=0A=
 		node->ae.avd.allowed |=3D perms;=0A=
 		break;=0A=
@@ -708,40 +752,42 @@=0A=
 	case AVC_CALLBACK_AUDITDENY_DISABLE:=0A=
 		node->ae.avd.auditdeny &=3D ~perms;=0A=
 		break;=0A=
 	}=0A=
+	list_replace_rcu(&org->list,&node->list);=0A=
+out:=0A=
+	spin_unlock(&avc_cache.slots_lock[hvalue]);=0A=
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
+			list_for_each_entry(node, &avc_cache.slots[i], list) {=0A=
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
 		node =3D avc_search_node(ssid, tsid, tclass, NULL);=0A=
 		if (node) {=0A=
-			avc_update_node(event,node,perms);=0A=
+			avc_update_node(event, perms, ssid, tsid, tclass);=0A=
 		}=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 =0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -751,9 +797,8 @@=0A=
 {=0A=
 	struct avc_callback_node *c;=0A=
 	u32 tretained =3D 0, cretained =3D 0;=0A=
 	int rc =3D 0;=0A=
-	unsigned long flags;=0A=
 =0A=
 	/*=0A=
 	 * try_revoke only removes permissions from the cache=0A=
 	 * state if they are not retained by the object manager.=0A=
@@ -786,12 +831,9 @@=0A=
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
@@ -856,34 +898,22 @@=0A=
 int avc_ss_reset(u32 seqno)=0A=
 {=0A=
 	struct avc_callback_node *c;=0A=
 	int i, rc =3D 0;=0A=
-	struct avc_node *node, *tmp;=0A=
-	unsigned long flags;=0A=
+	struct avc_node *node;=0A=
 =0A=
 	avc_hash_eval("reset");=0A=
 =0A=
-	spin_lock_irqsave(&avc_lock,flags);=0A=
-=0A=
+	rcu_read_lock();=0A=
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
+		spin_lock(&avc_cache.slots_lock[i]);=0A=
+		list_for_each_entry(node, &avc_cache.slots[i], list){=0A=
+			list_del_rcu(&node->list);=0A=
+			call_rcu(&node->container->rhead, avc_node_free);=0A=
 		}=0A=
-		avc_cache.slots[i] =3D NULL;=0A=
+		spin_unlock(&avc_cache.slots_lock[i]);=0A=
 	}=0A=
-	avc_cache.lru_hint =3D 0;=0A=
-=0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 =0A=
 	for (i =3D 0; i < AVC_NSTATS; i++)=0A=
 		avc_cache_stats[i] =3D 0;=0A=
 =0A=
@@ -895,12 +925,9 @@=0A=
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
@@ -949,9 +976,9 @@=0A=
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
@@ -968,72 +995,46 @@=0A=
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,=0A=
                          u16 tclass, u32 requested,=0A=
                          struct avc_entry_ref *aeref, struct =
av_decision *avd)=0A=
 {=0A=
-	struct avc_entry *ae;=0A=
-	int rc =3D 0;=0A=
-	unsigned long flags;=0A=
+	struct avc_node *node;=0A=
 	struct avc_entry entry;=0A=
+	int rc =3D 0;=0A=
 	u32 denied;=0A=
-	struct avc_entry_ref ref;=0A=
-=0A=
-	if (!aeref) {=0A=
-		avc_entry_ref_init(&ref);=0A=
-		aeref =3D &ref;=0A=
-	}=0A=
 =0A=
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
+	node =3D avc_lookup(ssid, tsid, tclass, requested);=0A=
+	if (!node) {=0A=
+		rcu_read_unlock();=0A=
+		rc =3D security_compute_av(ssid,tsid,tclass,requested,&entry.avd);=0A=
+		if (rc)=0A=
+			goto out;=0A=
+		rcu_read_lock();=0A=
+		node =3D avc_insert(ssid,tsid,tclass,&entry);=0A=
+		if (!node) {=0A=
+			rc =3D -ENOMEM;=0A=
+			rcu_read_unlock();=0A=
+			goto out;=0A=
 		}=0A=
-		ae =3D aeref->ae;=0A=
 	}=0A=
-=0A=
 	if (avd)=0A=
-		memcpy(avd, &ae->avd, sizeof(*avd));=0A=
+		memcpy(avd, &node->ae.avd, sizeof(*avd));=0A=
 =0A=
-	denied =3D requested & ~(ae->avd.allowed);=0A=
+	denied =3D requested & ~(node->ae.avd.allowed);=0A=
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
+			if (node->ae.avd.allowed !=3D (node->ae.avd.allowed|requested))=0A=
+				avc_update_node(AVC_CALLBACK_GRANT=0A=
+				                ,requested,ssid,tsid,tclass);=0A=
 		}=0A=
 	}=0A=
 =0A=
-	spin_unlock_irqrestore(&avc_lock,flags);=0A=
+	rcu_read_unlock();=0A=
 out:=0A=
 	return rc;=0A=
 }=0A=
 =0A=
@@ -1042,9 +1043,9 @@=0A=
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
@@ -1061,8 +1062,8 @@=0A=
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

------=_NextPart_000_0428_01C489F6.FA5DFC00--

