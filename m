Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVI0GIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVI0GIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 02:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVI0GIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 02:08:13 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:34058 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S1750842AbVI0GIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 02:08:12 -0400
Message-ID: <4338E301.4090808@mrv.com>
Date: Tue, 27 Sep 2005 09:13:21 +0300
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-rt2
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
In-Reply-To: <20050926070210.GA5157@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000108070306050706040800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108070306050706040800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached 2 patches (against 2.6.14-rc2-rt3) seem to be required to 
compile dccp and nfnetlink (only compile-tested).

Ingo Molnar wrote:
> i have released the 2.6.14-rc2-rt2 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
...

--------------000108070306050706040800
Content-Type: text/x-patch;
 name="rt-netfilter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-netfilter.patch"

--- linux-2.6.x/net/netfilter/nfnetlink_queue.c	2005-09-13 10:48:26.000000000 +0300
+++ linux-2.6.x-RT/net/netfilter/nfnetlink_queue.c	2005-09-27 08:20:10.000000000 +0300
@@ -149,7 +149,7 @@
 	atomic_set(&inst->id_sequence, 0);
 	/* needs to be two, since we _put() after creation */
 	atomic_set(&inst->use, 2);
-	inst->lock = SPIN_LOCK_UNLOCKED;
+	inst->lock = SPIN_LOCK_UNLOCKED(inst->lock);
 	INIT_LIST_HEAD(&inst->queue_list);
 
 	if (!try_module_get(THIS_MODULE))
--- linux-2.6.x/net/netfilter/nfnetlink_log.c	2005-09-13 10:48:25.000000000 +0300
+++ linux-2.6.x-RT/net/netfilter/nfnetlink_log.c	2005-09-27 08:50:58.000000000 +0300
@@ -152,7 +152,7 @@
 
 	memset(inst, 0, sizeof(*inst));
 	INIT_HLIST_NODE(&inst->hlist);
-	inst->lock = SPIN_LOCK_UNLOCKED;
+	inst->lock = SPIN_LOCK_UNLOCKED(inst->lock);
 	/* needs to be two, since we _put() after creation */
 	atomic_set(&inst->use, 2);
 

--------------000108070306050706040800
Content-Type: text/x-patch;
 name="rt-dccp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-dccp.patch"

--- linux-2.6.x/net/dccp/ipv4.c	2005-09-25 15:49:57.000000000 +0300
+++ linux-2.6.x-RT/net/dccp/ipv4.c	2005-09-26 15:06:02.000000000 +0300
@@ -28,10 +28,10 @@
 #include "dccp.h"
 
 struct inet_hashinfo __cacheline_aligned dccp_hashinfo = {
-	.lhash_lock	= RW_LOCK_UNLOCKED,
+	.lhash_lock	= RW_LOCK_UNLOCKED(dccp_hashinfo.lhash_lock),
 	.lhash_users	= ATOMIC_INIT(0),
 	.lhash_wait = __WAIT_QUEUE_HEAD_INITIALIZER(dccp_hashinfo.lhash_wait),
-	.portalloc_lock	= SPIN_LOCK_UNLOCKED,
+	.portalloc_lock	= SPIN_LOCK_UNLOCKED(dccp_hashinfo.portalloc_lock),
 	.port_rover	= 1024 - 1,
 };
 
--- linux-2.6.x/net/dccp/minisocks.c	2005-09-25 15:49:57.000000000 +0300
+++ linux-2.6.x-RT/net/dccp/minisocks.c	2005-09-26 15:07:41.000000000 +0300
@@ -26,7 +26,7 @@
 struct inet_timewait_death_row dccp_death_row = {
 	.sysctl_max_tw_buckets = NR_FILE * 2,
 	.period		= DCCP_TIMEWAIT_LEN / INET_TWDR_TWKILL_SLOTS,
-	.death_lock	= SPIN_LOCK_UNLOCKED,
+	.death_lock	= SPIN_LOCK_UNLOCKED(dccp_death_row.death_lock),
 	.hashinfo	= &dccp_hashinfo,
 	.tw_timer	= TIMER_INITIALIZER(inet_twdr_hangman, 0,
 					    (unsigned long)&dccp_death_row),

--------------000108070306050706040800--
