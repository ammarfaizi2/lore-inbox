Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261788AbSJNBn0>; Sun, 13 Oct 2002 21:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSJNBnZ>; Sun, 13 Oct 2002 21:43:25 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:41227 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261788AbSJNBnW>; Sun, 13 Oct 2002 21:43:22 -0400
Date: Sun, 13 Oct 2002 10:48:57 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/udp to seq_file
Message-ID: <20021013124857.GD9330@conectiva.com.br>
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

master.kernel.org:/home/acme/BK/ip-2.5

	Now there are two outstanding changesets there.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.835, 2002-10-13 23:45:25-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/udp to seq_file
  
  Also make some functions and structs static, as they're only used in
  ip_proc.c


 ip_proc.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 udp.c     |   61 -------------------------------------------
 2 files changed, 82 insertions(+), 66 deletions(-)


diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sun Oct 13 23:45:58 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 13 23:45:58 2002
@@ -18,6 +18,7 @@
 #include <linux/netdevice.h>
 #include <net/neighbour.h>
 #include <net/arp.h>
+#include <net/udp.h>
 #include <linux/rtnetlink.h>
 #include <linux/route.h>
 #include <net/ip_fib.h>
@@ -29,7 +30,6 @@
 extern int netstat_get_info(char *, char **, off_t, int);
 extern int afinet_get_info(char *, char **, off_t, int);
 extern int tcp_get_info(char *, char **, off_t, int);
-extern int udp_get_info(char *, char **, off_t, int);
 
 #ifdef CONFIG_PROC_FS
 #ifdef CONFIG_AX25
@@ -38,7 +38,7 @@
 /*
  *	ax25 -> ASCII conversion
  */
-char *ax2asc2(ax25_address *a, char *buf)
+static char *ax2asc2(ax25_address *a, char *buf)
 {
 	char c, *s;
 	int n;
@@ -198,20 +198,81 @@
 
 /* ------------------------------------------------------------------------ */
 
-struct seq_operations arp_seq_ops = {
+static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock(&udp_hash_lock);
+	return (void *)(unsigned long)++*pos;
+}
+
+static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return (void *)(unsigned long)((++*pos) >=
+				       (UDP_HTABLE_SIZE - 1) ? 0 : *pos);
+}
+
+static void udp_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&udp_hash_lock);
+}
+
+static void udp_format_sock(struct sock *sp, char *tmpbuf, int i)
+{
+	struct inet_opt *inet = inet_sk(sp);
+	unsigned int dest = inet->daddr;
+	unsigned int src  = inet->rcv_saddr;
+	__u16 destp	  = ntohs(inet->dport);
+	__u16 srcp	  = ntohs(inet->sport);
+
+	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
+		i, src, srcp, dest, destp, sp->state, 
+		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
+		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
+		atomic_read(&sp->refcnt), sp);
+}
+
+static int udp_seq_show(struct seq_file *seq, void *v)
+{
+	char tmpbuf[129];
+	struct sock *sk;
+	unsigned long l = (unsigned long)v - 1;
+
+	if (!l)
+		seq_printf(seq, "%-127s\n",
+			   "  sl  local_address rem_address   st tx_queue "
+			   "rx_queue tr tm->when retrnsmt   uid  timeout inode");
+
+	for (sk = udp_hash[l]; sk; sk = sk->next) {
+		if (sk->family != PF_INET)
+			continue;
+		udp_format_sock(sk, tmpbuf, l);
+		seq_printf(seq, "%-127s\n", tmpbuf);
+	}
+	return 0;
+}
+/* ------------------------------------------------------------------------ */
+
+static struct seq_operations arp_seq_ops = {
 	.start  = arp_seq_start,
 	.next   = arp_seq_next,
 	.stop   = arp_seq_stop,
 	.show   = arp_seq_show,
 };
 
-struct seq_operations fib_seq_ops = {
+static struct seq_operations fib_seq_ops = {
 	.start  = fib_seq_start,
 	.next   = fib_seq_next,
 	.stop   = fib_seq_stop,
 	.show   = fib_seq_show,
 };
 
+static struct seq_operations udp_seq_ops = {
+	.start  = udp_seq_start,
+	.next   = udp_seq_next,
+	.stop   = udp_seq_stop,
+	.show   = udp_seq_show,
+};
+
 static int arp_seq_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &arp_seq_ops);
