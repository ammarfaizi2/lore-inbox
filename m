Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJTGEp>; Sun, 20 Oct 2002 02:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSJTGEp>; Sun, 20 Oct 2002 02:04:45 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:61706 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262310AbSJTGEh>; Sun, 20 Oct 2002 02:04:37 -0400
Date: Sun, 20 Oct 2002 03:10:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: only produce one record per fib_seq_sholl call
Message-ID: <20021020061031.GA15857@conectiva.com.br>
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

	Here it is, fib code fixed and moved back to fib implementation,
please consider pulling from:

master.kernel.org:/home/acme/BK/net-2.5

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.809, 2002-10-20 03:03:19-03:00, acme@conectiva.com.br
  o ipv4: only produce one record per fib_seq_sholl call
  
  Also move the fib code back to the fib implementation, and that will
  now be done for udp and arp, then finally burying the ip_proc stillborn.


 include/net/ip.h         |    1 
 include/net/ip_fib.h     |    2 
 net/ipv4/af_inet.c       |    1 
 net/ipv4/fib_hash.c      |  257 ++++++++++++++++++++++++++++++++++++++++-------
 net/ipv4/fib_semantics.c |   41 -------
 net/ipv4/ip_proc.c       |   74 -------------
 6 files changed, 229 insertions(+), 147 deletions(-)


diff -Nru a/include/net/ip.h b/include/net/ip.h
--- a/include/net/ip.h	Sun Oct 20 03:06:50 2002
+++ b/include/net/ip.h	Sun Oct 20 03:06:50 2002
@@ -282,6 +282,7 @@
 extern void	ip_local_error(struct sock *sk, int err, u32 daddr, u16 dport,
 			       u32 info);
 
+extern int ip_seq_release(struct inode *inode, struct file *file);
 extern int ipv4_proc_init(void);
 
 #endif	/* _IP_H */
diff -Nru a/include/net/ip_fib.h b/include/net/ip_fib.h
--- a/include/net/ip_fib.h	Sun Oct 20 03:06:50 2002
+++ b/include/net/ip_fib.h	Sun Oct 20 03:06:50 2002
@@ -129,7 +129,6 @@
 	int		(*tb_dump)(struct fib_table *table, struct sk_buff *skb,
 				     struct netlink_callback *cb);
 	int		(*tb_flush)(struct fib_table *table);
-	int		(*tb_seq_show)(struct fib_table *table, struct seq_file *seq);
 	void		(*tb_select_default)(struct fib_table *table,
 					     const struct flowi *flp, struct fib_result *res);
 
@@ -277,5 +276,6 @@
 #endif
 }
 
+extern int fib_proc_init(void);
 
 #endif  /* _NET_FIB_H */
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Sun Oct 20 03:06:50 2002
+++ b/net/ipv4/af_inet.c	Sun Oct 20 03:06:50 2002
@@ -1218,6 +1218,7 @@
 #endif
 
 	ipv4_proc_init();
+	fib_proc_init();
 	return 0;
 }
 
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	Sun Oct 20 03:06:50 2002
+++ b/net/ipv4/fib_hash.c	Sun Oct 20 03:06:50 2002
@@ -745,37 +745,6 @@
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
@@ -897,9 +866,229 @@
 	tb->tb_flush = fn_hash_flush;
 	tb->tb_select_default = fn_hash_select_default;
 	tb->tb_dump = fn_hash_dump;
-#ifdef CONFIG_PROC_FS
-	tb->tb_seq_show = fn_hash_seq_show;
-#endif
 	memset(tb->tb_data, 0, sizeof(struct fn_hash));
 	return tb;
 }
