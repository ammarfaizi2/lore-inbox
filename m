Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbSJMWOR>; Sun, 13 Oct 2002 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSJMWOQ>; Sun, 13 Oct 2002 18:14:16 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:13071 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261712AbSJMWOG>; Sun, 13 Oct 2002 18:14:06 -0400
Date: Sun, 13 Oct 2002 20:19:50 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/route to seq_file
Message-ID: <20021013221950.GC9330@conectiva.com.br>
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

master.kernel.org:/home/acme/BK/ip-2.5

	Now there is just this outstanding changeset there.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.834, 2002-10-13 20:14:27-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/route to seq_file


 include/net/ip_fib.h     |   25 ++++++++---------
 net/ipv4/fib_frontend.c  |   68 +++++++----------------------------------------
 net/ipv4/fib_hash.c      |   37 +++++++------------------
 net/ipv4/fib_semantics.c |   30 ++++++++++----------
 net/ipv4/ip_proc.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 110 deletions(-)


diff -Nru a/include/net/ip_fib.h b/include/net/ip_fib.h
--- a/include/net/ip_fib.h	Sun Oct 13 20:14:59 2002
+++ b/include/net/ip_fib.h	Sun Oct 13 20:14:59 2002
@@ -18,6 +18,7 @@
 
 #include <linux/config.h>
 #include <net/flow.h>
+#include <linux/seq_file.h>
 
 struct kern_rta
 {
@@ -128,8 +129,7 @@
 	int		(*tb_dump)(struct fib_table *table, struct sk_buff *skb,
 				     struct netlink_callback *cb);
 	int		(*tb_flush)(struct fib_table *table);
-	int		(*tb_get_info)(struct fib_table *table, char *buf,
-				       int first, int count);
+	int		(*tb_seq_show)(struct fib_table *table, struct seq_file *seq);
 	void		(*tb_select_default)(struct fib_table *table,
 					     const struct flowi *flp, struct fib_result *res);
 
@@ -138,14 +138,14 @@
 
 #ifndef CONFIG_IP_MULTIPLE_TABLES
 
-extern struct fib_table *local_table;
-extern struct fib_table *main_table;
+extern struct fib_table *ip_fib_local_table;
+extern struct fib_table *ip_fib_main_table;
 
 static inline struct fib_table *fib_get_table(int id)
 {
 	if (id != RT_TABLE_LOCAL)
-		return main_table;
-	return local_table;
+		return ip_fib_main_table;
+	return ip_fib_local_table;
 }
 
 static inline struct fib_table *fib_new_table(int id)
@@ -155,8 +155,8 @@
 
 static inline int fib_lookup(const struct flowi *flp, struct fib_result *res)
 {
-	if (local_table->tb_lookup(local_table, flp, res) &&
-	    main_table->tb_lookup(main_table, flp, res))
+	if (ip_fib_local_table->tb_lookup(ip_fib_local_table, flp, res) &&
+	    ip_fib_main_table->tb_lookup(ip_fib_main_table, flp, res))
 		return -ENETUNREACH;
 	return 0;
 }
@@ -164,12 +164,12 @@
 static inline void fib_select_default(const struct flowi *flp, struct fib_result *res)
 {
 	if (FIB_RES_GW(*res) && FIB_RES_NH(*res).nh_scope == RT_SCOPE_LINK)
-		main_table->tb_select_default(main_table, flp, res);
+		ip_fib_main_table->tb_select_default(ip_fib_main_table, flp, res);
 }
 
 #else /* CONFIG_IP_MULTIPLE_TABLES */
-#define local_table (fib_tables[RT_TABLE_LOCAL])
-#define main_table (fib_tables[RT_TABLE_MAIN])
+#define ip_fib_local_table (fib_tables[RT_TABLE_LOCAL])
+#define ip_fib_main_table (fib_tables[RT_TABLE_MAIN])
 
 extern struct fib_table * fib_tables[RT_TABLE_MAX+1];
 extern int fib_lookup(const struct flowi *flp, struct fib_result *res);
@@ -222,7 +222,8 @@
 extern int fib_sync_up(struct net_device *dev);
 extern int fib_convert_rtentry(int cmd, struct nlmsghdr *nl, struct rtmsg *rtm,
 			       struct kern_rta *rta, struct rtentry *r);
-extern void fib_node_get_info(int type, int dead, struct fib_info *fi, u32 prefix, u32 mask, char *buffer);
+extern void fib_node_seq_show(struct seq_file *seq, int type, int dead,
+			      struct fib_info *fi, u32 prefix, u32 mask);
 extern u32  __fib_res_prefsrc(struct fib_result *res);
 
 /* Exported by fib_hash.c */
diff -Nru a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
--- a/net/ipv4/fib_frontend.c	Sun Oct 13 20:14:59 2002
+++ b/net/ipv4/fib_frontend.c	Sun Oct 13 20:14:59 2002
@@ -31,7 +31,6 @@
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
-#include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/init.h>
@@ -51,8 +50,8 @@
 
 #define RT_TABLE_MIN RT_TABLE_MAIN
 
-struct fib_table *local_table;
-struct fib_table *main_table;
+struct fib_table *ip_fib_local_table;
+struct fib_table *ip_fib_main_table;
 
 #else
 
@@ -88,56 +87,14 @@
 		flushed += tb->tb_flush(tb);
 	}
 #else /* CONFIG_IP_MULTIPLE_TABLES */
