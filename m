Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSLHDBX>; Sat, 7 Dec 2002 22:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSLHDBW>; Sat, 7 Dec 2002 22:01:22 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:20485 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265114AbSLHDBR>; Sat, 7 Dec 2002 22:01:17 -0500
Date: Sun, 8 Dec 2002 01:08:51 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4/route: convert /proc/net/rt_cache to seq_file
Message-ID: <20021208030851.GB12907@conectiva.com.br>
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

Hi David,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/net-2.5

	Now there is just this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.865, 2002-12-08 00:46:09-02:00, acme@conectiva.com.br
  o ipv4/route: convert /proc/net/rt_cache to seq_file


 include/net/route.h |    2 
 net/ipv4/route.c    |  231 ++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 164 insertions(+), 69 deletions(-)


diff -Nru a/include/net/route.h b/include/net/route.h
--- a/include/net/route.h	Sun Dec  8 01:02:46 2002
+++ b/include/net/route.h	Sun Dec  8 01:02:46 2002
@@ -107,7 +107,7 @@
 extern struct ip_rt_acct *ip_rt_acct;
 
 struct in_device;
-extern void		ip_rt_init(void);
+extern int		ip_rt_init(void);
 extern void		ip_rt_redirect(u32 old_gw, u32 dst, u32 new_gw,
 				       u32 src, u8 tos, struct net_device *dev);
 extern void		ip_rt_advice(struct rtable **rp, int advice);
diff -Nru a/net/ipv4/route.c b/net/ipv4/route.c
--- a/net/ipv4/route.c	Sun Dec  8 01:02:46 2002
+++ b/net/ipv4/route.c	Sun Dec  8 01:02:46 2002
@@ -53,6 +53,7 @@
  *	Vladimir V. Ivanov	:	IP rule info (flowid) is really useful.
  *		Marc Boucher	:	routing by fwmark
  *	Robert Olsson		:	Added rt_cache statistics
+ *	Arnaldo C. Melo		:	Convert proc stuff to seq_file
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -208,74 +209,107 @@
 	return (hash ^ (hash >> 8)) & rt_hash_mask;
 }
 
-static int rt_cache_get_info(char *buffer, char **start, off_t offset,
-				int length)
+#ifdef CONFIG_PROC_FS
+struct rt_cache_iter_state {
+	int bucket;
+};
+
+static struct rtable *rt_cache_get_first(struct seq_file *seq)
 {
-	int len = 0;
-	off_t pos = 128;
-	char temp[256];
-	struct rtable *r;
-	int i;
+	struct rtable *r = NULL;
+	struct rt_cache_iter_state *st = seq->private;
 
-	if (offset < 128) {
-		sprintf(buffer, "%-127s\n",
-			"Iface\tDestination\tGateway \tFlags\t\tRefCnt\tUse\t"
-			"Metric\tSource\t\tMTU\tWindow\tIRTT\tTOS\tHHRef\t"
-			"HHUptod\tSpecDst");
-		len = 128;
-  	}
-	
-	for (i = rt_hash_mask; i >= 0; i--) {
-		read_lock_bh(&rt_hash_table[i].lock);
-		for (r = rt_hash_table[i].chain; r; r = r->u.rt_next) {
-			/*
-			 *	Spin through entries until we are ready
-			 */
-			pos += 128;
+	for (st->bucket = rt_hash_mask; st->bucket >= 0; --st->bucket) {
+		read_lock_bh(&rt_hash_table[st->bucket].lock);
+		r = rt_hash_table[st->bucket].chain;
+		if (r)
+			break;
+		read_unlock_bh(&rt_hash_table[st->bucket].lock);
+	}
+	return r;
+}
 
-			if (pos <= offset) {
-				len = 0;
-				continue;
-			}
-			sprintf(temp, "%s\t%08lX\t%08lX\t%8X\t%d\t%u\t%d\t"
-				"%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
-				r->u.dst.dev ? r->u.dst.dev->name : "*",
-				(unsigned long)r->rt_dst,
-				(unsigned long)r->rt_gateway,
-				r->rt_flags,
-				atomic_read(&r->u.dst.__refcnt),
-				r->u.dst.__use,
-				0,
-				(unsigned long)r->rt_src,
-				(dst_metric(&r->u.dst, RTAX_ADVMSS) ?
-				 (int) dst_metric(&r->u.dst, RTAX_ADVMSS) + 40 : 0),
-				dst_metric(&r->u.dst, RTAX_WINDOW),
-				(int)((dst_metric(&r->u.dst, RTAX_RTT) >> 3)
-				      + dst_metric(&r->u.dst, RTAX_RTTVAR)),
-				r->fl.fl4_tos,
-				r->u.dst.hh ?
-					atomic_read(&r->u.dst.hh->hh_refcnt) :
-					-1,
-				r->u.dst.hh ?
-			       		(r->u.dst.hh->hh_output ==
-					 dev_queue_xmit) : 0,
-				r->rt_spec_dst);
-			sprintf(buffer + len, "%-127s\n", temp);
-			len += 128;
-			if (pos >= offset+length) {
-				read_unlock_bh(&rt_hash_table[i].lock);
-				goto done;
-			}
-		}
-		read_unlock_bh(&rt_hash_table[i].lock);
-        }
+static struct rtable *rt_cache_get_next(struct seq_file *seq, struct rtable *r)
+{
+	struct rt_cache_iter_state *st = seq->private;
 
-done:
-  	*start = buffer + len - (pos - offset);
-  	len = pos - offset;
-  	if (len > length)
-  		len = length;
-  	return len;
+	r = r->u.rt_next;
+	while (!r) {
+		read_unlock_bh(&rt_hash_table[st->bucket].lock);
+		if (--st->bucket < 0)
+			break;
+		read_lock_bh(&rt_hash_table[st->bucket].lock);
+		r = rt_hash_table[st->bucket].chain;
+	}
+	return r;
+}
+
+static struct rtable *rt_cache_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct rtable *r = rt_cache_get_first(seq);
+
+	if (r)
+		while (pos && (r = rt_cache_get_next(seq, r)))
+			--pos;
+	return pos ? NULL : r;
+}
+
+static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos ? rt_cache_get_idx(seq, *pos) : (void *)1;
+}
+
+static void *rt_cache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct rtable *r = NULL;
+
+	if (v == (void *)1)
+		r = rt_cache_get_first(seq);
+	else
+		r = rt_cache_get_next(seq, v);
+	++*pos;
+	return r;
+}
+
+static void rt_cache_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v && v != (void *)1) {
+		struct rt_cache_iter_state *st = seq->private;
+
+		read_unlock_bh(&rt_hash_table[st->bucket].lock);
+	}
+}
+
+static int rt_cache_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == (void *)1)
+		seq_printf(seq, "%-127s\n",
+			   "Iface\tDestination\tGateway \tFlags\t\tRefCnt\tUse\t"
+			   "Metric\tSource\t\tMTU\tWindow\tIRTT\tTOS\tHHRef\t"
+			   "HHUptod\tSpecDst");
+	else {
+		struct rtable *r = v;
+		char temp[256];
+
+		sprintf(temp, "%s\t%08lX\t%08lX\t%8X\t%d\t%u\t%d\t"
+			      "%08lX\t%d\t%u\t%u\t%02X\t%d\t%1d\t%08X",
+			r->u.dst.dev ? r->u.dst.dev->name : "*",
+			(unsigned long)r->rt_dst, (unsigned long)r->rt_gateway,
+			r->rt_flags, atomic_read(&r->u.dst.__refcnt),
+			r->u.dst.__use, 0, (unsigned long)r->rt_src,
+			(dst_metric(&r->u.dst, RTAX_ADVMSS) ?
+			     (int)dst_metric(&r->u.dst, RTAX_ADVMSS) + 40 : 0),
+			dst_metric(&r->u.dst, RTAX_WINDOW),
+			(int)((dst_metric(&r->u.dst, RTAX_RTT) >> 3) +
+			      dst_metric(&r->u.dst, RTAX_RTTVAR)),
+			r->fl.fl4_tos,
+			r->u.dst.hh ? atomic_read(&r->u.dst.hh->hh_refcnt) : -1,
+			r->u.dst.hh ? (r->u.dst.hh->hh_output ==
+				       dev_queue_xmit) : 0,
+			r->rt_spec_dst);
+		seq_printf(seq, "%-127s\n", temp);
+        }
+  	return 0;
 }
 
 static int rt_cache_stat_get_info(char *buffer, char **start, off_t offset, int length)
