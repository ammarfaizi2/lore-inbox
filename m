Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSKNQ7l>; Thu, 14 Nov 2002 11:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSKNQ7k>; Thu, 14 Nov 2002 11:59:40 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:48134 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264978AbSKNQ7X>; Thu, 14 Nov 2002 11:59:23 -0500
Date: Thu, 14 Nov 2002 13:07:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/raw to seq_file
Message-ID: <20021114150723.GC13379@conectiva.com.br>
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

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are three outstanding changesets there.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.827, 2002-11-14 12:48:56-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/raw to seq_file
  
  Also:
  
  . prototypes for _proc_init functions only needed in af_inet.c, and only
    if CONFIG_PROC_FS is set.
  . net/socket.c needs include <linux/seq_file.h>
  . review raw.c needed includes


 include/linux/udp.h  |    3 
 include/net/ip_fib.h |    3 
 include/net/udp.h    |    2 
 net/ipv4/af_inet.c   |   16 ++-
 net/ipv4/fib_hash.c  |   12 --
 net/ipv4/raw.c       |  213 +++++++++++++++++++++++++++++++++++++--------------
 net/ipv4/udp.c       |   12 --
 net/socket.c         |    1 
 8 files changed, 166 insertions(+), 96 deletions(-)


diff -Nru a/include/linux/udp.h b/include/linux/udp.h
--- a/include/linux/udp.h	Thu Nov 14 12:55:45 2002
+++ b/include/linux/udp.h	Thu Nov 14 12:55:45 2002
@@ -57,7 +57,4 @@
 
 #define udp_sk(__sk) (&((struct udp_sock *)__sk)->udp)
 
-extern int udp_proc_init(void);
-extern void udp_proc_exit(void);
-
 #endif	/* _LINUX_UDP_H */
diff -Nru a/include/net/ip_fib.h b/include/net/ip_fib.h
--- a/include/net/ip_fib.h	Thu Nov 14 12:55:45 2002
+++ b/include/net/ip_fib.h	Thu Nov 14 12:55:45 2002
@@ -276,7 +276,4 @@
 #endif
 }
 
-extern int fib_proc_init(void);
-extern void fib_proc_exit(void);
-
 #endif  /* _NET_FIB_H */
diff -Nru a/include/net/udp.h b/include/net/udp.h
--- a/include/net/udp.h	Thu Nov 14 12:55:45 2002
+++ b/include/net/udp.h	Thu Nov 14 12:55:45 2002
@@ -76,6 +76,4 @@
 #define UDP_INC_STATS_BH(field)		SNMP_INC_STATS_BH(udp_statistics, field)
 #define UDP_INC_STATS_USER(field) 	SNMP_INC_STATS_USER(udp_statistics, field)
 
-extern int udp_proc_init(void);
-
 #endif	/* _UDP_H */
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Thu Nov 14 12:55:45 2002
+++ b/net/ipv4/af_inet.c	Thu Nov 14 12:55:45 2002
@@ -1160,16 +1160,20 @@
 /* ------------------------------------------------------------------------ */
 
 #ifdef CONFIG_PROC_FS
