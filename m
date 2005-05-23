Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVEWXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEWXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEWXVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:21:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:35715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbVEWXUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:20:02 -0400
Date: Mon, 23 May 2005 16:19:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, bdschuym@pandora.be,
       herbert@gondor.apana.org.au, mailinglists@unix-scripts.com
Subject: [patch 03/16] [EBTABLES]: Fix smp race.
Message-ID: <20050523231920.GO27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes an smp race that happens on such systems under
heavy load.
This bug was reported and solved by Steve Herrell
<steve_herrell@yahoo.ca>

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/bridge/netfilter/ebtables.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.11.10.orig/net/bridge/netfilter/ebtables.c	2005-05-20 09:36:00.942030616 -0700
+++ linux-2.6.11.10/net/bridge/netfilter/ebtables.c	2005-05-20 09:36:18.350384144 -0700
@@ -179,9 +179,10 @@
 	struct ebt_chainstack *cs;
 	struct ebt_entries *chaininfo;
 	char *base;
-	struct ebt_table_info *private = table->private;
+	struct ebt_table_info *private;
 
 	read_lock_bh(&table->lock);
+	private = table->private;
 	cb_base = COUNTER_BASE(private->counters, private->nentries,
 	   smp_processor_id());
 	if (private->chainstack)
