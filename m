Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWJMGcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWJMGcG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJMGcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:32:05 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:29524 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751072AbWJMGcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:32:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=x1LRG+Pj9K03qTK/DNqpAZjKAb5pnBjJ5QREvofxsuQFlvBCO7MOxZG/uTEG2bz2UEoul93G3aXfp0bZUMZY9eBtGNwl8zLIc5f0V2OIqSogADkoKdGGxXizkqODa1YOWQpCgr/C02CW2EPr8ugQ96CIT7e3B+LCup5GYc09uzg=  ;
Message-ID: <452F32DF.5090608@yahoo.com.au>
Date: Fri, 13 Oct 2006 16:31:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] oom: don't kill unkillable children or siblings
References: <20061012120102.29671.31163.sendpatchset@linux.site>	<20061012120111.29671.83152.sendpatchset@linux.site> <20061012150050.ad6e1c8b.akpm@osdl.org>
In-Reply-To: <20061012150050.ad6e1c8b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 12 Oct 2006 16:09:43 +0200 (CEST)
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>Abort the kill if any of our threads have OOM_DISABLE set. Having this test
>>here also prevents any OOM_DISABLE child of the "selected" process from being
>>killed.
>>
>>Signed-off-by: Nick Piggin <npiggin@suse.de>
>>
>>Index: linux-2.6/mm/oom_kill.c
>>===================================================================
>>--- linux-2.6.orig/mm/oom_kill.c
>>+++ linux-2.6/mm/oom_kill.c
>>@@ -312,15 +312,24 @@ static int oom_kill_task(struct task_str
>> 	if (mm == NULL)
>> 		return 1;
>> 
>>+	/*
>>+	 * Don't kill the process if any threads are set to OOM_DISABLE
>>+	 */
>>+	do_each_thread(g, q) {
>>+		if (q->mm == mm && p->oomkilladj == OOM_DISABLE)
>>+			return 1;
>>+	} while_each_thread(g, q);
>>+
>> 	__oom_kill_task(p, message);
>>+
>> 	/*
>> 	 * kill all processes that share the ->mm (i.e. all threads),
>> 	 * but are in a different thread group
>> 	 */
>>-	do_each_thread(g, q)
>>+	do_each_thread(g, q) {
>> 		if (q->mm == mm && q->tgid != p->tgid)
>> 			__oom_kill_task(q, message);
>>-	while_each_thread(g, q);
>>+	} while_each_thread(g, q);
>> 
>> 	return 0;
>>
>
>One wonders whether OOM_DISABLE should be a property of the mm_struct, not
>of the task_struct.
>

Hmm... I don't think I could argue with that. I think this patch is needed
in the meantime though.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