-
-extern int ip_misc_proc_init(void);
-extern int raw_get_info(char *, char **, off_t, int);
-extern int tcp_get_info(char *, char **, off_t, int);
+extern int  fib_proc_init(void);
+extern void fib_proc_exit(void);
+extern int  ip_misc_proc_init(void);
+extern int  raw_proc_init(void);
+extern void raw_proc_exit(void);
+extern int  tcp_get_info(char *buffer, char **start, off_t offset, int length);
+extern int  udp_proc_init(void);
+extern void udp_proc_exit(void);
 
 int __init ipv4_proc_init(void)
 {
 	int rc = 0;
 
-	if (!proc_net_create("raw", 0, raw_get_info))
+	if (raw_proc_init())
 		goto out_raw;
 	if (!proc_net_create("tcp", 0, tcp_get_info))
 		goto out_tcp;
@@ -1188,7 +1192,7 @@
 out_udp:
 	proc_net_remove("tcp");
 out_tcp:
-	proc_net_remove("raw");
+	raw_proc_exit();
 out_raw:
 	rc = -ENOMEM;
 	goto out;
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	Thu Nov 14 12:55:45 2002
+++ b/net/ipv4/fib_hash.c	Thu Nov 14 12:55:45 2002
@@ -1092,16 +1092,4 @@
 {
 	remove_proc_entry("route", proc_net);
 }
-
-#else /* CONFIG_PROC_FS */
-
-int __init fib_proc_init(void)
-{
-	return 0;
-}
-
-void __init fib_proc_exit(void)
-{
-	return 0;
-}
 #endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c	Thu Nov 14 12:55:45 2002
+++ b/net/ipv4/raw.c	Thu Nov 14 12:55:45 2002
@@ -40,31 +40,42 @@
  */
  
 #include <linux/config.h> 
-#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/byteorder.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/stddef.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
+#include <linux/aio.h>
 #include <linux/kernel.h>
-#include <linux/fcntl.h>
+#include <linux/spinlock.h>
+#include <linux/sockios.h>
 #include <linux/socket.h>
 #include <linux/in.h>
-#include <linux/inet.h>
 #include <linux/netdevice.h>
-#include <linux/mroute.h>
-#include <net/tcp.h>
-#include <net/protocol.h>
+#include <linux/in_route.h>
+#include <linux/route.h>
+#include <linux/tcp.h>
 #include <linux/skbuff.h>
+#include <net/dst.h>
 #include <net/sock.h>
+#include <linux/gfp.h>
+#include <linux/ip.h>
+#include <net/ip.h>
 #include <net/icmp.h>
 #include <net/udp.h>
 #include <net/raw.h>
+#include <net/snmp.h>
 #include <net/inet_common.h>
 #include <net/checksum.h>
 #include <net/xfrm.h>
+#include <linux/rtnetlink.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 
 struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
@@ -656,7 +667,95 @@
 	}
 }
 
-static void get_raw_sock(struct sock *sp, char *tmpbuf, int i)
+struct proto raw_prot = {
+	.name =		"RAW",
+	.close =	raw_close,
+	.connect =	udp_connect,
+	.disconnect =	udp_disconnect,
+	.ioctl =	raw_ioctl,
+	.init =		raw_init,
+	.setsockopt =	raw_setsockopt,
+	.getsockopt =	raw_getsockopt,
+	.sendmsg =	raw_sendmsg,
+	.recvmsg =	raw_recvmsg,
+	.bind =		raw_bind,
+	.backlog_rcv =	raw_rcv_skb,
+	.hash =		raw_v4_hash,
+	.unhash =	raw_v4_unhash,
+};
+
+#ifdef CONFIG_PROC_FS
+struct raw_iter_state {
+	int bucket;
+};
+
+#define raw_seq_private(seq) ((struct raw_iter_state *)&seq->private)
+
+static struct sock *raw_get_first(struct seq_file *seq)
+{
+	struct sock *sk = NULL;
+	struct raw_iter_state* state = raw_seq_private(seq);
+
+	for (state->bucket = 0; state->bucket < RAWV4_HTABLE_SIZE; ++state->bucket) {
+		sk = raw_v4_htable[state->bucket];
+		while (sk && sk->family != PF_INET)
+			sk = sk->next;
+		if (sk)
+			break;
+	}
+	return sk;
+}
+
+static struct sock *raw_get_next(struct seq_file *seq, struct sock *sk)
+{
+	struct raw_iter_state* state = raw_seq_private(seq);
+
+	do {
+		sk = sk->next;
+try_again:
+	} while (sk && sk->family != PF_INET);
+
+	if (!sk && ++state->bucket < RAWV4_HTABLE_SIZE) {
+		sk = raw_v4_htable[state->bucket];
+		goto try_again;
+	}
+	return sk;
+}
+
+static struct sock *raw_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct sock *sk = raw_get_first(seq);
+
+	if (sk)
+		while (pos && (sk = raw_get_next(seq, sk)) != NULL)
+			--pos;
+	return pos ? NULL : sk;
+}
+
+static void *raw_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock(&raw_v4_lock);
+	return *pos ? raw_get_idx(seq, *pos) : (void *)1;
+}
+
+static void *raw_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock *sk;
+
+	if (v == (void *)1)
+		sk = raw_get_first(seq);
+	else
+		sk = raw_get_next(seq, v);
+	++*pos;
+	return sk;
+}
+
+static void raw_seq_stop(struct seq_file *seq, void *v)
+{
+	read_unlock(&raw_v4_lock);
+}
+
+static __inline__ char *get_raw_sock(struct sock *sp, char *tmpbuf, int i)
 {
 	struct inet_opt *inet = inet_sk(sp);
 	unsigned int dest = inet->daddr,
@@ -668,65 +767,63 @@
 		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
 		i, src, srcp, dest, destp, sp->state, 
 		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
-		0, 0L, 0,
-		sock_i_uid(sp), 0,
-		sock_i_ino(sp),
+		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
 		atomic_read(&sp->refcnt), sp);
