Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263731AbTCUSYp>; Fri, 21 Mar 2003 13:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263714AbTCUSXp>; Fri, 21 Mar 2003 13:23:45 -0500
Received: from freeside.toyota.com ([63.87.74.7]:5070 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263722AbTCUSWz>; Fri, 21 Mar 2003 13:22:55 -0500
Message-ID: <3E7B5B0E.9080808@tmsusa.com>
Date: Fri, 21 Mar 2003 10:33:50 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: An oops while running 2.5.65-mm2
References: <3E7A1ABF.7050402@tmsusa.com>	 <20030320122931.0d2f208f.akpm@digeo.com> <1048209554.1103.21.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have 12 hours uptime so far with this
patch, and everything is good so far -

Will report any change in status -

Joe

Martin Josefsson wrote:

>You are correct. It was a list_del() that caused it (at least I think
>so, it's 2am right now).
>
>1. conntrack helper adds an expectation and adds that to a list hanging
>of off a connection.
>
>2. the expected connection arrives. the expectation is still on the
>list.
>
>3. the original connection that caused the expectation terminates but
>the expectation still thinks it's added to the list.
>
>4. the expected connection terminates and list_del() is called to remove
>it from the list which doesn't exist anymore. boom!
>
>  
>
>------------------------------------------------------------------------
>
>--- linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c.orig	2003-03-21 01:42:57.000000000 +0100
>+++ linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-21 01:44:11.000000000 +0100
>@@ -274,6 +274,7 @@
> 		 * the un-established ones only */
> 		if (exp->sibling) {
> 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
>+			exp->sibling = NULL;
> 			continue;
> 		}
> 
>@@ -327,9 +328,11 @@
> 	WRITE_LOCK(&ip_conntrack_lock);
> 	/* Delete our master expectation */
> 	if (ct->master) {
>-		/* can't call __unexpect_related here,
>-		 * since it would screw up expect_list */
>-		list_del(&ct->master->expected_list);
>+		if (ct->master->sibling) {
>+			/* can't call __unexpect_related here,
>+			 * since it would screw up expect_list */
>+			list_del(&ct->master->expected_list);
>+		}
> 		kfree(ct->master);
> 	}
> 	WRITE_UNLOCK(&ip_conntrack_lock);
>  
>