@@ -222,6 +283,11 @@
 	return seq_open(file, &fib_seq_ops);
 }
 
+static int udp_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &udp_seq_ops);
+}
+
 static struct file_operations arp_seq_fops = {
 	.open           = arp_seq_open,
 	.read           = seq_read,
@@ -236,6 +302,13 @@
 	.release	= seq_release,
 };
 
+static struct file_operations udp_seq_fops = {
+	.open           = udp_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= seq_release,
+};
+
 /* ------------------------------------------------------------------------ */
 
 int __init ipv4_proc_init(void)
@@ -258,8 +331,10 @@
 	if (!proc_net_create("tcp", 0, tcp_get_info))
 		goto out_tcp;
 
-	if (!proc_net_create("udp", 0, udp_get_info))
+	p = create_proc_entry("udp", S_IRUGO, proc_net);
+	if (!p)
 		goto out_udp;
+	p->proc_fops = &udp_seq_fops;
 
 	p = create_proc_entry("arp", S_IRUGO, proc_net);
 	if (!p)
@@ -275,7 +350,7 @@
 out_route:
 	remove_proc_entry("route", proc_net);
 out_arp:
-	proc_net_remove("udp");
+	remove_proc_entry("udp", proc_net);
 out_udp:
 	proc_net_remove("tcp");
 out_tcp:
diff -Nru a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c	Sun Oct 13 23:45:58 2002
+++ b/net/ipv4/udp.c	Sun Oct 13 23:45:58 2002
@@ -61,6 +61,7 @@
  *					return ENOTCONN for unconnected sockets (POSIX)
  *		Janos Farkas	:	don't deliver multi/broadcasts to a different
  *					bound-to-device socket
+ *		Arnaldo C. Melo :	move proc routines to ip_proc.c.
  *
  *
  *		This program is free software; you can redistribute it and/or
@@ -982,66 +983,6 @@
 	UDP_INC_STATS_BH(UdpInErrors);
 	kfree_skb(skb);
 	return(0);
-}
-
-static void get_udp_sock(struct sock *sp, char *tmpbuf, int i)
-{
-	struct inet_opt *inet = inet_sk(sp);
-	unsigned int dest, src;
-	__u16 destp, srcp;
-
-	dest  = inet->daddr;
-	src   = inet->rcv_saddr;
-	destp = ntohs(inet->dport);
-	srcp  = ntohs(inet->sport);
-	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
-		i, src, srcp, dest, destp, sp->state, 
-		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
-		0, 0L, 0,
-		sock_i_uid(sp), 0,
-		sock_i_ino(sp),
-		atomic_read(&sp->refcnt), sp);
-}
-
-int udp_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	int len = 0, num = 0, i;
-	off_t pos = 0;
-	off_t begin;
-	char tmpbuf[129];
-
-	if (offset < 128) 
-		len += sprintf(buffer, "%-127s\n",
-			       "  sl  local_address rem_address   st tx_queue "
-			       "rx_queue tr tm->when retrnsmt   uid  timeout inode");
-	pos = 128;
-	read_lock(&udp_hash_lock);
-	for (i = 0; i < UDP_HTABLE_SIZE; i++) {
-		struct sock *sk;
-
-		for (sk = udp_hash[i]; sk; sk = sk->next, num++) {
-			if (sk->family != PF_INET)
-				continue;
-			pos += 128;
-			if (pos <= offset)
-				continue;
-			get_udp_sock(sk, tmpbuf, i);
-			len += sprintf(buffer+len, "%-127s\n", tmpbuf);
-			if(len >= length)
-				goto out;
-		}
-	}
-out:
-	read_unlock(&udp_hash_lock);
-	begin = len - (pos - offset);
-	*start = buffer + begin;
-	len -= begin;
-	if(len > length)
-		len = length;
-	if (len < 0)
-		len = 0; 
-	return len;
 }
 
 struct proto udp_prot = {

===================================================================


This BitKeeper patch contains the following changesets:
1.835
## Wrapped with gzip_uu ##


begin 664 bkpatch8898
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
2,1^[MDN?2[;Q'\9*S.'Q$```
`
end
