Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUJODHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUJODHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUJODHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:07:20 -0400
Received: from ozlabs.org ([203.10.76.45]:32990 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265996AbUJODHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:07:17 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: dominik.karall@gmx.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Harald Welte <laforge@netfilter.org>
In-Reply-To: <20041014190910.79cb2665.akpm@osdl.org>
References: <20041004020207.4f168876.akpm@osdl.org>
	 <200410051607.40860.dominik.karall@gmx.net>
	 <1097804285.22673.47.camel@localhost.localdomain>
	 <20041014184427.65d75324.akpm@osdl.org>
	 <1097805925.22673.70.camel@localhost.localdomain>
	 <20041014190910.79cb2665.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097809631.22673.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 13:07:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 12:09, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > > We were getting warnings from somewhere or other due to smp_processor_id()
> >  > within preemptible code - I don't recall the callsite.
> > 
> >  That's weird, but implies bogosity in the caller.  Covering it up like
> >  this is not necessarily a win.
> 
> umm.
> 
> 	ip_conntrack_cleanup
> 	->ip_ct_selective_cleanup
> 	  ->death_by_timeout
> 	    ->CONNTRACK_STAT_INC
> 
> is one route.

Yep, called on module removal.

Cheers,
Rusty.

Name: Avoid warning on CONNTRACK_STAT_INC in death_by_timeout()
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Module removal can call death_by_timeout() manually, which isn't in
softirq context, so the CONNTRACK_STAT_INC() call there (which assumes
preempt disabled) can give a warning.  Of course, the warning here is
spurious, but the simplest workaround is to call CONNTRACK_STAT_INC()
inside the lock.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29431-linux-2.6.9-rc4-bk2/net/ipv4/netfilter/ip_conntrack_core.c .29431-linux-2.6.9-rc4-bk2.updated/net/ipv4/netfilter/ip_conntrack_core.c
--- .29431-linux-2.6.9-rc4-bk2/net/ipv4/netfilter/ip_conntrack_core.c	2004-10-11 15:17:21.000000000 +1000
+++ .29431-linux-2.6.9-rc4-bk2.updated/net/ipv4/netfilter/ip_conntrack_core.c	2004-10-15 13:05:52.000000000 +1000
@@ -328,9 +328,10 @@ static void death_by_timeout(unsigned lo
 {
 	struct ip_conntrack *ct = (void *)ul_conntrack;
 
-	CONNTRACK_STAT_INC(delete_list);
-
 	WRITE_LOCK(&ip_conntrack_lock);
+	/* Inside lock so preempt is disabled on module removal path.
+	 * Otherwise we can get spurious warnings. */
+	CONNTRACK_STAT_INC(delete_list);
 	clean_from_lists(ct);
 	WRITE_UNLOCK(&ip_conntrack_lock);
 	ip_conntrack_put(ct);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

