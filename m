Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUHTU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUHTU30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHTU30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:29:26 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:43320 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268710AbUHTUXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:23:01 -0400
Date: Fri, 20 Aug 2004 13:19:15 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Message-ID: <20040820201914.GA1244@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:36:03PM +0900, Kaigai Kohei wrote:
> Hello, everyone.
> 
> Tuesday, August 17, 2004 12:19 AM
> James Morris wrote:
> > > Is removing direct reference to AVC-Entry approach acceptable?
> > > 
> > > I'll try to consider this issue further.
> > 
> > Sure, if you can make it work without problems.
> 
> The attached patches against to 2.6.8.1 kernel improve the performance
> and the scalability of SELinux by RCU-approach.
> 
> The evaluation results are as follows:
> <Environment>
> CPU: Itanium2(1GHz) x 4/8/16/32
> Memory: enough (no swap)
> OS: 2.6.8.1 (SELinux disabled by 'selinux=0' boot option)
>     2.6.8.1 (SELinux enabled)
>     2.6.8.1 + rwlock patch by KaiGai
>     2.6.8.1 + RCU patch by KaiGai
> 
> The test program iterates write() to files on tmpfs 500,000 times in parallel.
> It is attached as 'rcutest.c'.
> 
> We observed performance improvement and perfect scalability.
> 
> [rcutest Loop=500000 Parallel=<Num of CPU>]
>   - upper column is the RealTime [second].
>   - lefthand of lower column is the UserTime, righthand is the SysTime.
>                  --- 4CPU ---  --- 8CPU ---  --- 16CPU ---  --- 32CPU ---
> 2.6.8.1(disable)    8.0158[s]     8.0183[s]      8.0146[s]      8.0037[s]
>                  (2.08/ 6.07)   (1.86/6.31)   (0.78/ 7.33)    (2.03/5.94)
> 2.6.8.1(enable)    78.0957[s]   319.0451[s]   1322.0313[s]      too long 
>                  (2.47/76.48) (2.47/316.96)  (2.43/1319.8)     (---/---) 
> 2.6.8.1.rwlock     20.0100[s]    49.0390[s]     90.0200[s]    177.0533[s]
>                  (2.57/17.52)  (2.45/46.93)   (2.37/87.78)   (2.41/175.1)
> 2.6.8.1.rcu        11.0464[s]    11.0205[s]     11.0372[s]     11.0496[s]
>                   (2.64/8.82)   (2.21/8.98)   (2.67/ 8.68)    (2.51/8.95)
> -------------------------------------------------------------------------

Nice performance increase and great scalability!  I echo an earlier
email asking for 1-CPU and 2-CPU results.

> These patches achieve lock-free read access to AVC cache.
> 
> Significant changes are as follows:
> - Direct references by avc_entry_ref were removed for RCU.
> - Some structures(avc_entry/avc_node/avc_cache) were changed for RCU.
> - avc_node type objects are allocated dynamically, not statically.
>   avc_reclaim_node() reclaims some avc_node objects when the number of
>   objects exceeds AVC_CACHE_THRESHOLD.
> - For updating av_decision structure, I came up with a new RCU primitive,
>   list_replace_rcu() in include/linux/list.h .
>   It is needed to switch the linked pointer atomically, and replace
>   an old object with a new one. list_replace_rcu() is used in avc_update_node()
>   to update av_decision structure, and an original object is duplicated and updated.
>   We now pay more cost for updating av_decision structure as a compensation
>   for lock-free read access. But, in my opinion, updating av_decision is so rare.
> 
> NOTE: The fifth arguments of avc_has_perm() and avc_has_perm_noaudit()
>       are not necessary. But the prototype declarations and all the callers
>       remain, since I want to avoid messing up the patches.
> 
> Any comments?
> ----------
> KaiGai <kaigai@ak.jp.nec.com>

The list_replace_rcu() primitive looks good.  At last, a primitive that
reflects the reason for RCU's name!  ;-)

A few comments interspersed for the larger patch (look for empty lines).
I am missing why some of the list insertions and deletions are SMP safe.

							Thanx, Paul

