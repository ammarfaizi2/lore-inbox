Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSIELrf>; Thu, 5 Sep 2002 07:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSIELrf>; Thu, 5 Sep 2002 07:47:35 -0400
Received: from dp.samba.org ([66.70.73.150]:1006 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317402AbSIELrb>;
	Thu, 5 Sep 2002 07:47:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Schaaf <bof@bof.de>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ip_conntrack_hash() problem 
In-reply-to: Your message of "Thu, 05 Sep 2002 08:21:28 +0200."
             <20020905082128.D19551@oknodo.bof.de> 
Date: Thu, 05 Sep 2002 21:14:08 +1000
Message-Id: <20020905115208.484DA2C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020905082128.D19551@oknodo.bof.de> you write:
> On Thu, Sep 05, 2002 at 10:39:40AM +1000, Rusty Russell wrote:
> > In message <20020904152626.A11438@wotan.suse.de> you write:
> > > > I think the hash function should be fixed, not the possible choice of
> > > > hash sizes, if that is at feasible.
> > > I also agree with Martin that it is better to fix the hash function in
> > > this case. Restricting to magic hash table sizes looks like a bad hack.
> > 
> > This work is already done:
> > http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/connt
rack_hashing.patch.gz
> 
> Some comments:
> 
> A) secs_between_rehash is doubled every rehash, and never decreased
>    again. This looks broken. What's the rationale?

It's deliberate.  The randomness available in the system becomes
better with time.  If hashing sucks, then we're screwed anyway: let's
not spuriously stop the world for no improvement.  In an ideal world
we'd say "feed a random number into ip_conntrack once you've booted",
but relying on userspace to do that to avoid DoS is inadvisable.

> B) I despise the (1 << ...htable_bits) construct, used in several places.
>    It's nothing but obfuscation. Please reinstate ...htable_size, and
>    use that, the code will be more readable.

Well, if you really dislike it, how about:

	static inline unsigned htable_size(void)
	{
		return 1 << ip_conntrack_htable_bits;
	}

I chose it because the number of *bits* is the fundament now.

> C) did you measure how much time the rehashing takes, for a single run
>    on a significant (2^16 buckets, at least) conntracking table?

Good question.  I expect it to take an awfully long time, and it will
only get slower when I make the locks per-hash chain (ie. grabbing
2^16 locks will take a long time).  Hence 'don't do it often!'.

We also have an opportunity to resize the hash table here (for the
multiple lock extention, this means grabbing the network write
brlock, which needs to be done from a userspace context).  We *could*
do this when someone frobs ip_conntrack_max though, if we wanted.

> D) did you run your hash_conntrack() against my cttest bucket occupation
>    simulator? Can we see comparing pictures?

No, I havent: I was hoping that you would do that 8)

> To conclude, I agree with using a multiplicative hash, but I'm a bit nervous
> about the rehashing thing. A single random hash_base call would be enough
> to satisfy _my_ paranoia. IMHO the rehashing should be a compile/run time
> "be more paranoid" option.

