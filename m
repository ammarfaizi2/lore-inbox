Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265785AbSJSX12>; Sat, 19 Oct 2002 19:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265781AbSJSX1W>; Sat, 19 Oct 2002 19:27:22 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:23817 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265780AbSJSX0q>; Sat, 19 Oct 2002 19:26:46 -0400
Date: Sat, 19 Oct 2002 20:32:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021019233236.GI14009@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please consider pulling from:

master.kernel.org:/home/acme/BK/net-2.5

	Ah, this tree is in sync with 2.5.44, i.e with the latest
Linus BK tree.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.809, 2002-10-19 19:53:16-03:00, acme@conectiva.com.br
  o ipv4: only produce one record in fib_seq_show
  
  This one had to move lots of stuff around, but that is IMHO good, so
  that the proc_fs support code gets into just one file, in the
  future we may well introduce CONFIG_IP_PROC_FS, that way we can have
  procfs support disabled just for the TCP/IP stuff, for those who want
  to use only iproute2 tools that use netlink and not /proc/net to get
  information.
  
  Also use a common ip_seq_release for the file_operations fops, we may
  well indeed introduce a private_seq_release or any other more sane name
  for the seq_file users that only want to kmalloc a seq->private area
  and at seq_release time just kfree it.


 include/net/ip_fib.h     |   49 ++++++++++++
 net/ipv4/fib_hash.c      |   99 +++----------------------
 net/ipv4/fib_semantics.c |   41 ----------
 net/ipv4/ip_proc.c       |  186 +++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 225 insertions(+), 150 deletions(-)


diff -Nru a/include/net/ip_fib.h b/include/net/ip_fib.h
--- a/include/net/ip_fib.h	Sat Oct 19 20:26:53 2002
+++ b/include/net/ip_fib.h	Sat Oct 19 20:26:53 2002
@@ -52,6 +52,34 @@
 	u32			nh_gw;
 };
 
+/**
+ *	struct fn_zone - zone
+ *
+ *	fz_next	- Next not empty zone
+ *	fz_hash - Hash table pointer
+ *	fz_nent - Number of entries
+ *	fz_divisor - Hash divisor
+ *	fz_hashmask - (1 << fz_divisor) - 1
+ *	fz_order - Zone order
+ *	fz_mask - Mask
+ */
+struct fn_zone {
+	struct fn_zone  *fz_next;
+	struct fib_node **fz_hash;
+	int             fz_nent;
+	int             fz_divisor;
+	u32             fz_hashmask;
+#define FZ_HASHMASK(fz) ((fz)->fz_hashmask)
+	int             fz_order;
+	u32             fz_mask;
+#define FZ_MASK(fz)     ((fz)->fz_mask)
+};
+
+struct fn_hash {
+	struct fn_zone *fn_zones[33];
+	struct fn_zone *fn_zone_list;
+};
+
 /*
  * This structure contains data shared by many of routes.
  */
@@ -80,6 +108,25 @@
 #define fib_dev		fib_nh[0].nh_dev
 };
 
+struct fn_key {
+	u32     datum;
+};
+
+#define fz_prefix(key, fz) ((key).datum)
+
+#define FN_S_ZOMBIE	1
+#define FN_S_ACCESSED	2
+
+struct fib_node {
+	struct fib_node	*fn_next;
+	struct fib_info	*fn_info;
+#define FIB_INFO(f)     ((f)->fn_info)
+	struct fn_key	fn_key;
+	u8		fn_tos;
+	u8		fn_type;
+	u8		fn_scope;
+	u8		fn_state;
+};
 
 #ifdef CONFIG_IP_MULTIPLE_TABLES
 struct fib_rule;
@@ -129,7 +176,6 @@
 	int		(*tb_dump)(struct fib_table *table, struct sk_buff *skb,
 				     struct netlink_callback *cb);
 	int		(*tb_flush)(struct fib_table *table);
