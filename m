Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbSJUE0p>; Mon, 21 Oct 2002 00:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264734AbSJUE0p>; Mon, 21 Oct 2002 00:26:45 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:60434 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264733AbSJUE0a>; Mon, 21 Oct 2002 00:26:30 -0400
Date: Mon, 21 Oct 2002 01:32:26 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: move /proc/net/arp seq_file support back to arp.c
Message-ID: <20021021043225.GL17834@conectiva.com.br>
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

	Now that we have everything settled as how this is to be done, i.e. we
now know how to use seq_file properly and ip_proc was considered harmful, with
the conversion happening in the same file it is today, I think I'll be able to
finish the rest by the end of this week.

Best regards,

- Arnaldo


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.811, 2002-10-21 01:18:33-03:00, acme@conectiva.com.br
  o ipv4: move /proc/net/arp seq_file support back to arp.c
  
  This also buries ip_proc.c.


 b/include/linux/udp.h |    3 
 b/include/net/arp.h   |    1 
 b/net/ipv4/Makefile   |    2 
 b/net/ipv4/af_inet.c  |   69 +++++++++-
 b/net/ipv4/arp.c      |  287 +++++++++++++++++++++++++++++++++++++++++
 b/net/ipv4/udp.c      |   12 +
 net/ipv4/ip_proc.c    |  344 --------------------------------------------------
 7 files changed, 367 insertions(+), 351 deletions(-)


diff -Nru a/include/linux/udp.h b/include/linux/udp.h
--- a/include/linux/udp.h	Mon Oct 21 01:20:52 2002
+++ b/include/linux/udp.h	Mon Oct 21 01:20:52 2002
@@ -57,4 +57,7 @@
 
 #define udp_sk(__sk) (&((struct udp_sock *)__sk)->udp)
 
+extern int udp_proc_init(void);
+extern void udp_proc_exit(void);
+
 #endif	/* _LINUX_UDP_H */
diff -Nru a/include/net/arp.h b/include/net/arp.h
--- a/include/net/arp.h	Mon Oct 21 01:20:52 2002
+++ b/include/net/arp.h	Mon Oct 21 01:20:52 2002
@@ -18,7 +18,6 @@
 extern int	arp_bind_neighbour(struct dst_entry *dst);
 extern int	arp_mc_map(u32 addr, u8 *haddr, struct net_device *dev, int dir);
 extern void	arp_ifdown(struct net_device *dev);
-extern unsigned arp_state_to_flags(struct neighbour *neigh);
 
 extern struct neigh_ops arp_broken_ops;
 
diff -Nru a/net/ipv4/Makefile b/net/ipv4/Makefile
--- a/net/ipv4/Makefile	Mon Oct 21 01:20:52 2002
+++ b/net/ipv4/Makefile	Mon Oct 21 01:20:52 2002
@@ -4,7 +4,7 @@
 
 obj-y     := utils.o route.o inetpeer.o proc.o protocol.o \
 	     ip_input.o ip_fragment.o ip_forward.o ip_options.o \
-	     ip_output.o ip_sockglue.o ip_proc.o \
+	     ip_output.o ip_sockglue.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o tcp_minisocks.o \
 	     tcp_diag.o raw.o udp.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     sysctl_net_ipv4.o fib_frontend.o fib_semantics.o fib_hash.o
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Mon Oct 21 01:20:52 2002
+++ b/net/ipv4/af_inet.c	Mon Oct 21 01:20:52 2002
@@ -102,6 +102,8 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <linux/skbuff.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/raw.h>
 #include <net/icmp.h>
@@ -1123,6 +1125,8 @@
 	.handler =	icmp_rcv,
 };
 
+int ipv4_proc_init(void);
+
 static int __init inet_init(void)
 {
 	struct sk_buff *dummy_skb;
@@ -1218,9 +1222,70 @@
 #endif
 
 	ipv4_proc_init();
-	udp_proc_init();
-	fib_proc_init();
 	return 0;
 }
 
 module_init(inet_init);
