Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264326AbTCUXsr>; Fri, 21 Mar 2003 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264322AbTCUXsq>; Fri, 21 Mar 2003 18:48:46 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:61081 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S264320AbTCUXso>;
	Fri, 21 Mar 2003 18:48:44 -0500
Subject: Re: An oops while running 2.5.65-mm2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@digeo.com>
Cc: jjs <jjs@tmsusa.com>, linux-kernel@vger.kernel.org,
       Netfilter-devel <netfilter-devel@lists.netfilter.org>
In-Reply-To: <1048209554.1103.21.camel@tux.rsn.bth.se>
References: <3E7A1ABF.7050402@tmsusa.com>
	 <20030320122931.0d2f208f.akpm@digeo.com>
	 <1048209554.1103.21.camel@tux.rsn.bth.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048291181.1105.38.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Mar 2003 00:59:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 02:19, Martin Josefsson wrote:

> You are correct. It was a list_del() that caused it (at least I think
> so, it's 2am right now).
> 
> 1. conntrack helper adds an expectation and adds that to a list hanging
> of off a connection.
> 
> 2. the expected connection arrives. the expectation is still on the
> list.
> 
> 3. the original connection that caused the expectation terminates but
> the expectation still thinks it's added to the list.
> 
> 4. the expected connection terminates and list_del() is called to remove
> it from the list which doesn't exist anymore. boom!

Ok, the previous patch was a little bit incorrect. It did fix the use
after free bug (which can cause corruption if the slabmemory is
reallocated before we write to it) but lost some internal information.
I can't see that we use this anywhere after this point but here's the
proper patch.

Sorry about that.


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

Never argue with an idiot. They drag you down to their level, then beat you with experience.
