Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWFOLFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWFOLFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWFOLFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:05:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8404 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964999AbWFOLF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:05:28 -0400
Date: Thu, 15 Jun 2006 12:05:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix broken uses of NIPQUAD in net/atm
Message-ID: <20060615110520.GI27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIPQUAD expects an l-value of type __be32, _NOT_ a pointer to __be32.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 net/atm/mpc.c         |   13 +++----------
 net/atm/mpoa_caches.c |   12 ++++--------
 2 files changed, 7 insertions(+), 18 deletions(-)

f94b4d3e9349e01adf01b658b383ed3168a5f06e
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index c304ef1..a48a5d5 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -229,20 +229,15 @@ int atm_mpoa_delete_qos(struct atm_mpoa_
 /* this is buggered - we need locking for qos_head */
 void atm_mpoa_disp_qos(struct seq_file *m)
 {
-	unsigned char *ip;
-	char ipaddr[16];
 	struct atm_mpoa_qos *qos;
 
 	qos = qos_head;
 	seq_printf(m, "QoS entries for shortcuts:\n");
 	seq_printf(m, "IP address\n  TX:max_pcr pcr     min_pcr max_cdv max_sdu\n  RX:max_pcr pcr     min_pcr max_cdv max_sdu\n");
 
-	ipaddr[sizeof(ipaddr)-1] = '\0';
 	while (qos != NULL) {
-		ip = (unsigned char *)&qos->ipaddr;
-		sprintf(ipaddr, "%u.%u.%u.%u", NIPQUAD(ip));
 		seq_printf(m, "%u.%u.%u.%u\n     %-7d %-7d %-7d %-7d %-7d\n     %-7d %-7d %-7d %-7d %-7d\n",
-				NIPQUAD(ipaddr),
+				NIPQUAD(qos->ipaddr),
 				qos->qos.txtp.max_pcr, qos->qos.txtp.pcr, qos->qos.txtp.min_pcr, qos->qos.txtp.max_cdv, qos->qos.txtp.max_sdu,
 				qos->qos.rxtp.max_pcr, qos->qos.rxtp.pcr, qos->qos.rxtp.min_pcr, qos->qos.rxtp.max_cdv, qos->qos.rxtp.max_sdu);
 		qos = qos->next;
@@ -1083,7 +1078,6 @@ static void MPOA_trigger_rcvd(struct k_m
 static void check_qos_and_open_shortcut(struct k_message *msg, struct mpoa_client *client, in_cache_entry *entry)
 {
 	uint32_t dst_ip = msg->content.in_info.in_dst_ip;
-	unsigned char *ip __attribute__ ((unused)) = (unsigned char *)&dst_ip;
 	struct atm_mpoa_qos *qos = atm_mpoa_search_qos(dst_ip);
 	eg_cache_entry *eg_entry = client->eg_ops->get_by_src_ip(dst_ip, client);
 
@@ -1097,7 +1091,7 @@ static void check_qos_and_open_shortcut(
 				    entry->shortcut = eg_entry->shortcut;
 		}
 	 	if(entry->shortcut){
-			dprintk("mpoa: (%s) using egress SVC to reach %u.%u.%u.%u\n",client->dev->name, NIPQUAD(ip));
+			dprintk("mpoa: (%s) using egress SVC to reach %u.%u.%u.%u\n",client->dev->name, NIPQUAD(dst_ip));
 			client->eg_ops->put(eg_entry);
 			return;
 		}
@@ -1123,8 +1117,7 @@ static void MPOA_res_reply_rcvd(struct k
 
 	uint32_t dst_ip = msg->content.in_info.in_dst_ip;
 	in_cache_entry *entry = mpc->in_ops->get(dst_ip, mpc);
-	ip = (unsigned char *)&dst_ip;
-	dprintk("mpoa: (%s) MPOA_res_reply_rcvd: ip %u.%u.%u.%u\n", mpc->dev->name, NIPQUAD(ip));
+	dprintk("mpoa: (%s) MPOA_res_reply_rcvd: ip %u.%u.%u.%u\n", mpc->dev->name, NIPQUAD(dst_ip));
 	ddprintk("mpoa: (%s) MPOA_res_reply_rcvd() entry = %p", mpc->dev->name, entry);
 	if(entry == NULL){
 		printk("\nmpoa: (%s) ARGH, received res. reply for an entry that doesn't exist.\n", mpc->dev->name);
diff --git a/net/atm/mpoa_caches.c b/net/atm/mpoa_caches.c
index 64ddebb..781ed1b 100644
--- a/net/atm/mpoa_caches.c
+++ b/net/atm/mpoa_caches.c
@@ -223,7 +223,6 @@ static void in_cache_remove_entry(in_cac
    but an easy one... */
 static void clear_count_and_expired(struct mpoa_client *client)
 {
-	unsigned char *ip;
 	in_cache_entry *entry, *next_entry;
 	struct timeval now;
 
@@ -236,8 +235,7 @@ static void clear_count_and_expired(stru
 		next_entry = entry->next;
 		if((now.tv_sec - entry->tv.tv_sec)
 		   > entry->ctrl_info.holding_time){
-			ip = (unsigned char*)&entry->ctrl_info.in_dst_ip;
-			dprintk("mpoa: mpoa_caches.c: holding time expired, ip = %u.%u.%u.%u\n", NIPQUAD(ip));
+			dprintk("mpoa: mpoa_caches.c: holding time expired, ip = %u.%u.%u.%u\n", NIPQUAD(entry->ctrl_info.in_dst_ip));
 			client->in_ops->remove_entry(entry, client);
 		}
 		entry = next_entry;
@@ -455,7 +453,6 @@ static void eg_cache_remove_entry(eg_cac
 
 static eg_cache_entry *eg_cache_add_entry(struct k_message *msg, struct mpoa_client *client)
 {
-	unsigned char *ip;
 	eg_cache_entry *entry = kmalloc(sizeof(eg_cache_entry), GFP_KERNEL);
 
 	if (entry == NULL) {
@@ -463,8 +460,7 @@ static eg_cache_entry *eg_cache_add_entr
 		return NULL;
 	}
 
-	ip = (unsigned char *)&msg->content.eg_info.eg_dst_ip;
-	dprintk("mpoa: mpoa_caches.c: adding an egress entry, ip = %u.%u.%u.%u, this should be our IP\n", NIPQUAD(ip));
+	dprintk("mpoa: mpoa_caches.c: adding an egress entry, ip = %u.%u.%u.%u, this should be our IP\n", NIPQUAD(msg->content.eg_info.eg_dst_ip));
 	memset(entry, 0, sizeof(eg_cache_entry));
 
 	atomic_set(&entry->use, 1);
@@ -481,8 +477,8 @@ static eg_cache_entry *eg_cache_add_entr
 	do_gettimeofday(&(entry->tv));
 	entry->entry_state = EGRESS_RESOLVED;
 	dprintk("mpoa: mpoa_caches.c: new_eg_cache_entry cache_id %lu\n", ntohl(entry->ctrl_info.cache_id));
-	ip = (unsigned char *)&entry->ctrl_info.mps_ip;
-	dprintk("mpoa: mpoa_caches.c: mps_ip = %u.%u.%u.%u\n", NIPQUAD(ip));
+	dprintk("mpoa: mpoa_caches.c: mps_ip = %u.%u.%u.%u\n",
+		NIPQUAD(entry->ctrl_info.mps_ip));
 	atomic_inc(&entry->use);
 
 	write_unlock_irq(&client->egress_lock);
-- 
1.3.GIT

