Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264463AbTCXWVA>; Mon, 24 Mar 2003 17:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264471AbTCXWVA>; Mon, 24 Mar 2003 17:21:00 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:53157 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S264463AbTCXWUy>;
	Mon, 24 Mar 2003 17:20:54 -0500
Subject: Re: conntrack related slab corruption in 2.5.65
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324220404.GB3034@suse.de>
References: <20030324220404.GB3034@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048545120.14720.45.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Mar 2003 23:32:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 23:04, Dave Jones wrote:
> Slab corruption: start=cf480a84, expend=cf480bb7, problemat=cf480aec
> Last user: [<c03ed43a>](destroy_conntrack+0xf8/0x159)
> Data: ********************************************************************************************************EC 0A 48 CF EC 0A 48 CF ***************************************************************************************************************************************************************************************************A5 
> Next: 71 F0 2C .3A D4 3E C0 71 F0 2C .********************
> slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing

Are you using a conntrack helper (ie. ip_conntrack_ftp) ?
If so then this is fixed in -mm. If not then this is another bug that I
need to track down.

I've been trying to get hold of Harald Welte for a few days now, all
netfilter patches should go through him -> davem -> linus/marcelo.


--- linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c.orig	2003-03-21 01:42:57.000000000 +0100
+++ linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-22 00:43:28.000000000 +0100
@@ -274,6 +274,7 @@
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
+			exp->expectant = NULL;
 			continue;
 		}
 
@@ -327,9 +328,11 @@
 	WRITE_LOCK(&ip_conntrack_lock);
 	/* Delete our master expectation */
 	if (ct->master) {
-		/* can't call __unexpect_related here,
-		 * since it would screw up expect_list */
-		list_del(&ct->master->expected_list);
+		if (ct->master->expectant) {
+			/* can't call __unexpect_related here,
+			 * since it would screw up expect_list */
+			list_del(&ct->master->expected_list);
+		}
 		kfree(ct->master);
 	}
 	WRITE_UNLOCK(&ip_conntrack_lock);


-- 
/Martin
