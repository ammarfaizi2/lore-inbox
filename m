Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTGJPHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbTGJPHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:07:47 -0400
Received: from sea2-f47.sea2.hotmail.com ([207.68.165.47]:64013 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S269321AbTGJPHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:07:45 -0400
X-Originating-IP: [63.173.114.243]
X-Originating-Email: [kambo77@hotmail.com]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH pktgen hang, memleak, fixes 
Date: Thu, 10 Jul 2003 11:22:24 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F47vJo8jUbRX8z000320b1@hotmail.com>
X-OriginalArrivalTime: 10 Jul 2003 15:22:25.0186 (UTC) FILETIME=[10F4F020:01C346F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix about 3 things.  My first patch, be gentle...

2.5 has the same problem but I do not know if this will apply or not, we run 
2.4.


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--- linux-2.4.21/net/core/pktgen.c	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4-kjp/net/core/pktgen.c	2003-07-10 11:08:31.000000000 -0400
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
@@ -634,9 +634,10 @@
				last_ok = 0;
			}
                         else {
-		           last_ok = 1;
-                           info->sofar++;
-                           info->seq_num++;
+				atomic_inc(&skb->users);
+				last_ok = 1;
+				info->sofar++;
+				info->seq_num++;
                         }
		}
		else {
@@ -707,6 +708,7 @@
		}
	}/* while we should be running */

+
	do_gettimeofday(&(info->stopped_at));

	total = (info->stopped_at.tv_sec - info->started_at.tv_sec) * 1000000 +
@@ -731,6 +733,8 @@
			     (unsigned long long) info->errors
			     );
	}
+
+	kfree_skb(skb);

out_reldev:
         if (odev) {

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

