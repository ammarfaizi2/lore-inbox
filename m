Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTEAUnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbTEAUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:43:41 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:61455 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S262488AbTEAUmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:42:21 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305012055.VAA19315@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes (part 2)
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 May 2003 21:55:51 +0100 (BST)
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030501.060909.26990580.davem@redhat.com> from "David S. Miller" at May 01, 2003 06:09:09 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is part 2 (depends on part 1) with the following features:

  o Removed blksize from decnet device parameters - use the device mtu like we
    ought to.
  o Removed /proc/net/decnet_route file - I don't think anybody ever used it
    and it was lacking a full enough description of the routes to be useful.
    ip -D route list is much better :-)
  o Added rt_local_src entry to decnet routes so that we get the local source
    address right when forwarding.
  o Added correct proto argument to struct flowi for routing
  o MSG_MORE in sendmsg (ignored, but accepted whereas before we'd error)
  o /proc/net/decnet converted to seq_file
  o /proc/net/decnet_dev converted to seq_file
  o /proc/net/decnet_cache converted to seq_file
  o Use pskb_may_pull() and add code to linearize skbs on the input path
    except for those containing data.
  o Fixed returned packet code (mostly - some left to do)
  o update_pmtu() method for decnet dst entries (ip_gre device assumes this
    method exists - well I think it does :-)
  o Fixed bug in forwarding to get IE bit set correctly
  o Fixed compile bugs with CONFIG_DECNET_ROUTE_FWMARK pointed out by Adrian
    Bunk
  o Fixed zero dest code to grab an address from loopback
  o Fixed local routes in dn_route_output_slow()
  o Fixed error case in dn_route_input/output_slow() pointed out by Rusty

Steve.


-----------------------------------------------------------------------------

diff -Nru linux-2.5.68-bk10/include/net/dn_dev.h linux/include/net/dn_dev.h
--- linux-2.5.68-bk10/include/net/dn_dev.h	Sun Apr 20 03:28:00 2003
+++ linux/include/net/dn_dev.h	Mon Apr 21 04:13:14 2003
@@ -71,7 +71,6 @@
 #define DN_DEV_MPOINT 4
 	int state;                /* Initial state                      */
 	int forwarding;	          /* 0=EndNode, 1=L1Router, 2=L2Router  */
-	unsigned short blksize;   /* Block Size                         */
 	unsigned long t2;         /* Default value of t2                */
 	unsigned long t3;         /* Default value of t3                */
 	int priority;             /* Priority to be a router            */
diff -Nru linux-2.5.68-bk10/include/net/dn_fib.h linux/include/net/dn_fib.h
--- linux-2.5.68-bk10/include/net/dn_fib.h	Sun Apr 20 03:28:00 2003
+++ linux/include/net/dn_fib.h	Wed Apr 23 09:43:44 2003
@@ -101,10 +101,6 @@
 	int (*lookup)(struct dn_fib_table *t, const struct flowi *fl,
 			struct dn_fib_res *res);
 	int (*flush)(struct dn_fib_table *t);
-#ifdef CONFIG_PROC_FS
-	int (*get_info)(struct dn_fib_table *table, char *buf,
-			int first, int count);
-#endif /* CONFIG_PROC_FS */
 	int (*dump)(struct dn_fib_table *t, struct sk_buff *skb, struct netlink_callback *cb);
 
 	unsigned char data[0];
@@ -183,6 +179,9 @@
 extern struct dn_fib_table *dn_fib_tables[];
 
 #else /* Endnode */
+
+#define dn_fib_init() (0)
+#define dn_fib_cleanup() (0)
 
 #define dn_fib_lookup(fl, res) (-ESRCH)
 #define dn_fib_info_put(fi) do { } while(0)
diff -Nru linux-2.5.68-bk10/include/net/dn_route.h linux/include/net/dn_route.h
--- linux-2.5.68-bk10/include/net/dn_route.h	Sun Apr 20 03:28:00 2003
+++ linux/include/net/dn_route.h	Wed Apr 23 07:44:23 2003
@@ -74,7 +74,7 @@
 	__u16 rt_saddr;
 	__u16 rt_daddr;
 	__u16 rt_gateway;
-	__u16 __padding;
+	__u16 rt_local_src;	/* Source used for forwarding packets */
 	__u16 rt_src_map;
 	__u16 rt_dst_map;
 
diff -Nru linux-2.5.68-bk10/net/decnet/TODO linux/net/decnet/TODO
--- linux-2.5.68-bk10/net/decnet/TODO	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/TODO	Wed Apr 23 10:31:38 2003
@@ -23,15 +23,9 @@
 
  o check MSG_CTRUNC is set where it should be.
 
- o Start to hack together user level software and add more DECnet support
-   in ifconfig for example. 
-
  o Find all the commonality between DECnet and IPv4 routing code and extract 
    it into a small library of routines. [probably a project for 2.7.xx]
 
- o Add the routing message grabbing netfilter module [written, tested,
-   awaiting merge]
-
  o Add perfect socket hashing - an idea suggested by Paul Koning. Currently
    we have a half-way house scheme which seems to work reasonably well, but
    the full scheme is still worth implementing, its not not top of my list
@@ -44,6 +38,4 @@
  o DECnet sendpages() function
 
  o AIO for DECnet
-
- o Eliminate dn_db->parms.blksize
 
diff -Nru linux-2.5.68-bk10/net/decnet/af_decnet.c linux/net/decnet/af_decnet.c
--- linux-2.5.68-bk10/net/decnet/af_decnet.c	Thu May  1 03:00:23 2003
+++ linux/net/decnet/af_decnet.c	Thu May  1 05:34:36 2003
@@ -116,6 +116,7 @@
 #include <linux/inet.h>
 #include <linux/route.h>
 #include <linux/netfilter.h>
+#include <linux/seq_file.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/flow.h>
@@ -675,45 +676,6 @@
 }
 
 
-static char *dn_state2asc(unsigned char state)
-{
-	switch(state) {
-		case DN_O:
-			return "OPEN";
-		case DN_CR:
-			return "  CR";
-		case DN_DR:
-			return "  DR";
-		case DN_DRC:
-			return " DRC";
-		case DN_CC:
-			return "  CC";
-		case DN_CI:
-			return "  CI";
-		case DN_NR:
-			return "  NR";
-		case DN_NC:
-			return "  NC";
-		case DN_CD:
-			return "  CD";
-		case DN_RJ:
-			return "  RJ";
-		case DN_RUN:
-			return " RUN";
-		case DN_DI:
-			return "  DI";
-		case DN_DIC:
-			return " DIC";
-		case DN_DN:
-			return "  DN";
-		case DN_CL:
-			return "  CL";
-		case DN_CN:
-			return "  CN";
-	}
-
-	return "????";
-}
 
 static int dn_create(struct socket *sock, int protocol)
 {
@@ -1000,6 +962,7 @@
 	fl.fld_dst = dn_saddr2dn(&scp->peer);
 	fl.fld_src = dn_saddr2dn(&scp->addr);
 	dn_sk_ports_copy(&fl, scp);
+	fl.proto = DNPROTO_NSP;
 	if (dn_route_output_sock(&sk->dst_cache, &fl, sk, flags) < 0)
 		goto out;
 	sk->route_caps = sk->dst_cache->dev->features;
@@ -1963,7 +1926,7 @@
 	unsigned char fctype;
 	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 
-	if (flags & ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL))
+	if (flags & ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL|MSG_MORE))
 		return -EOPNOTSUPP;
 
 	if (addr_len && (addr_len != sizeof(struct sockaddr_dn)))
@@ -2142,6 +2105,95 @@
 	.data =		(void*)1,
 };
 
