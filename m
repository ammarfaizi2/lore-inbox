Return-Path: <linux-kernel-owner+w=401wt.eu-S1161043AbXALLQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbXALLQq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbXALLQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:16:46 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:56294 "EHLO
	favonius.humilis.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161043AbXALLQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:16:46 -0500
X-Greylist: delayed 1459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 06:16:45 EST
Date: Fri, 12 Jan 2007 11:52:24 +0100
From: Sander <sander@humilis.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 'struct task_struct' has no member named 'mems_allowed'  (was: Re: 2.6.20-rc4-mm1)
Message-ID: <20070112105224.GA12813@favonius>
Reply-To: sander@humilis.net
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
X-Uptime: 11:30:41 up 10:19, 15 users,  load average: 0.15, 0.10, 0.03
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote (ao):
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/

>  x86/x86_64 things

> +mbind-restrict-nodes-to-the-currently-allowed-cpuset.patch

I had to revert this patch because of:

===
mm/mempolicy.c: In function 'sys_mbind':
mm/mempolicy.c:885: error: 'struct task_struct' has no member named 'mems_allowed'
make[1]: *** [mm/mempolicy.o] Error 1
make: *** [mm] Error 2
===

===
http://lkml.org/lkml/2007/1/9/375

Date	Tue, 9 Jan 2007 20:15:07 -0800 (PST)
From	Christoph Lameter <>
Subject	mbind: Restrict nodes to the currently allowed cpuset
Digg This

Currently one can specify an arbitrary node mask to mbind that includes nodes
not allowed. If that is done with an interleave policy then we will go around
all the nodes. Those outside of the currently allowed cpuset will be redirected
to the border nodes. Interleave will then create imbalances at the borders
of the cpuset.

This patch restricts the nodes to the currently allowed cpuset.

The RFC for this patch was discussed at
http://marc.theaimsgroup.com/?t=116793842100004&r=1&w=2
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.19-mm1.orig/mm/mempolicy.c	2006-12-11 19:00:38.224610647 -0800
+++ linux-2.6.19-mm1/mm/mempolicy.c	2006-12-13 11:13:10.175294067 -0800
@@ -882,6 +882,7 @@ asmlinkage long sys_mbind(unsigned long 
 	int err;
 
 	err = get_nodes(&nodes, nmask, maxnode);
+	nodes_and(nodes, nodes, current->mems_allowed);
 	if (err)
 		return err;
 	return do_mbind(start, len, mode, &nodes, flags);
===

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
