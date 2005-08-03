Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVHCHEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVHCHEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVHCHCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:02:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbVHCHAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:00:10 -0400
Date: Tue, 2 Aug 2005 23:59:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: [08/13] [NETFILTER]: Wait until all references to ip_conntrack_untracked are dropped on unload
Message-ID: <20050803065948.GW7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[NETFILTER]: Wait until all references to ip_conntrack_untracked are dropped on unload

Fixes a crash when unloading ip_conntrack.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_conntrack_core.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.12.3.orig/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-28 11:17:16.000000000 -0700
@@ -1124,6 +1124,9 @@
 		schedule();
 		goto i_see_dead_people;
 	}
+	/* wait until all references to ip_conntrack_untracked are dropped */
+	while (atomic_read(&ip_conntrack_untracked.ct_general.use) > 1)
+		schedule();
 
 	kmem_cache_destroy(ip_conntrack_cachep);
 	kmem_cache_destroy(ip_conntrack_expect_cachep);