-	flushed += main_table->tb_flush(main_table);
-	flushed += local_table->tb_flush(local_table);
+	flushed += ip_fib_main_table->tb_flush(ip_fib_main_table);
+	flushed += ip_fib_local_table->tb_flush(ip_fib_local_table);
 #endif /* CONFIG_IP_MULTIPLE_TABLES */
 
 	if (flushed)
 		rt_cache_flush(-1);
 }
 
-
-#ifdef CONFIG_PROC_FS
-
-/* 
- *	Called from the PROCfs module. This outputs /proc/net/route.
- *
- *	It always works in backward compatibility mode.
- *	The format of the file is not supposed to be changed.
- */
- 
-static int
-fib_get_procinfo(char *buffer, char **start, off_t offset, int length)
-{
-	int first = offset/128;
-	char *ptr = buffer;
-	int count = (length+127)/128;
-	int len;
-
-	*start = buffer + offset%128;
-	
-	if (--first < 0) {
-		sprintf(buffer, "%-127s\n", "Iface\tDestination\tGateway \tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU\tWindow\tIRTT");
-		--count;
-		ptr += 128;
-		first = 0;
-  	}
-
-	if (main_table && count > 0) {
-		int n = main_table->tb_get_info(main_table, ptr, first, count);
-		count -= n;
-		ptr += n*128;
-	}
-	len = ptr - *start;
-	if (len >= length)
-		return length;
-	if (len >= 0)
-		return len;
-	return 0;
-}
-
-#endif /* CONFIG_PROC_FS */
-
 /*
  *	Find the first device with a given source address.
  */
@@ -152,9 +109,9 @@
 	res.r = NULL;
 #endif
 
-	if (!local_table || local_table->tb_lookup(local_table, &fl, &res)) {
+	if (!ip_fib_local_table ||
+	    ip_fib_local_table->tb_lookup(ip_fib_local_table, &fl, &res))
 		return NULL;
-	}
 	if (res.type != RTN_LOCAL)
 		goto out;
 	dev = FIB_RES_DEV(res);
@@ -181,9 +138,10 @@
 	res.r = NULL;
 #endif
 	
