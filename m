Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVKALFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVKALFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVKALFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:05:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:21000 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750741AbVKALFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:05:11 -0500
Date: Tue, 1 Nov 2005 12:04:59 +0100
From: Willy TARREAU <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, grant_lkml@dodo.com.au
Subject: Linux-2.4.31-hf7
Message-ID: <20051101110459.GA4225@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all !

This is the seventh hotfix for kernel 2.4.31, which brings it to
the same fix level as 2.4.32-rc2. As usual, patches for 2.4.29
and 2.4.30 are also provided. There are just a few patches, one
minor security fix from Andrew restricting loadkeys usage to root
only, a memory ordering bug fix from Nick Piggin, a TCP window
clamping fix from Alexey blessed by Ion Badulescu, two IPVS fixes
from Julian Anastasov related to persistence, a few typos in mcast
and ax25 from Denis Lukianov and Ralf Baechle, and a netfilter
build fix for gcc-3.4.3 from Marcus Sundberg. Nothing that terrible,
but and upgrade is recommended.

The patch from 2.4.31-hf6 is small, so I append it to the end of
this mail after the change log for those how like to patch directly
from mbox.

Those who can easily upgrade to 2.4.32-rc* are encouraged to do
so, of course, to help testing the next release.

So, the new hotfixes are 2.4.31-hf7, 2.4.30-hf10 and 2.4.29-hf17.
Starting from 2.4.32-hf*, I will change the numbering scheme to
something which will make it easier for system admins to know
whether they are late or not. The idea is to reflect the head
version in the hot fix, to look like something such as this :

    current version      would become      and evolve as
    -----------------+------------------+---------------
    2.4.31-hf7          2.4.31-hf31.7      2.4.31-hf32.1
    2.4.30-hf10         2.4.30-hf31.7      2.4.30-hf32.1
    2.4.29-hf17         2.4.29-hf31.7      2.4.29-hf32.1

and so on...

I know it makes the names longer, but knowing that 2.4.32-hf32.1
goes out makes it more obvious that your 2.4.29-hf31.4 is late
than 2.4.31-hf7 makes it "obvious" that 2.4.29-hf10 is late !
Comments and suggestions more than welcome !

As usual, everything is available for download there :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)

I'm happily running 2.4.31-hf7 right now on athlon-SMP without any
trouble (yet), and it also perfectly runs on sparc64-SMP.

Regards,
Willy

---

Changelog from 2.4.31-hf6 to 2.4.31-hf7
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.31-loadkeys-requires-root-1                            (Andrew Morton)

  [PATCH] loadkeys requires root priviledges

+ 2.4.31-possible-mem-ordering-bug-1                           (Nick Piggin)

  [PATCH] possible memory ordering bug in page reclaim
  Is there anything that prevents PageDirty from theoretically being
  speculatively loaded before page_count here? (see patch)
  It would result in pagecache corruption.

+ 2.4.31-ax25-signed-char-bug-1                               (Ralf Baechle)

  [PATCH] AX.25: signed char bug
  On architectures where the char type defaults to unsigned some of the
  arithmetic in the AX.25 stack to fail, resulting in some packets being
  dropped on receive. Credits for tracking this down and the original
  patch to Bob Brose N0QBJ <linuxhams@n0qbj-11.ampr.org>.

+ 2.4.31-fix-jiffies-multiply-overflow-2                     (Willy Tarreau)

  The checks for multiply overflow in msecs_to_jiffies() are wrong and
  limit maximum time to very low values because the check itself can
  overflow. Those functions are not much used but select() and poll()
  would benefit from them by eliminating divides and multiples in most
  situations.

+ 2.4.31-ip_vs_ftp-persistence-breaks-connections-1       (Julian Anastasov)

  [IPVS]: ip_vs_ftp breaks connections using persistence
  ip_vs_ftp when loaded can create NAT connections with unknown client
  port for passive FTP. For such expectations we lookup with cport=0
  on incoming packet but it matches the format of the persistence
  templates causing packets to other persistent virtual servers to
  be forwarded to real server without creating connection. Later the
  reply packets are treated as foreign and not SNAT-ed. This patch
  changes the connection lookup for packets from clients:

