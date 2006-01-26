Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWAZLOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWAZLOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWAZLOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:14:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55259 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932294AbWAZLOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:14:16 -0500
Date: Thu, 26 Jan 2006 03:13:52 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, lock validator] fix uidhash_lock <-> RCU deadlock
Message-ID: <20060126111352.GF4953@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060125142307.GA5427@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125142307.GA5427@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 03:23:07PM +0100, Ingo Molnar wrote:
> RCU task-struct freeing can call free_uid(), which is taking 
> uidhash_lock - while other users of uidhash_lock are softirq-unsafe.

I guess I get to feel doubly stupid today.  Good catch, great tool!!!

						Thanx, Paul

Acked-by <paulmck@us.ibm.com>

> This bug was found by the lock validator i'm working on:
> 
>  ============================
>  [ BUG: illegal lock usage! ]
>  ----------------------------
>  illegal {enabled-softirqs} -> {used-in-softirq} usage.
>  swapper/0 [HC0[0]:SC1[2]:HE1:SE0] takes {uidhash_lock [u:25]}, at:
>   [<c025e858>] _atomic_dec_and_lock+0x48/0x80
>  {enabled-softirqs} state was registered at:
>   [<c04d7cfd>] _write_unlock_bh+0xd/0x10
>  hardirqs last enabled at: [<c015f278>] kmem_cache_free+0x78/0xb0
>  softirqs last enabled at: [<c011b2da>] copy_process+0x2ca/0xe80
> 
>  other info that might help in debugging this:
>  ------------------------------
>  | showing all locks held by: |  (swapper/0 [c30d8790, 140]): <none>
>  ------------------------------
> 
>   [<c010432d>] show_trace+0xd/0x10
>   [<c0104347>] dump_stack+0x17/0x20
>   [<c01371d1>] print_usage_bug+0x1e1/0x200
>   [<c0137789>] mark_lock+0x259/0x290
>   [<c0137c25>] debug_lock_chain_spin+0x465/0x10f0
>   [<c0264abd>] _raw_spin_lock+0x2d/0x90
>   [<c04d7a68>] _spin_lock+0x8/0x10
>   [<c025e858>] _atomic_dec_and_lock+0x48/0x80
>   [<c0127674>] free_uid+0x14/0x70
>   [<c011a428>] __put_task_struct+0x38/0x130
>   [<c0114afd>] __put_task_struct_cb+0xd/0x10
>   [<c012f151>] __rcu_process_callbacks+0x81/0x180
>   [<c012f550>] rcu_process_callbacks+0x30/0x60
>   [<c0122aa4>] tasklet_action+0x54/0xd0
>   [<c0122c77>] __do_softirq+0x87/0x120
>   [<c0105519>] do_softirq+0x69/0xb0
>   =======================
>   [<c0122939>] irq_exit+0x39/0x50
>   [<c010f47c>] smp_apic_timer_interrupt+0x4c/0x50
>   [<c010393b>] apic_timer_interrupt+0x27/0x2c
>   [<c0101c58>] cpu_idle+0x68/0x80
>   [<c010e37e>] start_secondary+0x29e/0x480
>   [<00000000>] 0x0
>   [<c30d9fb4>] 0xc30d9fb4
> 
> the fix is to always take the uidhash_spinlock in a softirq-safe manner.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ----
> 
> Index: linux/kernel/user.c
> ===================================================================
> --- linux.orig/kernel/user.c
> +++ linux/kernel/user.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/bitops.h>
>  #include <linux/key.h>
> +#include <linux/interrupt.h>
>  
>  /*
>   * UID task count cache, to get fast user lookup in "alloc_uid"
> @@ -27,6 +28,12 @@
>  
>  static kmem_cache_t *uid_cachep;
>  static struct list_head uidhash_table[UIDHASH_SZ];
> +
> +/*
> + * The uidhash_lock is mostly taken from process context, but it is
> + * occasionally also taken from softirq/tasklet context, when
> + * task-structs get RCU-freed. Hence all locking must be softirq-safe.
> + */
>  static DEFINE_SPINLOCK(uidhash_lock);
>  
>  struct user_struct root_user = {
> @@ -83,14 +90,15 @@ struct user_struct *find_user(uid_t uid)
>  {
>  	struct user_struct *ret;
>  
> -	spin_lock(&uidhash_lock);
> +	spin_lock_bh(&uidhash_lock);
>  	ret = uid_hash_find(uid, uidhashentry(uid));
> -	spin_unlock(&uidhash_lock);
> +	spin_unlock_bh(&uidhash_lock);
>  	return ret;
>  }
>  
>  void free_uid(struct user_struct *up)
>  {
> +	local_bh_disable();
>  	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
>  		uid_hash_remove(up);
>  		key_put(up->uid_keyring);
> @@ -98,6 +106,7 @@ void free_uid(struct user_struct *up)
>  		kmem_cache_free(uid_cachep, up);
>  		spin_unlock(&uidhash_lock);
>  	}
> +	local_bh_enable();
>  }
>  
>  struct user_struct * alloc_uid(uid_t uid)
> @@ -105,9 +114,9 @@ struct user_struct * alloc_uid(uid_t uid
>  	struct list_head *hashent = uidhashentry(uid);
>  	struct user_struct *up;
>  
> -	spin_lock(&uidhash_lock);
> +	spin_lock_bh(&uidhash_lock);
>  	up = uid_hash_find(uid, hashent);
> -	spin_unlock(&uidhash_lock);
> +	spin_unlock_bh(&uidhash_lock);
>  
>  	if (!up) {
>  		struct user_struct *new;
> @@ -137,7 +146,7 @@ struct user_struct * alloc_uid(uid_t uid
>  		 * Before adding this, check whether we raced
>  		 * on adding the same user already..
>  		 */
> -		spin_lock(&uidhash_lock);
> +		spin_lock_bh(&uidhash_lock);
>  		up = uid_hash_find(uid, hashent);
>  		if (up) {
>  			key_put(new->uid_keyring);
> @@ -147,7 +156,7 @@ struct user_struct * alloc_uid(uid_t uid
>  			uid_hash_insert(new, hashent);
>  			up = new;
>  		}
> -		spin_unlock(&uidhash_lock);
> +		spin_unlock_bh(&uidhash_lock);
>  
>  	}
>  	return up;
> @@ -183,9 +192,9 @@ static int __init uid_cache_init(void)
>  		INIT_LIST_HEAD(uidhash_table + n);
>  
>  	/* Insert the root user immediately (init already runs as root) */
> -	spin_lock(&uidhash_lock);
> +	spin_lock_bh(&uidhash_lock);
>  	uid_hash_insert(&root_user, uidhashentry(0));
> -	spin_unlock(&uidhash_lock);
> +	spin_unlock_bh(&uidhash_lock);
>  
>  	return 0;
>  }
> 