-	if (local_table) {
+	if (ip_fib_local_table) {
 		ret = RTN_UNICAST;
-		if (local_table->tb_lookup(local_table, &fl, &res) == 0) {
+		if (!ip_fib_local_table->tb_lookup(ip_fib_local_table,
+						   &fl, &res)) {
 			ret = res.type;
 			fib_res_put(&res);
 		}
@@ -636,13 +594,9 @@
 
 void __init ip_fib_init(void)
 {
-#ifdef CONFIG_PROC_FS
-	proc_net_create("route",0,fib_get_procinfo);
-#endif		/* CONFIG_PROC_FS */
-
 #ifndef CONFIG_IP_MULTIPLE_TABLES
-	local_table = fib_hash_init(RT_TABLE_LOCAL);
-	main_table = fib_hash_init(RT_TABLE_MAIN);
+	ip_fib_local_table = fib_hash_init(RT_TABLE_LOCAL);
+	ip_fib_main_table  = fib_hash_init(RT_TABLE_MAIN);
 #else
 	fib_rules_init();
 #endif
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	Sun Oct 13 20:14:59 2002
+++ b/net/ipv4/fib_hash.c	Sun Oct 13 20:14:59 2002
@@ -747,46 +747,31 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int fn_hash_get_info(struct fib_table *tb, char *buffer, int first, int count)
+static int fn_hash_seq_show(struct fib_table *tb, struct seq_file *seq)
 {
-	struct fn_hash *table = (struct fn_hash*)tb->tb_data;
+	struct fn_hash *table = (struct fn_hash *)tb->tb_data;
 	struct fn_zone *fz;
-	int pos = 0;
-	int n = 0;
 
 	read_lock(&fib_hash_lock);
-	for (fz=table->fn_zone_list; fz; fz = fz->fz_next) {
+	for (fz = table->fn_zone_list; fz; fz = fz->fz_next) {
 		int i;
 		struct fib_node *f;
 		int maxslot = fz->fz_divisor;
 		struct fib_node **fp = fz->fz_hash;
 
-		if (fz->fz_nent == 0)
+		if (!fz->fz_nent)
 			continue;
 
-		if (pos + fz->fz_nent <= first) {
-			pos += fz->fz_nent;
-			continue;
-		}
-
-		for (i=0; i < maxslot; i++, fp++) {
-			for (f = *fp; f; f = f->fn_next) {
-				if (++pos <= first)
-					continue;
-				fib_node_get_info(f->fn_type,
-						  f->fn_state&FN_S_ZOMBIE,
+		for (i = 0; i < maxslot; i++, fp++)
+			for (f = *fp; f; f = f->fn_next)
+				fib_node_seq_show(seq, f->fn_type,
+						  f->fn_state & FN_S_ZOMBIE,
 						  FIB_INFO(f),
 						  fz_prefix(f->fn_key, fz),
-						  FZ_MASK(fz), buffer);
-				buffer += 128;
-				if (++n >= count)
-					goto out;
-			}
-		}
+						  FZ_MASK(fz));
 	}
-out:
 	read_unlock(&fib_hash_lock);
-  	return n;
+  	return 0;
 }
 #endif
 
@@ -913,7 +898,7 @@
 	tb->tb_select_default = fn_hash_select_default;
 	tb->tb_dump = fn_hash_dump;
 #ifdef CONFIG_PROC_FS
-	tb->tb_get_info = fn_hash_get_info;
+	tb->tb_seq_show = fn_hash_seq_show;
 #endif
 	memset(tb->tb_data, 0, sizeof(struct fn_hash));
 	return tb;
diff -Nru a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c	Sun Oct 13 20:14:59 2002
+++ b/net/ipv4/fib_semantics.c	Sun Oct 13 20:14:59 2002
@@ -1017,24 +1017,24 @@
 	return flags;
 }
 
-void fib_node_get_info(int type, int dead, struct fib_info *fi, u32 prefix, u32 mask, char *buffer)
+void fib_node_seq_show(struct seq_file *seq, int type, int dead,
+		       struct fib_info *fi, u32 prefix, u32 mask)
 {
-	int len;
+	char bf[128];
 	unsigned flags = fib_flag_trans(type, dead, mask, fi);
 
-	if (fi) {
-		len = sprintf(buffer, "%s\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
-			      fi->fib_dev ? fi->fib_dev->name : "*", prefix,
-			      fi->fib_nh->nh_gw, flags, 0, 0, fi->fib_priority,
-			      mask, fi->fib_advmss+40, fi->fib_window, fi->fib_rtt>>3);
-	} else {
-		len = sprintf(buffer, "*\t%08X\t%08X\t%04X\t%d\t%u\t%d\t%08X\t%d\t%u\t%u",
-			      prefix, 0,
-			      flags, 0, 0, 0,
-			      mask, 0, 0, 0);
-	}
-	memset(buffer+len, ' ', 127-len);
-	buffer[127] = '\n';
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
 }
 
 #endif
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sun Oct 13 20:14:59 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 13 20:14:59 2002
@@ -18,6 +18,9 @@
 #include <linux/netdevice.h>
 #include <net/neighbour.h>
 #include <net/arp.h>
+#include <linux/rtnetlink.h>
+#include <linux/route.h>
+#include <net/ip_fib.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 
@@ -30,6 +33,8 @@
 
 #ifdef CONFIG_PROC_FS
 #ifdef CONFIG_AX25
+
+/* ------------------------------------------------------------------------ */
 /*
  *	ax25 -> ASCII conversion
  */
@@ -159,6 +164,40 @@
 	return 0;
 }
 
+/* ------------------------------------------------------------------------ */
+
+static void *fib_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos ? NULL : (void *)1;
+}
+
+static void *fib_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static void fib_seq_stop(struct seq_file *seq, void *v)
+{
+}
+/* 
+ *	This outputs /proc/net/route.
+ *
+ *	It always works in backward compatibility mode.
+ *	The format of the file is not supposed to be changed.
+ */
+static int fib_seq_show(struct seq_file *seq, void *v)
+{
+	seq_printf(seq, "%-127s\n", "Iface\tDestination\tGateway "
+			"\tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU"
+			"\tWindow\tIRTT");
+	if (ip_fib_main_table)
+		ip_fib_main_table->tb_seq_show(ip_fib_main_table, seq);
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------------ */
+
 struct seq_operations arp_seq_ops = {
 	.start  = arp_seq_start,
 	.next   = arp_seq_next,
@@ -166,11 +205,23 @@
 	.show   = arp_seq_show,
 };
 
+struct seq_operations fib_seq_ops = {
+	.start  = fib_seq_start,
+	.next   = fib_seq_next,
+	.stop   = fib_seq_stop,
+	.show   = fib_seq_show,
+};
+
 static int arp_seq_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &arp_seq_ops);
 }
 
+static int fib_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &fib_seq_ops);
+}
+
 static struct file_operations arp_seq_fops = {
 	.open           = arp_seq_open,
 	.read           = seq_read,
@@ -178,6 +229,15 @@
 	.release	= seq_release,
 };
 
+static struct file_operations fib_seq_fops = {
+	.open           = fib_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= seq_release,
+};
+
+/* ------------------------------------------------------------------------ */
+
 int __init ipv4_proc_init(void)
 {
 	struct proc_dir_entry *p;
@@ -205,8 +265,15 @@
 	if (!p)
 		goto out_arp;
 	p->proc_fops = &arp_seq_fops;
+
+	p = create_proc_entry("route", S_IRUGO, proc_net);
+	if (!p)
+		goto out_route;
+	p->proc_fops = &fib_seq_fops;
 out:
 	return rc;
+out_route:
+	remove_proc_entry("route", proc_net);
 out_arp:
 	proc_net_remove("udp");
 out_udp:

===================================================================


This BitKeeper patch contains the following changesets:
1.834
## Wrapped with gzip_uu ##


begin 664 bkpatch30341
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
(5S2"U?@>````
`
end
