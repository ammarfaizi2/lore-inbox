Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbQLDFwR>; Mon, 4 Dec 2000 00:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLDFwH>; Mon, 4 Dec 2000 00:52:07 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:8702 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129710AbQLDFv5>; Mon, 4 Dec 2000 00:51:57 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "Johan Kullstam" <kullstam@ne.mediaone.net>, Roger Crandell <rwc@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem 
In-Reply-To: Your message of "03 Dec 2000 19:22:21 CDT."
             <m2elzp3uiq.fsf@euler.axel.nom> 
Date: Mon, 04 Dec 2000 16:21:13 +1100
Message-Id: <20001204052123.CE84281F0@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <m2elzp3uiq.fsf@euler.axel.nom> you write:
> yes, but is it a dual machine or is it an N-way SMP with N > 2?  the
> other guy with iptables/SMP problems also has a quad box.  could this
> perhaps be a problem only when you have more than two processors?

Yes, hacked my machine to think it had 4 cpus, and boom.

There are two problems:
(1) initialization of multiple tables was wrong, and
(2) iterating through tables should not use cpu_number_map (doesn't
    matter on X86 though).

Please try attached patch.

Thanks,
Rusty,
--
Hacking time.
--- working-2.4.0-test11-5/net/ipv4/netfilter/ip_tables.c.~1~	Sat Aug 12 00:23:40 2000
+++ working-2.4.0-test11-5/net/ipv4/netfilter/ip_tables.c	Mon Dec  4 16:12:44 2000
@@ -89,10 +89,8 @@
 	unsigned int hook_entry[NF_IP_NUMHOOKS];
 	unsigned int underflow[NF_IP_NUMHOOKS];
 
-	char padding[SMP_ALIGN((NF_IP_NUMHOOKS*2+2)*sizeof(unsigned int))];
-
 	/* ipt_entry tables: one per CPU */
-	char entries[0];
+	char entries[0] __attribute__((aligned(SMP_CACHE_BYTES)));
 };
 
 static LIST_HEAD(ipt_target);
@@ -101,7 +99,7 @@
 #define ADD_COUNTER(c,b,p) do { (c).bcnt += (b); (c).pcnt += (p); } while(0)
 
 #ifdef CONFIG_SMP
-#define TABLE_OFFSET(t,p) (SMP_ALIGN((t)->size)*cpu_number_map(p))
+#define TABLE_OFFSET(t,p) (SMP_ALIGN((t)->size)*(p))
 #else
 #define TABLE_OFFSET(t,p) 0
 #endif
@@ -283,7 +281,8 @@
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
 	table_base = (void *)table->private->entries
-		+ TABLE_OFFSET(table->private, smp_processor_id());
+		+ TABLE_OFFSET(table->private,
+			       cpu_number_map(smp_processor_id()));
 	e = get_entry(table_base, table->private->hook_entry[hook]);
 
 #ifdef CONFIG_NETFILTER_DEBUG
@@ -860,7 +859,7 @@
 
 	/* And one copy for every other CPU */
 	for (i = 1; i < smp_num_cpus; i++) {
-		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size*i),
+		memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
 		       newinfo->entries,
 		       SMP_ALIGN(newinfo->size));
 	}
@@ -1359,7 +1358,7 @@
 	int ret;
 	struct ipt_table_info *newinfo;
 	static struct ipt_table_info bootstrap
-		= { 0, 0, { 0 }, { 0 }, { }, { } };
+		= { 0, 0, { 0 }, { 0 }, { } };
 
 	MOD_INC_USE_COUNT;
 	newinfo = vmalloc(sizeof(struct ipt_table_info)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
