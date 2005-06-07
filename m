Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVFGOJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVFGOJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFGOJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:09:24 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:63847 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261866AbVFGOJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:09:16 -0400
Message-ID: <42A5AA85.60709@yahoo.com.au>
Date: Wed, 08 Jun 2005 00:09:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: linux-kernel@vger.kernel.org, John Hawkes <hawkes@sgi.com>
Subject: Re: Hang in sched_balance_self()
References: <20050603225544.GA8499@sgi.com>
In-Reply-To: <20050603225544.GA8499@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------090308050408040102080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308050408040102080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jack Steiner wrote:
> Nick -
> 
> The latest 2.6.12-rc5-mm2 tree fails to boot on some of the 64p
> SGI systems. The system hangs immediately after printing:
> 
> 	...
> 	Inode-cache hash table entries: 8388608 (order: 12, 67108864 bytes)
> 	Mount-cache hash table entries: 1024
> 	Boot processor id 0x0/0x0
> 	Brought up 64 CPUs
> 	Total of 64 processors activated (118415.36 BogoMIPS).
> 
> 
> I have isolated the failure to cpu 0 hanging in sched_balance_self() during
> a fork (or clone).  The "while" loop at the end of function never 
> terminates, ie. sd is never NULL.
> 
> Is this a problem that you have seen before. If not, I'll do some
> more digging & isolate the problem.
> 

Hi Jack,
I haven't completely got to the bottom of this yet, but I was able
to reproduce on a 64-way Altix, and something like the attached patch
seems to 'fix' the problem.

I didn't have time to find what's gone wrong tonight, but I'll get
to that tomorrow.

-- 
SUSE Labs, Novell Inc.


--------------090308050408040102080300
Content-Type: text/plain;
 name="sched-balance-self-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-balance-self-fix.patch"

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-06-08 00:01:53.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-06-08 00:02:47.000000000 +1000
@@ -1113,6 +1113,7 @@ static int sched_balance_self(int cpu, i
 		cpumask_t span;
 		struct sched_group *group;
 		int new_cpu;
+		int weight;
 
 		span = sd->span;
 		group = find_idlest_group(sd, t, cpu);
@@ -1127,8 +1128,9 @@ static int sched_balance_self(int cpu, i
 		cpu = new_cpu;
 nextlevel:
 		sd = NULL;
+		weight = cpus_weight(span);
 		for_each_domain(cpu, tmp) {
-			if (cpus_subset(span, tmp->span))
+			if (weight <= cpus_weight(tmp->span))
 				break;
 			if (tmp->flags & flag)
 				sd = tmp;

--------------090308050408040102080300--
Send instant messages to your online friends http://au.messenger.yahoo.com 
