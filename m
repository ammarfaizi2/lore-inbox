Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266392AbTGJR1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTGJR1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:27:13 -0400
Received: from sea2-f40.sea2.hotmail.com ([207.68.165.40]:55820 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S269433AbTGJRZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:25:28 -0400
X-Originating-IP: [63.173.114.243]
X-Originating-Email: [kambo77@hotmail.com]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: robert.olsson@its.uu.se
Subject: [PATCH] [UPDATED] pktgen fixes ....
Date: Thu, 10 Jul 2003 13:40:04 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F408r8e4DjaQhm0000e1a4@hotmail.com>
X-OriginalArrivalTime: 10 Jul 2003 17:40:05.0049 (UTC) FILETIME=[4C380290:01C3470A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That last fix was bad... the skb->users refcount change made it possible for 
the skb to get double freed as skb->users  was only incremented from one 
immediately after calling dev_hard_xmit, this should address that I hope.  I 
now see thats what the old code was trying to avoid, but  the old way fails 
if the first packet attempted failed dev_hard_xmit.  So it needs a fix 
somehow.  I am testing this by looping a script that starts pktgen with 
count=10000 and clone_skb=100.  Making sure it does not soft hang (requiring 
a control c)  or cause mem leaks.

Here is the updated patch.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- linux-2.4.21/net/core/pktgen.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4-kjp/net/core/pktgen.c	2003-07-10 13:22:17.000000000 -0400
@@ -34,6 +34,7 @@
  *   *  The new changes seem to have a performance impact of around 1%,
  *       as far as I can tell.
  *   --Ben Greear <greearb@candelatech.com>
+ * Fix refcount off by one if first packet fails, potential null deref, 
memleak 030710- KJP
  *
  * Renamed multiskb to clone_skb and cleaned up sending core for two 
distinct
  * skb modes. A clone_skb=0 mode for Ben "ranges" work and a clone_skb != 0
@@ -84,9 +85,9 @@
#define cycles()	((u32)get_cycles())


-#define VERSION "pktgen version 1.2"
+#define VERSION "pktgen version 1.2.1"
static char version[] __initdata =
-  "pktgen.c: v1.2: Packet Generator for packet performance testing.\n";
+  "pktgen.c: v1.2.1: Packet Generator for packet performance testing.\n";

/* Used to help with determining the pkts on receive */

@@ -613,12 +614,11 @@
                                 kfree_skb(skb);
                                 skb = fill_packet(odev, info);
                                 if (skb == NULL) {
-                                        break;
+					goto out_reldev;
                                 }
                                 fp++;
                                 fp_tmp = 0; /* reset counter */
                         }
-                        atomic_inc(&skb->users);
                 }

                 nr_frags = skb_shinfo(skb)->nr_frags;
@@ -626,7 +626,9 @@
		spin_lock_bh(&odev->xmit_lock);
		if (!netif_queue_stopped(odev)) {

+			atomic_inc(&skb->users);
			if (odev->hard_start_xmit(skb, odev)) {
+				atomic_dec(&skb->users);
				if (net_ratelimit()) {
                                    printk(KERN_INFO "Hard xmit error\n");
                                 }
@@ -634,9 +636,9 @@
				last_ok = 0;
			}
                         else {
-		           last_ok = 1;
-                           info->sofar++;
-                           info->seq_num++;
+				last_ok = 1;
+				info->sofar++;
+				info->seq_num++;
                         }
		}
		else {
@@ -731,6 +733,8 @@
			     (unsigned long long) info->errors
			     );
	}
+
+	kfree_skb(skb);

out_reldev:
         if (odev) {

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus

