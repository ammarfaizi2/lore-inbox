Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWHHJOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWHHJOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWHHJOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:14:53 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:29599 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1750794AbWHHJOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:14:52 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 11:14:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
References: <20060808070708.GA3931@localhost.localdomain>
In-Reply-To: <20060808070708.GA3931@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081114.50256.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 09:07, Ravikiran G Thirumalai wrote:
> Current futex hash scheme is not the best for NUMA.   The futex hash table
> is an array of struct futex_hash_bucket, which is just a spinlock and a
> list_head -- this means multiple spinlocks on the same cacheline and on
> NUMA machines, on the same internode cacheline.  If futexes of two
> unrelated threads running on two different nodes happen to hash onto
> adjacent hash buckets, or buckets on the same internode cacheline, then we
> have the internode cacheline bouncing between nodes.
>
> Here is a simple scheme which maintains per-node hash tables for futexes.
>
> In this scheme, a private futex is assigned to the node id of the futex's
> KVA. The reasoning is, the futex KVA is allocated from the node as
> indicated by memory policy set by the process, and that should be a good
> 'home node' for that futex.  Of course this helps workloads where all the
> threads of a process are bound to the same node, but it seems reasonable to
> run all threads of a process on the same node.
>
> A shared futex is assigned a home node based on jhash2 itself.  Since inode
> and offset are used as the key, the same inode offset is used to arrive at
> the home node of a shared futex.  This distributes private futexes across
> all nodes.
>
> Comments? Suggestions? Particularly regarding shared futexes.  Any policy
> suggestions?
>

Your patch seems fine, but I have one comment.

For non NUMA machine, we would have one useless indirection to get the 
futex_queues pointer.

static struct futex_hash_bucket *futex_queues[1];

I think it is worth to redesign your patch so that this extra-indirection is 
needed only for NUMA machines.

#if defined(CONFIG_NUMA)
static struct futex_hash_bucket *futex_queues[MAX_NUMNODES];
#define FUTEX_QUEUES(nodeid, hash) \
	&futex_queues[nodeid][hash & ((1 << FUTEX_HASHBITS)-1)];
#else
static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
# define FUTEX_QUEUES(nodeid, hash) \
     &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
#endif

Thank you

> Thanks,
> Kiran
>
> Note: This patch needs to have kvaddr_to_nid() reintroduced.  This was
> taken out in git commit 9f3fd602aef96c2a490e3bfd669d06475aeba8d8
>
> Index: linux-2.6.18-rc3/kernel/futex.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/kernel/futex.c	2006-08-02 12:11:34.000000000
> -0700 +++ linux-2.6.18-rc3/kernel/futex.c	2006-08-02 16:48:47.000000000
> -0700 @@ -137,20 +137,35 @@ struct futex_hash_bucket {
>         struct list_head       chain;
>  };
>
> -static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
> +static struct futex_hash_bucket *futex_queues[MAX_NUMNODES] __read_mostly;
>
>  /* Futex-fs vfsmount entry: */
>  static struct vfsmount *futex_mnt;
>
>  /*
>   * We hash on the keys returned from get_futex_key (see below).
> + * With NUMA aware futex hashing, we have per-node hash tables.
> + * We determine the home node of a futex based on the KVA -- if the futex
> + * is a private futex.  For shared futexes, we use  jhash2 itself on the
> + * futex_key to arrive at a home node.
>   */
>  static struct futex_hash_bucket *hash_futex(union futex_key *key)
>  {
> +	int nodeid;
>  	u32 hash = jhash2((u32*)&key->both.word,
>  			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
>  			  key->both.offset);
> -	return &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
> +	if (key->both.offset & 0x1) {
> +		/*
> +		 * Shared futex: Use any of the 'possible' nodes as home node.
> +		 */
> +		nodeid = hash & (MAX_NUMNODES -1);
> +		BUG_ON(!node_possible(nodeid));
> +	} else
> +		/* Private futex */
> +		nodeid = kvaddr_to_nid(key->both.ptr);
> +
> +	return &futex_queues[nodeid][hash & ((1 << FUTEX_HASHBITS)-1)];
>  }
>
>  /*
> @@ -1909,13 +1924,25 @@ static int __init init(void)
>  {
>  	unsigned int i;
>
> +	int nid;
> +
> +	for_each_node(nid)
> +	{
> +		futex_queues[nid] = kmalloc_node(
> +					(sizeof(struct futex_hash_bucket) *
> +					(1 << FUTEX_HASHBITS)),
> +					GFP_KERNEL, nid);
> +		if (!futex_queues[nid])
> +			panic("futex_init: Allocation of multi-node futex_queues failed");
> +		for (i = 0; i < (1 << FUTEX_HASHBITS); i++) {
> +			INIT_LIST_HEAD(&futex_queues[nid][i].chain);
> +			spin_lock_init(&futex_queues[nid][i].lock);
> +		}
> +	}
> +
>  	register_filesystem(&futex_fs_type);
>  	futex_mnt = kern_mount(&futex_fs_type);
>
> -	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
> -		INIT_LIST_HEAD(&futex_queues[i].chain);
> -		spin_lock_init(&futex_queues[i].lock);
> -	}
>  	return 0;
>  }
>  __initcall(init);
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
