Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJMGvV>; Sun, 13 Oct 2002 02:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbSJMGvV>; Sun, 13 Oct 2002 02:51:21 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:29445 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261439AbSJMGvP>; Sun, 13 Oct 2002 02:51:15 -0400
Date: Sun, 13 Oct 2002 04:56:56 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/arp to seq_file
Message-ID: <20021013065656.GC7898@conectiva.com.br>
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

	Now there is only this changeset outstanding there.

	Best Regards,

- Arnaldo

PS.: Any feedback from the pppoe maintainer about seq_file patch?



You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.833, 2002-10-13 04:47:51-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/arp to seq_file


 include/net/arp.h  |    1 
 net/ipv4/arp.c     |  155 +--------------------------------------------------
 net/ipv4/ip_proc.c |  161 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 150 deletions(-)


diff -Nru a/include/net/arp.h b/include/net/arp.h
--- a/include/net/arp.h	Sun Oct 13 04:52:41 2002
+++ b/include/net/arp.h	Sun Oct 13 04:52:41 2002
@@ -18,6 +18,7 @@
 extern int	arp_bind_neighbour(struct dst_entry *dst);
 extern int	arp_mc_map(u32 addr, u8 *haddr, struct net_device *dev, int dir);
 extern void	arp_ifdown(struct net_device *dev);
+extern unsigned arp_state_to_flags(struct neighbour *neigh);
 
 extern struct neigh_ops arp_broken_ops;
 
diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Sun Oct 13 04:52:41 2002
+++ b/net/ipv4/arp.c	Sun Oct 13 04:52:41 2002
@@ -66,6 +66,8 @@
  *		Alexey Kuznetsov:	new arp state machine;
  *					now it is in net/core/neighbour.c.
  *		Krzysztof Halasa:	Added Frame Relay ARP support.
+ *		Arnaldo C. Melo :	move proc stuff to seq_file and
+ *					net/ipv4/ip_proc.c
  */
 
 #include <linux/types.h>
@@ -85,7 +87,6 @@
 #include <linux/if_arp.h>
 #include <linux/trdevice.h>
 #include <linux/skbuff.h>