> diff -rNU4 linux-2.6.8.1/security/selinux/avc.c linux-2.6.8.1.rcu/security/selinux/avc.c
> --- linux-2.6.8.1/security/selinux/avc.c	2004-08-14 19:55:48.000000000 +0900
> +++ linux-2.6.8.1.rcu/security/selinux/avc.c	2004-08-20 20:38:06.000000000 +0900
> @@ -35,28 +35,31 @@
>  #include "av_perm_to_string.h"
>  #include "objsec.h"
>  
>  #define AVC_CACHE_SLOTS		512
> -#define AVC_CACHE_MAXNODES	410
> +#define AVC_CACHE_THRESHOLD	410
> +#define AVC_CACHE_RECLAIM	16
>  
>  struct avc_entry {
>  	u32			ssid;
>  	u32			tsid;
>  	u16			tclass;
>  	struct av_decision	avd;
> -	int			used;	/* used recently */
> +	atomic_t		used;	/* used recently */
>  };
>  
>  struct avc_node {
> +	struct list_head	list;
> +	struct rcu_head		rhead;
>  	struct avc_entry	ae;
> -	struct avc_node		*next;
>  };
>  
>  struct avc_cache {
> -	struct avc_node	*slots[AVC_CACHE_SLOTS];
> -	u32		lru_hint;	/* LRU hint for reclaim scan */
> -	u32		active_nodes;
> -	u32		latest_notif;	/* latest revocation notification */
> +	struct list_head	slots[AVC_CACHE_SLOTS];
> +	spinlock_t		slots_lock[AVC_CACHE_SLOTS];	/* Lock for RCUupdate */
> +	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
> +	atomic_t		active_nodes;
> +	u32			latest_notif;	/* latest revocation notification */
>  };
>  
>  struct avc_callback_node {
>  	int (*callback) (u32 event, u32 ssid, u32 tsid,
> @@ -69,10 +72,8 @@
>  	u32 perms;
>  	struct avc_callback_node *next;
>  };
>  
> -static spinlock_t avc_lock = SPIN_LOCK_UNLOCKED;
> -static struct avc_node *avc_node_freelist;
>  static struct avc_cache avc_cache;
>  static unsigned avc_cache_stats[AVC_NSTATS];
>  static struct avc_callback_node *avc_callbacks;
>  
> @@ -187,52 +188,44 @@
>   * Initialize the access vector cache.
>   */
>  void __init avc_init(void)
>  {
> -	struct avc_node	*new;
>  	int i;
>  
> -	for (i = 0; i < AVC_CACHE_MAXNODES; i++) {
> -		new = kmalloc(sizeof(*new), GFP_ATOMIC);
> -		if (!new) {
> -			printk(KERN_WARNING "avc:  only able to allocate "
> -			       "%d entries\n", i);
> -			break;
> -		}
> -		memset(new, 0, sizeof(*new));
> -		new->next = avc_node_freelist;
> -		avc_node_freelist = new;
> -	}
> -
> +	for (i =0; i < AVC_CACHE_SLOTS; i++) {
> +		INIT_LIST_HEAD(&avc_cache.slots[i]);
> +		avc_cache.slots_lock[i] = SPIN_LOCK_UNLOCKED;
> +	}
> +	atomic_set(&avc_cache.active_nodes, 0);
> +	atomic_set(&avc_cache.lru_hint, 0);
> +	
>  	audit_log(current->audit_context, "AVC INITIALIZED\n");
>  }
>  
>  #if 0
>  static void avc_hash_eval(char *tag)
>  {
>  	int i, chain_len, max_chain_len, slots_used;
>  	struct avc_node *node;
> +	struct list_head *pos;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&avc_lock,flags);
> +	rcu_read_lock();
>  
>  	slots_used = 0;
>  	max_chain_len = 0;
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -		node = avc_cache.slots[i];
> -		if (node) {
> +		if (!list_empty(&avc_cache.slots[i])) {
>  			slots_used++;
>  			chain_len = 0;
> -			while (node) {
> +			list_for_each_rcu(pos, &avc_cache.slots[i])
>  				chain_len++;
> -				node = node->next;
> -			}
>  			if (chain_len > max_chain_len)
>  				max_chain_len = chain_len;
>  		}
>  	}
>  
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	rcu_read_unlock();
>  
>  	printk(KERN_INFO "\n");
>  	printk(KERN_INFO "%s avc:  %d entries and %d/%d buckets used, longest "
>  	       "chain length %d\n", tag, avc_cache.active_nodes, slots_used,
> @@ -242,188 +235,194 @@
>  static inline void avc_hash_eval(char *tag)
>  { }
>  #endif
>  
> -static inline struct avc_node *avc_reclaim_node(void)
> -{
> -	struct avc_node *prev, *cur;
> -	int hvalue, try;
> +static void avc_node_free(struct rcu_head *rhead) {
> +	struct avc_node *node;
> +	node = container_of(rhead, struct avc_node, rhead);
> +	kfree(node);
> +}
>  
> -	hvalue = avc_cache.lru_hint;
> -	for (try = 0; try < 2; try++) {
> -		do {
> -			prev = NULL;
> -			cur = avc_cache.slots[hvalue];
> -			while (cur) {
> -				if (!cur->ae.used)
> -					goto found;
> +static inline void avc_reclaim_node(void)
> +{
> +	struct avc_node *node;
> +	struct list_head *pos;
> +	int hvalue, try, ecx;
>  
> -				cur->ae.used = 0;
> +	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++ ) {
> +		hvalue = atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;
>  
> -				prev = cur;
> -				cur = cur->next;
> +		if (spin_trylock(&avc_cache.slots_lock[hvalue])) {
> +			list_for_each_rcu(pos, &avc_cache.slots[hvalue]) {

Since we are holding the lock, the list cannot change, and the _rcu()
is not needed.  Right?

> +				node = list_entry(pos, struct avc_node, list);

Why not just do:

		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {

rather than having the separate list_entry().

> +				if (!atomic_dec_and_test(&node->ae.used)) {
> +					/* Recently Unused */
> +					list_del_rcu(&node->list);
> +					call_rcu(&node->rhead, avc_node_free);
> +					atomic_dec(&avc_cache.active_nodes);
> +					ecx++;
> +					if (ecx >= AVC_CACHE_RECLAIM) {
> +						spin_unlock(&avc_cache.slots_lock[hvalue]);
> +						goto out;
> +					}
> +				}
>  			}
> -			hvalue = (hvalue + 1) & (AVC_CACHE_SLOTS - 1);
> -		} while (hvalue != avc_cache.lru_hint);
> +			spin_unlock(&avc_cache.slots_lock[hvalue]);
> +		}
>  	}
> -
> -	panic("avc_reclaim_node");
> -
> -found:
> -	avc_cache.lru_hint = hvalue;
> -
> -	if (prev == NULL)
> -		avc_cache.slots[hvalue] = cur->next;
> -	else
> -		prev->next = cur->next;
> -
> -	return cur;
> +out:
> +	return;
>  }
>  
> -static inline struct avc_node *avc_claim_node(u32 ssid,
> -                                              u32 tsid, u16 tclass)
> +static inline struct avc_node *avc_get_node(void)
>  {
>  	struct avc_node *new;
> -	int hvalue;
> +	int actives;
>  
> -	hvalue = avc_hash(ssid, tsid, tclass);
> -	if (avc_node_freelist) {
> -		new = avc_node_freelist;
> -		avc_node_freelist = avc_node_freelist->next;
> -		avc_cache.active_nodes++;
> -	} else {
> -		new = avc_reclaim_node();
> -		if (!new)
> -			goto out;
> +	new = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
> +	if (new) {
> +		actives = atomic_inc_return(&avc_cache.active_nodes);
> +		if (actives > AVC_CACHE_THRESHOLD)
> +			avc_reclaim_node();
>  	}
>  
> -	new->ae.used = 1;
> -	new->ae.ssid = ssid;
> -	new->ae.tsid = tsid;
> -	new->ae.tclass = tclass;
> -	new->next = avc_cache.slots[hvalue];
> -	avc_cache.slots[hvalue] = new;
> -
> -out:
>  	return new;
>  }
>  
>  static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid,
>                                                 u16 tclass, int *probes)
>  {
> -	struct avc_node *cur;
> +	struct list_head *pos;
> +	struct avc_node *node, *ret = NULL;
>  	int hvalue;
>  	int tprobes = 1;
>  
>  	hvalue = avc_hash(ssid, tsid, tclass);
> -	cur = avc_cache.slots[hvalue];
> -	while (cur != NULL &&
> -	       (ssid != cur->ae.ssid ||
> -		tclass != cur->ae.tclass ||
> -		tsid != cur->ae.tsid)) {
> +	list_for_each_rcu(pos, &avc_cache.slots[hvalue]) {
> +		node = list_entry(pos, struct avc_node, list);

Why not just do:

		list_for_each_entry_rcu(pos, &avc_cache.slots[hvalue], list) {

rather than having the separate list_entry().

> +		if (ssid == node->ae.ssid &&
> +		    tclass == node->ae.tclass &&
> +		    tsid == node->ae.tsid) {
> +			ret = node;
> +			break;
> +		}
>  		tprobes++;
> -		cur = cur->next;
>  	}
>  
> -	if (cur == NULL) {
> +	if (ret == NULL) {
>  		/* cache miss */
>  		goto out;
>  	}
>  
>  	/* cache hit */
>  	if (probes)
>  		*probes = tprobes;
> -
> -	cur->ae.used = 1;
> -
> +	if (atomic_read(&ret->ae.used) != 1)
> +		atomic_set(&ret->ae.used, 1);
>  out:
> -	return cur;
> +	return ret;
>  }
>  
>  /**
>   * avc_lookup - Look up an AVC entry.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
>   * @requested: requested permissions, interpreted based on @tclass
> - * @aeref:  AVC entry reference
>   *
>   * Look up an AVC entry that is valid for the
>   * @requested permissions between the SID pair
>   * (@ssid, @tsid), interpreting the permissions
>   * based on @tclass.  If a valid AVC entry exists,
> - * then this function updates @aeref to refer to the
> - * entry and returns %0. Otherwise, this function
> - * returns -%ENOENT.
> + * then this function return the avc_node.
> + * Otherwise, this function returns NULL.
>   */
> -int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
> -               u32 requested, struct avc_entry_ref *aeref)
> +struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested)
>  {
>  	struct avc_node *node;
> -	int probes, rc = 0;
> +	int probes;
>  
>  	avc_cache_stats_incr(AVC_CAV_LOOKUPS);
>  	node = avc_search_node(ssid, tsid, tclass,&probes);
>  
>  	if (node && ((node->ae.avd.decided & requested) == requested)) {
>  		avc_cache_stats_incr(AVC_CAV_HITS);
>  		avc_cache_stats_add(AVC_CAV_PROBES,probes);
> -		aeref->ae = &node->ae;
>  		goto out;
>  	}
>  
>  	avc_cache_stats_incr(AVC_CAV_MISSES);
> -	rc = -ENOENT;
>  out:
> -	return rc;
> +	return node;
> +}
> +
> +static int avc_latest_notif_update(int seqno, int is_insert)
> +{
> +	int ret = 0;
> +	static spinlock_t notif_lock = SPIN_LOCK_UNLOCKED;
> +
> +	spin_lock(&notif_lock);
> +	if (seqno < avc_cache.latest_notif) {
> +		if (is_insert) {
> +			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
> +			       seqno, avc_cache.latest_notif);
> +			ret = -EAGAIN;
> +		} else {
> +			avc_cache.latest_notif = seqno;
> +		}
> +	}
> +	spin_unlock(&notif_lock);
> +	return ret;
>  }
>  
>  /**
>   * avc_insert - Insert an AVC entry.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
>   * @ae: AVC entry
> - * @aeref:  AVC entry reference
>   *
>   * Insert an AVC entry for the SID pair
>   * (@ssid, @tsid) and class @tclass.
>   * The access vectors and the sequence number are
>   * normally provided by the security server in
>   * response to a security_compute_av() call.  If the
>   * sequence number @ae->avd.seqno is not less than the latest
>   * revocation notification, then the function copies
> - * the access vectors into a cache entry, updates
> - * @aeref to refer to the entry, and returns %0.
> - * Otherwise, this function returns -%EAGAIN.
> + * the access vectors into a cache entry, returns
> + * avc_node inserted. Otherwise, this function returns NULL.
>   */
> -int avc_insert(u32 ssid, u32 tsid, u16 tclass,
> -               struct avc_entry *ae, struct avc_entry_ref *aeref)
> +struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
>  {
> -	struct avc_node *node;
> -	int rc = 0;
> +	struct avc_node *node = NULL;
> +	int hvalue;
>  
> -	if (ae->avd.seqno < avc_cache.latest_notif) {
> -		printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
> -		       ae->avd.seqno, avc_cache.latest_notif);
> -		rc = -EAGAIN;
> +	if (avc_latest_notif_update(ae->avd.seqno, 1))
>  		goto out;
> -	}
>  
> -	node = avc_claim_node(ssid, tsid, tclass);
> -	if (!node) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	node = avc_get_node();
> +
> +	if (node) {
> +		hvalue = avc_hash(ssid, tsid, tclass);
> +
> +		INIT_LIST_HEAD(&node->list);
> +		INIT_RCU_HEAD(&node->rhead);
>  
> -	node->ae.avd.allowed = ae->avd.allowed;
> -	node->ae.avd.decided = ae->avd.decided;
> -	node->ae.avd.auditallow = ae->avd.auditallow;
> -	node->ae.avd.auditdeny = ae->avd.auditdeny;
> -	node->ae.avd.seqno = ae->avd.seqno;
> -	aeref->ae = &node->ae;
> +		node->ae.ssid = ssid;
> +		node->ae.tsid = tsid;
> +		node->ae.tclass = tclass;
> +		atomic_set(&node->ae.used, 1);
> +
> +		node->ae.avd.allowed = ae->avd.allowed;
> +		node->ae.avd.decided = ae->avd.decided;
> +		node->ae.avd.auditallow = ae->avd.auditallow;
> +		node->ae.avd.auditdeny = ae->avd.auditdeny;
> +		node->ae.avd.seqno = ae->avd.seqno;
> +
> +		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);
> +	}
>  out:
> -	return rc;
> +	return node;
>  }
>  
>  static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
>  				       struct in6_addr *addr, u16 port,
> @@ -685,63 +684,99 @@
>  {
>  	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
>  }
>  
> -static inline void avc_update_node(u32 event, struct avc_node *node, u32 perms)
> +static void avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
>  {
> -	switch (event) {
> -	case AVC_CALLBACK_GRANT:
> -		node->ae.avd.allowed |= perms;
> -		break;
> -	case AVC_CALLBACK_TRY_REVOKE:
> -	case AVC_CALLBACK_REVOKE:
> -		node->ae.avd.allowed &= ~perms;
> -		break;
> -	case AVC_CALLBACK_AUDITALLOW_ENABLE:
> -		node->ae.avd.auditallow |= perms;
> -		break;
> -	case AVC_CALLBACK_AUDITALLOW_DISABLE:
> -		node->ae.avd.auditallow &= ~perms;
> -		break;
> -	case AVC_CALLBACK_AUDITDENY_ENABLE:
> -		node->ae.avd.auditdeny |= perms;
> -		break;
> -	case AVC_CALLBACK_AUDITDENY_DISABLE:
> -		node->ae.avd.auditdeny &= ~perms;
> -		break;
> +	int hvalue;
> +	struct list_head *pos;
> +	struct avc_node *new, *node, *org = NULL;
> +
> +	new = kmalloc(sizeof(struct avc_node), GFP_ATOMIC);
> +	hvalue = avc_hash(ssid, tsid, tclass);
> +
> +	/* Lock the target slot */
> +	spin_lock(&avc_cache.slots_lock[hvalue]);
> +	list_for_each(pos, &avc_cache.slots[hvalue]) {
> +		node = list_entry(pos, struct avc_node, list);

Why not just do:

		list_for_each_entry_rcu(pos, &avc_cache.slots[hvalue], list) {

rather than having the separate list_entry().

> +		if (ssid==node->ae.ssid &&
> +		    tsid==node->ae.tsid &&
> +		    tclass==node->ae.tclass ) {
> +			org = node;
> +			break;
> +		}
> +	}
> +
> +	if (org) {
> +		if (!new) {

If we run out of memory, we silently delete the node that we were
wanting to update?  Is this really what you want?

OK, OK, given that the "C" in "AVC" stands for "cache", I guess that
deleting the element does indeed make sense...

> +			list_del_rcu(&org->list);
> +			call_rcu(&org->rhead, avc_node_free);
> +			goto out;
> +		}
> +
> +		/* Duplicate and Update */
> +		memcpy(new, org, sizeof(struct avc_node));
> +
> +		switch (event) {
> +		case AVC_CALLBACK_GRANT:
> +			new->ae.avd.allowed |= perms;

This is a 32-bit field, and is protected by a lock.  Therefore, only
one update should be happening at a time.  This field is 32-bit aligned
(right?), and so the write that does the update will appear atomic to
readers.  Only one of the the updates happens in a given call.

So it should be safe to make the updates in place, right?

Some possible reasons why it might -not- be safe to do this:

o	There is some bizarre CPU out there that does not do
	atomic 32-bit writes (but this would break all sorts of
	stuff).

o	Consecutive changes might give a slow reader the incorrect
	impression that permissions are wide open.  One way to take
	care of this would be to force a grace period between each
	change.  One way to do this would be to set a bit indicating
	an update, and have the call_rcu() clear it.  When getting
	ready to update, if the bit is still set, block until the
	bit is cleared.  This would guarantee that a given reader
	would see at most one update.

	But this would require considerable code restructuring, since
	this code is still under an rcu_read_lock().  But putting
	forward the thought anyway in case it is helpful.

	If updates are -really- rare, a simple way to make this happen
	would be to protect the updates with a sema_t, and just do
	an unconditional synchronize_kernel() just before releasing
	the sema_t.

	Since the current code permits readers to see changes to
	several different nodes, a single synchronize_kernel() should
	suffice.

> +			break;
> +		case AVC_CALLBACK_TRY_REVOKE:
> +		case AVC_CALLBACK_REVOKE:
> +			new->ae.avd.allowed &= ~perms;
> +			break;
> +		case AVC_CALLBACK_AUDITALLOW_ENABLE:
> +			new->ae.avd.auditallow |= perms;
> +			break;
> +		case AVC_CALLBACK_AUDITALLOW_DISABLE:
> +			new->ae.avd.auditallow &= ~perms;
> +			break;
> +		case AVC_CALLBACK_AUDITDENY_ENABLE:
> +			new->ae.avd.auditdeny |= perms;
> +			break;
> +		case AVC_CALLBACK_AUDITDENY_DISABLE:
> +			new->ae.avd.auditdeny &= ~perms;
> +			break;
> +		}
> +
> +		list_replace_rcu(&org->list,&new->list);
> +		call_rcu(&org->rhead, avc_node_free);
>  	}
> +out:
> +	spin_unlock(&avc_cache.slots_lock[hvalue]);
>  }
>  
>  static int avc_update_cache(u32 event, u32 ssid, u32 tsid,
>                              u16 tclass, u32 perms)
>  {
> +	struct list_head *pos;
>  	struct avc_node *node;
>  	int i;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&avc_lock,flags);
> +	rcu_read_lock();
>  
>  	if (ssid == SECSID_WILD || tsid == SECSID_WILD) {
>  		/* apply to all matching nodes */
>  		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -			for (node = avc_cache.slots[i]; node;
> -			     node = node->next) {
> +			list_for_each_rcu(pos, &avc_cache.slots[i] ) {
> +				node = list_entry(pos, struct avc_node, list);

Why not just do:

		list_for_each_entry_rcu(pos, &avc_cache.slots[i], list) {

rather than having the separate list_entry().

>  				if (avc_sidcmp(ssid, node->ae.ssid) &&
>  				    avc_sidcmp(tsid, node->ae.tsid) &&
> -				    tclass == node->ae.tclass) {
> -					avc_update_node(event,node,perms);
> +				    tclass == node->ae.tclass ) {
> +					avc_update_node(event, perms, node->ae.ssid
> +					                ,node->ae.tsid, node->ae.tclass);
>  				}
>  			}
>  		}
>  	} else {
>  		/* apply to one node */
>  		node = avc_search_node(ssid, tsid, tclass, NULL);
>  		if (node) {
> -			avc_update_node(event,node,perms);
> +			avc_update_node(event, perms, ssid, tsid, tclass);
>  		}
>  	}
>  
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	rcu_read_unlock();
>  
>  	return 0;
>  }
>  
> @@ -751,9 +786,8 @@
>  {
>  	struct avc_callback_node *c;
>  	u32 tretained = 0, cretained = 0;
>  	int rc = 0;
> -	unsigned long flags;
>  
>  	/*
>  	 * try_revoke only removes permissions from the cache
>  	 * state if they are not retained by the object manager.
> @@ -786,12 +820,9 @@
>  		avc_update_cache(event,ssid,tsid,tclass,perms);
>  		*out_retained = tretained;
>  	}
>  
> -	spin_lock_irqsave(&avc_lock,flags);
> -	if (seqno > avc_cache.latest_notif)
> -		avc_cache.latest_notif = seqno;
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	avc_latest_notif_update(seqno, 0);
>  
>  out:
>  	return rc;
>  }
> @@ -856,34 +887,24 @@
>  int avc_ss_reset(u32 seqno)
>  {
>  	struct avc_callback_node *c;
>  	int i, rc = 0;
> -	struct avc_node *node, *tmp;
> -	unsigned long flags;
> +	struct list_head *pos;
> +	struct avc_node *node;
>  
>  	avc_hash_eval("reset");
>  
> -	spin_lock_irqsave(&avc_lock,flags);
> +	rcu_read_lock();
>  
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -		node = avc_cache.slots[i];
> -		while (node) {
> -			tmp = node;
> -			node = node->next;
> -			tmp->ae.ssid = tmp->ae.tsid = SECSID_NULL;
> -			tmp->ae.tclass = SECCLASS_NULL;
> -			tmp->ae.avd.allowed = tmp->ae.avd.decided = 0;
> -			tmp->ae.avd.auditallow = tmp->ae.avd.auditdeny = 0;
> -			tmp->ae.used = 0;
> -			tmp->next = avc_node_freelist;
> -			avc_node_freelist = tmp;
> -			avc_cache.active_nodes--;
> +		list_for_each_rcu(pos, &avc_cache.slots[i]) {
> +			node = list_entry(pos, struct avc_node, list);

Why not just do:

		list_for_each_entry_rcu(pos, &avc_cache.slots[i], list) {

rather than having the separate list_entry().

> +			list_del_rcu(&node->list);

I don't see what prevents multiple list_del_rcu()s from executing in
parallel, mangling the list.  Is there some higher-level lock?
If so, why do we need RCU protecting the list?

> +			call_rcu(&node->rhead, avc_node_free);
>  		}
> -		avc_cache.slots[i] = NULL;
>  	}
> -	avc_cache.lru_hint = 0;
>  
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	rcu_read_unlock();
>  
>  	for (i = 0; i < AVC_NSTATS; i++)
>  		avc_cache_stats[i] = 0;
>  
> @@ -895,12 +916,9 @@
>  				goto out;
>  		}
>  	}
>  
> -	spin_lock_irqsave(&avc_lock,flags);
> -	if (seqno > avc_cache.latest_notif)
> -		avc_cache.latest_notif = seqno;
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	avc_latest_notif_update(seqno, 0);
>  out:
>  	return rc;
>  }
>  
> @@ -949,9 +967,9 @@
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
>   * @requested: requested permissions, interpreted based on @tclass
> - * @aeref:  AVC entry reference
> + * @aeref:  AVC entry reference(not in use)
>   * @avd: access vector decisions
>   *
>   * Check the AVC to determine whether the @requested permissions are granted
>   * for the SID pair (@ssid, @tsid), interpreting the permissions
> @@ -968,72 +986,45 @@
>  int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>                           u16 tclass, u32 requested,
>                           struct avc_entry_ref *aeref, struct av_decision *avd)
>  {
> -	struct avc_entry *ae;
> -	int rc = 0;
> -	unsigned long flags;
> +	struct avc_node *node;
>  	struct avc_entry entry;
> +	int rc = 0;
>  	u32 denied;
> -	struct avc_entry_ref ref;
>  
> -	if (!aeref) {
> -		avc_entry_ref_init(&ref);
> -		aeref = &ref;
> -	}
> -
> -	spin_lock_irqsave(&avc_lock, flags);
> +	rcu_read_lock();
>  	avc_cache_stats_incr(AVC_ENTRY_LOOKUPS);
> -	ae = aeref->ae;
> -	if (ae) {
> -		if (ae->ssid == ssid &&
> -		    ae->tsid == tsid &&
> -		    ae->tclass == tclass &&
> -		    ((ae->avd.decided & requested) == requested)) {
> -			avc_cache_stats_incr(AVC_ENTRY_HITS);
> -			ae->used = 1;
> -		} else {
> -			avc_cache_stats_incr(AVC_ENTRY_DISCARDS);
> -			ae = NULL;
> -		}
> -	}
>  
> -	if (!ae) {
> -		avc_cache_stats_incr(AVC_ENTRY_MISSES);
> -		rc = avc_lookup(ssid, tsid, tclass, requested, aeref);
> -		if (rc) {
> -			spin_unlock_irqrestore(&avc_lock,flags);
> -			rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
> -			if (rc)
> -				goto out;
> -			spin_lock_irqsave(&avc_lock, flags);
> -			rc = avc_insert(ssid,tsid,tclass,&entry,aeref);
> -			if (rc) {
> -				spin_unlock_irqrestore(&avc_lock,flags);
> -				goto out;
> -			}
> +	node = avc_lookup(ssid, tsid, tclass, requested);
> +	if (!node) {
> +		rcu_read_unlock();
> +		rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
> +		if (rc)
> +			goto out;
> +		rcu_read_lock();
> +		node = avc_insert(ssid,tsid,tclass,&entry);

I don't see what prevents two copies of avc_insert from running in parallel.
Seems like this would trash the lists.  Or, if there is a higher-level lock
that I am missing, why do we need RCU protecting the lists?

> +		if (!node) {
> +			rcu_read_unlock();
> +			goto out;
>  		}
> -		ae = aeref->ae;
>  	}
> -
>  	if (avd)
> -		memcpy(avd, &ae->avd, sizeof(*avd));
> +		memcpy(avd, &node->ae.avd, sizeof(*avd));
>  
> -	denied = requested & ~(ae->avd.allowed);
> +	denied = requested & ~(node->ae.avd.allowed);
>  
>  	if (!requested || denied) {
>  		if (selinux_enforcing) {
> -			spin_unlock_irqrestore(&avc_lock,flags);
>  			rc = -EACCES;
> -			goto out;
>  		} else {
> -			ae->avd.allowed |= requested;
> -			spin_unlock_irqrestore(&avc_lock,flags);
> -			goto out;
> +			if (node->ae.avd.allowed != (node->ae.avd.allowed|requested))
> +				avc_update_node(AVC_CALLBACK_GRANT
> +				                ,requested,ssid,tsid,tclass);
>  		}
>  	}
>  
> -	spin_unlock_irqrestore(&avc_lock,flags);
> +	rcu_read_unlock();
>  out:
>  	return rc;
>  }
>  
> @@ -1042,9 +1033,9 @@
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
>   * @requested: requested permissions, interpreted based on @tclass
> - * @aeref:  AVC entry reference
> + * @aeref:  AVC entry reference(not in use)
>   * @auditdata: auxiliary audit data
>   *
>   * Check the AVC to determine whether the @requested permissions are granted
>   * for the SID pair (@ssid, @tsid), interpreting the permissions
> @@ -1061,8 +1052,8 @@
>  {
>  	struct av_decision avd;
>  	int rc;
>  
> -	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
> +	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, NULL, &avd);
>  	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
>  	return rc;
>  }
> diff -rNU4 linux-2.6.8.1/security/selinux/include/avc.h linux-2.6.8.1.rcu/security/selinux/include/avc.h
> --- linux-2.6.8.1/security/selinux/include/avc.h	2004-08-14 19:54:51.000000000 +0900
> +++ linux-2.6.8.1.rcu/security/selinux/include/avc.h	2004-08-20 20:40:50.000000000 +0900
> @@ -118,13 +118,11 @@
>   */
>  
>  void __init avc_init(void);
>  
> -int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
> -               u32 requested, struct avc_entry_ref *aeref);
> +struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass, u32 requested);
>  
> -int avc_insert(u32 ssid, u32 tsid, u16 tclass,
> -               struct avc_entry *ae, struct avc_entry_ref *out_aeref);
> +struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae);
>  
>  void avc_audit(u32 ssid, u32 tsid,
>                 u16 tclass, u32 requested,
>                 struct av_decision *avd, int result, struct avc_audit_data *auditdata);