+#ifdef CONFIG_PROC_FS
+struct dn_iter_state {
+	int bucket;
+};
+
+static struct sock *dn_socket_get_first(struct seq_file *seq)
+{
+	struct dn_iter_state *state = seq->private;
+	struct sock *n = NULL;
+
+	for(state->bucket = 0;
+	    state->bucket < DN_SK_HASH_SIZE;
+	    ++state->bucket) {
+		n = dn_sk_hash[state->bucket];
+		if (n)
+			break;
+	}
+
+	return n;
+}
+
+static struct sock *dn_socket_get_next(struct seq_file *seq,
+				       struct sock *n)
+{
+	struct dn_iter_state *state = seq->private;
+
+	n = n->next;
+try_again:
+	if (n)
+		goto out;
+	if (++state->bucket >= DN_SK_HASH_SIZE)
+		goto out;
+	n = dn_sk_hash[state->bucket];
+	goto try_again;
+out:
+	return n;
+}
+
+static struct sock *socket_get_idx(struct seq_file *seq, loff_t *pos)
+{
+	struct sock *sk = dn_socket_get_first(seq);
+
+	if (sk) {
+		while(*pos && (sk = dn_socket_get_next(seq, sk)))
+			--*pos;
+	}
+	return *pos ? NULL : sk;
+}
+
+static void *dn_socket_get_idx(struct seq_file *seq, loff_t pos)
+{
+	void *rc;
+	read_lock_bh(&dn_hash_lock);
+	rc = socket_get_idx(seq, &pos);
+	if (!rc) {
+		read_unlock_bh(&dn_hash_lock);
+	}
+	return rc;
+}
+
+static void *dn_socket_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos ? dn_socket_get_idx(seq, *pos - 1) : (void*)1;
+}
+
+static void *dn_socket_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	void *rc;
+
+	if (v == (void*)1) {
+		rc = dn_socket_get_idx(seq, 0);
+		goto out;
+	}
+
+	rc = dn_socket_get_next(seq, v);
+	if (rc)
+		goto out;
+	read_unlock_bh(&dn_hash_lock);
+out:
+	++*pos;
+	return rc;
+}
+
+static void dn_socket_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v && v != (void*)1)
+		read_unlock_bh(&dn_hash_lock);
+}
+
 #define IS_NOT_PRINTABLE(x) ((x) < 32 || (x) > 126)
 
 static void dn_printable_object(struct sockaddr_dn *dn, unsigned char *buf)
@@ -2162,70 +2214,127 @@
     	}
 }
 
-static int dn_get_info(char *buffer, char **start, off_t offset, int length)
+static char *dn_state2asc(unsigned char state)
 {
-	struct sock *sk;
-	struct dn_scp *scp;
-	int len = 0;
-	off_t pos = 0;
-	off_t begin = 0;
+	switch(state) {
+		case DN_O:
+			return "OPEN";
+		case DN_CR:
+			return "  CR";
+		case DN_DR:
+			return "  DR";
+		case DN_DRC:
+			return " DRC";
+		case DN_CC:
+			return "  CC";
+		case DN_CI:
+			return "  CI";
+		case DN_NR:
+			return "  NR";
+		case DN_NC:
+			return "  NC";
+		case DN_CD:
+			return "  CD";
+		case DN_RJ:
+			return "  RJ";
+		case DN_RUN:
+			return " RUN";
+		case DN_DI:
+			return "  DI";
+		case DN_DIC:
+			return " DIC";
+		case DN_DN:
+			return "  DN";
+		case DN_CL:
+			return "  CL";
+		case DN_CN:
+			return "  CN";
+	}
+
+	return "????";
+}
+
+static inline void dn_socket_format_entry(struct seq_file *seq, struct sock *sk)
+{
+	struct dn_scp *scp = DN_SK(sk);
 	char buf1[DN_ASCBUF_LEN];
 	char buf2[DN_ASCBUF_LEN];
 	char local_object[DN_MAXOBJL+3];
 	char remote_object[DN_MAXOBJL+3];
-	int i;
 
-	len += sprintf(buffer + len, "Local                                              Remote\n");
+	dn_printable_object(&scp->addr, local_object);
+	dn_printable_object(&scp->peer, remote_object);
 
-	read_lock(&dn_hash_lock);
-	for(i = 0; i < DN_SK_HASH_SIZE; i++) {
-		for(sk = dn_sk_hash[i]; sk != NULL; sk = sk->next) {
-			scp = DN_SK(sk);
-
-			dn_printable_object(&scp->addr, local_object);
-			dn_printable_object(&scp->peer, remote_object);
-
-			len += sprintf(buffer + len,
-					"%6s/%04X %04d:%04d %04d:%04d %01d %-16s %6s/%04X %04d:%04d %04d:%04d %01d %-16s %4s %s\n",
-					dn_addr2asc(dn_ntohs(dn_saddr2dn(&scp->addr)), buf1),
-					scp->addrloc,
-					scp->numdat,
-					scp->numoth,
-					scp->ackxmt_dat,
-					scp->ackxmt_oth,
-					scp->flowloc_sw,
-					local_object,
-					dn_addr2asc(dn_ntohs(dn_saddr2dn(&scp->peer)), buf2),
-					scp->addrrem,
-					scp->numdat_rcv,
-					scp->numoth_rcv,
-					scp->ackrcv_dat,
-					scp->ackrcv_oth,
-					scp->flowrem_sw,
-					remote_object,
-					dn_state2asc(scp->state),
-					((scp->accept_mode == ACC_IMMED) ? "IMMED" : "DEFER"));
-
-			pos = begin + len;
-			if (pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			if (pos > (offset + length))
-				break;
-		}
+	seq_printf(seq,
+		   "%6s/%04X %04d:%04d %04d:%04d %01d %-16s "
+		   "%6s/%04X %04d:%04d %04d:%04d %01d %-16s %4s %s\n",
+		   dn_addr2asc(dn_ntohs(dn_saddr2dn(&scp->addr)), buf1),
+		   scp->addrloc,
+		   scp->numdat,
+		   scp->numoth,
+		   scp->ackxmt_dat,
+		   scp->ackxmt_oth,
+		   scp->flowloc_sw,
+		   local_object,
+		   dn_addr2asc(dn_ntohs(dn_saddr2dn(&scp->peer)), buf2),
+		   scp->addrrem,
+		   scp->numdat_rcv,
+		   scp->numoth_rcv,
+		   scp->ackrcv_dat,
+		   scp->ackrcv_oth,
+		   scp->flowrem_sw,
+		   remote_object,
+		   dn_state2asc(scp->state),
+		   ((scp->accept_mode == ACC_IMMED) ? "IMMED" : "DEFER"));
+}
+
+static int dn_socket_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == (void*)1) {
+		seq_puts(seq, "Local                                              Remote\n");
+	} else {
+		dn_socket_format_entry(seq, v);
 	}
-	read_unlock(&dn_hash_lock);
+	return 0;
+}
 
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
+static struct seq_operations dn_socket_seq_ops = {
+	.start	= dn_socket_seq_start,
+	.next	= dn_socket_seq_next,
+	.stop	= dn_socket_seq_stop,
+	.show	= dn_socket_seq_show,
+};
 
-	if (len > length)
-		len = length;
+static int dn_socket_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct dn_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
 
-	return len;
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &dn_socket_seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq		= file->private_data;
+	seq->private	= s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
 }
 