+
+/* ------------------------------------------------------------------------ */
+#ifdef CONFIG_PROC_FS
+
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
+static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	void *v = NULL;
+
+	read_lock(&fib_hash_lock);
+	if (ip_fib_main_table)
+		v = *pos ? fib_get_next(seq) : (void *)1;
+	return v;
+}
+
+static void *fib_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return v == (void *)1 ? fib_get_first(seq) : fib_get_next(seq);
+}
+
+static void fib_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&fib_hash_lock);
+}
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
+/* 
+ *	This outputs /proc/net/route.
+ *
+ *	It always works in backward compatibility mode.
+ *	The format of the file is not supposed to be changed.
+ */
+static int fib_seq_show(struct seq_file *seq, void *v)
+{
+	struct fib_iter_state* iter;
+	char bf[128];
+	u32 prefix, mask;
+	unsigned flags;
+	struct fib_node *f;
+	struct fib_info *fi;
+
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
+	return 0;
+}
+
+static struct seq_operations fib_seq_ops = {
+	.start  = fib_seq_start,
+	.next   = fib_seq_next,
+	.stop   = fib_seq_stop,
+	.show   = fib_seq_show,
+};
+
+static int fib_seq_open(struct inode *inode, struct file *file)
+{
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
+}
+
+static struct file_operations fib_seq_fops = {
+	.open           = fib_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= ip_seq_release,
+};
+
+int __init fib_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = 0;
+
+	p = create_proc_entry("route", S_IRUGO, proc_net);
+	if (p)
+		p->proc_fops = &fib_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+#else /* CONFIG_PROC_FS */
+int __init fib_proc_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c	Sun Oct 20 03:06:50 2002
+++ b/net/ipv4/fib_semantics.c	Sun Oct 20 03:06:50 2002
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
--- a/net/ipv4/ip_proc.c	Sun Oct 20 03:06:50 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 20 03:06:50 2002
@@ -21,7 +21,6 @@
 #include <net/udp.h>
 #include <linux/rtnetlink.h>
 #include <linux/route.h>
-#include <net/ip_fib.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 
@@ -250,38 +249,6 @@
 
 /* ------------------------------------------------------------------------ */
 
-static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	return *pos ? NULL : (void *)1;
-}
-
-static void *fib_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	return NULL;
-}
-
-static void fib_seq_stop(struct seq_file *seq, void *v)
-{
-}
-/* 
- *	This outputs /proc/net/route.
- *
- *	It always works in backward compatibility mode.
- *	The format of the file is not supposed to be changed.
- */
-static int fib_seq_show(struct seq_file *seq, void *v)
-{
-	seq_printf(seq, "%-127s\n", "Iface\tDestination\tGateway "
-			"\tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU"
-			"\tWindow\tIRTT");
-	if (ip_fib_main_table)
-		ip_fib_main_table->tb_seq_show(ip_fib_main_table, seq);
-
-	return 0;
-}
-
-/* ------------------------------------------------------------------------ */
-
 struct udp_iter_state {
 	int bucket;
 };
@@ -384,13 +351,6 @@
 	.show   = arp_seq_show,
 };
 
-static struct seq_operations fib_seq_ops = {
-	.start  = fib_seq_start,
-	.next   = fib_seq_next,
-	.stop   = fib_seq_stop,
-	.show   = fib_seq_show,
-};
-
 static struct seq_operations udp_seq_ops = {
 	.start  = udp_seq_start,
 	.next   = udp_seq_next,
@@ -421,7 +381,7 @@
 	goto out;
 }
 
-static int arp_seq_release(struct inode *inode, struct file *file)
+int ip_seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq = (struct seq_file *)file->private_data;
 
@@ -431,11 +391,6 @@
 	return seq_release(inode, file);
 }
 
-static int fib_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &fib_seq_ops);
-}
-
 static int udp_seq_open(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq;
@@ -459,35 +414,18 @@
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
-};
-
-static struct file_operations fib_seq_fops = {
-	.open           = fib_seq_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
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
@@ -522,14 +460,8 @@
 		goto out_arp;
 	p->proc_fops = &arp_seq_fops;
 
-	p = create_proc_entry("route", S_IRUGO, proc_net);
-	if (!p)
-		goto out_route;
-	p->proc_fops = &fib_seq_fops;
 out:
 	return rc;
-out_route:
-	remove_proc_entry("route", proc_net);
 out_arp:
 	remove_proc_entry("udp", proc_net);
 out_udp:

===================================================================


This BitKeeper patch contains the following changesets:
1.809
## Wrapped with gzip_uu ##


begin 664 bkpatch30901
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
*_P=QF-=-*R@`````
`
end