-#include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #ifdef CONFIG_SYSCTL
@@ -851,7 +852,7 @@
 }
 
 /*
- *	User level interface (ioctl, /proc)
+ *	User level interface (ioctl)
  */
 
 /*
@@ -918,7 +919,7 @@
 	return err;
 }
 
-static unsigned arp_state_to_flags(struct neighbour *neigh)
+unsigned arp_state_to_flags(struct neighbour *neigh)
 {
 	unsigned flags = 0;
 	if (neigh->nud_state&NUD_PERMANENT)
@@ -1066,111 +1067,6 @@
 	return err;
 }
 
-/*
- *	Write the contents of the ARP cache to a PROCfs file.
- */
-#ifndef CONFIG_PROC_FS
-static int arp_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	return 0;
-}
-#else
-#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
-static char *ax2asc2(ax25_address *a, char *buf);
-#endif
-#define HBUFFERLEN 30
-
-static int arp_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	char hbuffer[HBUFFERLEN];
-	int i,j,k;
-	const char hexbuf[] = "0123456789ABCDEF";
-	int size = sprintf(buffer, "IP address       HW type     Flags       "
-				   "HW address            Mask     Device\n");
-	int len = size;
-	off_t pos = size;
-
-	for (i = 0; i <= NEIGH_HASHMASK; i++) {
-		struct neighbour *n;
-		read_lock_bh(&arp_tbl.lock);
-		for (n = arp_tbl.hash_buckets[i]; n; n = n->next) {
-			char tbuf[16];
-			struct net_device *dev = n->dev;
-			int hatype = dev->type;
-
-			/* Do not confuse users "arp -a" with magic entries */
-			if (!(n->nud_state & ~NUD_NOARP))
-				continue;
-
-			read_lock(&n->lock);
-			/* Convert hardware address to XX:XX:XX:XX ... form. */
-#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
-			if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
-				ax2asc2((ax25_address *)n->ha, hbuffer);
-			else {
-#endif
-			for (k = 0, j = 0; k < HBUFFERLEN - 3 &&
-					   j < dev->addr_len; j++) {
-				hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
-				hbuffer[k++] = hexbuf[n->ha[j] & 15];
-				hbuffer[k++] = ':';
-			}
-			hbuffer[--k] = 0;
-#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
-			}
-#endif
-			sprintf(tbuf, "%u.%u.%u.%u",
-				NIPQUAD(*(u32*)n->primary_key));
-			size = sprintf(buffer + len, "%-16s 0x%-10x0x%-10x%s"
-						     "     *        %s\n",
-				       tbuf, hatype, arp_state_to_flags(n), 
-				       hbuffer, dev->name);
-			read_unlock(&n->lock);
-
-			len += size;
-			pos += size;
-		  
-			if (pos <= offset)
-				len = 0;
-			if (pos >= offset + length) {
-				read_unlock_bh(&arp_tbl.lock);
- 				goto done;
-			}
-		}
-		read_unlock_bh(&arp_tbl.lock);
-	}
-
-	for (i = 0; i <= PNEIGH_HASHMASK; i++) {
-		struct pneigh_entry *n;
-		for (n = arp_tbl.phash_buckets[i]; n; n = n->next) {
-			struct net_device *dev = n->dev;
-			int hatype = dev ? dev->type : 0;
-			char tbuf[16];
-			sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
-			size = sprintf(buffer + len, "%-16s 0x%-10x0x%-10x%s"
-						     "     *        %s\n",
-					tbuf, hatype, ATF_PUBL | ATF_PERM,
-					"00:00:00:00:00:00",
-					dev ? dev->name : "*");
-			len += size;
-			pos += size;
-		  
-			if (pos <= offset)
-				len = 0;
-			if (pos >= offset+length)
-				goto done;
-		}
-	}
-done:	*start = buffer + len - (pos - offset);	/* Start of wanted data */
-	len = pos - offset;			/* Start slop */
-	if (len > length)
-		len = length;			/* Ending slop */
-	if (len < 0)
-		len = 0;
-	return len;
-}
-#endif
-
 /* Note, that it is not on notifier chain.
    It is necessary, that this routine was called after route cache will be
    flushed.
@@ -1191,54 +1087,13 @@
 	.data =	(void*) 1, /* understand shared skbs */
 };
 
-void __init arp_init (void)
+void __init arp_init(void)
 {
 	neigh_table_init(&arp_tbl);
 
 	dev_add_pack(&arp_packet_type);
-
-	proc_net_create ("arp", 0, arp_get_info);
-
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_register(NULL, &arp_tbl.parms, NET_IPV4,
 			      NET_IPV4_NEIGH, "ipv4");
 #endif
 }
-
-
-#ifdef CONFIG_PROC_FS
-#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
-
-/*
- *	ax25 -> ASCII conversion
- */
-char *ax2asc2(ax25_address *a, char *buf)
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
-
-#endif
-#endif
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sun Oct 13 04:52:41 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 13 04:52:41 2002
@@ -15,6 +15,10 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/netdevice.h>
+#include <net/neighbour.h>
+#include <net/arp.h>
+#include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 
 extern int raw_get_info(char *, char **, off_t, int);
@@ -25,8 +29,158 @@
 extern int udp_get_info(char *, char **, off_t, int);
 
 #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_AX25