+static struct file_operations dn_socket_seq_fops = {
+	.open		= dn_socket_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kfree_release,
+};
+#endif
 
 static struct net_proto_family	dn_family_ops = {
 	.family =	AF_DECnet,
@@ -2257,13 +2366,11 @@
 void dn_register_sysctl(void);
 void dn_unregister_sysctl(void);
 
-
 MODULE_DESCRIPTION("The Linux DECnet Network Protocol");
 MODULE_AUTHOR("Linux DECnet Project Team");
 MODULE_LICENSE("GPL");
 
-
-static char banner[] __initdata = KERN_INFO "NET4: DECnet for Linux: V.2.5.67s (C) 1995-2003 Linux DECnet Project Team\n";
+static char banner[] __initdata = KERN_INFO "NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team\n";
 
 static int __init decnet_init(void)
 {
@@ -2280,15 +2387,12 @@
 	dev_add_pack(&dn_dix_packet_type);
 	register_netdevice_notifier(&dn_dev_notifier);
 
-	proc_net_create("decnet", 0, dn_get_info);
+	proc_net_fops_create("decnet", S_IRUGO, &dn_socket_seq_fops);
 
 	dn_neigh_init();
 	dn_dev_init();
 	dn_route_init();
-
-#ifdef CONFIG_DECNET_ROUTER
 	dn_fib_init();
-#endif /* CONFIG_DECNET_ROUTER */
 
 	dn_register_sysctl();
 
@@ -2315,10 +2419,7 @@
 	dn_route_cleanup();
 	dn_dev_cleanup();
 	dn_neigh_cleanup();
-
-#ifdef CONFIG_DECNET_ROUTER
 	dn_fib_cleanup();
-#endif /* CONFIG_DECNET_ROUTER */
 
 	proc_net_remove("decnet");
 
diff -Nru linux-2.5.68-bk10/net/decnet/dn_dev.c linux/net/decnet/dn_dev.c
--- linux-2.5.68-bk10/net/decnet/dn_dev.c	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/dn_dev.c	Thu May  1 03:47:27 2003
@@ -20,6 +20,8 @@
  *          Steve Whitehouse : /proc/sys/net/decnet/conf/<sys>/forwarding
  *          Steve Whitehouse : Removed timer1 - it's a user space issue now
  *         Patrick Caulfield : Fixed router hello message format
+ *          Steve Whitehouse : Got rid of constant sizes for blksize for
+ *                             devices. All mtu based now.
  */
 
 #include <linux/config.h>
@@ -28,6 +30,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/if_arp.h>
@@ -72,16 +75,13 @@
 static int dn_eth_up(struct net_device *);
 static void dn_eth_down(struct net_device *);
 static void dn_send_brd_hello(struct net_device *dev, struct dn_ifaddr *ifa);
-#if 0
 static void dn_send_ptp_hello(struct net_device *dev, struct dn_ifaddr *ifa);
-#endif
 
 static struct dn_dev_parms dn_dev_list[] =  {
 {
 	.type =		ARPHRD_ETHER, /* Ethernet */
 	.mode =		DN_DEV_BCAST,
 	.state =	DN_DEV_S_RU,
-	.blksize =	1498,
 	.t2 =		1,
 	.t3 =		10,
 	.name =		"ethernet",
@@ -94,7 +94,6 @@
 	.type =		ARPHRD_IPGRE, /* DECnet tunneled over GRE in IP */
 	.mode =		DN_DEV_BCAST,
 	.state =	DN_DEV_S_RU,
-	.blksize =	1400,
 	.t2 =		1,
 	.t3 =		10,
 	.name =		"ipgre",
@@ -106,7 +105,6 @@
 	.type =		ARPHRD_X25, /* Bog standard X.25 */
 	.mode =		DN_DEV_UCAST,
 	.state =	DN_DEV_S_DS,
-	.blksize =	230,
 	.t2 =		1,
 	.t3 =		120,
 	.name =		"x25",
@@ -119,7 +117,6 @@
 	.type =		ARPHRD_PPP, /* DECnet over PPP */
 	.mode =		DN_DEV_BCAST,
 	.state =	DN_DEV_S_RU,
-	.blksize =	230,
 	.t2 =		1,
 	.t3 =		10,
 	.name =		"ppp",
@@ -127,24 +124,20 @@
 	.timer3 =	dn_send_brd_hello,
 },
 #endif
-#if 0
 {
 	.type =		ARPHRD_DDCMP, /* DECnet over DDCMP */
 	.mode =		DN_DEV_UCAST,
 	.state =	DN_DEV_S_DS,
-	.blksize =	230,
 	.t2 =		1,
 	.t3 =		120,
 	.name =		"ddcmp",
 	.ctl_name =	NET_DECNET_CONF_DDCMP,
 	.timer3 =	dn_send_ptp_hello,
 },
-#endif
 {
 	.type =		ARPHRD_LOOPBACK, /* Loopback interface - always last */
 	.mode =		DN_DEV_BCAST,
 	.state =	DN_DEV_S_RU,
-	.blksize =	1498,
 	.t2 =		1,
 	.t3 =		10,
 	.name =		"loopback",
@@ -254,6 +247,21 @@
 	}, {0}}
 };
 
+static inline __u16 mtu2blksize(struct net_device *dev)
+{
+	u32 blksize = dev->mtu;
+	if (blksize > 0xffff)
+		blksize = 0xffff;
+
+	if (dev->type == ARPHRD_ETHER ||
+	    dev->type == ARPHRD_PPP ||
+	    dev->type == ARPHRD_IPGRE ||
+	    dev->type == ARPHRD_LOOPBACK)
+		blksize -= 2;
+
+	return (__u16)blksize;
+}
+
 static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *parms)
 {
 	struct dn_dev_sysctl_table *t;
@@ -858,7 +866,7 @@
         memcpy(msg->tiver, dn_eco_version, 3);
 	dn_dn2eth(msg->id, ifa->ifa_local);
         msg->iinfo   = DN_RT_INFO_ENDN;
-        msg->blksize = dn_htons(dn_db->parms.blksize);
+        msg->blksize = dn_htons(mtu2blksize(dev));
         msg->area    = 0x00;
         memset(msg->seed, 0, 8);
         memcpy(msg->neighbor, dn_hiord, ETH_ALEN);
@@ -920,10 +928,10 @@
 	unsigned short *pktlen;
 	char *src;
 
-	if (dn_db->parms.blksize < (26 + 7))
+	if (mtu2blksize(dev) < (26 + 7))
 		return;
 
-	n = dn_db->parms.blksize - 26;
+	n = mtu2blksize(dev) - 26;
 	n /= 7;
 
 	if (n > 32)
@@ -946,7 +954,7 @@
 	ptr += ETH_ALEN;
 	*ptr++ = dn_db->parms.forwarding == 1 ? 
 			DN_RT_INFO_L1RT : DN_RT_INFO_L2RT;
-	*((unsigned short *)ptr) = dn_htons(dn_db->parms.blksize);
+	*((unsigned short *)ptr) = dn_htons(mtu2blksize(dev));
 	ptr += 2;
 	*ptr++ = dn_db->parms.priority; /* Priority */ 
 	*ptr++ = 0; /* Area: Reserved */
@@ -990,16 +998,13 @@
 		dn_send_router_hello(dev, ifa);
 }
 
-#if 0
 static void dn_send_ptp_hello(struct net_device *dev, struct dn_ifaddr *ifa)
 {
 	int tdlen = 16;
 	int size = dev->hard_header_len + 2 + 4 + tdlen;
 	struct sk_buff *skb = dn_alloc_skb(NULL, size, GFP_ATOMIC);
-	struct dn_dev *dn_db = dev->dn_ptr;
 	int i;
 	unsigned char *ptr;
-	struct dn_neigh *dn = (struct dn_neigh *)dn_db->router;
 	char src[ETH_ALEN];
 
 	if (skb == NULL)
@@ -1020,7 +1025,6 @@
 	dn_dn2eth(src, ifa->ifa_local);
 	dn_rt_finish_output(skb, dn_rt_all_rt_mcast, src);
 }
