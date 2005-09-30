Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVI3CZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVI3CZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVI3CXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932419AbVI3CXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:22 -0400
Message-Id: <20050930022216.347232000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Julian Anastasov <ja@ssi.bg>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 04/10] [PATCH] ipvs: ip_vs_ftp breaks connections using persistence
Content-Disposition: inline; filename=ipvs-ip_vs_ftp-breaks-connections.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

	ip_vs_ftp when loaded can create NAT connections with unknown
client port for passive FTP. For such expectations we lookup with
cport=0 on incoming packet but it matches the format of the persistence
templates causing packets to other persistent virtual servers to be
forwarded to real server without creating connection. Later the
reply packets are treated as foreign and not SNAT-ed.

	If the IPVS box serves both FTP and other services (eg. HTTP)
for the time we wait for first packet for the FTP data connections with
unknown client port (there can be many), other HTTP connections
that have nothing common to the FTP conn break, i.e. HTTP client
sends SYN to the virtual IP but the SYN+ACK is not NAT-ed properly
in IPVS box and the client box returns RST to real server IP. I.e.
the result can be 10% broken HTTP traffic if 10% of the time
there are passive FTP connections in connecting state. It hurts
only IPVS connections.

	This patch changes the connection lookup for packets from
clients:

* introduce IP_VS_CONN_F_TEMPLATE connection flag to mark the
connection as template
* create new connection lookup function just for templates - ip_vs_ct_in_get
* make sure ip_vs_conn_in_get hits only connections with
IP_VS_CONN_F_NO_CPORT flag set when s_port is 0. By this way
we avoid returning template when looking for cport=0 (ftp)

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 include/net/ip_vs.h        |    3 +++
 net/ipv4/ipvs/ip_vs_conn.c |   41 ++++++++++++++++++++++++++++++++++++++---
 net/ipv4/ipvs/ip_vs_core.c |   16 ++++++++--------
 net/ipv4/ipvs/ip_vs_sync.c |   20 ++++++++++++++------
 4 files changed, 63 insertions(+), 17 deletions(-)

Index: linux-2.6.13.y/include/net/ip_vs.h
===================================================================
--- linux-2.6.13.y.orig/include/net/ip_vs.h
+++ linux-2.6.13.y/include/net/ip_vs.h
@@ -84,6 +84,7 @@
 #define IP_VS_CONN_F_IN_SEQ	0x0400		/* must do input seq adjust */
 #define IP_VS_CONN_F_SEQ_MASK	0x0600		/* in/out sequence mask */
 #define IP_VS_CONN_F_NO_CPORT	0x0800		/* no client port set yet */
+#define IP_VS_CONN_F_TEMPLATE	0x1000		/* template, not connection */
 
 /* Move it to better place one day, for now keep it unique */
 #define NFC_IPVS_PROPERTY	0x10000
@@ -740,6 +741,8 @@ enum {
 
 extern struct ip_vs_conn *ip_vs_conn_in_get
 (int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
+extern struct ip_vs_conn *ip_vs_ct_in_get
+(int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
 extern struct ip_vs_conn *ip_vs_conn_out_get
 (int protocol, __u32 s_addr, __u16 s_port, __u32 d_addr, __u16 d_port);
 
Index: linux-2.6.13.y/net/ipv4/ipvs/ip_vs_conn.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/ipvs/ip_vs_conn.c
+++ linux-2.6.13.y/net/ipv4/ipvs/ip_vs_conn.c
@@ -196,6 +196,7 @@ static inline struct ip_vs_conn *__ip_vs
 	list_for_each_entry(cp, &ip_vs_conn_tab[hash], c_list) {
 		if (s_addr==cp->caddr && s_port==cp->cport &&
 		    d_port==cp->vport && d_addr==cp->vaddr &&
+		    ((!s_port) ^ (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
 		    protocol==cp->protocol) {
 			/* HIT */
 			atomic_inc(&cp->refcnt);
@@ -227,6 +228,40 @@ struct ip_vs_conn *ip_vs_conn_in_get
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
@@ -367,7 +402,7 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, s
 		  atomic_read(&dest->refcnt));
 
 	/* Update the connection counters */
-	if (cp->cport || (cp->flags & IP_VS_CONN_F_NO_CPORT)) {
+	if (!(cp->flags & IP_VS_CONN_F_TEMPLATE)) {
 		/* It is a normal connection, so increase the inactive
 		   connection counter because it is in TCP SYNRECV
 		   state (inactive) or other protocol inacive state */
@@ -406,7 +441,7 @@ static inline void ip_vs_unbind_dest(str
 		  atomic_read(&dest->refcnt));
 
 	/* Update the connection counters */
-	if (cp->cport || (cp->flags & IP_VS_CONN_F_NO_CPORT)) {
+	if (!(cp->flags & IP_VS_CONN_F_TEMPLATE)) {
 		/* It is a normal connection, so decrease the inactconns
 		   or activeconns counter */
 		if (cp->flags & IP_VS_CONN_F_INACTIVE) {
@@ -776,7 +811,7 @@ void ip_vs_random_dropentry(void)
 		ct_write_lock_bh(hash);
 
 		list_for_each_entry(cp, &ip_vs_conn_tab[hash], c_list) {
-			if (!cp->cport && !(cp->flags & IP_VS_CONN_F_NO_CPORT))
+			if (cp->flags & IP_VS_CONN_F_TEMPLATE)
 				/* connection template */
 				continue;
 
Index: linux-2.6.13.y/net/ipv4/ipvs/ip_vs_core.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/ipvs/ip_vs_core.c
+++ linux-2.6.13.y/net/ipv4/ipvs/ip_vs_core.c
@@ -242,10 +242,10 @@ ip_vs_sched_persist(struct ip_vs_service
 	if (ports[1] == svc->port) {
 		/* Check if a template already exists */
 		if (svc->port != FTPPORT)
-			ct = ip_vs_conn_in_get(iph->protocol, snet, 0,
+			ct = ip_vs_ct_in_get(iph->protocol, snet, 0,
 					       iph->daddr, ports[1]);
 		else
-			ct = ip_vs_conn_in_get(iph->protocol, snet, 0,
+			ct = ip_vs_ct_in_get(iph->protocol, snet, 0,
 					       iph->daddr, 0);
 
 		if (!ct || !ip_vs_check_template(ct)) {
@@ -271,14 +271,14 @@ ip_vs_sched_persist(struct ip_vs_service
 						    iph->daddr,
 						    ports[1],
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
@@ -297,10 +297,10 @@ ip_vs_sched_persist(struct ip_vs_service
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
@@ -325,14 +325,14 @@ ip_vs_sched_persist(struct ip_vs_service
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
Index: linux-2.6.13.y/net/ipv4/ipvs/ip_vs_sync.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv4/ipvs/ip_vs_sync.c
+++ linux-2.6.13.y/net/ipv4/ipvs/ip_vs_sync.c
@@ -297,16 +297,24 @@ static void ip_vs_process_message(const 
 
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
@@ -315,11 +323,11 @@ static void ip_vs_process_message(const 
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

--
