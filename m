Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWHUSxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWHUSxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHUStD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:5053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750770AbWHUSs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:57 -0400
Date: Mon, 21 Aug 2006 11:47:23 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>,
       Patrick McHardy <kaber@trash.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/20] : ip_tables: fix table locking in ipt_do_table
Message-ID: <20060821184723.GO21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ip_tables-fix-table-locking-in-ipt_do_table.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

[NETFILTER]: ip_tables: fix table locking in ipt_do_table

table->private might change because of ruleset changes, don't use it without
holding the lock.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/arp_tables.c |    3 ++-
 net/ipv4/netfilter/ip_tables.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17.9.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.17.9/net/ipv4/netfilter/arp_tables.c
@@ -237,7 +237,7 @@ unsigned int arpt_do_table(struct sk_buf
 	struct arpt_entry *e, *back;
 	const char *indev, *outdev;
 	void *table_base;
-	struct xt_table_info *private = table->private;
+	struct xt_table_info *private;
 
 	/* ARP header, plus 2 device addresses, plus 2 IP addresses.  */
 	if (!pskb_may_pull((*pskb), (sizeof(struct arphdr) +
@@ -249,6 +249,7 @@ unsigned int arpt_do_table(struct sk_buf
 	outdev = out ? out->name : nulldevname;
 
 	read_lock_bh(&table->lock);
+	private = table->private;
 	table_base = (void *)private->entries[smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 	back = get_entry(table_base, private->underflow[hook]);
--- linux-2.6.17.9.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.17.9/net/ipv4/netfilter/ip_tables.c
@@ -231,7 +231,7 @@ ipt_do_table(struct sk_buff **pskb,
 	const char *indev, *outdev;
 	void *table_base;
 	struct ipt_entry *e, *back;
-	struct xt_table_info *private = table->private;
+	struct xt_table_info *private;
 
 	/* Initialization */
 	ip = (*pskb)->nh.iph;
@@ -248,6 +248,7 @@ ipt_do_table(struct sk_buff **pskb,
 
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
+	private = table->private;
 	table_base = (void *)private->entries[smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 

--
