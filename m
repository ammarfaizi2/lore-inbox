Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbSJTQLr>; Sun, 20 Oct 2002 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJTQLr>; Sun, 20 Oct 2002 12:11:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:56588 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263181AbSJTQLk>; Sun, 20 Oct 2002 12:11:40 -0400
Date: Sun, 20 Oct 2002 13:17:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] move /proc/net/udp support back to net/ipv4/udp.c
Message-ID: <20021020161738.GG15857@conectiva.com.br>
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

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

Best regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.810, 2002-10-20 13:15:42-03:00, acme@conectiva.com.br
  o ipv4: move /proc/net/udp support back to net/ipv4/udp.c


 include/net/udp.h  |    2 
 net/ipv4/af_inet.c |    1 
 net/ipv4/ip_proc.c |  142 -----------------------------------------------
 net/ipv4/udp.c     |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 162 insertions(+), 143 deletions(-)


diff -Nru a/include/net/udp.h b/include/net/udp.h
--- a/include/net/udp.h	Sun Oct 20 13:16:16 2002
+++ b/include/net/udp.h	Sun Oct 20 13:16:16 2002
@@ -76,4 +76,6 @@
 #define UDP_INC_STATS_BH(field)		SNMP_INC_STATS_BH(udp_statistics, field)
 #define UDP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udp_statistics, field)
 
+extern int udp_proc_init(void);
+
 #endif	/* _UDP_H */
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Sun Oct 20 13:16:16 2002
+++ b/net/ipv4/af_inet.c	Sun Oct 20 13:16:16 2002
@@ -1218,6 +1218,7 @@
 #endif
 
 	ipv4_proc_init();
+	udp_proc_init();
 	fib_proc_init();
 	return 0;
 }
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sun Oct 20 13:16:16 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 20 13:16:16 2002
@@ -18,9 +18,6 @@
 #include <linux/netdevice.h>
 #include <net/neighbour.h>
 #include <net/arp.h>
-#include <net/udp.h>
-#include <linux/rtnetlink.h>
-#include <linux/route.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 
@@ -249,101 +246,6 @@
 
 /* ------------------------------------------------------------------------ */
 
-struct udp_iter_state {
-	int bucket;
-};
-
-static __inline__ struct sock *udp_get_bucket(struct seq_file *seq, loff_t *pos)
-{
-	int i;
-	struct sock *sk = NULL;
-	loff_t l = *pos;
-	struct udp_iter_state *state = seq->private;
-
-	for (; state->bucket < UDP_HTABLE_SIZE; ++state->bucket)
-		for (i = 0, sk = udp_hash[state->bucket]; sk; ++i, sk = sk->next) {
-			if (sk->family != PF_INET)
-				continue;
-			if (l--)
-				continue;
-			*pos = i;
-			goto out;
-		}
-out:
-	return sk;
-}
-
-static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	read_lock(&udp_hash_lock);
-	return *pos ? udp_get_bucket(seq, pos) : (void *)1;
-}
-
-static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct sock *sk;
-	struct udp_iter_state *state;
-
-	if (v == (void *)1) {
-		sk = udp_get_bucket(seq, pos);
-		goto out;
-	}
-
-	sk = v;
-	sk = sk->next;
-	if (sk) 
-		goto out;
-
-	state = seq->private;
-	if (++state->bucket >= UDP_HTABLE_SIZE) 
-		goto out;
-
-	*pos = 0;
-	sk = udp_get_bucket(seq, pos);
-out:
-	++*pos;
-	return sk;
-}
-
-static void udp_seq_stop(struct seq_file *seq, void *v)
-{
-	read_unlock(&udp_hash_lock);
-}
-
-static void udp_format_sock(struct sock *sp, char *tmpbuf, int bucket)
-{
-	struct inet_opt *inet = inet_sk(sp);
-	unsigned int dest = inet->daddr;
-	unsigned int src  = inet->rcv_saddr;
-	__u16 destp	  = ntohs(inet->dport);
-	__u16 srcp	  = ntohs(inet->sport);
-
-	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
-		bucket, src, srcp, dest, destp, sp->state, 
-		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
-		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
-		atomic_read(&sp->refcnt), sp);
-}
-
-static int udp_seq_show(struct seq_file *seq, void *v)
-{
-	if (v == (void *)1)
-		seq_printf(seq, "%-127s\n",
-			   "  sl  local_address rem_address   st tx_queue "
-			   "rx_queue tr tm->when retrnsmt   uid  timeout "
-			   "inode");
-	else {
-		char tmpbuf[129];
-		struct udp_iter_state *state = seq->private;
-
-		udp_format_sock(v, tmpbuf, state->bucket);
-		seq_printf(seq, "%-127s\n", tmpbuf);
-	}
-	return 0;
-}
-/* ------------------------------------------------------------------------ */
-
 static struct seq_operations arp_seq_ops = {
 	.start  = arp_seq_start,
 	.next   = arp_seq_next,
@@ -351,13 +253,6 @@
 	.show   = arp_seq_show,
 };
 