+/*
+ *	ax25 -> ASCII conversion
+ */
+char *ax2asc2(ax25_address *a, char *buf)
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
+static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return (void *)(unsigned long)++*pos;
+}
+
+static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return (void *)(unsigned long)((++*pos) >=
+				       (NEIGH_HASHMASK +
+					PNEIGH_HASHMASK - 1) ? 0 : *pos);
+}
+
+static void arp_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+#define HBUFFERLEN 30
+
+static __inline__ void arp_format_neigh_table(struct seq_file *seq, int entry)
+{
+	char hbuffer[HBUFFERLEN];
+	const char hexbuf[] = "0123456789ABCDEF";
+	struct neighbour *n;
+	int k, j;
+
+	read_lock_bh(&arp_tbl.lock);
+	for (n = arp_tbl.hash_buckets[entry]; n; n = n->next) {
+		char tbuf[16];
+		struct net_device *dev = n->dev;
+		int hatype = dev->type;
+
+		/* Do not confuse users "arp -a" with magic entries */
+		if (!(n->nud_state & ~NUD_NOARP))
+			continue;
+
+		read_lock(&n->lock);
+		/* Convert hardware address to XX:XX:XX:XX ... form. */
+#ifdef CONFIG_AX25
+		if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
+			ax2asc2((ax25_address *)n->ha, hbuffer);
+		else {
+#endif
+		for (k = 0, j = 0; k < HBUFFERLEN - 3 &&
+				   j < dev->addr_len; j++) {
+			hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
+			hbuffer[k++] = hexbuf[n->ha[j] & 15];
+			hbuffer[k++] = ':';
+		}
+		hbuffer[--k] = 0;
+#ifdef CONFIG_AX25
+		}
+#endif
+		sprintf(tbuf, "%u.%u.%u.%u",
+			NIPQUAD(*(u32*)n->primary_key));
+		seq_printf(seq, "%-16s 0x%-10x0x%-10x%s"
+				"     *        %s\n",
+			   tbuf, hatype, arp_state_to_flags(n), 
+			   hbuffer, dev->name);
+		read_unlock(&n->lock);
+	}
+	read_unlock_bh(&arp_tbl.lock);
+}
+
+static __inline__ void arp_format_pneigh_table(struct seq_file *seq, int entry)
+{
+	struct pneigh_entry *n;
+
+	for (n = arp_tbl.phash_buckets[entry]; n; n = n->next) {
+		struct net_device *dev = n->dev;
+		int hatype = dev ? dev->type : 0;
+		char tbuf[16];
+
+		sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
+		seq_printf(seq, "%-16s 0x%-10x0x%-10x%s"
+				"     *        %s\n",
+			   tbuf, hatype, ATF_PUBL | ATF_PERM,
+			   "00:00:00:00:00:00",
+			   dev ? dev->name : "*");
+	}
+}
+
+static int arp_seq_show(struct seq_file *seq, void *v)
+{
+	unsigned long l = (unsigned long)v - 1;
+
+	if (!l)
+		seq_puts(seq, "IP address       HW type     Flags       "
+			      "HW address            Mask     Device\n");
+
+	if (l <= NEIGH_HASHMASK)
+		arp_format_neigh_table(seq, l);
+	else
+		arp_format_pneigh_table(seq, l - NEIGH_HASHMASK);
+
+	return 0;
+}
+
+struct seq_operations arp_seq_ops = {
+	.start  = arp_seq_start,
+	.next   = arp_seq_next,
+	.stop   = arp_seq_stop,
+	.show   = arp_seq_show,
+};
+
+static int arp_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &arp_seq_ops);
+}
+
+static struct file_operations arp_seq_fops = {
+	.open           = arp_seq_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release	= seq_release,
+};
+
 int __init ipv4_proc_init(void)
 {
+	struct proc_dir_entry *p;
 	int rc = 0;
 
 	if (!proc_net_create("raw", 0, raw_get_info))
@@ -46,8 +200,15 @@
 
 	if (!proc_net_create("udp", 0, udp_get_info))
 		goto out_udp;
+
+	p = create_proc_entry("arp", S_IRUGO, proc_net);
+	if (!p)
+		goto out_arp;
+	p->proc_fops = &arp_seq_fops;
 out:
 	return rc;
+out_arp:
+	proc_net_remove("udp");
 out_udp:
 	proc_net_remove("tcp");
 out_tcp:

===================================================================


This BitKeeper patch contains the following changesets:
1.833
## Wrapped with gzip_uu ##


begin 664 bkpatch30585
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
=NK7ZOP!WQ-UQ,IUT5,?554=5Y?\"V$&N&648````
`
end
