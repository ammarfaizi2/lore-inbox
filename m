Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264171AbTDJVC6 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbTDJVC6 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:02:58 -0400
Received: from [12.47.58.73] ([12.47.58.73]:50481 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264171AbTDJVCy (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:02:54 -0400
Date: Thu, 10 Apr 2003 14:14:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org, sct@redhat.com,
       akpm@zip.com.au, adilger@clusterfs.com, davem@redhat.com,
       jmorris@intercode.com.au
Subject: Re: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
Message-Id: <20030410141443.730ead79.akpm@digeo.com>
In-Reply-To: <20030410173017.GB20177@suse.de>
References: <20030410163857.GB19129@zip.com.au>
	<20030410173017.GB20177@suse.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Apr 2003 21:14:29.0955 (UTC) FILETIME=[2CB5A130:01C2FFA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Fri, Apr 11, 2003 at 02:38:58AM +1000, CaT wrote:
> 
>  > Slab corruption: start=ce6130c4, expend=ce6131f3, problemat=ce613128
>  > Last user: [<c032ff78>](destroy_conntrack+0x9c/0xac)
>  > Data: ****************************************************************************************************28 31 61 CE 28 31 61 CE ***************************************************************************************************************************************************************************************************A5 
>  > Next: 71 F0 2C .78 FF 32 C0 71 F0 2C .********************
>  > slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
>  > Call Trace:
>  >  [<c0131d5d>] __slab_error+0x21/0x28
>  >  [<c013214c>] check_poison_obj+0x174/0x180
>  >  [<c01331b9>] kmem_cache_alloc+0x8d/0x128
>  >  [<c033075f>] init_conntrack+0xcf/0x310
>  >  [<c033075f>] init_conntrack+0xcf/0x310
> 
> Known bug, with known fix. This really should go to Linus.
> http://bugzilla.kernel.org/show_bug.cgi?id=497

I've had the below patch in -mm for some time, but am not sure what to do
with it.  My last attempt to contact netfilter people didn't work.

James?  Help?


From: Martin Josefsson <gandalf@wlug.westbo.se>

You are correct. It was a list_del() that caused it (at least I think
so, it's 2am right now).

1. conntrack helper adds an expectation and adds that to a list hanging
of off a connection.

2. the expected connection arrives. the expectation is still on the
list.

3. the original connection that caused the expectation terminates but
the expectation still thinks it's added to the list.

4. the expected connection terminates and list_del() is called to remove
it from the list which doesn't exist anymore. boom!

(forwarded by akpm@digeo.com)


 25-akpm/net/ipv4/netfilter/ip_conntrack_core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN net/ipv4/netfilter/ip_conntrack_core.c~conntrack-use-after-free-fix net/ipv4/netfilter/ip_conntrack_core.c
--- 25/net/ipv4/netfilter/ip_conntrack_core.c~conntrack-use-after-free-fix	Thu Apr  3 14:53:46 2003
+++ 25-akpm/net/ipv4/netfilter/ip_conntrack_core.c	Thu Apr  3 14:53:46 2003
@@ -273,6 +273,7 @@ static void remove_expectations(struct i
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
+			exp->expectant = NULL;
 			continue;
 		}
 
@@ -326,9 +327,11 @@ destroy_conntrack(struct nf_conntrack *n
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

_