+	return tmpbuf;
 }
 
-int raw_get_info(char *buffer, char **start, off_t offset, int length)
+static int raw_seq_show(struct seq_file *seq, void *v)
 {
-	int len = 0, num = 0, i;
-	off_t pos = 128;
-	off_t begin;
 	char tmpbuf[129];
 
-	if (offset < 128) 
-		len += sprintf(buffer, "%-127s\n",
+	if (v == (void *)1)
+		seq_printf(seq, "%-127s\n",
 			       "  sl  local_address rem_address   st tx_queue "
 			       "rx_queue tr tm->when retrnsmt   uid  timeout "
 			       "inode");
-	read_lock(&raw_v4_lock);
-	for (i = 0; i < RAWV4_HTABLE_SIZE; i++) {
-		struct sock *sk;
+	else {
+		struct raw_iter_state *state = raw_seq_private(seq);
 
-		for (sk = raw_v4_htable[i]; sk; sk = sk->next, num++) {
-			if (sk->family != PF_INET)
-				continue;
-			pos += 128;
-			if (pos <= offset)
-				continue;
-			get_raw_sock(sk, tmpbuf, i);
-			len += sprintf(buffer + len, "%-127s\n", tmpbuf);
-			if (len >= length)
-				goto out;
-		}
+		seq_printf(seq, "%-127s\n",
+			   get_raw_sock(v, tmpbuf, state->bucket));
 	}
-out:
-	read_unlock(&raw_v4_lock);
-	begin = len - (pos - offset);
-	*start = buffer + begin;
-	len -= begin;
-	if (len > length)
-		len = length;
-	if (len < 0)
-		len = 0; 
-	return len;
+	return 0;
 }
 
-struct proto raw_prot = {
-	.name =		"RAW",
-	.close =	raw_close,
-	.connect =	udp_connect,
-	.disconnect =	udp_disconnect,
-	.ioctl =	raw_ioctl,
-	.init =		raw_init,
-	.setsockopt =	raw_setsockopt,
-	.getsockopt =	raw_getsockopt,
-	.sendmsg =	raw_sendmsg,
-	.recvmsg =	raw_recvmsg,
-	.bind =		raw_bind,
-	.backlog_rcv =	raw_rcv_skb,
-	.hash =		raw_v4_hash,
-	.unhash =	raw_v4_unhash,
+static struct seq_operations raw_seq_ops = {
+	.start = raw_seq_start,
+	.next  = raw_seq_next,
+	.stop  = raw_seq_stop,
+	.show  = raw_seq_show,
+};
+
+static int raw_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &raw_seq_ops);
+}
+
+static struct file_operations raw_seq_fops = {
+	.open	 = raw_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = seq_release,
 };
+
+int __init raw_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = 0;
+
+	p = create_proc_entry("raw", S_IRUGO, proc_net);
+	if (p)
+		p->proc_fops = &raw_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+void __init raw_proc_exit(void)
+{
+	remove_proc_entry("raw", proc_net);
+}
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c	Thu Nov 14 12:55:45 2002
+++ b/net/ipv4/udp.c	Thu Nov 14 12:55:45 2002
@@ -1377,16 +1377,4 @@
 {
 	remove_proc_entry("udp", proc_net);
 }
-
-#else /* CONFIG_PROC_FS */
-
-int __init udp_proc_init(void)
-{
-	return 0;
-}
-
-void __init udp_proc_exit(void)
-{
-	return 0;
-}
 #endif /* CONFIG_PROC_FS */
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Thu Nov 14 12:55:45 2002
+++ b/net/socket.c	Thu Nov 14 12:55:45 2002
@@ -66,6 +66,7 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/wanrouter.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.827
## Wrapped with gzip_uu ##


begin 664 bkpatch3671
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
+NO)?6)Z$4NTK````
`
end
