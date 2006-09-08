Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWIHQbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWIHQbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIHQbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:31:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49828 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751024AbWIHQbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:31:36 -0400
Date: Fri, 8 Sep 2006 21:27:57 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: [RFC] Add tgid aggregation to beancounters (was Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user memory))
Message-ID: <20060908155757.GA21703@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com> <44FEC7E4.7030708@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FEC7E4.7030708@sw.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 05:06:44PM +0400, Kirill Korotaev wrote:
> Balbir Singh wrote:
> > Kirill Korotaev wrote:
> > 
> >> Core Resource Beancounters (BC) + kernel/user memory control.
> >>
> >> BC allows to account and control consumption
> >> of kernel resources used by group of processes.
> >>
> >> Draft UBC description on OpenVZ wiki can be found at
> >> http://wiki.openvz.org/UBC_parameters
> >>
> >> The full BC patch set allows to control:
> >> - kernel memory. All the kernel objects allocatable
> >> on user demand should be accounted and limited
> >> for DoS protection.
> >> E.g. page tables, task structs, vmas etc.
> > 
> > 
> > One of the key requirements of resource management for us is to be able to
> > migrate tasks across resource groups. Since bean counters do not associate
> > a list of tasks associated with them, I do not see how this can be done
> > with the existing bean counters.
> It was discussed multiple times already.
> The key problem here is the objects which do not _belong_ to tasks.
> e.g. IPC objects. They exist in global namespace and can't be reaccounted.
> At least no one proposed the policy to reaccount.
> And please note, IPCs are not the only such objects.
> 
> But I guess your comment mostly concerns user pages, yeah?
> In this case reaccounting can be easily done using page beancounters
> which are introduced in this patch set.
> So if it is a requirement, then lets cooperate and create such functionality.
> 
> So for now I see 2 main requirements from people:
> - memory reclamation
> - tasks moving across beancounters
> 
> I agree with these requirements and lets move into this direction.
> But moving so far can't be done without accepting:
> 1. core functionality
> 2. accounting
> 
> Thanks,
> Kirill

Hi, Kirill,

I've got a patch to extend bean-counters to do simple aggregation.

The idea is to use this to finally do task migration. Initial comments on the
design and idea would be useful. The original idea was suggested by Dave
Hansen during a private discussion.

TODOS:

1. Add task data extraction support
2. Add task migration support

I've gotten the patch to compile and boot on a x86-64 box.


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/bc/beancounter.h |   53 ++++++++++++++++++
 kernel/bc/beancounter.c  |  134 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/bc/misc.c         |    9 +++
 3 files changed, 194 insertions(+), 2 deletions(-)

diff -puN include/bc/beancounter.h~per-tgid-resource-tracking include/bc/beancounter.h
--- linux-2.6.18-rc5/include/bc/beancounter.h~per-tgid-resource-tracking	2006-09-08 12:03:31.000000000 +0530
+++ linux-2.6.18-rc5-balbir/include/bc/beancounter.h	2006-09-08 17:01:53.000000000 +0530
@@ -42,7 +42,10 @@ struct bc_resource_parm {
 #include <linux/list.h>
 #include <asm/atomic.h>
 
-#define BC_MAXVALUE	LONG_MAX
+#define BC_MAXVALUE		LONG_MAX
+
+#define BC_TGID_HASH_BITS	6
+#define BC_TGID_HASH_SIZE	(1 << BC_TGID_HASH_BITS)
 
 /*
  * This magic is used to distinuish user beancounter and pages beancounter
@@ -73,6 +76,17 @@ struct beancounter {
 #endif
 	/* resources statistics and settings */
 	struct bc_resource_parm	bc_parms[BC_RESOURCES];
+	struct hlist_head	tgid_hash[BC_TGID_HASH_SIZE];
+};
+
+/*
+ * Per tgid resource statistics
+ */
+struct tgid_beancounter {
+	struct bc_resource_parm	tbc_parms[BC_RESOURCES];
+	struct hlist_node	hash;
+	pid_t			tgid;
+	struct beancounter	*bc;
 };
 
 enum bc_severity { BC_BARRIER, BC_LIMIT, BC_FORCE };