-	int		(*tb_seq_show)(struct fib_table *table, struct seq_file *seq);
 	void		(*tb_select_default)(struct fib_table *table,
 					     const struct flowi *flp, struct fib_result *res);
 
@@ -277,5 +323,6 @@
 #endif
 }
 
+extern rwlock_t fib_hash_lock;
 
 #endif  /* _NET_FIB_H */
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	Sat Oct 19 20:26:53 2002
+++ b/net/ipv4/fib_hash.c	Sat Oct 19 20:26:53 2002
@@ -59,55 +59,15 @@
 
 typedef struct {
 	u32	datum;
-} fn_key_t;
-
-typedef struct {
-	u32	datum;
 } fn_hash_idx_t;
 
-struct fib_node
-{
-	struct fib_node		*fn_next;
-	struct fib_info		*fn_info;
-#define FIB_INFO(f)	((f)->fn_info)
-	fn_key_t		fn_key;
-	u8			fn_tos;
-	u8			fn_type;
-	u8			fn_scope;
-	u8			fn_state;
-};
-
-#define FN_S_ZOMBIE	1
-#define FN_S_ACCESSED	2
-
 static int fib_hash_zombies;
 
-struct fn_zone
-{
-	struct fn_zone	*fz_next;	/* Next not empty zone	*/
-	struct fib_node	**fz_hash;	/* Hash table pointer	*/
-	int		fz_nent;	/* Number of entries	*/
-
-	int		fz_divisor;	/* Hash divisor		*/
-	u32		fz_hashmask;	/* (1<<fz_divisor) - 1	*/
-#define FZ_HASHMASK(fz)	((fz)->fz_hashmask)
-
-	int		fz_order;	/* Zone order		*/
-	u32		fz_mask;
-#define FZ_MASK(fz)	((fz)->fz_mask)
-};
-
 /* NOTE. On fast computers evaluation of fz_hashmask and fz_mask
    can be cheaper than memory lookup, so that FZ_* macros are used.
  */
 
-struct fn_hash
-{
-	struct fn_zone	*fn_zones[33];
-	struct fn_zone	*fn_zone_list;
-};
-
-static __inline__ fn_hash_idx_t fn_hash(fn_key_t key, struct fn_zone *fz)
+static __inline__ fn_hash_idx_t fn_hash(struct fn_key key, struct fn_zone *fz)
 {
 	u32 h = ntohl(key.datum)>>(32 - fz->fz_order);
 	h ^= (h>>20);
@@ -118,36 +78,37 @@
 }
 
 #define fz_key_0(key)		((key).datum = 0)
-#define fz_prefix(key,fz)	((key).datum)
 
-static __inline__ fn_key_t fz_key(u32 dst, struct fn_zone *fz)
+static __inline__ struct fn_key fz_key(u32 dst, struct fn_zone *fz)
 {
-	fn_key_t k;
+	struct fn_key k;
 	k.datum = dst & FZ_MASK(fz);
 	return k;
 }
 
-static __inline__ struct fib_node ** fz_chain_p(fn_key_t key, struct fn_zone *fz)
+static __inline__ struct fib_node ** fz_chain_p(struct fn_key key,
+						struct fn_zone *fz)
 {
 	return &fz->fz_hash[fn_hash(key, fz).datum];
 }
 
-static __inline__ struct fib_node * fz_chain(fn_key_t key, struct fn_zone *fz)
+static __inline__ struct fib_node *fz_chain(struct fn_key key,
+					    struct fn_zone *fz)
 {
 	return fz->fz_hash[fn_hash(key, fz).datum];
 }
 
-extern __inline__ int fn_key_eq(fn_key_t a, fn_key_t b)
+extern __inline__ int fn_key_eq(struct fn_key a, struct fn_key b)
 {
 	return a.datum == b.datum;
 }
 
-extern __inline__ int fn_key_leq(fn_key_t a, fn_key_t b)
+extern __inline__ int fn_key_leq(struct fn_key a, struct fn_key b)
 {
 	return a.datum <= b.datum;
 }
 
