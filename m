Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUJAVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUJAVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUJAVSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:18:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:6056
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266603AbUJAU6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:58:14 -0400
Date: Fri, 1 Oct 2004 13:56:36 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, laforge@gnumonks.org
Subject: Re: Oops at __neigh_for_each_release (2.6.9-rc3)
Message-Id: <20041001135636.0c071602.davem@davemloft.net>
In-Reply-To: <200410012217.35264.baldrick@free.fr>
References: <200410012217.35264.baldrick@free.fr>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004 22:17:35 +0200
Duncan Sands <baldrick@free.fr> wrote:

> EIP is at __neigh_for_each_release+0x32/0xb0

Give this patch a try.  And please report networking bugs
to netdev@oss.sgi.com in the future, thanks.

===== net/atm/clip.c 1.42 vs edited =====
--- 1.42/net/atm/clip.c	2004-09-23 18:02:32 -07:00
+++ edited/net/atm/clip.c	2004-10-01 13:35:40 -07:00
@@ -984,19 +984,7 @@
 
 static int __init atm_clip_init(void)
 {
-	/* we should use neigh_table_init() */
-	clip_tbl.lock = RW_LOCK_UNLOCKED;
-	clip_tbl.kmem_cachep = kmem_cache_create(clip_tbl.id,
-	    clip_tbl.entry_size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
-
-	if (!clip_tbl.kmem_cachep)
-		return -ENOMEM;
-
-	/* so neigh_ifdown() doesn't complain */
-	clip_tbl.proxy_timer.data = 0;
-	clip_tbl.proxy_timer.function = NULL;
-	init_timer(&clip_tbl.proxy_timer);
-	skb_queue_head_init(&clip_tbl.proxy_queue);
+	neigh_table_init(&clip_tbl);
 
 	clip_tbl_hook = &clip_tbl;
 	register_atm_ioctl(&clip_ioctl_ops);
@@ -1022,7 +1010,6 @@
 
 	deregister_atm_ioctl(&clip_ioctl_ops);
 
-	neigh_ifdown(&clip_tbl, NULL);
 	dev = clip_devs;
 	while (dev) {
 		next = PRIV(dev)->next;
@@ -1030,9 +1017,11 @@
 		free_netdev(dev);
 		dev = next;
 	}
-	if (start_timer == 0) del_timer(&idle_timer);
 
-	kmem_cache_destroy(clip_tbl.kmem_cachep);
+	neigh_table_clear(&clip_tbl);
+
+	if (start_timer == 0)
+		del_timer(&idle_timer);
 
 	clip_tbl_hook = NULL;
 }