-static struct seq_operations udp_seq_ops = {
-	.start  = udp_seq_start,
-	.next   = udp_seq_next,
-	.stop   = udp_seq_stop,
-	.show   = udp_seq_show,
-};
-
 static int arp_seq_open(struct inode *inode, struct file *file)
 {
 	struct seq_file *seq;
@@ -391,29 +286,6 @@
 	return seq_release(inode, file);
 }
 
-static int udp_seq_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int rc = -ENOMEM;
-	struct udp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
-       
-	if (!s)
-		goto out;
-
-	rc = seq_open(file, &udp_seq_ops);
-	if (rc)
-		goto out_kfree;
-
-	seq	     = file->private_data;
-	seq->private = s;
-	memset(s, 0, sizeof(*s));
-out:
-	return rc;
-out_kfree:
-	kfree(s);
-	goto out;
-}
-
 static struct file_operations arp_seq_fops = {
 	.open           = arp_seq_open,
 	.read           = seq_read,
@@ -421,13 +293,6 @@
 	.release	= ip_seq_release,
 };
 
-static struct file_operations udp_seq_fops = {
-	.open           = udp_seq_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release	= ip_seq_release,
-};
-
 /* ------------------------------------------------------------------------ */
 
 int __init ipv4_proc_init(void)
@@ -450,11 +315,6 @@
 	if (!proc_net_create("tcp", 0, tcp_get_info))
 		goto out_tcp;
 
-	p = create_proc_entry("udp", S_IRUGO, proc_net);
-	if (!p)
-		goto out_udp;
-	p->proc_fops = &udp_seq_fops;
-
 	p = create_proc_entry("arp", S_IRUGO, proc_net);
 	if (!p)
 		goto out_arp;
@@ -463,8 +323,6 @@
 out:
 	return rc;
 out_arp:
-	remove_proc_entry("udp", proc_net);
-out_udp:
 	proc_net_remove("tcp");
 out_tcp:
 	proc_net_remove("sockstat");
diff -Nru a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c	Sun Oct 20 13:16:16 2002
+++ b/net/ipv4/udp.c	Sun Oct 20 13:16:16 2002
@@ -62,10 +62,10 @@
  *					return ENOTCONN for unconnected sockets (POSIX)
  *		Janos Farkas	:	don't deliver multi/broadcasts to a different
  *					bound-to-device socket
- *		Arnaldo C. Melo :	move proc routines to ip_proc.c.
  *	Hirokazu Takahashi	:	HW checksumming for outgoing UDP
  *					datagrams.
  *	Hirokazu Takahashi	:	sendfile() on UDP works now.
+ *		Arnaldo C. Melo :	convert /proc/net/udp to seq_file
  *
  *
  *		This program is free software; you can redistribute it and/or