+ 2.4.31-ipvs-invalidate-persistent-templates-1           (Julian Anastasov)

  [IPVS]: really invalidate persistent templates
  Agostino di Salle noticed that persistent templates are not
  invalidated due to buggy optimization.

+ 2.4.31-mcast-exclude-typos-1                              (Denis Lukianov)

  [MCAST]: Fix MCAST_EXCLUDE line dupes
  pmc->sfcount[MCAST_EXCLUDE] got initialized twice and [MCAST_INCLUDE]
  did not get initialized.

+ 2.4.31-tcp_clamp_window-fix-1                           (Alexey Kuznetsov)

  [TCP]: Don't over-clamp window in tcp_clamp_window()
  Handle better the case where the sender sends full sized frames
  initially, then moves to a mode where it trickles out small amounts
  of data at a time. This known problem is even mentioned in the
  comments above tcp_grow_window() in tcp_input.c. Fix confirmed by
  Ion Badulescu.

+ 2.4.31-netfilter-gcc-3.4.3-build-1                       (Marcus Sundberg)

  [NETFILTER]: this patch fixes a compilation issue with gcc 3.4.3.


Patch to upgrade 2.4.31-hf6 to 2.4.31-hf7.

--- linux-2.4.31-hf6/Makefile	Sun Sep 25 20:51:58 2005
+++ linux-2.4.31-hf7/Makefile	Tue Nov  1 08:38:43 2005
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 31
-EXTRAVERSION = -hf6
+EXTRAVERSION = -hf7
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
--- linux-2.4.31-hf6/net/ipv4/ipvs/ip_vs_conn.c	Sun Sep 25 20:51:57 2005
+++ linux-2.4.31-hf7/net/ipv4/ipvs/ip_vs_conn.c	Tue Nov  1 08:38:42 2005
@@ -210,6 +210,7 @@
 		cp = list_entry(e, struct ip_vs_conn, c_list);
 		if (s_addr==cp->caddr && s_port==cp->cport &&
 		    d_port==cp->vport && d_addr==cp->vaddr &&
+		    ((!s_port) ^ (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
 		    protocol==cp->protocol) {
 			/* HIT */
 			atomic_inc(&cp->refcnt);
@@ -241,6 +242,40 @@
 	return cp;
 }
 
+/* Get reference to connection template */
+struct ip_vs_conn *ip_vs_ct_in_get
+(int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port)
+{
+	unsigned hash;
+	struct ip_vs_conn *cp;
+
+	hash = ip_vs_conn_hashkey(protocol, s_addr, s_port);
+
+	ct_read_lock(hash);
+
+	list_for_each_entry(cp, &ip_vs_conn_tab[hash], c_list) {
+		if (s_addr==cp->caddr && s_port==cp->cport &&
+		    d_port==cp->vport && d_addr==cp->vaddr &&
+		    cp->flags & IP_VS_CONN_F_TEMPLATE &&
+		    protocol==cp->protocol) {
+			/* HIT */
+			atomic_inc(&cp->refcnt);
+			goto out;
+		}
+	}
+	cp = NULL;
+
+  out:
+	ct_read_unlock(hash);
+
+	IP_VS_DBG(7, "template lookup/in %s %u.%u.%u.%u:%d->%u.%u.%u.%u:%d %s\n",
+		  ip_vs_proto_name(protocol),
+		  NIPQUAD(s_addr), ntohs(s_port),
+		  NIPQUAD(d_addr), ntohs(d_port),
+		  cp?"hit":"not hit");
+
+	return cp;
+}
 
 /*
  *  Gets ip_vs_conn associated with supplied parameters in the ip_vs_conn_tab.
@@ -1087,7 +1122,7 @@
 
 	IP_VS_DBG(9, "Unbind-dest %s c:%u.%u.%u.%u:%d "
 		  "v:%u.%u.%u.%u:%d d:%u.%u.%u.%u:%d fwd:%c "
-		  "s:%s flg:%X cnt:%d destcnt:%d",
+		  "s:%s flg:%X cnt:%d destcnt:%d\n",
 		  ip_vs_proto_name(cp->protocol),
 		  NIPQUAD(cp->caddr), ntohs(cp->cport),
 		  NIPQUAD(cp->vaddr), ntohs(cp->vport),
@@ -1098,10 +1133,9 @@
 
 	/*
 	 * Decrease the inactconns or activeconns counter
-	 * if it is not a connection template ((cp->cport!=0)
-	 *   || (cp->flags & IP_VS_CONN_F_NO_CPORT)).
+	 * if it is not a connection template
 	 */
-	if (cp->cport || (cp->flags & IP_VS_CONN_F_NO_CPORT)) {
+	if (!(cp->flags & IP_VS_CONN_F_TEMPLATE)) {
 		if (cp->flags & IP_VS_CONN_F_INACTIVE) {
 			atomic_dec(&dest->inactconns);
 		} else {
@@ -1145,7 +1179,7 @@
 		/*
 		 * Invalidate the connection template
 		 */
-		if (ct->cport) {
+		if (ct->vport != 65535) {
 			if (ip_vs_conn_unhash(ct)) {
 				ct->dport = 65535;
 				ct->vport = 65535;
@@ -1428,7 +1462,7 @@
 		l = &ip_vs_conn_tab[hash];
 		for (e=l->next; e!=l; e=e->next) {
 			cp = list_entry(e, struct ip_vs_conn, c_list);
-			if (!cp->cport && !(cp->flags & IP_VS_CONN_F_NO_CPORT))
+			if (cp->flags & IP_VS_CONN_F_TEMPLATE)
 				/* connection template */
 				continue;
 			switch(cp->state) {
--- linux-2.4.31/drivers/char/vt.c	Wed Dec 22 22:26:14 2004
+++ linux-2.4.31-hf7/drivers/char/vt.c	Tue Nov  1 08:38:41 2005
@@ -276,6 +276,9 @@
 	char *first_free, *fj, *fnw;
 	int i, j, k;
 
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		return -EPERM;
+
 	/* we mostly copy too much here (512bytes), but who cares ;) */
 	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
 		return -EFAULT;
--- linux-2.4.31/include/linux/delay.h	Sun Oct  9 23:40:12 2005
+++ linux-2.4.31-hf7/include/linux/delay.h	Tue Nov  1 08:38:42 2005
@@ -14,6 +14,24 @@
 #include <asm/delay.h>
 
 /*
+ * We define MAX_MSEC_OFFSET as the maximal value that can be accepted by
+ * msecs_to_jiffies() without risking a multiply overflow. This function
+ * returns MAX_JIFFY_OFFSET for arguments above those values.
+ */
+
+#if HZ <= 1000 && !(1000 % HZ)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (1000 / HZ) + 1)
+#elif HZ > 1000 && !(HZ % 1000)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX / (HZ / 1000))
+#else
+#  define MAX_MSEC_OFFSET \
+	((ULONG_MAX - 999) / HZ)
+#endif
+
+
+/*
  * Convert jiffies to milliseconds and back.
  *
  * Avoid unnecessary multiplications/divisions in the
@@ -43,14 +61,14 @@
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (MAX_MSEC_OFFSET < UINT_MAX && m > (unsigned int)MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= 1000 && !(1000 % HZ)
-	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+	return ((unsigned long)m + (1000 / HZ) - 1) / (1000 / HZ);
 #elif HZ > 1000 && !(HZ % 1000)
-	return m * (HZ / 1000);
+	return (unsigned long)m * (HZ / 1000);
 #else
-	return (m * HZ + 999) / 1000;
+	return ((unsigned long)m * HZ + 999) / 1000;
 #endif
 }
 
--- linux-2.4.31/include/linux/netfilter_ipv4/ip_conntrack.h	Sun Sep 25 20:05:10 2005
+++ linux-2.4.31-hf7/include/linux/netfilter_ipv4/ip_conntrack.h	Tue Nov  1 08:38:42 2005
@@ -229,7 +229,7 @@
 ip_conntrack_get(struct sk_buff *skb, enum ip_conntrack_info *ctinfo);
 
 /* decrement reference count on a conntrack */
-extern inline void ip_conntrack_put(struct ip_conntrack *ct);
+extern void ip_conntrack_put(struct ip_conntrack *ct);
 
 /* find unconfirmed expectation based on tuple */
 struct ip_conntrack_expect *
--- linux-2.4.31/include/net/ax25.h	Sun Oct  9 23:40:29 2005
+++ linux-2.4.31-hf7/include/net/ax25.h	Tue Nov  1 08:38:42 2005
@@ -142,7 +142,7 @@
 	ax25_address		calls[AX25_MAX_DIGIS];
 	unsigned char		repeated[AX25_MAX_DIGIS];
 	unsigned char		ndigi;
-	char			lastrepeat;
+	signed char		lastrepeat;
 } ax25_digi;
 
 typedef struct ax25_route {
--- linux-2.4.31/include/net/ip_vs.h	Sun Sep 25 20:03:49 2005
+++ linux-2.4.31-hf7/include/net/ip_vs.h	Tue Nov  1 08:38:42 2005
@@ -82,6 +82,7 @@
 #define IP_VS_CONN_F_IN_SEQ           0x0400    /* must do input seq adjust */
 #define IP_VS_CONN_F_SEQ_MASK         0x0600    /* in/out sequence mask */
 #define IP_VS_CONN_F_NO_CPORT         0x0800    /* no client port set yet */
+#define IP_VS_CONN_F_TEMPLATE         0x1000    /* template, not connection */
 
 /* Move it to better place one day, for now keep it unique */
 #define NFC_IPVS_PROPERTY	0x10000
@@ -591,6 +592,8 @@
 extern struct ip_vs_timeout_table vs_timeout_table_dos;
 
 extern struct ip_vs_conn *ip_vs_conn_in_get
+(int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
+extern struct ip_vs_conn *ip_vs_ct_in_get
 (int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
 extern struct ip_vs_conn *ip_vs_conn_out_get
 (int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
--- linux-2.4.31/mm/vmscan.c	Sun Dec 19 21:18:28 2004
+++ linux-2.4.31-hf7/mm/vmscan.c	Tue Nov  1 08:38:41 2005
@@ -556,6 +556,7 @@
 			continue;
 			
 		}
+		smp_rmb();
 		if (PageDirty(page)) {
 			spin_unlock(&pagecache_lock);
 			UnlockPage(page);
--- linux-2.4.31/net/ipv4/igmp.c	Sun Dec 19 21:18:28 2004
+++ linux-2.4.31-hf7/net/ipv4/igmp.c	Tue Nov  1 08:38:42 2005
@@ -1582,7 +1582,7 @@
 	}
 	pmc->sources = 0;
 	pmc->sfmode = MCAST_EXCLUDE;
-	pmc->sfcount[MCAST_EXCLUDE] = 0;
+	pmc->sfcount[MCAST_INCLUDE] = 0;
 	pmc->sfcount[MCAST_EXCLUDE] = 1;
 }
 
--- linux-2.4.31/net/ipv4/ipvs/ip_vs_core.c	Sun Apr 17 15:32:24 2005
+++ linux-2.4.31-hf7/net/ipv4/ipvs/ip_vs_core.c	Tue Nov  1 08:38:42 2005
@@ -188,10 +188,10 @@
 	if (portp[1] == svc->port) {
 		/* Check if a template already exists */
 		if (svc->port != FTPPORT)
-			ct = ip_vs_conn_in_get(iph->protocol, snet, 0,
+			ct = ip_vs_ct_in_get(iph->protocol, snet, 0,
 					       iph->daddr, portp[1]);
 		else
-			ct = ip_vs_conn_in_get(iph->protocol, snet, 0,
+			ct = ip_vs_ct_in_get(iph->protocol, snet, 0,
 					       iph->daddr, 0);
 
 		if (!ct || !ip_vs_check_template(ct)) {
@@ -216,14 +216,14 @@
 						    snet, 0,
 						    iph->daddr, portp[1],
 						    dest->addr, dest->port,
-						    0,
+						    IP_VS_CONN_F_TEMPLATE,
 						    dest);
 			else
 				ct = ip_vs_conn_new(iph->protocol,
 						    snet, 0,
 						    iph->daddr, 0,
 						    dest->addr, 0,
-						    0,
+						    IP_VS_CONN_F_TEMPLATE,
 						    dest);
 			if (ct == NULL)
 				return NULL;
@@ -242,10 +242,10 @@
 		 * port zero template: <protocol,caddr,0,vaddr,0,daddr,0>
 		 */
 		if (svc->fwmark)
-			ct = ip_vs_conn_in_get(IPPROTO_IP, snet, 0,
+			ct = ip_vs_ct_in_get(IPPROTO_IP, snet, 0,
 					       htonl(svc->fwmark), 0);
 		else
-			ct = ip_vs_conn_in_get(iph->protocol, snet, 0,
+			ct = ip_vs_ct_in_get(iph->protocol, snet, 0,
 					       iph->daddr, 0);
 
 		if (!ct || !ip_vs_check_template(ct)) {
@@ -270,14 +270,14 @@
 						    snet, 0,
 						    htonl(svc->fwmark), 0,
 						    dest->addr, 0,
-						    0,
+						    IP_VS_CONN_F_TEMPLATE,
 						    dest);
 			else
 				ct = ip_vs_conn_new(iph->protocol,
 						    snet, 0,
 						    iph->daddr, 0,
 						    dest->addr, 0,
-						    0,
+						    IP_VS_CONN_F_TEMPLATE,
 						    dest);
 			if (ct == NULL)
 				return NULL;
--- linux-2.4.31/net/ipv4/ipvs/ip_vs_sync.c	Wed Jun  1 06:28:10 2005
+++ linux-2.4.31-hf7/net/ipv4/ipvs/ip_vs_sync.c	Tue Nov  1 08:38:42 2005
@@ -295,16 +295,24 @@
 
 	p = (char *)buffer + sizeof(struct ip_vs_sync_mesg);
 	for (i=0; i<m->nr_conns; i++) {
+		unsigned flags;
+
 		s = (struct ip_vs_sync_conn *)p;
-		cp = ip_vs_conn_in_get(s->protocol,
-				       s->caddr, s->cport,
-				       s->vaddr, s->vport);
+		flags = ntohs(s->flags);
+		if (!(flags & IP_VS_CONN_F_TEMPLATE))
+			cp = ip_vs_conn_in_get(s->protocol,
+					       s->caddr, s->cport,
+					       s->vaddr, s->vport);
+		else
+			cp = ip_vs_ct_in_get(s->protocol,
+					       s->caddr, s->cport,
+					       s->vaddr, s->vport);
 		if (!cp) {
 			cp = ip_vs_conn_new(s->protocol,
 					    s->caddr, s->cport,
 					    s->vaddr, s->vport,
 					    s->daddr, s->dport,
-					    ntohs(s->flags), NULL);
+					    flags, NULL);
 			if (!cp) {
 				IP_VS_ERR("ip_vs_conn_new failed\n");
 				return;
@@ -313,11 +321,11 @@
 		} else if (!cp->dest) {
 			/* it is an entry created by the synchronization */
 			cp->state = ntohs(s->state);
-			cp->flags = ntohs(s->flags) | IP_VS_CONN_F_HASHED;
+			cp->flags = flags | IP_VS_CONN_F_HASHED;
 		}	/* Note that we don't touch its state and flags
 			   if it is a normal entry. */
 
-		if (ntohs(s->flags) & IP_VS_CONN_F_SEQ_MASK) {
+		if (flags & IP_VS_CONN_F_SEQ_MASK) {
 			opt = (struct ip_vs_sync_conn_options *)&s[1];
 			memcpy(&cp->in_seq, opt, sizeof(*opt));
 			p += FULL_CONN_SIZE;
--- linux-2.4.31/net/ipv4/tcp_input.c	Wed Jun  1 06:28:10 2005
+++ linux-2.4.31-hf7/net/ipv4/tcp_input.c	Tue Nov  1 08:38:42 2005
@@ -374,8 +374,6 @@
 			app_win -= tp->ack.rcv_mss;
 		app_win = max(app_win, 2U*tp->advmss);
 
-		if (!ofo_win)
-			tp->window_clamp = min(tp->window_clamp, app_win);
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
 	}
 }
--- linux-2.4.31/net/ipv6/mcast.c	Sun Dec 19 21:18:28 2004
+++ linux-2.4.31-hf7/net/ipv6/mcast.c	Tue Nov  1 08:38:42 2005
@@ -1867,7 +1867,7 @@
 	}
 	pmc->mca_sources = 0;
 	pmc->mca_sfmode = MCAST_EXCLUDE;
-	pmc->mca_sfcount[MCAST_EXCLUDE] = 0;
+	pmc->mca_sfcount[MCAST_INCLUDE] = 0;
 	pmc->mca_sfcount[MCAST_EXCLUDE] = 1;
 }
 

--- end of patch ---

