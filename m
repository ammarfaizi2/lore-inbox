Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWFBHxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWFBHxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFBHxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:53:21 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:24942 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751296AbWFBHxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:53:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=gUDH/LyMSGblImpSuLKNHu+hBZQnGi7jvx6QBzELjCQ5bw31YFS0W6KBiv5p3neN7V6EJRKVeFg0S0hLUHUq/H1U61T1e8FH1Q9RpvepkcN3iRJP1I1HDUs3DeQryAo3RPOx91qZXmAEEYT5Itrl9jCkX5bSqDQHKBSYgyFlB0M=  ;
Message-ID: <447FEE6C.7000408@yahoo.com.au>
Date: Fri, 02 Jun 2006 17:53:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021355.23671.kernel@kolivas.org> <447FBC28.8030401@yahoo.com.au> <200606021608.33928.kernel@kolivas.org>
In-Reply-To: <200606021608.33928.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------090300010002000708070108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300010002000708070108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:

>>Nice to acknowledge Chris's idea for 
>>trylocks in your changelog when you submit a final patch.
> 
> 
> I absolutely would and I would ask for him to sign off on it as well, once we 
> agreed on a final form.

No worries, I thought you would ;)

This is a small micro-optimisation / cleanup we can do after
smtnice gets converted to use trylocks. Might result in a little
less cacheline footprint in some cases.

-- 
SUSE Labs, Novell Inc.

--------------090300010002000708070108
Content-Type: text/plain;
 name="sched-lock-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-lock-opt.patch"

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2006-06-02 17:46:23.000000000 +1000
+++ linux-2.6/kernel/sched.c	2006-06-02 17:48:50.000000000 +1000
@@ -239,7 +239,6 @@ struct runqueue {
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
-	int cpu;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -1700,7 +1699,7 @@ static void double_rq_lock(runqueue_t *r
 		spin_lock(&rq1->lock);
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1736,7 +1735,7 @@ static void double_lock_balance(runqueue
 	__acquires(this_rq->lock)
 {
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest->cpu < this_rq->cpu) {
+		if (busiest < this_rq) {
 			spin_unlock(&this_rq->lock);
 			spin_lock(&busiest->lock);
 			spin_lock(&this_rq->lock);
@@ -6104,7 +6103,6 @@ void __init sched_init(void)
 		rq->push_cpu = 0;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
-		rq->cpu = i;
 #endif
 		atomic_set(&rq->nr_iowait, 0);
 

--------------090300010002000708070108--
Send instant messages to your online friends http://au.messenger.yahoo.com 
