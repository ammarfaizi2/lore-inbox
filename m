Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRCEPys>; Mon, 5 Mar 2001 10:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRCEPyi>; Mon, 5 Mar 2001 10:54:38 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:33751 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129381AbRCEPya>; Mon, 5 Mar 2001 10:54:30 -0500
Date: Mon, 5 Mar 2001 15:55:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: Marc Boucher <marc@mbsi.ca>, linux-kernel@vger.kernel.org
Subject: netfilter ip_conntrack num_physpages
In-Reply-To: <Pine.LNX.4.21.0103022135140.1440-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0103051552210.1056-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

num_physpages is shifted too far in netfilter's ip_conntrack_init():
would go to 0 on a 4GB, 8GB, ... 32-bit machine.  Okay, not quite all
the 4GB goes into num_physpages, so it's rather an issue with 5GB ...

Naive patch (against 2.4.3-pre2 or 2.4.2-ac11 or 2.4.2 or 2.4.1) below,
but I won't be submitting this to Alan or Linus myself (unless you ask):
I expect you'll want to consider whether the number should go on
climbing linearly in that way above 1GB.

Hugh

--- 2.4.2-ac11/net/ipv4/netfilter/ip_conntrack_core.c	Mon Mar  5 11:47:01 2001
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c	Mon Mar  5 12:01:49 2001
@@ -1078,7 +1078,7 @@
 	/* Idea from tcp.c: use 1/16384 of memory.  On i386: 32MB
 	 * machine has 256 buckets.  1GB machine has 8192 buckets. */
 	ip_conntrack_htable_size
-		= (((num_physpages << PAGE_SHIFT) / 16384)
+		= (((num_physpages << (PAGE_SHIFT - 12)) / 4)
 		   / sizeof(struct list_head));
 	ip_conntrack_max = 8 * ip_conntrack_htable_size;
 