-static rwlock_t fib_hash_lock = RW_LOCK_UNLOCKED;
+rwlock_t fib_hash_lock = RW_LOCK_UNLOCKED;
 
 #define FZ_MAX_DIVISOR 1024
 
@@ -275,7 +236,7 @@
 	read_lock(&fib_hash_lock);
 	for (fz = t->fn_zone_list; fz; fz = fz->fz_next) {
 		struct fib_node *f;
-		fn_key_t k = fz_key(flp->fl4_dst, fz);
+		struct fn_key k = fz_key(flp->fl4_dst, fz);
 
 		for (f = fz_chain(k, fz); f; f = f->fn_next) {
 			if (!fn_key_eq(k, f->fn_key)) {
@@ -443,7 +404,7 @@
 #ifdef CONFIG_IP_ROUTE_TOS
 	u8 tos = r->rtm_tos;
 #endif
-	fn_key_t key;
+	struct fn_key key;
 	int err;
 
 FTprint("tb(%d)_insert: %d %08x/%d %d %08x\n", tb->tb_id, r->rtm_type, rta->rta_dst ?
@@ -618,7 +579,7 @@
 	struct fib_node **fp, **del_fp, *f;
 	int z = r->rtm_dst_len;
 	struct fn_zone *fz;
-	fn_key_t key;
+	struct fn_key key;
 	int matched;
 #ifdef CONFIG_IP_ROUTE_TOS
 	u8 tos = r->rtm_tos;
@@ -745,37 +706,6 @@
 }
 
 
-#ifdef CONFIG_PROC_FS
-
-static int fn_hash_seq_show(struct fib_table *tb, struct seq_file *seq)
-{
-	struct fn_hash *table = (struct fn_hash *)tb->tb_data;
-	struct fn_zone *fz;
-
-	read_lock(&fib_hash_lock);
-	for (fz = table->fn_zone_list; fz; fz = fz->fz_next) {
-		int i;
-		struct fib_node *f;
-		int maxslot = fz->fz_divisor;
-		struct fib_node **fp = fz->fz_hash;
-
-		if (!fz->fz_nent)
-			continue;
-
-		for (i = 0; i < maxslot; i++, fp++)
-			for (f = *fp; f; f = f->fn_next)
-				fib_node_seq_show(seq, f->fn_type,
-						  f->fn_state & FN_S_ZOMBIE,
-						  FIB_INFO(f),
-						  fz_prefix(f->fn_key, fz),
-						  FZ_MASK(fz));
-	}
-	read_unlock(&fib_hash_lock);
-  	return 0;
-}
-#endif
-
-
 static __inline__ int
 fn_hash_dump_bucket(struct sk_buff *skb, struct netlink_callback *cb,
 		     struct fib_table *tb,
@@ -897,9 +827,6 @@
 	tb->tb_flush = fn_hash_flush;
 	tb->tb_select_default = fn_hash_select_default;
 	tb->tb_dump = fn_hash_dump;
-#ifdef CONFIG_PROC_FS
-	tb->tb_seq_show = fn_hash_seq_show;
-#endif
 	memset(tb->tb_data, 0, sizeof(struct fn_hash));
 	return tb;
 }
diff -Nru a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c	Sat Oct 19 20:26:53 2002
+++ b/net/ipv4/fib_semantics.c	Sat Oct 19 20:26:53 2002
@@ -997,44 +997,3 @@
 	spin_unlock_bh(&fib_multipath_lock);
 }
 #endif
-
-
-#ifdef CONFIG_PROC_FS
-
-static unsigned fib_flag_trans(int type, int dead, u32 mask, struct fib_info *fi)
-{
-	static unsigned type2flags[RTN_MAX+1] = {
-		0, 0, 0, 0, 0, 0, 0, RTF_REJECT, RTF_REJECT, 0, 0, 0
-	};
-	unsigned flags = type2flags[type];
-
-	if (fi && fi->fib_nh->nh_gw)
-		flags |= RTF_GATEWAY;
-	if (mask == 0xFFFFFFFF)
-		flags |= RTF_HOST;
-	if (!dead)
-		flags |= RTF_UP;
-	return flags;
-}
-
-void fib_node_seq_show(struct seq_file *seq, int type, int dead,
-		       struct fib_info *fi, u32 prefix, u32 mask)
-{
-	char bf[128];
-	unsigned flags = fib_flag_trans(type, dead, mask, fi);
-
-	if (fi)
-		snprintf(bf, sizeof(bf),
-			 "%s\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
-			 fi->fib_dev ? fi->fib_dev->name : "*", prefix,
-			 fi->fib_nh->nh_gw, flags, 0, 0, fi->fib_priority,
-			 mask, fi->fib_advmss + 40, fi->fib_window,
-			 fi->fib_rtt >> 3);
-	else
-		snprintf(bf, sizeof(bf),
-			 "*\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
-			 prefix, 0, flags, 0, 0, 0, mask, 0, 0, 0);
-	seq_printf(seq, "%-127s\n", bf);
-}
-
-#endif
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sat Oct 19 20:26:53 2002
+++ b/net/ipv4/ip_proc.c	Sat Oct 19 20:26:53 2002
@@ -250,19 +250,125 @@
 
 /* ------------------------------------------------------------------------ */
 
+struct fib_iter_state {
+	struct fn_zone	*zone;
+	int		bucket;
+	struct fib_node **hash;
+	struct fib_node *node;
+};
+
+static __inline__ struct fib_node *fib_get_first(struct seq_file *seq)
+{
+	struct fib_iter_state* iter = seq->private;
+	struct fn_hash *table = (struct fn_hash *)ip_fib_main_table->tb_data;
+
+	iter->bucket = 0;
+	iter->hash   = NULL;
+	iter->node   = NULL;
+
+	for (iter->zone = table->fn_zone_list; iter->zone;
+	     iter->zone = iter->zone->fz_next) {
+		int maxslot;
+
+		if (!iter->zone->fz_next)
+			continue;
+
+		iter->hash = iter->zone->fz_hash;
+		maxslot = iter->zone->fz_divisor;
+
+		for (iter->bucket = 0; iter->bucket < maxslot;
+		     ++iter->bucket, ++iter->hash) {
+			iter->node = *iter->hash;
+
+			if (iter->node)
+				goto out;
+		}
+	}
+out:
+	return iter->node;
+}
+
+static __inline__ struct fib_node *fib_get_next(struct seq_file *seq)
+{
+	struct fib_iter_state* iter = seq->private;
+
+	if (iter->node)
+		iter->node = iter->node->fn_next;
+
+	if (iter->node)
+		goto out;
+
+	if (!iter->zone)
+		goto out;
+
+	for (;;) {
+		int maxslot;
+
+		maxslot = iter->zone->fz_divisor;
+
+		while (++iter->bucket < maxslot) {
+			iter->node = *++iter->hash;
+
+			if (iter->node)
+				goto out;
+		}
+
+		for (;;) {
+			iter->zone = iter->zone->fz_next;
+
+			if (!iter->zone)
+				goto out;
+			if (iter->zone->fz_next);
+				break;
+		}
+		
+		iter->hash = iter->zone->fz_hash;
+		iter->bucket = 0;
+		iter->node = *iter->hash;
+		if (iter->node)
+			break;
+	}
+out:
+	return iter->node;
+}
+
 static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return *pos ? NULL : (void *)1;
+	void *v = NULL;
+
+	read_lock(&fib_hash_lock);
+	if (ip_fib_main_table)
+		v = *pos ? fib_get_next(seq) : (void *)1;
+	return v;
 }
 
 static void *fib_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return NULL;
+	++*pos;
+	return v == (void *)1 ? fib_get_first(seq) : fib_get_next(seq);
 }
 
 static void fib_seq_stop(struct seq_file *seq, void *v)
 {
+	read_unlock(&fib_hash_lock);
 }
