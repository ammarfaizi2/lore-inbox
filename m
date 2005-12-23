Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVLWW2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVLWW2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVLWW2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:28:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:33992 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161077AbVLWW2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:38 -0500
Date: Fri, 23 Dec 2005 14:28:02 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ja@ssi.bg, davem@davemloft.net,
       ratz@drugphish.ch
Subject: [patch 10/11] ipvs: fix connection leak if expire_nodest_conn=1
Message-ID: <20051223222802.GK18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipvs-fix-connection-leak.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Anastasov <ja@ssi.bg>


There was a fix in 2.6.13 that changed the behaviour of
ip_vs_conn_expire_now function not to put reference to connection, its
callers should hold write lock or connection refcnt. But we forgot to
convert one caller, when the real server for connection is unavailable
caller should put the connection reference. It happens only when sysctl
var expire_nodest_conn is set to 1 and such connections never expire.
Thanks to Roberto Nibali who found the problem and tested a 2.4.32-rc2
patch, which is equal to this 2.6 version.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Roberto Nibali <ratz@drugphish.ch>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/ipvs/ip_vs_core.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.14.1.orig/net/ipv4/ipvs/ip_vs_core.c
+++ linux-2.6.14.1/net/ipv4/ipvs/ip_vs_core.c
@@ -1009,11 +1009,10 @@ ip_vs_in(unsigned int hooknum, struct sk
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
 

--