+
+/* ------------------------------------------------------------------------ */
+
+#ifdef CONFIG_PROC_FS
+
+extern int raw_get_info(char *, char **, off_t, int);
+extern int snmp_get_info(char *, char **, off_t, int);
+extern int netstat_get_info(char *, char **, off_t, int);
+extern int afinet_get_info(char *, char **, off_t, int);
+extern int tcp_get_info(char *, char **, off_t, int);
+extern int udp_get_info(char *, char **, off_t, int);
+
+int __init ipv4_proc_init(void)
+{
+	int rc = 0;
+
+	if (!proc_net_create("raw", 0, raw_get_info))
+		goto out_raw;
+	if (!proc_net_create("netstat", 0, netstat_get_info))
+		goto out_netstat;
+	if (!proc_net_create("snmp", 0, snmp_get_info))
+		goto out_snmp;
+	if (!proc_net_create("sockstat", 0, afinet_get_info))
+		goto out_sockstat;
+	if (!proc_net_create("tcp", 0, tcp_get_info))
+		goto out_tcp;
+	if (udp_proc_init())
+		goto out_udp;
+	if (fib_proc_init())
+		goto out_fib;
+out:
+	return rc;
+out_fib:
+	udp_proc_exit();
+out_udp:
+	proc_net_remove("tcp");
+out_tcp:
+	proc_net_remove("sockstat");
+out_sockstat:
+	proc_net_remove("snmp");
+out_snmp:
+	proc_net_remove("netstat");
+out_netstat:
+	proc_net_remove("raw");
+out_raw:
+	rc = -ENOMEM;
+	goto out;
+}
+
+int ip_seq_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = (struct seq_file *)file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+	return seq_release(inode, file);
+}
+#else /* CONFIG_PROC_FS */
+int __init ipv4_proc_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Mon Oct 21 01:20:52 2002
+++ b/net/ipv4/arp.c	Mon Oct 21 01:20:52 2002
@@ -66,8 +66,7 @@
  *		Alexey Kuznetsov:	new arp state machine;
  *					now it is in net/core/neighbour.c.
  *		Krzysztof Halasa:	Added Frame Relay ARP support.
- *		Arnaldo C. Melo :	move proc stuff to seq_file and
- *					net/ipv4/ip_proc.c
+ *		Arnaldo C. Melo :	convert /proc/net/arp to seq_file
  */
 
 #include <linux/types.h>
@@ -87,6 +86,8 @@
 #include <linux/if_arp.h>
 #include <linux/trdevice.h>
 #include <linux/skbuff.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #ifdef CONFIG_SYSCTL
@@ -919,7 +920,7 @@
 	return err;
 }
 
-unsigned arp_state_to_flags(struct neighbour *neigh)
+static unsigned arp_state_to_flags(struct neighbour *neigh)
 {
 	unsigned flags = 0;
 	if (neigh->nud_state&NUD_PERMANENT)
@@ -1087,13 +1088,293 @@
 	.data =	(void*) 1, /* understand shared skbs */
 };
 
+static int arp_proc_init(void);
+
 void __init arp_init(void)
 {
 	neigh_table_init(&arp_tbl);
 
 	dev_add_pack(&arp_packet_type);
+	arp_proc_init();
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_register(NULL, &arp_tbl.parms, NET_IPV4,
 			      NET_IPV4_NEIGH, "ipv4");
 #endif
 }