@@ -316,6 +350,59 @@
 	*start = buffer + offset;
   	return len;
 }
+
+static struct seq_operations rt_cache_seq_ops = {
+	.start  = rt_cache_seq_start,
+	.next   = rt_cache_seq_next,
+	.stop   = rt_cache_seq_stop,
+	.show   = rt_cache_seq_show,
+};
+
+static int rt_cache_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct rt_cache_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+
+	if (!s)
+		goto out;
+	rc = seq_open(file, &rt_cache_seq_ops);
+	if (rc)
+		goto out_kfree;
+	seq          = file->private_data;
+	seq->private = s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
+
+static struct file_operations rt_cache_seq_fops = {
+	.open	 = rt_cache_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = ip_seq_release,
+};
+
+int __init rt_cache_proc_init(void)
+{
+	int rc = 0;
+	struct proc_dir_entry *p = create_proc_entry("rt_cache", S_IRUGO,
+						     proc_net);
+	if (p)
+		p->proc_fops = &rt_cache_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+void __init rt_cache_proc_exit(void)
+{
+	remove_proc_entry("rt_cache", proc_net);
+}
+#endif /* CONFIG_PROC_FS */
   
 static __inline__ void rt_free(struct rtable *rt)
 {
@@ -2456,6 +2543,7 @@
 /* IP route accounting ptr for this logical cpu number. */
 #define IP_RT_ACCT_CPU(i) (ip_rt_acct + i * 256)
 
+#ifdef CONFIG_PROC_FS
 static int ip_rt_acct_read(char *buffer, char **start, off_t offset,
 			   int length, int *eof, void *data)
 {
@@ -2488,11 +2576,12 @@
 	}
 	return length;
 }
-#endif
+#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_NET_CLS_ROUTE */
 
-void __init ip_rt_init(void)
+int __init ip_rt_init(void)
 {
-	int i, order, goal;
+	int i, order, goal, rc = 0;
 
 #ifdef CONFIG_NET_CLS_ROUTE
 	for (order = 0;
@@ -2560,10 +2649,16 @@
 					ip_rt_gc_interval;
 	add_timer(&rt_periodic_timer);
 
-	proc_net_create ("rt_cache", 0, rt_cache_get_info);
+	if (rt_cache_proc_init())
+		goto out_enomem;
 	proc_net_create ("rt_cache_stat", 0, rt_cache_stat_get_info);
 #ifdef CONFIG_NET_CLS_ROUTE
 	create_proc_read_entry("net/rt_acct", 0, 0, ip_rt_acct_read, NULL);
 #endif
 	xfrm_init();
+out:
+	return rc;
+out_enomem:
+	rc = -ENOMEM;
+	goto out;
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.865
## Wrapped with gzip_uu ##


begin 664 bkpatch25036
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
;Q1?AZ,N]3Z;CW5O]UM`L]5;^%W`']E1U%P``
`
end