@@ -101,6 +115,16 @@ static inline void bc_adjust_maxheld(str
 		parm->maxheld = parm->held;
 }
 
+static inline void tbc_adjust_maxheld(struct tgid_beancounter *tbc,
+					int resource)
+{
+	struct bc_resource_parm *parm;
+
+	parm = &tbc->tbc_parms[resource];
+	if (parm->maxheld < parm->held)
+		parm->maxheld = parm->held;
+}
+
 static inline void bc_adjust_minheld(struct beancounter *bc, int resource)
 {
 	struct bc_resource_parm *parm;
@@ -110,6 +134,16 @@ static inline void bc_adjust_minheld(str
 		parm->minheld = parm->held;
 }
 
+static inline void tbc_adjust_minheld(struct tgid_beancounter *tbc,
+					int resource)
+{
+	struct bc_resource_parm *parm;
+
+	parm = &tbc->tbc_parms[resource];
+	if (parm->minheld > parm->held)
+		parm->minheld = parm->held;
+}
+
 int __must_check bc_charge_locked(struct beancounter *bc,
 		int res, unsigned long val, enum bc_severity strict);
 int __must_check bc_charge(struct beancounter *bc,
@@ -119,6 +153,11 @@ void bc_uncharge_locked(struct beancount
 void bc_uncharge(struct beancounter *bc, int res, unsigned long val);
 
 struct beancounter *beancounter_findcreate(bcid_t id, int mask);
+struct tgid_beancounter *tgid_beancounter_findcreate(
+						struct beancounter *bc,
+						int mask,
+						int locked);
+void tgid_beancounter_release(struct tgid_beancounter *tbc, int locked);
 
 static inline struct beancounter *get_beancounter(struct beancounter *bc)
 {
@@ -135,6 +174,18 @@ void bc_init_proc(void);
 extern struct beancounter init_bc;
 extern const char *bc_rnames[];
 
+#define tgid_beancounter_findcreate_locked(bc, mask) \
+	tgid_beancounter_findcreate(bc, mask, 1)
+
+#define tgid_beancounter_findcreate_unlocked(bc, mask) \
+	tgid_beancounter_findcreate(bc, mask, 0)
+
+#define tgid_beancounter_release_locked(bc) \
+	tgid_beancounter_release(bc, 1)
+
+#define tgid_beancounter_release_unlocked(bc) \
+	tgid_beancounter_release(bc, 0)
+
 #else /* CONFIG_BEANCOUNTERS */
 
 #define nr_beancounters 0
diff -puN kernel/bc/beancounter.c~per-tgid-resource-tracking kernel/bc/beancounter.c
--- linux-2.6.18-rc5/kernel/bc/beancounter.c~per-tgid-resource-tracking	2006-09-08 12:03:31.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/beancounter.c	2006-09-08 17:13:19.000000000 +0530
@@ -14,9 +14,12 @@
 #include <bc/vmrss.h>
 
 static kmem_cache_t *bc_cachep;
+static kmem_cache_t *bc_tgid_cachep;
 static struct beancounter default_beancounter;
 
 static void init_beancounter_struct(struct beancounter *bc, bcid_t id);
+static void init_tgid_beancounter_struct(struct tgid_beancounter *tbc,
+						struct beancounter *bc);
 
 struct beancounter init_bc;
 
@@ -34,6 +37,7 @@ const char *bc_rnames[] = {
 static struct hlist_head bc_hash[BC_HASH_SIZE];
 static spinlock_t bc_hash_lock;
 #define bc_hash_fn(bcid)	(hash_long(bcid, BC_HASH_BITS))
+#define bc_tgid_hash_fn(bcid)	(hash_long(bcid, BC_TGID_HASH_BITS))
 
 /*
  *	Per resource beancounting. Resources are tied to their bc id.
@@ -97,6 +101,95 @@ out:
 	return new_bc;
 }
 
+/*
+ * Introduce a hierarchy for beancounters.
+ * 		bc
+ *	tbc tbc ...  tbc tbc
+ * Each tgid_beancounter tracks the resource usage for the tgid.
+ * It makes it easier to move tasks across beancounters, since we know
+ * the usage of every tgid. It's quite easy to extend this detail to a
+ * per-task level, by creating task_beancounters under each tgid_beancounter.
+ */
+struct tgid_beancounter *tgid_beancounter_findcreate(struct beancounter *bc,
+							int mask, int locked)
+{
+	struct tgid_beancounter *new_tbc, *tbc;
+	unsigned long flags;
+	struct hlist_head *slot = NULL;
+	struct hlist_node *pos;
+
+	get_beancounter(bc);
+	slot = &bc->tgid_hash[bc_tgid_hash_fn(current->tgid)];
+	new_tbc = NULL;
+
+retry:
+	if (!locked)
+		spin_lock_irqsave(&bc->bc_lock, flags);
+	hlist_for_each_entry (tbc, pos, slot, hash)
+		if (tbc->tgid == current->tgid)
+			break;
+
+	if (pos != NULL) {
+		if (!(mask & BC_ALLOC))
+			put_beancounter(bc);
+		if (!locked)
+			spin_unlock_irqrestore(&bc->bc_lock, flags);
+
+		if (new_tbc != NULL)
+			kmem_cache_free(bc_tgid_cachep, new_tbc);
+		printk("returning tbc %p: tgid %d\n", tbc, current->tgid);
+		return tbc;
+	}
+
+	if (new_tbc != NULL)
+		goto out_install;
+
+	if (!locked)
+		spin_unlock_irqrestore(&bc->bc_lock, flags);
+
+	if (!(mask & BC_ALLOC))
+		goto out;
+
+	new_tbc = kmem_cache_alloc(bc_tgid_cachep,
+			mask & BC_ALLOC_ATOMIC ? GFP_ATOMIC : GFP_KERNEL);
+	if (new_tbc == NULL)
+		goto out;
+
+	init_tgid_beancounter_struct(new_tbc, bc);
+	goto retry;
+
+out_install:
+	hlist_add_head(&new_tbc->hash, slot);
+	if (!locked)
+		spin_unlock_irqrestore(&bc->bc_lock, flags);
+out:
+	if (!(mask & BC_ALLOC))
+		put_beancounter(bc);
+	printk("returning tbc %p: tgid %d\n", tbc, current->tgid);
+	return new_tbc;
+}
+
+void tgid_beancounter_release(struct tgid_beancounter *tbc, int locked)
+{
+	int i;
+	unsigned long flags;
+	struct beancounter *bc = tbc->bc;
+
+	if (!locked)
+		spin_lock_irqsave(&bc->bc_lock, flags);
+	for (i = 0; i < BC_RESOURCES; i++)
+		if (tbc->tbc_parms[i].held != 0)
+			printk("BC: %d has %lu of %s held on put", tbc->tgid,
+				tbc->tbc_parms[i].held, bc_rnames[i]);
+
+	hlist_del(&tbc->hash);
+	if (!locked)
+		spin_unlock_irqrestore(&bc->bc_lock, flags);
+	put_beancounter(bc);
+	kmem_cache_free(bc_tgid_cachep, tbc);
+	printk("releasing tbc %p: tgid %d\n", tbc, current->tgid);
+}
+
 void put_beancounter(struct beancounter *bc)
 {
 	int i;
@@ -139,12 +232,22 @@ int bc_charge_locked(struct beancounter 
 		enum bc_severity strict)
 {
 	unsigned long new_held;
+	unsigned long tgid_new_held;
+	struct tgid_beancounter *tbc;
+
+	tbc = tgid_beancounter_findcreate_locked(bc, BC_LOOKUP);
+	if (!tbc) {
+		printk(KERN_WARNING "Missing tgid beancounter for bc %d\n",
+			bc->bc_id);
+		return 0;
+	}
 
 	/*
 	 * bc_value <= BC_MAXVALUE, value <= BC_MAXVALUE, and only one addition
 	 * at the moment is possible so an overflow is impossible.  
 	 */
 	new_held = bc->bc_parms[resource].held + val;
+	tgid_new_held = tbc->tbc_parms[resource].held + val;
 
 	switch (strict) {
 	case BC_BARRIER:
@@ -160,6 +263,7 @@ int bc_charge_locked(struct beancounter 
 	case BC_FORCE:
 		bc->bc_parms[resource].held = new_held;
 		bc_adjust_maxheld(bc, resource);
+		tbc_adjust_maxheld(tbc, resource);
 		return 0;
 
 	default:
@@ -167,6 +271,7 @@ int bc_charge_locked(struct beancounter 
 	}
 
 	bc->bc_parms[resource].failcnt++;
+	tbc->tbc_parms[resource].failcnt++;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(bc_charge_locked);
@@ -189,6 +294,15 @@ EXPORT_SYMBOL_GPL(bc_charge);
 /* called with bc->bc_lock held and interrupts disabled */
 void bc_uncharge_locked(struct beancounter *bc, int resource, unsigned long val)
 {
+	struct tgid_beancounter *tbc;
+
+	tbc = tgid_beancounter_findcreate_locked(bc, BC_LOOKUP);
+	if (!tbc) {
+		printk(KERN_WARNING "Missing tgid beancounter for bc %d\n",
+			bc->bc_id);
+		return;
+	}
+
 	if (unlikely(bc->bc_parms[resource].held < val)) {
 		printk("BC: overuncharging bc %d %s: val %lu, holds %lu\n",
 				bc->bc_id, bc_rnames[resource], val,
@@ -197,8 +311,10 @@ void bc_uncharge_locked(struct beancount
 	}
 
 	bc->bc_parms[resource].held -= val;
-	bc_adjust_minheld(bc, resource);
+	tbc->tbc_parms[resource].held -= val;
+	tbc_adjust_minheld(tbc, resource);
 }
+
 EXPORT_SYMBOL_GPL(bc_uncharge_locked);
 
 void bc_uncharge(struct beancounter *bc, int resource, unsigned long val)
@@ -233,6 +349,18 @@ static void init_beancounter_struct(stru
 	bc->bc_id = id;
 }
 
+static void init_tgid_beancounter_struct(struct tgid_beancounter *tbc,
+						struct beancounter *bc)
+{
+	int k;
+
+	INIT_HLIST_NODE(&tbc->hash);
+	tbc->bc = bc;
+	for (k = 0; k < BC_RESOURCES; k++) {
+		tbc->tbc_parms[k].limit = BC_MAXVALUE;
+		tbc->tbc_parms[k].barrier = BC_MAXVALUE;
+	}
+}
 static void init_beancounter_nolimits(struct beancounter *bc)
 {
 	int k;
@@ -281,6 +409,10 @@ void __init bc_init_late(void)
 			sizeof(struct beancounter), 0,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
 
+	bc_tgid_cachep = kmem_cache_create("tgid_beancounters",
+			sizeof(struct tgid_beancounter), 0,
+			SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL, NULL);
+
 	bc = &default_beancounter;
 	init_beancounter_syslimits(bc);
 	init_beancounter_struct(bc, 0);
diff -puN kernel/bc/misc.c~per-tgid-resource-tracking kernel/bc/misc.c
--- linux-2.6.18-rc5/kernel/bc/misc.c~per-tgid-resource-tracking	2006-09-08 14:18:55.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/misc.c	2006-09-08 17:02:18.000000000 +0530
@@ -22,10 +22,19 @@ void bc_task_charge(struct task_struct *
 	bc = old_bc->fork_bc;
 	new_bc->exec_bc = get_beancounter(bc);
 	new_bc->fork_bc = get_beancounter(bc);
+	tgid_beancounter_findcreate_unlocked(bc, BC_ALLOC);
 }
 
 void bc_task_uncharge(struct task_struct *tsk)
 {
+	struct tgid_beancounter *tbc;
+	tbc = tgid_beancounter_findcreate_unlocked(tsk->task_bc.exec_bc,
+							BC_LOOKUP);
 	put_beancounter(tsk->task_bc.exec_bc);
 	put_beancounter(tsk->task_bc.fork_bc);
+	if (tbc)
+		tgid_beancounter_release(tbc);
+	else
+		printk(KERN_WARNING "No tgid beancounter bc %d with task %d\n",
+			tsk->task_bc.exec_bc->bc_id, tsk->tgid);
 }
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