+
+#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
+
+/* ------------------------------------------------------------------------ */
+/*
+ *	ax25 -> ASCII conversion
+ */
+static char *ax2asc2(ax25_address *a, char *buf)
+{
+	char c, *s;
+	int n;
+
+	for (n = 0, s = buf; n < 6; n++) {
+		c = (a->ax25_call[n] >> 1) & 0x7F;
+
+		if (c != ' ') *s++ = c;
+	}
+	
+	*s++ = '-';
+
+	if ((n = ((a->ax25_call[6] >> 1) & 0x0F)) > 9) {
+		*s++ = '1';
+		n -= 10;
+	}
+	
+	*s++ = n + '0';
+	*s++ = '\0';
+
+	if (*buf == '\0' || *buf == '-')
+	   return "*";
+
+	return buf;
+
+}
+#endif /* CONFIG_AX25 */
+
+struct arp_iter_state {
+	int is_pneigh, bucket;
+};
+
+static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
+						     loff_t *pos)
+{
+	struct neighbour *n = NULL;
+	struct arp_iter_state* state = seq->private;
+	loff_t l = *pos;
+	int i;
+
+	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
+		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
+		     ++i, n = n->next)
+			/* Do not confuse users "arp -a" with magic entries */
+			if ((n->nud_state & ~NUD_NOARP) && !l--) {
+				*pos = i;
+				goto out;
+			}
+out:
+	return n;
+}
+
+static __inline__ struct pneigh_entry *pneigh_get_bucket(struct seq_file *seq,
+							 loff_t *pos)
+{
+	struct pneigh_entry *n = NULL;
+	struct arp_iter_state* state = seq->private;
+	loff_t l = *pos;
+	int i;
+
+	for (; state->bucket <= PNEIGH_HASHMASK; ++state->bucket)
+		for (i = 0, n = arp_tbl.phash_buckets[state->bucket]; n;
+		     ++i, n = n->next)
+			if (!l--) {
+				*pos = i;
+				goto out;
+			}
+out:
+	return n;
+}
+
+static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
+{
+	void *rc = neigh_get_bucket(seq, pos);
+
+	if (!rc) {
+		struct arp_iter_state* state = seq->private;
+
+		read_unlock_bh(&arp_tbl.lock);
+		state->is_pneigh = 1;
+		state->bucket	 = 0;
+		*pos		 = 0;
+		rc = pneigh_get_bucket(seq, pos);
+	}
+	return rc;
+}
+
+static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	read_lock_bh(&arp_tbl.lock);
+	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
+}
+
+static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	void *rc;
+	struct arp_iter_state* state;
+
+	if (v == (void *)1) {
+		rc = arp_get_bucket(seq, pos);
+		goto out;
+	}
+
+	state = seq->private;
+	if (!state->is_pneigh) {
+		struct neighbour *n = v;
+
+		rc = n = n->next;
+		if (n)
+			goto out;
+		*pos = 0;
+		++state->bucket;
+		rc = neigh_get_bucket(seq, pos);
+		if (rc)
+			goto out;
+		read_unlock_bh(&arp_tbl.lock);
+		state->is_pneigh = 1;
+		state->bucket	 = 0;
+		*pos		 = 0;
+		rc = pneigh_get_bucket(seq, pos);
+	} else {
+		struct pneigh_entry *pn = v;
+
+		pn = pn->next;
+		if (!pn) {
+			++state->bucket;
+			*pos = 0;
+			pn   = pneigh_get_bucket(seq, pos);
+		}
+		rc = pn;
+	}
+out:
+	++*pos;
+	return rc;
+}
+
+static void arp_seq_stop(struct seq_file *seq, void *v)
+{
+	struct arp_iter_state* state = seq->private;
+
+	if (!state->is_pneigh)
+		read_unlock_bh(&arp_tbl.lock);
+}
+
+#define HBUFFERLEN 30
+
+static __inline__ void arp_format_neigh_entry(struct seq_file *seq,
+					      struct neighbour *n)
+{
+	char hbuffer[HBUFFERLEN];
+	const char hexbuf[] = "0123456789ABCDEF";
+	int k, j;
+	char tbuf[16];
+	struct net_device *dev = n->dev;
+	int hatype = dev->type;
+
+	read_lock(&n->lock);
+	/* Convert hardware address to XX:XX:XX:XX ... form. */
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
+	if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
+		ax2asc2((ax25_address *)n->ha, hbuffer);
+	else {
+#endif
+	for (k = 0, j = 0; k < HBUFFERLEN - 3 && j < dev->addr_len; j++) {
+		hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
+		hbuffer[k++] = hexbuf[n->ha[j] & 15];
+		hbuffer[k++] = ':';
+	}
+	hbuffer[--k] = 0;
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
+	}
+#endif
+	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->primary_key));
+	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
+		   tbuf, hatype, arp_state_to_flags(n), hbuffer, dev->name);
+	read_unlock(&n->lock);
+}
+
+static __inline__ void arp_format_pneigh_entry(struct seq_file *seq,
+					       struct pneigh_entry *n)
+{
+
+	struct net_device *dev = n->dev;
+	int hatype = dev ? dev->type : 0;
+	char tbuf[16];
+
+	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
+	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
+		   tbuf, hatype, ATF_PUBL | ATF_PERM, "00:00:00:00:00:00",
+		   dev ? dev->name : "*");
+}
+
+static int arp_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == (void *)1)
+		seq_puts(seq, "IP address       HW type     Flags       "
+			      "HW address            Mask     Device\n");
+	else {
+		struct arp_iter_state* state = seq->private;
+
+		if (state->is_pneigh)
+			arp_format_pneigh_entry(seq, v);
+		else
+			arp_format_neigh_entry(seq, v);
+	}
+
+	return 0;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct seq_operations arp_seq_ops = {
+	.start  = arp_seq_start,
+	.next   = arp_seq_next,
+	.stop   = arp_seq_stop,
+	.show   = arp_seq_show,
+};
+
+static int arp_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct arp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+       
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &arp_seq_ops);
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
+static struct file_operations arp_seq_fops = {
+	.open           = arp_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= ip_seq_release,
+};
+
+static int __init arp_proc_init(void)
+{
+	int rc = 0;
+	struct proc_dir_entry *p = create_proc_entry("arp", S_IRUGO, proc_net);
+
+        if (p)
+		p->proc_fops = &arp_seq_fops;
+	else
+		rc = -ENOMEM;
+	return rc;
+}
+
+#else /* CONFIG_PROC_FS */
+
+static int __init arp_proc_init(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Mon Oct 21 01:20:52 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,344 +0,0 @@
-/*
- * INET		An implementation of the TCP/IP protocol suite for the LINUX
- *		operating system.  INET is implemented using the  BSD Socket
- *		interface as the means of communication with the user level.
- *
- *		ipv4 proc support
- *
- *		Arnaldo Carvalho de Melo <acme@conectiva.com.br>, 2002/10/10
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License as
- *		published by the Free Software Foundation; version 2 of the
- *		License
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <net/neighbour.h>
-#include <net/arp.h>
-#include <linux/seq_file.h>
-#include <linux/proc_fs.h>
-
-extern int raw_get_info(char *, char **, off_t, int);
-extern int snmp_get_info(char *, char **, off_t, int);
-extern int netstat_get_info(char *, char **, off_t, int);
-extern int afinet_get_info(char *, char **, off_t, int);
-extern int tcp_get_info(char *, char **, off_t, int);
-
-#ifdef CONFIG_PROC_FS
-#ifdef CONFIG_AX25
-
-/* ------------------------------------------------------------------------ */
-/*
- *	ax25 -> ASCII conversion
- */
-static char *ax2asc2(ax25_address *a, char *buf)
-{
-	char c, *s;
-	int n;
-
-	for (n = 0, s = buf; n < 6; n++) {
-		c = (a->ax25_call[n] >> 1) & 0x7F;
-
-		if (c != ' ') *s++ = c;
-	}
-	
-	*s++ = '-';
-
-	if ((n = ((a->ax25_call[6] >> 1) & 0x0F)) > 9) {
-		*s++ = '1';
-		n -= 10;
-	}
-	
-	*s++ = n + '0';
-	*s++ = '\0';
-
-	if (*buf == '\0' || *buf == '-')
-	   return "*";
-
-	return buf;
-
-}
-#endif /* CONFIG_AX25 */
-
-struct arp_iter_state {
-	int is_pneigh, bucket;
-};
-
-static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
-						     loff_t *pos)
-{
-	struct neighbour *n = NULL;
-	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
-	int i;
-
-	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
-		     ++i, n = n->next)
-			/* Do not confuse users "arp -a" with magic entries */
-			if ((n->nud_state & ~NUD_NOARP) && !l--) {
-				*pos = i;
-				goto out;
-			}
-out:
-	return n;
-}
-
-static __inline__ struct pneigh_entry *pneigh_get_bucket(struct seq_file *seq,
-							 loff_t *pos)
-{
-	struct pneigh_entry *n = NULL;
-	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
-	int i;
-
-	for (; state->bucket <= PNEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.phash_buckets[state->bucket]; n;
-		     ++i, n = n->next)
-			if (!l--) {
-				*pos = i;
-				goto out;
-			}
-out:
-	return n;
-}
-
-static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
-{
-	void *rc = neigh_get_bucket(seq, pos);
-
-	if (!rc) {
-		struct arp_iter_state* state = seq->private;
-
-		read_unlock_bh(&arp_tbl.lock);
-		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
-		rc = pneigh_get_bucket(seq, pos);
-	}
-	return rc;
-}
-
-static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	read_lock_bh(&arp_tbl.lock);
-	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
-}
-
-static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	void *rc;
-	struct arp_iter_state* state;
-
-	if (v == (void *)1) {
-		rc = arp_get_bucket(seq, pos);
-		goto out;
-	}
-
-	state = seq->private;
-	if (!state->is_pneigh) {
-		struct neighbour *n = v;
-
-		rc = n = n->next;
-		if (n)
-			goto out;
-		*pos = 0;
-		++state->bucket;
-		rc = neigh_get_bucket(seq, pos);
-		if (rc)
-			goto out;
-		read_unlock_bh(&arp_tbl.lock);
-		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
-		rc = pneigh_get_bucket(seq, pos);
-	} else {
-		struct pneigh_entry *pn = v;
-
-		pn = pn->next;
-		if (!pn) {
-			++state->bucket;
-			*pos = 0;
-			pn   = pneigh_get_bucket(seq, pos);
-		}
-		rc = pn;
-	}
-out:
-	++*pos;
-	return rc;
-}
-
-static void arp_seq_stop(struct seq_file *seq, void *v)
-{
-	struct arp_iter_state* state = seq->private;
-
-	if (!state->is_pneigh)
-		read_unlock_bh(&arp_tbl.lock);
-}
-
-#define HBUFFERLEN 30
-
-static __inline__ void arp_format_neigh_entry(struct seq_file *seq,
-					      struct neighbour *n)
-{
-	char hbuffer[HBUFFERLEN];
-	const char hexbuf[] = "0123456789ABCDEF";
-	int k, j;
-	char tbuf[16];
-	struct net_device *dev = n->dev;
-	int hatype = dev->type;
-
-	read_lock(&n->lock);
-	/* Convert hardware address to XX:XX:XX:XX ... form. */
-#ifdef CONFIG_AX25
-	if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
-		ax2asc2((ax25_address *)n->ha, hbuffer);
-	else {
-#endif
-	for (k = 0, j = 0; k < HBUFFERLEN - 3 && j < dev->addr_len; j++) {
-		hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
-		hbuffer[k++] = hexbuf[n->ha[j] & 15];
-		hbuffer[k++] = ':';
-	}
-	hbuffer[--k] = 0;
-#ifdef CONFIG_AX25
-	}
-#endif
-	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->primary_key));
-	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
-		   tbuf, hatype, arp_state_to_flags(n), hbuffer, dev->name);
-	read_unlock(&n->lock);
-}
-
-static __inline__ void arp_format_pneigh_entry(struct seq_file *seq,
-					       struct pneigh_entry *n)
-{
-
-	struct net_device *dev = n->dev;
-	int hatype = dev ? dev->type : 0;
-	char tbuf[16];
-
-	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
-	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
-		   tbuf, hatype, ATF_PUBL | ATF_PERM, "00:00:00:00:00:00",
-		   dev ? dev->name : "*");
-}
-
-static int arp_seq_show(struct seq_file *seq, void *v)
-{
-	if (v == (void *)1)
-		seq_puts(seq, "IP address       HW type     Flags       "
-			      "HW address            Mask     Device\n");
-	else {
-		struct arp_iter_state* state = seq->private;
-
-		if (state->is_pneigh)
-			arp_format_pneigh_entry(seq, v);
-		else
-			arp_format_neigh_entry(seq, v);
-	}
-
-	return 0;
-}
-
-/* ------------------------------------------------------------------------ */
-
-static struct seq_operations arp_seq_ops = {
-	.start  = arp_seq_start,
-	.next   = arp_seq_next,
-	.stop   = arp_seq_stop,
-	.show   = arp_seq_show,
-};
-
-static int arp_seq_open(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int rc = -ENOMEM;
-	struct arp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
-       
-	if (!s)
-		goto out;
-
-	rc = seq_open(file, &arp_seq_ops);
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
-int ip_seq_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq = (struct seq_file *)file->private_data;
-
-	kfree(seq->private);
-	seq->private = NULL;
-
-	return seq_release(inode, file);
-}
-
-static struct file_operations arp_seq_fops = {
-	.open           = arp_seq_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release	= ip_seq_release,
-};
-
-/* ------------------------------------------------------------------------ */
-
-int __init ipv4_proc_init(void)
-{
-	struct proc_dir_entry *p;
-	int rc = 0;
-
-	if (!proc_net_create("raw", 0, raw_get_info))
-		goto out_raw;
-
-	if (!proc_net_create("netstat", 0, netstat_get_info))
-		goto out_netstat;
-
-	if (!proc_net_create("snmp", 0, snmp_get_info))
-		goto out_snmp;
-
-	if (!proc_net_create("sockstat", 0, afinet_get_info))
-		goto out_sockstat;
-
-	if (!proc_net_create("tcp", 0, tcp_get_info))
-		goto out_tcp;
-
-	p = create_proc_entry("arp", S_IRUGO, proc_net);
-	if (!p)
-		goto out_arp;
-	p->proc_fops = &arp_seq_fops;
-
-out:
-	return rc;
-out_arp:
-	proc_net_remove("tcp");
-out_tcp:
-	proc_net_remove("sockstat");
-out_sockstat:
-	proc_net_remove("snmp");
-out_snmp:
-	proc_net_remove("netstat");
-out_netstat:
-	proc_net_remove("raw");
-out_raw:
-	rc = -ENOMEM;
-	goto out;
-}
-#else /* CONFIG_PROC_FS */
-int __init ipv4_proc_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_PROC_FS */
diff -Nru a/net/ipv4/udp.c b/net/ipv4/udp.c
--- a/net/ipv4/udp.c	Mon Oct 21 01:20:52 2002
+++ b/net/ipv4/udp.c	Mon Oct 21 01:20:52 2002
@@ -1360,8 +1360,20 @@
 		rc = -ENOMEM;
 	return rc;
 }
+
+void __init udp_proc_exit(void)
+{
+	remove_proc_entry("udp", proc_net);
+}
+
 #else /* CONFIG_PROC_FS */
+
 int __init udp_proc_init(void)
+{
+	return 0;
+}
+
+void __init udp_proc_exit(void)
 {
 	return 0;
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.811
## Wrapped with gzip_uu ##


begin 664 bkpatch17330
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
!````
`
end