@@ -92,6 +92,8 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 #include <linux/skbuff.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/udp.h>
 #include <net/icmp.h>
@@ -1208,3 +1210,159 @@
 	.unhash =	udp_v4_unhash,
 	.get_port =	udp_v4_get_port,
 };
+
+/* ------------------------------------------------------------------------ */
+#ifdef CONFIG_PROC_FS
+
+struct udp_iter_state {
+	int bucket;
+};
+
+static __inline__ struct sock *udp_get_bucket(struct seq_file *seq, loff_t *pos)
+{
+	int i;
+	struct sock *sk = NULL;
+	loff_t l = *pos;
+	struct udp_iter_state *state = seq->private;
+
+	for (; state->bucket < UDP_HTABLE_SIZE; ++state->bucket)
+		for (i = 0, sk = udp_hash[state->bucket]; sk; ++i, sk = sk->next) {
+			if (sk->family != PF_INET)
+				continue;
+			if (l--)
+				continue;
+			*pos = i;
+			goto out;
+		}
+out:
+	return sk;
+}
+
+static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock(&udp_hash_lock);
+	return *pos ? udp_get_bucket(seq, pos) : (void *)1;
+}
+
+static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock *sk;
+	struct udp_iter_state *state;
+
+	if (v == (void *)1) {
+		sk = udp_get_bucket(seq, pos);
+		goto out;
+	}
+
+	sk = v;
+	sk = sk->next;
+	if (sk) 
+		goto out;
+
+	state = seq->private;
+	if (++state->bucket >= UDP_HTABLE_SIZE) 
+		goto out;
+
+	*pos = 0;
+	sk = udp_get_bucket(seq, pos);
+out:
+	++*pos;
+	return sk;
+}
+
+static void udp_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&udp_hash_lock);
+}
+
+static void udp_format_sock(struct sock *sp, char *tmpbuf, int bucket)
+{
+	struct inet_opt *inet = inet_sk(sp);
+	unsigned int dest = inet->daddr;
+	unsigned int src  = inet->rcv_saddr;
+	__u16 destp	  = ntohs(inet->dport);
+	__u16 srcp	  = ntohs(inet->sport);
+
+	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
+		bucket, src, srcp, dest, destp, sp->state, 
+		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
+		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
+		atomic_read(&sp->refcnt), sp);
+}
+
+static int udp_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == (void *)1)
+		seq_printf(seq, "%-127s\n",
+			   "  sl  local_address rem_address   st tx_queue "
+			   "rx_queue tr tm->when retrnsmt   uid  timeout "
+			   "inode");
+	else {
+		char tmpbuf[129];
+		struct udp_iter_state *state = seq->private;
+
+		udp_format_sock(v, tmpbuf, state->bucket);
+		seq_printf(seq, "%-127s\n", tmpbuf);
+	}
+	return 0;
+}
+/* ------------------------------------------------------------------------ */
+
+static struct seq_operations udp_seq_ops = {
+	.start  = udp_seq_start,
+	.next   = udp_seq_next,
+	.stop   = udp_seq_stop,
+	.show   = udp_seq_show,
+};
+
+static int udp_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct udp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+       
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &udp_seq_ops);
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
+static struct file_operations udp_seq_fops = {
+	.open           = udp_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= ip_seq_release,
+};
+
+/* ------------------------------------------------------------------------ */
+
+int __init udp_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = 0;
+
+	p = create_proc_entry("udp", S_IRUGO, proc_net);
+	if (p)
+		p->proc_fops = &udp_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+#else /* CONFIG_PROC_FS */
+int __init udp_proc_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PROC_FS */

===================================================================


This BitKeeper patch contains the following changesets:
1.810
## Wrapped with gzip_uu ##


begin 664 bkpatch16608
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
H66[/<;D'[?,HP+@V>IK_OQ6_S_U!-AYUF68YGNGIZO\-\`\,R!D`````
`
end