+
+static unsigned fib_flag_trans(int type, int dead, u32 mask, struct fib_info *fi)
+{
+	static unsigned type2flags[RTN_MAX + 1] = {
+		[7] = RTF_REJECT, [8] = RTF_REJECT,
+	};
+	unsigned flags = type2flags[type];
+
+	if (fi && fi->fib_nh->nh_gw)
+		flags |= RTF_GATEWAY;
+	if (mask == 0xFFFFFFFF)
+		flags |= RTF_HOST;
+	if (!dead)
+		flags |= RTF_UP;
+	return flags;
+}
+
 /* 
  *	This outputs /proc/net/route.
  *
@@ -271,12 +377,40 @@
  */
 static int fib_seq_show(struct seq_file *seq, void *v)
 {
-	seq_printf(seq, "%-127s\n", "Iface\tDestination\tGateway "
-			"\tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU"
-			"\tWindow\tIRTT");
-	if (ip_fib_main_table)
-		ip_fib_main_table->tb_seq_show(ip_fib_main_table, seq);
+	struct fib_iter_state* iter;
+	char bf[128];
+	u32 prefix, mask;
+	unsigned flags;
+	struct fib_node *f;
+	struct fib_info *fi;
 
+	if (v == (void *)1) {
+		seq_printf(seq, "%-127s\n", "Iface\tDestination\tGateway "
+			   "\tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU"
+			   "\tWindow\tIRTT");
+		goto out;
+	}
+
+	f	= v;
+	fi	= FIB_INFO(f);
+	iter	= seq->private;
+	prefix	= fz_prefix(f->fn_key, iter->zone);
+	mask	= FZ_MASK(iter->zone);
+	flags	= fib_flag_trans(f->fn_type, f->fn_state & FN_S_ZOMBIE,
+				 mask, fi);
+	if (fi)
+		snprintf(bf, sizeof(bf),
+			 "%s\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
+			 fi->fib_dev ? fi->fib_dev->name : "*", prefix,
+			 fi->fib_nh->nh_gw, flags, 0, 0, fi->fib_priority,
+			 mask, fi->fib_advmss + 40, fi->fib_window,
+			 fi->fib_rtt >> 3);
+	else
+		snprintf(bf, sizeof(bf),
+			 "*\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
+			 prefix, 0, flags, 0, 0, 0, mask, 0, 0, 0);
+	seq_printf(seq, "%-127s\n", bf);
+out:
 	return 0;
 }
 
