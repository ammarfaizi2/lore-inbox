Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268308AbTGSQSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbTGSQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:18:41 -0400
Received: from robur.slu.se ([130.238.98.12]:49158 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id S268308AbTGSQSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:18:39 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16153.29344.964485.457389@robur.slu.se>
Date: Sat, 19 Jul 2003 18:32:32 +0200
To: "Kambo Lohan" <kambo77@hotmail.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: PATCH pktgen hang, memleak, fixes 
In-Reply-To: <Sea2-F47vJo8jUbRX8z000320b1@hotmail.com>
References: <Sea2-F47vJo8jUbRX8z000320b1@hotmail.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!
It looks fine. Jeff cross-posted to netdev which is the appropriate list. 
It goes for both 2.4 and 2.5 versions. We ask DaveM to apply.

Cheers.
					--ro


Kambo Lohan writes:
 > This should fix about 3 things.  My first patch, be gentle...
 > 
 > 2.5 has the same problem but I do not know if this will apply or not, we run 
 > 2.4.

--- linux/net/core/pktgen.c.orig	Thu Jul 17 16:00:14 2003
+++ linux/net/core/pktgen.c	Thu Jul 17 16:37:21 2003
@@ -47,6 +47,9 @@
  * Also moved to /proc/net/pktgen/ 
  * --ro 
  *
+ * Fix refcount off by one if first packet fails, potential null deref, 
+ * memleak 030710- KJP
+ *
  * See Documentation/networking/pktgen.txt for how to use this.
  */
 
@@ -85,9 +88,9 @@
 #define cycles()	((u32)get_cycles())
 
 
-#define VERSION "pktgen version 1.2"
+#define VERSION "pktgen version 1.2.1"
 static char version[] __initdata = 
-  "pktgen.c: v1.2: Packet Generator for packet performance testing.\n";
+  "pktgen.c: v1.2.1: Packet Generator for packet performance testing.\n";
 
 /* Used to help with determining the pkts on receive */
 
@@ -611,12 +614,11 @@
 				kfree_skb(skb);
 				skb = fill_packet(odev, info);
 				if (skb == NULL) {
-					break;
+					goto out_reldev;
 				}
 				fp++;
 				fp_tmp = 0; /* reset counter */
 			}
-			atomic_inc(&skb->users);
 		}
 
 		nr_frags = skb_shinfo(skb)->nr_frags;
@@ -632,6 +634,7 @@
 				last_ok = 0;
 			}
 			else {
+			   atomic_inc(&skb->users);
 			   last_ok = 1;	
 			   info->sofar++;
 			   info->seq_num++;
@@ -729,7 +732,9 @@
 			     (unsigned long long) info->errors
 			     );
 	}
-	
+
+	kfree_skb(skb);
+
 out_reldev:
 	if (odev) {
 		dev_put(odev);

