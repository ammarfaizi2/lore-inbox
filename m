Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVKDJmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVKDJmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 04:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVKDJmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 04:42:08 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:57019 "HELO
	toe-A.terreactive.ch") by vger.kernel.org with SMTP
	id S1161094AbVKDJmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 04:42:07 -0500
Message-ID: <436B2CE5.5070400@drugphish.ch>
Date: Fri, 04 Nov 2005 10:41:57 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: .
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org, ja@ssi.bg
Subject: [PATCH 2.4] [IPVS] fix missing refcnt put with expire_nodest_conn
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet>
In-Reply-To: <20051101063402.GA3311@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------090907040204070601040606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907040204070601040606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Marcelo,

It seems we forgot to fix one place where ip_vs_conn_expire_now
is used. Callers should hold write lock or cp->refcnt (and not forget
it). This results in hanging template entries when expire_nodest_conn is
kicking in and trying to remove all connection entries for a specific
destination.

Julian Anastasov created a patch to fix this and asked me to forward it
for inclusion, after test and verification, which have happened the last
24 hours.

This problem also exists in 2.6.x kernels, patch will be sent to netdev.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Roberto Nibali <ratz@drugphish.ch>

Please apply this before releasing 2.4.32.

Best regards,
Roberto Nibali, ratz
-- 
-------------------------------------------------------------
addr://Kasinostrasse 30, CH-5001 Aarau tel://++41 62 823 9355
http://www.terreactive.com             fax://++41 62 823 9356
-------------------------------------------------------------
terreActive AG                       Wir sichern Ihren Erfolg
-------------------------------------------------------------

--------------090907040204070601040606
Content-Type: text/plain;
 name="linux-2.4.32-rc2-ip_vs_conn_expire_now-fix_refcnt-dec-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.32-rc2-ip_vs_conn_expire_now-fix_refcnt-dec-1.diff"

diff -ur v2.4.32-rc2/linux/net/ipv4/ipvs/ip_vs_core.c linux/net/ipv4/ipvs/ip_vs_core.c
--- v2.4.32-rc2/linux/net/ipv4/ipvs/ip_vs_core.c	2005-11-03 01:20:02.000000000 +0200
+++ linux/net/ipv4/ipvs/ip_vs_core.c	2005-11-03 01:22:36.347895544 +0200
@@ -1111,11 +1111,10 @@
 		if (sysctl_ip_vs_expire_nodest_conn) {
 			/* try to expire the connection immediately */
 			ip_vs_conn_expire_now(cp);
-		} else {
-			/* don't restart its timer, and silently
-			   drop the packet. */
-			__ip_vs_conn_put(cp);
 		}
+		/* don't restart its timer, and silently
+		   drop the packet. */
+		__ip_vs_conn_put(cp);
 		return NF_DROP;
 	}

--------------090907040204070601040606--