I'd be happy, too, *except* there's no entropy at boot 8(  Hence my
workaround.

In message <20020905085103.G19551@oknodo.bof.de> you write:
> Regarding the rehash check in ip_conntrack_find_get, wouldn't it be
> better to do that in the confirm function, where a new conntrack
> is put into the list? That's called a lot less often than _find_get,
> and should be logically equivalent. IOW, why wait until we _find_
> an overly long list, when we can rehash at the point in time when
> it _became_ overly long?

Yes, agreed, that's much nicer, esp. since we hold the lock anyway.
Done.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Conntrack Hashing Patch Rewrite
Author: Rusty Russell
Status: Experimental
Depends: 

D: This changes connection tracking's hash to use a secret and
D: multiplicitive the hashing.  The secret is rekeyed occasionally.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.33/net/ipv4/netfilter/ip_conntrack_core.c working-2.5.33-conntrack-hash/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5.33/net/ipv4/netfilter/ip_conntrack_core.c	2002-08-28 09:29:54.000000000 +1000
+++ working-2.5.33-conntrack-hash/net/ipv4/netfilter/ip_conntrack_core.c	2002-09-05 21:11:36.000000000 +1000
@@ -32,6 +32,9 @@
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
+#include <linux/hash.h>
+#include <linux/bitops.h>
+#include <linux/random.h>
 /* For ERR_PTR().  Yeah, I know... --RR */
 #include <linux/fs.h>
 
@@ -61,14 +64,62 @@ void (*ip_conntrack_destroyed)(struct ip
 LIST_HEAD(ip_conntrack_expect_list);
 LIST_HEAD(protocol_list);
 static LIST_HEAD(helpers);
-unsigned int ip_conntrack_htable_size = 0;
+unsigned int ip_conntrack_htable_bits;
 static int ip_conntrack_max = 0;
 static atomic_t ip_conntrack_count = ATOMIC_INIT(0);
 struct list_head *ip_conntrack_hash;
 static kmem_cache_t *ip_conntrack_cachep;
+static unsigned long hash_base;
+static unsigned long secs_between_rehash, min_next_rehash;
+
+static inline unsigned htable_size(void)
+{
+	return 1 << ip_conntrack_htable_bits;
+}
 
 extern struct ip_conntrack_protocol ip_conntrack_generic_protocol;
 
+/* Very slow, so only call occasionally in case we didn't have enough
+   randomness to avoid chain bombing by a determined attacker. */
+static void rehash_conntracks(void)
+{
+	unsigned int i;
+	unsigned long new_hash_base;
+	LIST_HEAD(conntracks);
+
+	MUST_BE_WRITE_LOCKED(&ip_conntrack_lock);
+
+	get_random_bytes(&new_hash_base, sizeof(new_hash_base));
+
+	/* Strip everything. */
+	for (i = 0; i < htable_size(); i++) {
+		struct list_head *l;
+		l = ip_conntrack_hash[i].next;
+		list_del_init(&ip_conntrack_hash[i]);
+		list_add(l, &conntracks);
+	}
+
+	/* Change hash over */
+	hash_base ^= new_hash_base;
+
+	/* Now add them back, one at a time */
+	while (!list_empty(&conntracks)) {
+		struct ip_conntrack_tuple_hash *h;
+		unsigned int hash;
+		struct list_head *l = conntracks.next;
+
+		list_del(l);
+		h = list_entry(l, struct ip_conntrack_tuple_hash, list);
+		hash = hash_conntrack(&h->tuple);
+		list_add(&h->list, &ip_conntrack_hash[hash]);
+	}
+
+	/* Double timeout if we can */
+	if (secs_between_rehash < ULONG_MAX/2/HZ)
+		secs_between_rehash *= 2;
+	min_next_rehash = jiffies + secs_between_rehash*HZ;
+}
+
 static inline int proto_cmpfn(const struct ip_conntrack_protocol *curr,
 			      u_int8_t protocol)
 {
@@ -111,17 +162,13 @@ ip_conntrack_put(struct ip_conntrack *ct
 static inline u_int32_t
 hash_conntrack(const struct ip_conntrack_tuple *tuple)
 {
-#if 0
-	dump_tuple(tuple);
-#endif
-	/* ntohl because more differences in low bits. */
-	/* To ensure that halves of the same connection don't hash
-	   clash, we add the source per-proto again. */
-	return (ntohl(tuple->src.ip + tuple->dst.ip
-		     + tuple->src.u.all + tuple->dst.u.all
-		     + tuple->dst.protonum)
-		+ ntohs(tuple->src.u.all))
-		% ip_conntrack_htable_size;
+	unsigned long hash = hash_base;
+
+	hash ^= tuple->src.ip;
+	hash ^= tuple->dst.ip << (BITS_PER_LONG - 32);
+	hash ^= (tuple->src.u.all + tuple->dst.u.all << 16)
+		 << (BITS_PER_LONG - 32)/2;
+	return hash_long(hash, ip_conntrack_htable_bits);
 }
 
 inline int
@@ -358,9 +405,11 @@ static void death_by_timeout(unsigned lo
 static inline int
 conntrack_tuple_cmp(const struct ip_conntrack_tuple_hash *i,
 		    const struct ip_conntrack_tuple *tuple,
-		    const struct ip_conntrack *ignored_conntrack)
+		    const struct ip_conntrack *ignored_conntrack,
+		    unsigned int *count)
 {
 	MUST_BE_READ_LOCKED(&ip_conntrack_lock);
+	if (count) (*count)++;
 	return i->ctrack != ignored_conntrack
 		&& ip_ct_tuple_equal(tuple, &i->tuple);
 }
@@ -375,7 +424,7 @@ __ip_conntrack_find(const struct ip_conn
 	h = LIST_FIND(&ip_conntrack_hash[hash_conntrack(tuple)],
 		      conntrack_tuple_cmp,
 		      struct ip_conntrack_tuple_hash *,
-		      tuple, ignored_conntrack);
+		      tuple, ignored_conntrack, NULL);
 	return h;
 }
 
@@ -420,7 +469,7 @@ ip_conntrack_get(struct sk_buff *skb, en
 int
 __ip_conntrack_confirm(struct nf_ct_info *nfct)
 {
-	unsigned int hash, repl_hash;
+	unsigned int hash, repl_hash, count;
 	struct ip_conntrack *ct;
 	enum ip_conntrack_info ctinfo;
 
@@ -447,17 +496,19 @@ __ip_conntrack_confirm(struct nf_ct_info
 	DEBUGP("Confirming conntrack %p\n", ct);
 
 	WRITE_LOCK(&ip_conntrack_lock);
+	count = 0;
 	/* See if there's one in the list already, including reverse:
            NAT could have grabbed it without realizing, since we're
            not in the hash.  If there is, we lost race. */
 	if (!LIST_FIND(&ip_conntrack_hash[hash],
 		       conntrack_tuple_cmp,
 		       struct ip_conntrack_tuple_hash *,
-		       &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple, NULL)
+		       &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple, NULL, &count)
 	    && !LIST_FIND(&ip_conntrack_hash[repl_hash],
 			  conntrack_tuple_cmp,
 			  struct ip_conntrack_tuple_hash *,
-			  &ct->tuplehash[IP_CT_DIR_REPLY].tuple, NULL)) {
+			  &ct->tuplehash[IP_CT_DIR_REPLY].tuple,
+			  NULL, &count)) {
 		list_prepend(&ip_conntrack_hash[hash],
 			     &ct->tuplehash[IP_CT_DIR_ORIGINAL]);
 		list_prepend(&ip_conntrack_hash[repl_hash],
@@ -468,6 +519,16 @@ __ip_conntrack_confirm(struct nf_ct_info
 		ct->timeout.expires += jiffies;
 		add_timer(&ct->timeout);
 		atomic_inc(&ct->ct_general.use);
+
+		/* Check for really long hash chains: say 64* normal
+                   for the two of them. */
+		if (count / 64 > (ip_conntrack_max >> ip_conntrack_htable_bits)
+		    && time_after(jiffies, min_next_rehash)) {
+			printk("ip_conntrack: Rehashing for len %u / %u\n",
+			       count,
+			       (ip_conntrack_max >> ip_conntrack_htable_bits));
+			rehash_conntracks();
+		}
 		WRITE_UNLOCK(&ip_conntrack_lock);
 		return NF_ACCEPT;
 	}
@@ -646,7 +707,7 @@ init_conntrack(const struct ip_conntrack
 		/* Try dropping from random chain, or else from the
                    chain about to put into (in case they're trying to
                    bomb one hash chain). */
-		unsigned int next = (drop_next++)%ip_conntrack_htable_size;
+		unsigned int next = ((drop_next++) & (htable_size() - 1));
 
 		if (!early_drop(&ip_conntrack_hash[next])
 		    && !early_drop(&ip_conntrack_hash[hash])) {
@@ -1154,7 +1215,7 @@ void ip_conntrack_helper_unregister(stru
 	LIST_DELETE(&helpers, me);
 
 	/* Get rid of expecteds, set helpers to NULL. */
-	for (i = 0; i < ip_conntrack_htable_size; i++)
+	for (i = 0; i < htable_size(); i++)
 		LIST_FIND_W(&ip_conntrack_hash[i], unhelp,
 			    struct ip_conntrack_tuple_hash *, me);
 	WRITE_UNLOCK(&ip_conntrack_lock);
@@ -1262,7 +1323,7 @@ get_next_corpse(int (*kill)(const struct
 	unsigned int i;
 
 	READ_LOCK(&ip_conntrack_lock);
-	for (i = 0; !h && i < ip_conntrack_htable_size; i++) {
+	for (i = 0; !h && i < htable_size(); i++) {
 		h = LIST_FIND(&ip_conntrack_hash[i], do_kill,
 			      struct ip_conntrack_tuple_hash *, kill, data);
 	}
@@ -1411,23 +1472,16 @@ int __init ip_conntrack_init(void)
 
 	/* Idea from tcp.c: use 1/16384 of memory.  On i386: 32MB
 	 * machine has 256 buckets.  >= 1GB machines have 8192 buckets. */
- 	if (hashsize) {
- 		ip_conntrack_htable_size = hashsize;
- 	} else {
-		ip_conntrack_htable_size
-			= (((num_physpages << PAGE_SHIFT) / 16384)
-			   / sizeof(struct list_head));
+ 	if (!hashsize) {
+		hashsize = (((num_physpages << PAGE_SHIFT) / 16384)
+			    / sizeof(struct list_head));
 		if (num_physpages > (1024 * 1024 * 1024 / PAGE_SIZE))
-			ip_conntrack_htable_size = 8192;
-		if (ip_conntrack_htable_size < 16)
-			ip_conntrack_htable_size = 16;
+			hashsize = 8192;
+		if (hashsize < 16)
+			hashsize = 16;
 	}
-	ip_conntrack_max = 8 * ip_conntrack_htable_size;
-
-	printk("ip_conntrack version %s (%u buckets, %d max)"
-	       " - %d bytes per conntrack\n", IP_CONNTRACK_VERSION,
-	       ip_conntrack_htable_size, ip_conntrack_max,
-	       sizeof(struct ip_conntrack));
+	ip_conntrack_htable_bits = fls(hashsize);
+	ip_conntrack_max = 8 * htable_size();
 
 	ret = nf_register_sockopt(&so_getorigdst);
 	if (ret != 0) {
@@ -1471,6 +1525,10 @@ int __init ip_conntrack_init(void)
 	}
 #endif /*CONFIG_SYSCTL*/
 
+	/* Start with 1 second between rehashing, any time now */
+	min_next_rehash = jiffies-1;
+	secs_between_rehash = 1;
+
 	/* For use by ipt_REJECT */
 	ip_ct_attach = ip_conntrack_attach;
 	return ret;
