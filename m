Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUDPTUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUDPTUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:20:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:37798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbUDPTUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:20:13 -0400
Date: Fri, 16 Apr 2004 12:19:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, coreteam@netfilter.org
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416121955.Y22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ken Ashcraft (ken@coverity.com) wrote:
> [BUG] overflow in SMP_ALIGN?
> /home/kash/linux/linux-2.6.5/net/ipv6/netfilter/ip6_tables.c:1156:do_replace: ERROR:TAINT: 1144:1156:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
> 	struct ip6t_replace tmp;
> 	struct ip6t_table *t;
> 	struct ip6t_table_info *newinfo, *oldinfo;
> 	struct ip6t_counters *counters;
> 
> Start --->
> 	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> 		return -EFAULT;
> 
> 	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
> 	if ((SMP_ALIGN(tmp.size) >> PAGE_SHIFT) + 2 > num_physpages)
> 		return -ENOMEM;
> 
> 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
> 			  + SMP_ALIGN(tmp.size) * NR_CPUS);
> 	if (!newinfo)
> 		return -ENOMEM;
> 
> Error --->
> 	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
> 			   tmp.size) != 0) {
> 		ret = -EFAULT;
> 		goto free_newinfo;

I don't think there's an overflow here.  Just possiblity of large
allocations.  Seems sane to me to have some limits.  Also nothing
seems to sanity check against the tmp.num_counters sized vmalloc().
I do believe these are protected by capable() check.

> ---------------------------------------------------------
> [BUG] overflow in SMP_ALIGN?
> /home/kash/linux/linux-2.6.5/net/ipv4/netfilter/arp_tables.c:891:do_replace: ERROR:TAINT: 875:891:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
> 	struct arpt_replace tmp;
> 	struct arpt_table *t;
> 	struct arpt_table_info *newinfo, *oldinfo;
> 	struct arpt_counters *counters;
> 
> Start --->
> 	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> 
> 	... DELETED 10 lines ...
> 
> 	newinfo = vmalloc(sizeof(struct arpt_table_info)
> 			  + SMP_ALIGN(tmp.size) * NR_CPUS);
> 	if (!newinfo)
> 		return -ENOMEM;
> 
> Error --->
> 	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
> 			   tmp.size) != 0) {
> 		ret = -EFAULT;
> 		goto free_newinfo;

There's a couple checks here:

	/* Hack: Causes ipchains to give correct error msg --RR */
	if (len != sizeof(tmp) + tmp.size)
		return -ENOPROTOOPT;

	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
	if ((SMP_ALIGN(tmp.size) >> PAGE_SHIFT) + 2 > num_physpages)
		return -ENOMEM;

Are these sufficient to limit considering the allocation is sized by
'SMP_ALIGN(tmp.size) * NR_CPUS'?  And nothing checking tmp.num_counters.
Again, protected by capable().

> ---------------------------------------------------------
> [BUG] overflow in SMP_ALIGN?
> /home/kash/linux/linux-2.6.5/net/ipv4/netfilter/ip_tables.c:1074:do_replace: ERROR:TAINT: 1058:1074:Passing unbounded user value "(tmp).size" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=] 
> 	struct ipt_replace tmp;
> 	struct ipt_table *t;
> 	struct ipt_table_info *newinfo, *oldinfo;
> 	struct ipt_counters *counters;
> 
> Start --->
> 	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> 
> 	... DELETED 10 lines ...
> 
> 	newinfo = vmalloc(sizeof(struct ipt_table_info)
> 			  + SMP_ALIGN(tmp.size) * NR_CPUS);
> 	if (!newinfo)
> 		return -ENOMEM;
> 
> Error --->
> 	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
> 			   tmp.size) != 0) {
> 		ret = -EFAULT;
> 		goto free_newinfo;

same here.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
