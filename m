Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTAQMTk>; Fri, 17 Jan 2003 07:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTAQMTk>; Fri, 17 Jan 2003 07:19:40 -0500
Received: from port-212-202-185-115.reverse.qdsl-home.de ([212.202.185.115]:4775
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S264715AbTAQMTi>; Fri, 17 Jan 2003 07:19:38 -0500
Message-ID: <3E27F79F.2090705@trash.net>
Date: Fri, 17 Jan 2003 13:31:27 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]: PPP_FILTER outbound only drops with debugging enables
Content-Type: multipart/mixed;
 boundary="------------060305090702030904040509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305090702030904040509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Packets in ppp_send_frame catched by pass_filter are only dropped if 
debuging is enabled:

                if (ppp->pass_filter.filter
                    && sk_run_filter(skb, ppp->pass_filter.filter,
                                     ppp->pass_filter.len) == 0) {
                        if (ppp->debug & 1) {
                                printk(KERN_DEBUG "PPP: outbound frame 
not passed\n");
                                kfree_skb(skb);
                                return;
                        }
                }



The problem is still present in 2.5 bitkeeper tree. Attached patch fixes it.
Regards,
Patrick


--------------060305090702030904040509
Content-Type: text/plain;
 name="ppp_filter-outbound-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppp_filter-outbound-fix.diff"

--- linux-2.4.20/drivers/net/ppp_generic.c.orig	2003-01-17 13:15:32.000000000 +0100
+++ linux-2.4.20/drivers/net/ppp_generic.c	2003-01-17 13:16:23.000000000 +0100
@@ -965,11 +965,10 @@
 		if (ppp->pass_filter.filter
 		    && sk_run_filter(skb, ppp->pass_filter.filter,
 				     ppp->pass_filter.len) == 0) {
-			if (ppp->debug & 1) {
+			if (ppp->debug & 1)
 				printk(KERN_DEBUG "PPP: outbound frame not passed\n");
-				kfree_skb(skb);
-				return;
-			}
+			kfree_skb(skb);
+			return;
 		}
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter.filter

--------------060305090702030904040509--

