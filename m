Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUH2RG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUH2RG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUH2RGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:06:55 -0400
Received: from holomorphy.com ([207.189.100.168]:37294 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268200AbUH2RDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:03:46 -0400
Date: Sun, 29 Aug 2004 10:03:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Message-ID: <20040829170328.GK5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave> <200408290948.06473.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408290948.06473.jbarnes@engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 29, 2004 6:39 am, James Bottomley wrote:
>> This patch causes an immediate panic when the secondary processors come
>> on-line because sd->next is NULL.
>> The fix is to use cpu_possible_map instead of nodemask (which expands,
>> probably erroneously, to cpu_online_map in the non-numa case).
>> Any use of cpu_online_map in initialisation code is almost invariably
>> wrong, so please don't do it in future.
>> I know I'm sounding like a broken record, but it would be a lot easier
>> to spot mistakes like this immediately if every arch used the hotplug
>> paths to bring SMP up.
>> Anyway, the attached fixes our panic.

On Sun, Aug 29, 2004 at 09:48:06AM -0700, Jesse Barnes wrote:
> But I think this breaks what the code is supposed to do.  You're
> right that we shouldn't use cpu_online_map, but we should leave the
> nodemask in there and fix the code that sets it in the non-NUMA case
> instead.

Index: wait-2.6.9-rc1-mm1/include/asm-generic/topology.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/asm-generic/topology.h	2004-08-24 00:01:54.000000000 -0700
+++ wait-2.6.9-rc1-mm1/include/asm-generic/topology.h	2004-08-29 10:02:01.513753008 -0700
@@ -36,7 +36,7 @@
 #define parent_node(node)	(0)
 #endif
 #ifndef node_to_cpumask
-#define node_to_cpumask(node)	(cpu_online_map)
+#define node_to_cpumask(node)	(cpu_possible_map)
 #endif
 #ifndef node_to_first_cpu
 #define node_to_first_cpu(node)	(0)