@@ -421,7 +555,7 @@
 	goto out;
 }
 
-static int arp_seq_release(struct inode *inode, struct file *file)
+static int ip_seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = (struct seq_file *)file->private_data;
 
@@ -433,7 +567,25 @@
 
 static int fib_seq_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &fib_seq_ops);
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct fib_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+       
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &fib_seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq	     = file->private_data;
+	seq->private = s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
 }
 
 static int udp_seq_open(struct inode *inode, struct file *file)
@@ -459,35 +611,25 @@
 	goto out;
 }
 
-static int udp_seq_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = (struct seq_file *)file->private_data;
-
-	kfree(seq->private);
-	seq->private = NULL;
-
-	return seq_release(inode, file);
-}
-
 static struct file_operations arp_seq_fops = {
 	.open           = arp_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= arp_seq_release,
+	.release	= ip_seq_release,
 };
 
 static struct file_operations fib_seq_fops = {
 	.open           = fib_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= seq_release,
+	.release	= ip_seq_release,
 };
 
 static struct file_operations udp_seq_fops = {
 	.open           = udp_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= udp_seq_release,
+	.release	= ip_seq_release,
 };
 
 /* ------------------------------------------------------------------------ */

===================================================================


This BitKeeper patch contains the following changesets:
1.809
## Wrapped with gzip_uu ##


begin 664 bkpatch3780
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
CDWUU#9P/7&SQ5]#^B/K7;#;9[@8]QQH.+?7_Z&V2^W(M````
`
end