-#endif
 
 static int dn_eth_up(struct net_device *dev)
 {
@@ -1332,6 +1336,63 @@
 
 
 #ifdef CONFIG_PROC_FS
+static inline struct net_device *dn_dev_get_next(struct seq_file *seq, struct net_device *dev)
+{
+	do {
+		dev = dev->next;
+	} while(dev && !dev->dn_ptr);
+
+	return dev;
+}
+
+static struct net_device *dn_dev_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct net_device *dev;
+
+	dev = dev_base;
+	if (dev && !dev->dn_ptr)
+		dev = dn_dev_get_next(seq, dev);
+	if (pos) {
+		while(dev && (dev = dn_dev_get_next(seq, dev)))
+			--pos;
+	}
+	return dev;
+}
+
+static void *dn_dev_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos) {
+		struct net_device *dev;
+		read_lock(&dev_base_lock);
+		dev = dn_dev_get_idx(seq, *pos - 1);
+		if (dev == NULL)
+			read_unlock(&dev_base_lock);
+		return dev;
+	}
+	return (void*)1;
+}
+
+static void *dn_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct net_device *dev = v;
+	loff_t one = 1;
+
+	if (v == (void*)1) {
+		dev = dn_dev_seq_start(seq, &one);
+	} else {
+		dev = dn_dev_get_next(seq, dev);
+		if (dev == NULL)
+			read_unlock(&dev_base_lock);
+	}
+	++*pos;
+	return dev;
+}
+
+static void dn_dev_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v && v != (void*)1)
+		read_unlock(&dev_base_lock);
+}
 
 static char *dn_type2asc(char type)
 {
@@ -1347,56 +1408,50 @@
 	return "?";
 }
 
-static int decnet_dev_get_info(char *buffer, char **start, off_t offset, int length)
+static int dn_dev_seq_show(struct seq_file *seq, void *v)
 {
-        struct dn_dev *dn_db;
-	struct net_device *dev;
-        int len = 0;
-        off_t pos = 0;
-        off_t begin = 0;
-	char peer_buf[DN_ASCBUF_LEN];
-	char router_buf[DN_ASCBUF_LEN];
-
+	if (v == (void*)1)
+        	seq_puts(seq, "Name     Flags T1   Timer1 T3   Timer3 BlkSize Pri State DevType    Router Peer\n");
+	else {
+		struct net_device *dev = v;
+		char peer_buf[DN_ASCBUF_LEN];
+		char router_buf[DN_ASCBUF_LEN];
+		struct dn_dev *dn_db = dev->dn_ptr;
 
-        len += sprintf(buffer, "Name     Flags T1   Timer1 T3   Timer3 BlkSize Pri State DevType    Router Peer\n");
-
-	read_lock(&dev_base_lock);
-        for (dev = dev_base; dev; dev = dev->next) {
-		if ((dn_db = (struct dn_dev *)dev->dn_ptr) == NULL)
-			continue;
-
-                len += sprintf(buffer + len, "%-8s %1s     %04u %04u   %04lu %04lu   %04hu    %03d %02x    %-10s %-7s %-7s\n",
+                seq_printf(seq, "%-8s %1s     %04u %04u   %04lu %04lu"
+				"   %04hu    %03d %02x    %-10s %-7s %-7s\n",
                              	dev->name ? dev->name : "???",
                              	dn_type2asc(dn_db->parms.mode),
                              	0, 0,
 				dn_db->t3, dn_db->parms.t3,
-				dn_db->parms.blksize,
+				mtu2blksize(dev),
 				dn_db->parms.priority,
 				dn_db->parms.state, dn_db->parms.name,
 				dn_db->router ? dn_addr2asc(dn_ntohs(*(dn_address *)dn_db->router->primary_key), router_buf) : "",
 				dn_db->peer ? dn_addr2asc(dn_ntohs(*(dn_address *)dn_db->peer->primary_key), peer_buf) : "");
+	}
+	return 0;
+}
 
+static struct seq_operations dn_dev_seq_ops = {
+	.start	= dn_dev_seq_start,
+	.next	= dn_dev_seq_next,
+	.stop	= dn_dev_seq_stop,
+	.show	= dn_dev_seq_show,
+};
 
-                pos = begin + len;
-
-                if (pos < offset) {
-                        len   = 0;
-                        begin = pos;
-                }
-                if (pos > offset + length)
-                        break;
-        }
-
-	read_unlock(&dev_base_lock);
-
-        *start = buffer + (offset - begin);
-        len   -= (offset - begin);
-
-        if (len > length) len = length;
-
-        return(len);
+static int dn_dev_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dn_dev_seq_ops);
 }
 
+static struct file_operations dn_dev_seq_fops = {
+	.open	 = dn_dev_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = seq_release,
+};
+
 #endif /* CONFIG_PROC_FS */
 
 static struct rtnetlink_link dnet_rtnetlink_table[RTM_MAX-RTM_BASE+1] = 
@@ -1448,9 +1503,7 @@
 
 	rtnetlink_links[PF_DECnet] = dnet_rtnetlink_table;
 
