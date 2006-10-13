Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWJMGi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJMGi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJMGi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:38:27 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:393 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751179AbWJMGi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=S5jqbBqL1prwEXmnUDB/jSZ3Pzl3XTJp49p7/z+aeyJtSBuo3usILSSvv+nzy9YbJHonS8c+ZRNVSbpaEwLDuXBfXvEZtws4ZMg8GQLhrfe785XCv7ycLN57aqXu0/bpIge/xlLZ3IMjV3Nl50zI6y2/3zkYlDfH3ZCielUPXpk=  ;
Message-ID: <452F345E.3000301@yahoo.com.au>
Date: Fri, 13 Oct 2006 16:38:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/5] oom: less memdie
References: <20061012120102.29671.31163.sendpatchset@linux.site>	<20061012120129.29671.3288.sendpatchset@linux.site> <20061012150350.00f19d2a.akpm@osdl.org>
In-Reply-To: <20061012150350.00f19d2a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 12 Oct 2006 16:10:01 +0200 (CEST)
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>Don't cause all threads in all other thread groups to gain TIF_MEMDIE
>>otherwise we'll get a thundering herd eating out memory reserve. This
>>may not be the optimal scheme, but it fits our policy of allowing just
>>one TIF_MEMDIE in the system at once.
>>
>>Signed-off-by: Nick Piggin <npiggin@suse.de>
>>
>>Index: linux-2.6/mm/oom_kill.c
>>===================================================================
>>--- linux-2.6.orig/mm/oom_kill.c
>>+++ linux-2.6/mm/oom_kill.c
>>@@ -322,11 +322,12 @@ static int oom_kill_task(struct task_str
>> 
>> 	/*
>> 	 * kill all processes that share the ->mm (i.e. all threads),
>>-	 * but are in a different thread group.
>>+	 * but are in a different thread group. Don't let them have access
>>+	 * to memory reserves though, otherwise we might deplete all memory.
>> 	 */
>> 	do_each_thread(g, q) {
>> 		if (q->mm == mm && q->tgid != p->tgid)
>>-			__oom_kill_task(q, 1);
>>+			force_sig(SIGKILL, p);
>> 	} while_each_thread(g, q);
>> 
>>
>
>Curious.  How much testing did you do of this stuff?  I assume there were
>some observed problems.  What were they, and what was the observed effect
>of these changes?
>

This change I actually didn't really test because I don't have any apps 
to speak
of which use multiple thread groups.

I stumbled on it by inspection when trying to fix the killing of 
OOM_DISABLE tasks.
Basically -- we don't set TIF_MEMDIE or boost the priority of *any* 
other thread in
our same group, so we shouldn't do it for *all* other threds of all 
other groups.

Consider an OOM situation, where there will likely be a lot of threads 
stuck in
__alloc_pages. If a large number of these suddenly get a big timeslice 
and full
access to memory reserves, they'll eat into more than we'd like.

Now I'm not sure that our current OOM killing / memory reserving scheme is
perfect -- indeed if we only allow a single TIF_MEMDIE thread at once, 
we can
get deadlocks. However, that's the direction we've chosen, and it seems 
to work
reasonably well. Mostly.

This is just an enforcement of that policy rather than a change in 
direction.
Criticism is always welcome though.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
