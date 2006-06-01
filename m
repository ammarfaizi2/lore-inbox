Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWFAOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWFAOyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWFAOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:54:04 -0400
Received: from stinky.trash.net ([213.144.137.162]:19696 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S965061AbWFAOyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:54:01 -0400
Message-ID: <447EFF72.1050803@trash.net>
Date: Thu, 01 Jun 2006 16:53:38 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
CC: Andrew Morton <akpm@osdl.org>, Stephen Frost <sfrost@snowman.net>,
       Amin Azez <azez@ufomechanic.net>,
       "David S. Miller" <davem@davemloft.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <44643BFD.3040708@trash.net> <20060515210342.GP7774@kenobi.snowman.net> <446AC1FB.5070406@trash.net> <200606010943.31554.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200606010943.31554.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050105060402030006050309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105060402030006050309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

[CC-list trimmed]

Andrew James Wade wrote:
> Hello Mr. McHardy,
> 
> The BUG below appears to be related to your ipt_recent rewrite. I
> haven't tracked it down further yet. I've attached the (toy) firewall
> script that's triggering the bug.

Yes, that was my fault. These two patches should fix it.


--------------050105060402030006050309
Content-Type: text/x-patch;
 name="01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01.diff"

[NETFILTER]: recent match: fix "sleeping function called from invalid context"

create_proc_entry must not be called with locks held. Use a mutex
instead to protect data only changed in user context.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 6812aa38ac35d6e819058d2273a6a7de091a2604
tree 140fea396f29415d7981fcfbc5980f5c0b2d91a7
parent a0447a3000b5d4e926928493def9d62aae3b87ed
author Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:40:39 +0200
committer Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:40:39 +0200

 net/ipv4/netfilter/ipt_recent.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/netfilter/ipt_recent.c b/net/ipv4/netfilter/ipt_recent.c
index 9686c4d..9b09e48 100644
--- a/net/ipv4/netfilter/ipt_recent.c
+++ b/net/ipv4/netfilter/ipt_recent.c
@@ -69,6 +69,7 @@ #endif
 
 static LIST_HEAD(tables);
 static DEFINE_SPINLOCK(recent_lock);
+static DEFINE_MUTEX(recent_mutex);
 
 #ifdef CONFIG_PROC_FS
 static struct proc_dir_entry	*proc_dir;
@@ -249,7 +250,7 @@ ipt_recent_checkentry(const char *tablen
 	    strnlen(info->name, IPT_RECENT_NAME_LEN) == IPT_RECENT_NAME_LEN)
 		return 0;
 
-	spin_lock_bh(&recent_lock);
+	mutex_lock(&recent_mutex);
 	t = recent_table_lookup(info->name);
 	if (t != NULL) {
 		t->refcnt++;
@@ -258,7 +259,7 @@ ipt_recent_checkentry(const char *tablen
 	}
 
 	t = kzalloc(sizeof(*t) + sizeof(t->iphash[0]) * ip_list_hash_size,
-		    GFP_ATOMIC);
+		    GFP_KERNEL);
 	if (t == NULL)
 		goto out;
 	strcpy(t->name, info->name);
@@ -274,10 +275,12 @@ #ifdef CONFIG_PROC_FS
 	t->proc->proc_fops = &recent_fops;
 	t->proc->data      = t;
 #endif
+	spin_lock_bh(&recent_lock);
 	list_add_tail(&t->list, &tables);
+	spin_unlock_bh(&recent_lock);
 	ret = 1;
 out:
-	spin_unlock_bh(&recent_lock);
+	mutex_unlock(&recent_mutex);
 	return ret;
 }
 
@@ -288,17 +291,19 @@ ipt_recent_destroy(const struct xt_match
 	const struct ipt_recent_info *info = matchinfo;
 	struct recent_table *t;
 
-	spin_lock_bh(&recent_lock);
+	mutex_lock(&recent_mutex);
 	t = recent_table_lookup(info->name);
 	if (--t->refcnt == 0) {
+		spin_lock_bh(&recent_lock);
 		list_del(&t->list);
+		spin_unlock_bh(&recent_lock);
 		recent_table_flush(t);
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry(t->name, proc_dir);
 #endif
 		kfree(t);
 	}
-	spin_unlock_bh(&recent_lock);
+	mutex_unlock(&recent_mutex);
 }
 
 #ifdef CONFIG_PROC_FS

--------------050105060402030006050309
Content-Type: text/x-patch;
 name="02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02.diff"

[NETFILTER]: recent match: missing refcnt initialization

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 10263005af5814396b8263c1c2a4367d49548e13
tree a73003fe82e7b4546359d86f684b90b78a6aa504
parent 6812aa38ac35d6e819058d2273a6a7de091a2604
author Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:49:58 +0200
committer Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:49:58 +0200

 net/ipv4/netfilter/ipt_recent.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/netfilter/ipt_recent.c b/net/ipv4/netfilter/ipt_recent.c
index 9b09e48..61a2139 100644
--- a/net/ipv4/netfilter/ipt_recent.c
+++ b/net/ipv4/netfilter/ipt_recent.c
@@ -262,6 +262,7 @@ ipt_recent_checkentry(const char *tablen
 		    GFP_KERNEL);
 	if (t == NULL)
 		goto out;
+	t->refcnt = 1;
 	strcpy(t->name, info->name);
 	INIT_LIST_HEAD(&t->lru_list);
 	for (i = 0; i < ip_list_hash_size; i++)

--------------050105060402030006050309--
