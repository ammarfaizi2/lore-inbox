Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVIWKCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVIWKCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 06:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVIWKCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 06:02:48 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:39642 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750868AbVIWKCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 06:02:48 -0400
Message-ID: <4333D2AA.6020009@cosmosbay.com>
Date: Fri, 23 Sep 2005 12:02:18 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: wensong@linux-vs.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ja@ssi.bg
Subject: [PATCH] reduce sizeof(struct file)
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org> <4333CF4C.2000306@anagramm.de>
In-Reply-To: <4333CF4C.2000306@anagramm.de>
Content-Type: multipart/mixed;
 boundary="------------060805000007050707010402"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 23 Sep 2005 12:02:20 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060805000007050707010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

Now that RCU applied on 'struct file' seems stable, we can place f_rcuhead in 
a memory location that is not anymore used at call_rcu(&f->f_rcuhead, 
file_free_rcu) time, to reduce the size of this critical kernel object.

The trick I used is to move f_rcuhead and f_list in an union and defining 
macros to access f_list and f_rcuhead

Unfortunatly f_list was also used in IPVS so I had to change 
include/net/ip_vs.h and net/ipv4/ipvs/ip_vs_ctl.c, changing their f_list to 
ipvs_f_list to avoid name clash.

(This is why I send this mail to IPVS maintainers)

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------060805000007050707010402
Content-Type: text/plain;
 name="shrink_struct_file"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shrink_struct_file"

--- linux-2.6.14-rc2/include/linux/fs.h	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed2/include/linux/fs.h	2005-09-23 11:22:19.000000000 +0200
@@ -574,7 +574,16 @@
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 
 struct file {
-	struct list_head	f_list;
+/*
+ * f_list and f_rcuhead can share the same memory location
+ */
+	union {
+		struct list_head	uf_f_list;
+		struct rcu_head 	uf_f_rcuhead;
+	} uf;
+#define f_list    uf.uf_f_list
+#define f_rcuhead uf.uf_f_rcuhead
+
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
 	struct file_operations	*f_op;
@@ -598,7 +607,6 @@
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
-	struct rcu_head 	f_rcuhead;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
--- linux-2.6.14-rc2/include/net/ip_vs.h	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed2/include/net/ip_vs.h	2005-09-23 11:46:55.000000000 +0200
@@ -548,7 +548,7 @@
  */
 struct ip_vs_service {
 	struct list_head	s_list;   /* for normal service table */
-	struct list_head	f_list;   /* for fwmark-based service table */
+	struct list_head	ipvs_f_list;   /* for fwmark-based service table */
 	atomic_t		refcnt;   /* reference counter */
 	atomic_t		usecnt;   /* use counter */
 
--- linux-2.6.14-rc2/net/ipv4/ipvs/ip_vs_ctl.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed2/net/ipv4/ipvs/ip_vs_ctl.c	2005-09-23 11:47:30.000000000 +0200
@@ -322,7 +322,7 @@
 		 *  Hash it by fwmark in ip_vs_svc_fwm_table
 		 */
 		hash = ip_vs_svc_fwm_hashkey(svc->fwmark);
-		list_add(&svc->f_list, &ip_vs_svc_fwm_table[hash]);
+		list_add(&svc->ipvs_f_list, &ip_vs_svc_fwm_table[hash]);
 	}
 
 	svc->flags |= IP_VS_SVC_F_HASHED;
@@ -349,7 +349,7 @@
 		list_del(&svc->s_list);
 	} else {
 		/* Remove it from the ip_vs_svc_fwm_table table */
-		list_del(&svc->f_list);
+		list_del(&svc->ipvs_f_list);
 	}
 
 	svc->flags &= ~IP_VS_SVC_F_HASHED;
@@ -395,7 +395,7 @@
 	/* Check for fwmark addressed entries */
 	hash = ip_vs_svc_fwm_hashkey(fwmark);
 
-	list_for_each_entry(svc, &ip_vs_svc_fwm_table[hash], f_list) {
+	list_for_each_entry(svc, &ip_vs_svc_fwm_table[hash], ipvs_f_list) {
 		if (svc->fwmark == fwmark) {
 			/* HIT */
 			atomic_inc(&svc->usecnt);
@@ -1297,7 +1297,7 @@
 	 */
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
 		list_for_each_entry_safe(svc, nxt,
-					 &ip_vs_svc_fwm_table[idx], f_list) {
+					 &ip_vs_svc_fwm_table[idx], ipvs_f_list) {
 			write_lock_bh(&__ip_vs_svc_lock);
 			ip_vs_svc_unhash(svc);
 			/*
@@ -1341,7 +1341,7 @@
 	}
 
 	for(idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], ipvs_f_list) {
 			ip_vs_zero_service(svc);
 		}
 	}
@@ -1666,7 +1666,7 @@
 
 	/* keep looking in fwmark */
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], ipvs_f_list) {
 			if (pos-- == 0) {
 				iter->table = ip_vs_svc_fwm_table;
 				iter->bucket = idx;
@@ -1718,13 +1718,13 @@
 	}
 
 	/* next service in hashed by fwmark */
-	if ((e = svc->f_list.next) != &ip_vs_svc_fwm_table[iter->bucket])
-		return list_entry(e, struct ip_vs_service, f_list);
+	if ((e = svc->ipvs_f_list.next) != &ip_vs_svc_fwm_table[iter->bucket])
+		return list_entry(e, struct ip_vs_service, ipvs_f_list);
 
  scan_fwmark:
 	while (++iter->bucket < IP_VS_SVC_TAB_SIZE) {
 		list_for_each_entry(svc, &ip_vs_svc_fwm_table[iter->bucket],
-				    f_list)
+				    ipvs_f_list)
 			return svc;
 	}
 
@@ -2095,7 +2095,7 @@
 	}
 
 	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
-		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], f_list) {
+		list_for_each_entry(svc, &ip_vs_svc_fwm_table[idx], ipvs_f_list) {
 			if (count >= get->num_services)
 				goto out;
 			memset(&entry, 0, sizeof(entry));

--------------060805000007050707010402--