-#ifdef CONFIG_PROC_FS
-	proc_net_create("decnet_dev", 0, decnet_dev_get_info);
-#endif /* CONFIG_PROC_FS */
+	proc_net_fops_create("decnet_dev", S_IRUGO, &dn_dev_seq_fops);
 
 #ifdef CONFIG_SYSCTL
 	{
diff -Nru linux-2.5.68-bk10/net/decnet/dn_fib.c linux/net/decnet/dn_fib.c
--- linux-2.5.68-bk10/net/decnet/dn_fib.c	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/dn_fib.c	Mon Apr 28 10:21:48 2003
@@ -67,18 +67,18 @@
 	int error;
 	u8 scope;
 } dn_fib_props[RTA_MAX+1] = {
-	{ .error = 0, .scope = RT_SCOPE_NOWHERE },	  /* RTN_UNSPEC */
-	{ .error = 0, .scope = RT_SCOPE_UNIVERSE },	  /* RTN_UNICAST */
-	{ .error = 0, .scope = RT_SCOPE_HOST },		  /* RTN_LOCAL */
-	{ .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },  /* RTN_BROADCAST */
-	{ .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },  /* RTN_ANYCAST */
-	{ .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },  /* RTN_MULTICAST */
-	{ .error = -EINVAL, .scope = RT_SCOPE_UNIVERSE }, /* RTN_BLACKHOLE */
-	{ .error = -EHOSTUNREACH, .scope = RT_SCOPE_UNIVERSE },	/* RTN_UNREACHABLE */
-	{ .error = -EACCES, .scope = RT_SCOPE_UNIVERSE }, /* RTN_PROHIBIT */
-	{ .error = -EAGAIN, .scope = RT_SCOPE_UNIVERSE }, /* RTN_THROW */
-	{ .error = 0, .scope = RT_SCOPE_NOWHERE },  /* RTN_NAT */
-	{ .error = -EINVAL, .scope = RT_SCOPE_NOWHERE }	  /* RTN_XRESOLVE */
+	[RTN_UNSPEC] =      { .error = 0,       .scope = RT_SCOPE_NOWHERE },
+	[RTN_UNICAST] =     { .error = 0,       .scope = RT_SCOPE_UNIVERSE },
+	[RTN_LOCAL] =       { .error = 0,       .scope = RT_SCOPE_HOST },
+	[RTN_BROADCAST] =   { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
+	[RTN_ANYCAST] =     { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
+	[RTN_MULTICAST] =   { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
+	[RTN_BLACKHOLE] =   { .error = -EINVAL, .scope = RT_SCOPE_UNIVERSE },
+	[RTN_UNREACHABLE] = { .error = -EHOSTUNREACH, .scope = RT_SCOPE_UNIVERSE },
+	[RTN_PROHIBIT] =    { .error = -EACCES, .scope = RT_SCOPE_UNIVERSE },
+	[RTN_THROW] =       { .error = -EAGAIN, .scope = RT_SCOPE_UNIVERSE },
+	[RTN_NAT] =         { .error = 0,       .scope = RT_SCOPE_NOWHERE },
+	[RTN_XRESOLVE] =    { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
 };
 
 void dn_fib_free_info(struct dn_fib_info *fi)
@@ -792,53 +792,12 @@
                 dn_rt_cache_flush(-1);
 }
 
-#ifdef CONFIG_PROC_FS
-
-static int decnet_rt_get_info(char *buffer, char **start, off_t offset, int length)
-{
-        int first = offset / 128;
-        char *ptr = buffer;
-        int count = (length + 127) / 128;
-        int len;
-        int i;
-        struct dn_fib_table *tb;
-
-        *start = buffer + (offset % 128);
-
-        if (--first < 0) {
-                sprintf(buffer, "%-127s\n", "Iface\tDest\tGW  \tFlags\tRefCnt\tUse\tMetric\tMask\t\tMTU\tWindow\tIRTT");
-                --count;
-                ptr += 128;
-                first = 0;
-        }
-
-
-        for(i = RT_MIN_TABLE; (i <= RT_TABLE_MAX) && (count > 0); i++) {
-                if ((tb = dn_fib_get_table(i, 0)) != NULL) {
-                        int n = tb->get_info(tb, ptr, first, count);
-                        count -= n;
-                        ptr += n * 128;
-                }
-        }
-
-        len = ptr - *start;
-        if (len >= length)
-                return length;
-        if (len >= 0)
-                return len;
-
-        return 0;
-}
-#endif /* CONFIG_PROC_FS */
-
 static struct notifier_block dn_fib_dnaddr_notifier = {
 	.notifier_call = dn_fib_dnaddr_event,
 };
 
 void __exit dn_fib_cleanup(void)
 {
-	proc_net_remove("decnet_route");
-
 	dn_fib_table_cleanup();
 	dn_fib_rules_cleanup();
 
@@ -848,10 +807,6 @@
 
 void __init dn_fib_init(void)
 {
-
-#ifdef CONFIG_PROC_FS
-	proc_net_create("decnet_route", 0, decnet_rt_get_info);
-#endif
 
 	dn_fib_table_init();
 	dn_fib_rules_init();
diff -Nru linux-2.5.68-bk10/net/decnet/dn_neigh.c linux/net/decnet/dn_neigh.c
--- linux-2.5.68-bk10/net/decnet/dn_neigh.c	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/dn_neigh.c	Wed Apr 23 13:37:47 2003
@@ -202,7 +202,7 @@
 	struct net_device *dev = neigh->dev;
 	char mac_addr[ETH_ALEN];
 
-	dn_dn2eth(mac_addr, rt->rt_saddr);
+	dn_dn2eth(mac_addr, rt->rt_local_src);
 	if (!dev->hard_header || dev->hard_header(skb, dev, ntohs(skb->protocol), neigh->ha, mac_addr, skb->len) >= 0)
 		return neigh->ops->queue_xmit(skb);
 
@@ -692,48 +692,23 @@
 	goto out;
 }
 
-static int dn_seq_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq  = (struct seq_file *)file->private_data;
-
-	kfree(seq->private);
-	seq->private = NULL;
-	return seq_release(inode, file);
-}
-
 static struct file_operations dn_neigh_seq_fops = {
 	.open		= dn_neigh_seq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= dn_seq_release,
+	.release	= kfree_release,
 };
 
-static int __init dn_neigh_proc_init(void)
-{
-	int rc = 0;
-	struct proc_dir_entry *p = create_proc_entry("decnet_neigh", S_IRUGO, proc_net);
-	if (p)
-		p->proc_fops = &dn_neigh_seq_fops;
-	else
-		rc = -ENOMEM;
-	return rc;
-}
-
-#else
-static int __init dn_neigh_proc_init(void)
-{
-	return 0;
-}
 #endif
 
 void __init dn_neigh_init(void)
 {
 	neigh_table_init(&dn_neigh_table);
-
-	dn_neigh_proc_init();
+	proc_net_fops_create("decnet_neigh", S_IRUGO, &dn_neigh_seq_fops);
 }
 
 void __exit dn_neigh_cleanup(void)
 {
+	proc_net_remove("decnet_neigh");
 	neigh_table_clear(&dn_neigh_table);
 }
diff -Nru linux-2.5.68-bk10/net/decnet/dn_nsp_in.c linux/net/decnet/dn_nsp_in.c
--- linux-2.5.68-bk10/net/decnet/dn_nsp_in.c	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/dn_nsp_in.c	Thu May  1 05:46:52 2003
@@ -28,6 +28,7 @@
  *    Steve Whitehouse:  Added backlog congestion level return codes.
  *   Patrick Caulfield:
  *    Steve Whitehouse:  Added flow control support (outbound)
+ *    Steve Whitehouse:  Prepare for nonlinear skbs
  */
 
 /******************************************************************************
@@ -240,7 +241,7 @@
 	cb->info     = msg->info;
 	cb->segsize  = dn_ntohs(msg->segsize);
 
-	if (skb->len < sizeof(*msg))
+	if (!pskb_may_pull(skb, sizeof(*msg)))
 		goto err_out;
 
 	skb_pull(skb, sizeof(*msg));
@@ -721,34 +722,19 @@
 	unsigned char *ptr = (unsigned char *)skb->data;
 	unsigned short reason = NSP_REASON_NL;
 
+	if (!pskb_may_pull(skb, 2))
+		goto free_out;
+
 	skb->h.raw    = skb->data;
 	cb->nsp_flags = *ptr++;
 
 	if (decnet_debug_level & 2)
 		printk(KERN_DEBUG "dn_nsp_rx: Message type 0x%02x\n", (int)cb->nsp_flags);
 
-	if (skb->len < 2) 
-		goto free_out;
-
 	if (cb->nsp_flags & 0x83) 
 		goto free_out;
 
 	/*
-	 * Returned packets...
-	 * Swap src & dst and look up in the normal way.
-	 */
-	if (cb->rt_flags & DN_RT_F_RTS) {
-		unsigned short tmp = cb->dst_port;
-		cb->dst_port = cb->src_port;
-		cb->src_port = tmp;
-		tmp = cb->dst;
-		cb->dst = cb->src;
-		cb->src = tmp;
-		sk = dn_find_by_skb(skb);
-		goto got_it;
-	}
-
-	/*
 	 * Filter out conninits and useless packet types
 	 */
 	if ((cb->nsp_flags & 0x0c) == 0x08) {
@@ -759,12 +745,14 @@
 				goto free_out;
 			case 0x10:
 			case 0x60:
+				if (unlikely(cb->rt_flags & DN_RT_F_RTS))
+					goto free_out;
 				sk = dn_find_listener(skb, &reason);
 				goto got_it;
 		}
 	}
 
-	if (skb->len < 3)
+	if (!pskb_may_pull(skb, 3))
 		goto free_out;
 
 	/*
@@ -777,13 +765,26 @@
 	/*
 	 * If not a connack, grab the source address too.
 	 */
-	if (skb->len >= 5) {
+	if (pskb_may_pull(skb, 5)) {
 		cb->src_port = *(unsigned short *)ptr;
 		ptr += 2;
 		skb_pull(skb, 5);
 	}
 
 	/*
+	 * Returned packets...
+	 * Swap src & dst and look up in the normal way.
+	 */
+	if (unlikely(cb->rt_flags & DN_RT_F_RTS)) {
+		unsigned short tmp = cb->dst_port;
+		cb->dst_port = cb->src_port;
+		cb->src_port = tmp;
+		tmp = cb->dst;
+		cb->dst = cb->src;
+		cb->src = tmp;
+	}
+
+	/*
 	 * Find the socket to which this skb is destined.
 	 */
 	sk = dn_find_by_skb(skb);
@@ -795,6 +796,15 @@
 		/* Reset backoff */
 		scp->nsp_rxtshift = 0;
 
+		/*
+		 * We linearize everything except data segments here.
+		 */
+		if (cb->nsp_flags & ~0x60) {
+			if (unlikely(skb_is_nonlinear(skb)) &&
+			    skb_linearize(skb, GFP_ATOMIC) != 0)
+				goto free_out;
+		}
+
 		bh_lock_sock(sk);
 		ret = NET_RX_SUCCESS;
 		if (decnet_debug_level & 8)
@@ -835,7 +845,10 @@
 	struct dn_skb_cb *cb = DN_SKB_CB(skb);
 
 	if (cb->rt_flags & DN_RT_F_RTS) {
-		dn_returned_conn_init(sk, skb);
+		if (cb->nsp_flags == 0x18 || cb->nsp_flags == 0x68)
+			dn_returned_conn_init(sk, skb);
+		else
+			kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
diff -Nru linux-2.5.68-bk10/net/decnet/dn_nsp_out.c linux/net/decnet/dn_nsp_out.c
--- linux-2.5.68-bk10/net/decnet/dn_nsp_out.c	Thu May  1 03:00:23 2003
+++ linux/net/decnet/dn_nsp_out.c	Thu May  1 03:00:49 2003
@@ -96,6 +96,7 @@
 	fl.fld_src = dn_saddr2dn(&scp->addr);
 	fl.fld_dst = dn_saddr2dn(&scp->peer);
 	dn_sk_ports_copy(&fl, scp);
+	fl.proto = DNPROTO_NSP;
 	if (dn_route_output_sock(&sk->dst_cache, &fl, sk, 0) == 0) {
 		dst = sk_dst_get(sk);
 		sk->route_caps = dst->dev->features;
@@ -349,8 +350,7 @@
 {
 	unsigned char *ptr = skb_push(skb, len);
 
-	if (len < 5)
-		BUG();
+	BUG_ON(len < 5);
 
 	*ptr++ = msgflag;
 	*((unsigned short *)ptr) = scp->addrrem;
@@ -367,8 +367,7 @@
 	unsigned short ackcrs = scp->numoth_rcv & 0x0FFF;
 	unsigned short *ptr;
 
-	if (hlen < 9)
-		BUG();
+	BUG_ON(hlen < 9);
 
 	scp->ackxmt_dat = acknum;
 	scp->ackxmt_oth = ackcrs;
@@ -485,8 +484,8 @@
 		 * We don't expect to see acknowledgements for packets we
 		 * haven't sent yet.
 		 */
-		if (xmit_count == 0)
-			BUG();
+		WARN_ON(xmit_count == 0);
+
 		/*
 		 * If the packet has only been sent once, we can use it
 		 * to calculate the RTT and also open the window a little
diff -Nru linux-2.5.68-bk10/net/decnet/dn_route.c linux/net/decnet/dn_route.c
--- linux-2.5.68-bk10/net/decnet/dn_route.c	Thu May  1 03:00:23 2003
+++ linux/net/decnet/dn_route.c	Thu May  1 05:21:11 2003
@@ -39,6 +39,7 @@
  *                                 no ref count on net devices.
  *              Steve Whitehouse : RCU for the route cache
  *              Steve Whitehouse : Preparations for the flow cache
+ *              Steve Whitehouse : Prepare for nonlinear skbs
  */
 
 /******************************************************************************
@@ -70,6 +71,7 @@
 #include <net/sock.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/string.h>
@@ -97,14 +99,17 @@
 
 static unsigned char dn_hiord_addr[6] = {0xAA,0x00,0x04,0x00,0x00,0x00};
 
-int dn_rt_min_delay = 2*HZ;
-int dn_rt_max_delay = 10*HZ;
-static unsigned long dn_rt_deadline = 0;
+int dn_rt_min_delay = 2 * HZ;
+int dn_rt_max_delay = 10 * HZ;
+int dn_rt_mtu_expires = 10 * 60 * HZ;
+
+static unsigned long dn_rt_deadline;
 
 static int dn_dst_gc(void);
 static struct dst_entry *dn_dst_check(struct dst_entry *, __u32);
 static struct dst_entry *dn_dst_negative_advice(struct dst_entry *);
 static void dn_dst_link_failure(struct sk_buff *);
+static void dn_dst_update_pmtu(struct dst_entry *dst, u32 mtu);
 static int dn_route_input(struct sk_buff *);
 static void dn_run_flush(unsigned long dummy);
 
@@ -124,6 +129,7 @@
 	.check =		dn_dst_check,
 	.negative_advice =	dn_dst_negative_advice,
 	.link_failure =		dn_dst_link_failure,
+	.update_pmtu =		dn_dst_update_pmtu,
 	.entry_size =		sizeof(struct dn_route),
 	.entries =		ATOMIC_INIT(0),
 };
@@ -210,16 +216,49 @@
 	return 0;
 }
 
+/*
+ * The decnet standards don't impose a particular minimum mtu, what they
+ * do insist on is that the routing layer accepts a datagram of at least
+ * 230 bytes long. Here we have to subtract the routing header length from
+ * 230 to get the minimum acceptable mtu. If there is no neighbour, then we
+ * assume the worst and use a long header size.
+ *
+ * We update both the mtu and the advertised mss (i.e. the segment size we
+ * advertise to the other end).
+ */
+static void dn_dst_update_pmtu(struct dst_entry *dst, u32 mtu)
+{
+	u32 min_mtu = 230;
+	struct dn_dev *dn = dst->neighbour ?
+			    (struct dn_dev *)dst->neighbour->dev->dn_ptr : NULL;
+
+	if (dn && dn->use_long == 0)
+		min_mtu -= 6;
+	else
+		min_mtu -= 21;
+
+	if (dst->metrics[RTAX_MTU-1] > mtu && mtu >= min_mtu) {
+		if (!(dst_metric_locked(dst, RTAX_MTU))) {
+			dst->metrics[RTAX_MTU-1] = mtu;
+			dst_set_expires(dst, dn_rt_mtu_expires);
+		}
+		if (!(dst_metric_locked(dst, RTAX_ADVMSS))) {
+			u32 mss = mtu - DN_MAX_NSP_DATA_HEADER;
+			if (dst->metrics[RTAX_ADVMSS-1] > mss)
+				dst->metrics[RTAX_ADVMSS-1] = mss;
+		}
+	}
+}
+
+/* 
+ * When a route has been marked obsolete. (e.g. routing cache flush)
+ */
 static struct dst_entry *dn_dst_check(struct dst_entry *dst, __u32 cookie)
 {
 	dst_release(dst);
 	return NULL;
 }
 
-/*
- * This is called through sendmsg() when you specify MSG_TRYHARD
- * and there is already a route in cache.
- */
 static struct dst_entry *dn_dst_negative_advice(struct dst_entry *dst)
 {
 	dst_release(dst);
@@ -467,7 +506,7 @@
 	struct dn_skb_cb *cb = DN_SKB_CB(skb);
 	unsigned char *ptr = skb->data;
 
-	if (skb->len < 21) /* 20 for long header, 1 for shortest nsp */
+	if (!pskb_may_pull(skb, 21)) /* 20 for long header, 1 for shortest nsp */
 		goto drop_it;
 
 	skb_pull(skb, 20);
@@ -505,7 +544,7 @@
 	struct dn_skb_cb *cb = DN_SKB_CB(skb);
 	unsigned char *ptr = skb->data;
 
-	if (skb->len < 6) /* 5 for short header + 1 for shortest nsp */
+	if (!pskb_may_pull(skb, 6)) /* 5 for short header + 1 for shortest nsp */
 		goto drop_it;
 
 	skb_pull(skb, 5);
@@ -555,6 +594,9 @@
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
 		goto out;
 
+	if (!pskb_may_pull(skb, 3))
+		goto dump_it;
+
 	skb_pull(skb, 2);
 
 	if (len > skb->len)
@@ -573,6 +615,8 @@
 	 */
 	if (flags & DN_RT_F_PF) {
 		padlen = flags & ~DN_RT_F_PF;
+		if (!pskb_may_pull(skb, padlen + 1))
+			goto dump_it;
 		skb_pull(skb, padlen);
 		flags = *skb->data;
 	}
@@ -594,6 +638,10 @@
 			padlen);
 
         if (flags & DN_RT_PKT_CNTL) {
+		if (unlikely(skb_is_nonlinear(skb)) &&
+		    skb_linearize(skb, GFP_ATOMIC) != 0)
+			goto dump_it;
+
                 switch(flags & DN_RT_CNTL_MSK) {
         	        case DN_RT_PKT_INIT:
 				dn_dev_init_pkt(skb);
@@ -712,7 +760,7 @@
 	 * packets, so we don't need to test for them here.
 	 */
 	cb->rt_flags &= ~DN_RT_F_IE;
-	if (rt->rt_flags | RTCF_DOREDIRECT)
+	if (rt->rt_flags & RTCF_DOREDIRECT)
 		cb->rt_flags |= DN_RT_F_IE;
 
 	return NF_HOOK(PF_DECnet, NF_DN_FORWARD, skb, dev, skb->dev, neigh->output);
@@ -788,8 +836,10 @@
 {
 	__u16 tmp = dn_ntohs(addr1) ^ dn_ntohs(addr2);
 	int match = 16;
-	while(tmp)
-		tmp >>= 1, match--;
+	while(tmp) {
+		tmp >>= 1;
+		match--;
+	}
 	return match;
 }
 
@@ -899,17 +949,19 @@
 	/* No destination? Assume its local */
 	if (!fl.fld_dst) {
 		fl.fld_dst = fl.fld_src;
-#if 0
-		if (!fl.fld_dst)
-			/* grab an address from loopback? */
-#endif
+
 		err = -EADDRNOTAVAIL;
 		if (dev_out)
 			dev_put(dev_out);
-		if (!fl.fld_dst)
-			goto out;
 		dev_out = &loopback_dev;
 		dev_hold(dev_out);
+		if (!fl.fld_dst) {
+			fl.fld_dst =
+			fl.fld_src = dnet_select_source(dev_out, 0,
+						       RT_SCOPE_HOST);
+			if (!fl.fld_dst)
+				goto out;
+		}
 		fl.oif = loopback_dev.ifindex;
 		res.type = RTN_LOCAL;
 		goto make_route;
@@ -1055,12 +1107,13 @@
 	rt->fl.oif        = oldflp->oif;
 	rt->fl.iif        = 0;
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
-	rt->fl.fld_fwmark = flp->fld_fwmark;
+	rt->fl.fld_fwmark = oldflp->fld_fwmark;
 #endif
 
 	rt->rt_saddr      = fl.fld_src;
 	rt->rt_daddr      = fl.fld_dst;
 	rt->rt_gateway    = gateway ? gateway : fl.fld_dst;
+	rt->rt_local_src  = fl.fld_src;
 
 	rt->rt_dst_map    = fl.fld_dst;
 	rt->rt_src_map    = fl.fld_src;
@@ -1075,14 +1128,14 @@
 	rt->u.dst.input   = dn_rt_bug;
 	rt->rt_flags      = flags;
 	if (flags & RTCF_LOCAL)
-		rt->u.dst.output = dn_nsp_rx;
+		rt->u.dst.input = dn_nsp_rx;
 
-	if (dn_rt_set_next_hop(rt, &res))
+	err = dn_rt_set_next_hop(rt, &res);
+	if (err)
 		goto e_neighbour;
 
 	hash = dn_hash(rt->fl.fld_src, rt->fl.fld_dst);
 	dn_insert_route(rt, hash, (struct dn_route **)pprt);
-	err = 0;
 
 done:
 	if (neigh)
@@ -1175,12 +1228,13 @@
 	unsigned hash;
 	int flags = 0;
 	__u16 gateway = 0;
+	__u16 local_src = 0;
 	struct flowi fl = { .nl_u = { .dn_u = 
 				     { .daddr = cb->dst,
 				       .saddr = cb->src,
 				       .scope = RT_SCOPE_UNIVERSE,
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
-				       .fwmark = skb->fwmark
+				       .fwmark = skb->nfmark
 #endif
 				    } },
 			    .iif = skb->dev->ifindex };
@@ -1275,6 +1329,8 @@
 		if (out_dev == in_dev && !(flags & RTCF_NAT))
 			flags |= RTCF_DOREDIRECT;
 
+		local_src = DN_FIB_RES_PREFSRC(res);
+
 	case RTN_BLACKHOLE:
 	case RTN_UNREACHABLE:
 		break;
@@ -1319,6 +1375,8 @@
 	rt->rt_gateway    = fl.fld_dst;
 	if (gateway)
 		rt->rt_gateway = gateway;
+	rt->rt_local_src  = local_src ? local_src : rt->rt_saddr;
+
 	rt->rt_dst_map    = fl.fld_dst;
 	rt->rt_src_map    = fl.fld_src;
 
@@ -1352,12 +1410,12 @@
 	if (rt->u.dst.dev)
 		dev_hold(rt->u.dst.dev);
 
-	if (dn_rt_set_next_hop(rt, &res))
+	err = dn_rt_set_next_hop(rt, &res);
+	if (err)
 		goto e_neighbour;
 
 	hash = dn_hash(rt->fl.fld_src, rt->fl.fld_dst);
 	dn_insert_route(rt, hash, (struct dn_route **)&skb->dst);
-	err = 0;
 
 done:
 	if (neigh)
@@ -1449,7 +1507,7 @@
 	 * they deal only with inputs and not with replies like they do
 	 * currently.
 	 */
-	RTA_PUT(skb, RTA_PREFSRC, 2, &rt->rt_saddr);
+	RTA_PUT(skb, RTA_PREFSRC, 2, &rt->rt_local_src);
 	if (rt->rt_daddr != rt->rt_gateway)
 		RTA_PUT(skb, RTA_GATEWAY, 2, &rt->rt_gateway);
 	if (rtnetlink_put_metrics(skb, rt->u.dst.metrics) < 0)
@@ -1490,6 +1548,7 @@
 	struct flowi fl;
 
 	memset(&fl, 0, sizeof(fl));
+	fl.proto = DNPROTO_NSP;
 
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (skb == NULL)
@@ -1609,54 +1668,114 @@
 }
 
 #ifdef CONFIG_PROC_FS
+struct dn_rt_cache_iter_state {
+	int bucket;
+};
 
-static int decnet_cache_get_info(char *buffer, char **start, off_t offset, int length)
+static struct dn_route *dn_rt_cache_get_first(struct seq_file *seq)
 {
-        int len = 0;
-        off_t pos = 0;
-        off_t begin = 0;
-	struct dn_route *rt;
-	int i;
-	char buf1[DN_ASCBUF_LEN], buf2[DN_ASCBUF_LEN];
+	struct dn_route *rt = NULL;
+	struct dn_rt_cache_iter_state *s = seq->private;
 
-	for(i = 0; i <= dn_rt_hash_mask; i++) {
+	for(s->bucket = dn_rt_hash_mask; s->bucket >= 0; --s->bucket) {
 		rcu_read_lock();
-		rt = dn_rt_hash_table[i].chain;
-		for(; rt != NULL; rt = rt->u.rt_next) {
-			read_barrier_depends();
-			len += sprintf(buffer + len, "%-8s %-7s %-7s %04d %04d %04d\n",
-					rt->u.dst.dev ? rt->u.dst.dev->name : "*",
-					dn_addr2asc(dn_ntohs(rt->rt_daddr), buf1),
-					dn_addr2asc(dn_ntohs(rt->rt_saddr), buf2),
-					atomic_read(&rt->u.dst.__refcnt),
-					rt->u.dst.__use,
-					(int) dst_metric(&rt->u.dst, RTAX_RTT)
-					);
-
+		rt = dn_rt_hash_table[s->bucket].chain;
+		if (rt)
+			break;
+		rcu_read_unlock();
+	}
+	return rt;
+}
 
+static struct dn_route *dn_rt_cache_get_next(struct seq_file *seq, struct dn_route *rt)
+{
+	struct dn_rt_cache_iter_state *s = seq->private;
 
-	                pos = begin + len;
-	
-        	        if (pos < offset) {
-                	        len   = 0;
-                        	begin = pos;
-                	}
-              		if (pos > offset + length)
-                	        break;
-		}
+	smp_read_barrier_depends();
+	rt = rt->u.rt_next;
+	while(!rt) {
 		rcu_read_unlock();
-		if (pos > offset + length)
+		if (--s->bucket < 0)
 			break;
+		rcu_read_lock();
+		rt = dn_rt_hash_table[s->bucket].chain;
 	}
+	return rt;
+}
+
+static void *dn_rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct dn_route *rt = dn_rt_cache_get_first(seq);
+
+	if (rt) {
+		while(*pos && (rt = dn_rt_cache_get_next(seq, rt)))
+			--*pos;
+	}
+	return *pos ? NULL : rt;
+}
+
+static void *dn_rt_cache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct dn_route *rt = dn_rt_cache_get_next(seq, v);
+	++*pos;
+	return rt;
+}
 
-        *start = buffer + (offset - begin);
-        len   -= (offset - begin);
+static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
+{
+	rcu_read_unlock();
+}
 
-        if (len > length) len = length;
+static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)
+{
+	struct dn_route *rt = v;
+	char buf1[DN_ASCBUF_LEN], buf2[DN_ASCBUF_LEN];
 
-        return(len);
+	seq_printf(seq, "%-8s %-7s %-7s %04d %04d %04d\n",
+			rt->u.dst.dev ? rt->u.dst.dev->name : "*",
+			dn_addr2asc(dn_ntohs(rt->rt_daddr), buf1),
+			dn_addr2asc(dn_ntohs(rt->rt_saddr), buf2),
+			atomic_read(&rt->u.dst.__refcnt),
+			rt->u.dst.__use,
+			(int) dst_metric(&rt->u.dst, RTAX_RTT));
+	return 0;
 } 
 
+static struct seq_operations dn_rt_cache_seq_ops = {
+	.start	= dn_rt_cache_seq_start,
+	.next	= dn_rt_cache_seq_next,
+	.stop	= dn_rt_cache_seq_stop,
+	.show	= dn_rt_cache_seq_show,
+};
+
+static int dn_rt_cache_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct dn_rt_cache_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+
+	if (!s)
+		goto out;
+	rc = seq_open(file, &dn_rt_cache_seq_ops);
+	if (rc)
+		goto out_kfree;
+	seq		= file->private_data;
+	seq->private	= s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
+
+static struct file_operations dn_rt_cache_seq_fops = {
+	.open	 = dn_rt_cache_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = kfree_release,
+};
+
 #endif /* CONFIG_PROC_FS */
 
 void __init dn_route_init(void)
@@ -1714,9 +1833,7 @@
 
         dn_dst_ops.gc_thresh = (dn_rt_hash_mask + 1);
 
-#ifdef CONFIG_PROC_FS
-	proc_net_create("decnet_cache",0,decnet_cache_get_info);
-#endif /* CONFIG_PROC_FS */
+	proc_net_fops_create("decnet_cache", S_IRUGO, &dn_rt_cache_seq_fops);
 }
 
 void __exit dn_route_cleanup(void)
diff -Nru linux-2.5.68-bk10/net/decnet/dn_table.c linux/net/decnet/dn_table.c
--- linux-2.5.68-bk10/net/decnet/dn_table.c	Sun Apr 20 03:28:01 2003
+++ linux/net/decnet/dn_table.c	Wed Apr 23 09:43:16 2003
@@ -744,86 +744,6 @@
         return err;
 }
 
-#ifdef CONFIG_PROC_FS
-
-static unsigned dn_fib_flag_trans(int type, int dead, u16 mask, struct dn_fib_info *fi)
-{
-	static unsigned type2flags[RTN_MAX+1] = {
-		0, 0, 0, 0, 0, 0, 0, RTF_REJECT, RTF_REJECT, 0, 0, 0
-	};
-	unsigned flags = type2flags[type];
-
-	if (fi && fi->fib_nh->nh_gw)
-		flags |= RTF_GATEWAY;
-	if (mask == 0xFFFF)
-		flags |= RTF_HOST;
-	if (dead)
-		flags |= RTF_UP;
-	return flags;
-}
-
-static void dn_fib_node_get_info(int type, int dead, struct dn_fib_info *fi, u16 prefix, u16 mask, char *buffer)
-{
-	int len;
-	unsigned flags = dn_fib_flag_trans(type, dead, mask, fi);
-
-	if (fi) {
-		len = sprintf(buffer, "%s\t%04x\t%04x\t%04x\t%d\t%u\t%d\t%04x\t%d\t%u\t%u",
-				fi->dn_fib_dev ? fi->dn_fib_dev->name : "*", prefix,
-				fi->fib_nh->nh_gw, flags, 0, 0, fi->fib_priority,
-				mask, 0, 0, 0);
-	} else {
-		len = sprintf(buffer, "*\t%04x\t%04x\t%04x\t%d\t%u\t%d\t%04x\t%d\t%u\t%u",
-					prefix, 0,
-					flags, 0, 0, 0,
-					mask, 0, 0, 0);
-	}
-	memset(buffer+len, ' ', 127-len);
-	buffer[127] = '\n';
-}
-
-static int dn_fib_table_get_info(struct dn_fib_table *tb, char *buffer, int first, int count)
-{
-	struct dn_hash *table = (struct dn_hash *)tb->data;
-	struct dn_zone *dz;
-	int pos = 0;
-	int n = 0;
-
-	read_lock(&dn_fib_tables_lock);
-	for(dz = table->dh_zone_list; dz; dz = dz->dz_next) {
-		int i;
-		struct dn_fib_node *f;
-		int maxslot = dz->dz_divisor;
-		struct dn_fib_node **fp = dz->dz_hash;
-
-		if (dz->dz_nent == 0)
-			continue;
-
-		if (pos + dz->dz_nent < first) {
-			pos += dz->dz_nent;
-			continue;
-		}
-
-		for(i = 0; i < maxslot; i++, fp++) {
-			for(f = *fp; f ; f = f->fn_next) {
-				if (++pos <= first)
-					continue;
-				dn_fib_node_get_info(f->fn_type,
-						f->fn_state & DN_S_ZOMBIE,
-						DN_FIB_INFO(f),
-						dz_prefix(f->fn_key, dz),
-						DZ_MASK(dz), buffer);
-				buffer += 128;
-				if (++n >= count)
-					goto out;
-			}
-		}
-	}
-out:
-	read_unlock(&dn_fib_tables_lock);
-	return n;
-}
-#endif /* CONFIG_PROC_FS */
 
 struct dn_fib_table *dn_fib_get_table(int n, int create)
 {
@@ -855,9 +775,6 @@
         t->delete = dn_fib_table_delete;
         t->lookup = dn_fib_table_lookup;
         t->flush  = dn_fib_table_flush;
-#ifdef CONFIG_PROC_FS
-	t->get_info = dn_fib_table_get_info;
-#endif
         t->dump = dn_fib_table_dump;
 	memset(t->data, 0, sizeof(struct dn_hash));
         dn_fib_tables[n] = t;
