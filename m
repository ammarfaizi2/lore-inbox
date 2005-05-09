Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVEINun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVEINun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEINun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:50:43 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:39110 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S261371AbVEINuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:50:22 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Frost <sfrost@snowman.net>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ipt_recent fixes
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Stephen Frost
	<sfrost@snowman.net>, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org
Date: Mon, 09 May 2005 15:50:09 +0200
Message-ID: <87ll6o1pbi.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had some ipt_recent rules acting strangely after an uptime of
about 25 days.  The broken behavior is reproducible in the 5 minutes
before the first jiffies roll-over right after booting too.

The cause of the problem is the jiffies comparision which doesn't work
like intended if one of the last hits was more than LONG_MAX seconds
ago or if the table of last hits contains empty slots and jiffies
is > LONG_MAX.

This patch fixes the problem by using get_seconds() instead of
jiffies.  It also fixes some 64-bit issues.


        Juergen

Signed-off-by: Juergen Kreileder <jk@blackdown.de>

diff --exclude=arch --exclude-from=Documentation/dontdiff -ur ../linux-2.6.12-rc3-mm3/include/linux/netfilter_ipv4/ipt_recent.h ./include/linux/netfilter_ipv4/ipt_recent.h
--- ../linux-2.6.12-rc3-mm3/include/linux/netfilter_ipv4/ipt_recent.h	2005-03-02 08:38:10.000000000 +0100
+++ ./include/linux/netfilter_ipv4/ipt_recent.h	2005-05-09 14:50:40.000000000 +0200
@@ -2,7 +2,7 @@
 #define _IPT_RECENT_H
 
 #define RECENT_NAME	"ipt_recent"
-#define RECENT_VER	"v0.3.1"
+#define RECENT_VER	"v0.3.2"
 
 #define IPT_RECENT_CHECK  1
 #define IPT_RECENT_SET    2
diff --exclude=arch --exclude-from=Documentation/dontdiff -ur ../linux-2.6.12-rc3-mm3/net/ipv4/netfilter/ipt_recent.c ./net/ipv4/netfilter/ipt_recent.c
--- ../linux-2.6.12-rc3-mm3/net/ipv4/netfilter/ipt_recent.c	2005-03-02 08:37:48.000000000 +0100
+++ ./net/ipv4/netfilter/ipt_recent.c	2005-05-09 15:06:58.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/ip.h>
 #include <linux/vmalloc.h>
+#include <linux/time.h>
 #include <linux/moduleparam.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
@@ -64,7 +65,7 @@
 
 struct time_info_list {
 	u_int32_t position;
-	u_int32_t time;
+	unsigned long time;
 };
 
 /* Structure of our linked list of tables of recent lists. */
@@ -223,7 +224,7 @@
 			curr_table->table[count].last_seen = 0;
 			curr_table->table[count].addr = 0;
 			curr_table->table[count].ttl = 0;
-			memset(curr_table->table[count].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+			memset(curr_table->table[count].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 			curr_table->table[count].oldest_pkt = 0;
 			curr_table->table[count].time_pos = 0;
 			curr_table->time_info[count].position = count;
@@ -418,8 +419,8 @@
 	if(debug) printk(KERN_INFO RECENT_NAME ": match(): checking table, addr: %u, ttl: %u, orig_ttl: %u\n",addr,ttl,skb->nh.iph->ttl);
 #endif
 
-	/* Get jiffies now in case they changed while we were waiting for a lock */
-	now = jiffies;
+	/* Get time now in case it changed while we were waiting for a lock */
+	now = get_seconds();
 	hash_table = curr_table->hash_table;
 	time_info = curr_table->time_info;
 
@@ -502,7 +503,7 @@
 		location = time_info[curr_table->time_pos].position;
 		hash_table[r_list[location].hash_entry] = -1;
 		hash_table[hash_result] = location;
-		memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+		memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 		r_list[location].time_pos = curr_table->time_pos;
 		r_list[location].addr = addr;
 		r_list[location].ttl = ttl;
@@ -528,11 +529,11 @@
 		if(info->check_set & IPT_RECENT_CHECK || info->check_set & IPT_RECENT_UPDATE) {
 			if(!info->seconds && !info->hit_count) ans = !info->invert; else ans = info->invert;
 			if(info->seconds && !info->hit_count) {
-				if(time_before_eq(now,r_list[location].last_seen+info->seconds*HZ)) ans = !info->invert; else ans = info->invert;
+				if(now <= r_list[location].last_seen+info->seconds) ans = !info->invert; else ans = info->invert;
 			}
 			if(info->seconds && info->hit_count) {
 				for(pkt_count = 0, hits_found = 0; pkt_count < ip_pkt_list_tot; pkt_count++) {
-					if(time_before_eq(now,r_list[location].last_pkts[pkt_count]+info->seconds*HZ)) hits_found++;
+					if(now <= r_list[location].last_pkts[pkt_count]+info->seconds) hits_found++;
 				}
 				if(hits_found >= info->hit_count) ans = !info->invert; else ans = info->invert;
 			}
@@ -631,7 +632,7 @@
 			r_list[location].last_seen = 0;
 			r_list[location].addr = 0;
 			r_list[location].ttl = 0;
-			memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(u_int32_t));
+			memset(r_list[location].last_pkts,0,ip_pkt_list_tot*sizeof(unsigned long));
 			r_list[location].oldest_pkt = 0;
 			ans = !info->invert;
 		}
@@ -734,10 +735,10 @@
 	memset(curr_table->table,0,sizeof(struct recent_ip_list)*ip_list_tot);
 #ifdef DEBUG
 	if(debug) printk(KERN_INFO RECENT_NAME ": checkentry: Allocating %d for pkt_list.\n",
-			sizeof(u_int32_t)*ip_pkt_list_tot*ip_list_tot);
+			sizeof(unsigned long)*ip_pkt_list_tot*ip_list_tot);
 #endif
 
-	hold = vmalloc(sizeof(u_int32_t)*ip_pkt_list_tot*ip_list_tot);
+	hold = vmalloc(sizeof(unsigned long)*ip_pkt_list_tot*ip_list_tot);
 #ifdef DEBUG
 	if(debug) printk(KERN_INFO RECENT_NAME ": checkentry: After pkt_list allocation.\n");
 #endif
=

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
