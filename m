Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWHYGUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWHYGUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWHYGUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:20:05 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:29089 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964809AbWHYGUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:20:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=imr+pUs+qENlxKNzlgUeNS502PX1Obcw3XnQ6VYLHOq1TufZrubL3hBEBiJro+HvAJSEBpb0l5iAgtMfpm+gY8+osZDt4Lt0dkmR4kxK9gZpdJ7V+CuUuPOSsuCTEDQwbNOU5eLebX83dPHocJXxL4FP6oDex/U0apF9zbUoNZE=  ;
Message-ID: <44EE9671.7010804@yahoo.com.au>
Date: Fri, 25 Aug 2006 16:19:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: ego@in.ibm.com
CC: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, davej@redhat.com,
       dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug
 "locking"
References: <20060824103233.GD2395@in.ibm.com> <20060824111440.GA19248@elte.hu> <20060824122808.GH2395@in.ibm.com> <20060824122527.GA28275@elte.hu> <20060824125813.GE25452@in.ibm.com> <20060825060425.GB6322@in.ibm.com>
In-Reply-To: <20060825060425.GB6322@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy wrote:
> On Thu, Aug 24, 2006 at 06:28:14PM +0530, Srivatsa Vaddagiri wrote:
> 
>>On Thu, Aug 24, 2006 at 02:25:27PM +0200, Ingo Molnar wrote:
>>
>>>no. The writer first sets the global write_active flag, and _then_ goes 
>>>on to wait for all readers (if any) to get out of their critical 
>>>sections. (That's the purpose of the per-cpu waitqueue that readers use 
>>>to wake up a writer waiting for the refcount to go to 0.)
>>>
>>>can you still see problems with this scheme?
>>
>>This can cause a deadlock sometimes, when a thread tries to take the
>>read_lock() recursively, with a writer having come in between the two
>>recursive reads:
>>
>>	Reader1 on CPU0			Writer1 on CPU1
>>
>>	read_lock() - success
>>
>>					write_lock() - blocks on Reader1
>>						  (writer_active = 1)
>>
>>
>>	read_lock() - blocks on Writer1
>>
>>The only way to avoid this deadlock is to either keep track of
>>cpu_hp_lock_count per-task (like the preemption count kept per-task)
>>or allow read_lock() to succeed if reader_count > 1 (even if
>>writer_active = 1). The later makes the lock unduely biased towards
>>readers.
> 
> 
> The reason why recursive read side locking works in the patches I posted, is 
> the fact that the _locking_is_unfair_. Which means even when a writer is 
> waiting, if there are readers in the system,a new reader will go ahead.
> 
> I can try incorporating this unfair model to Ingo's  suggestion 
> as follows:
> - A writer on arrival sets the global flag to writer_waiting.
> - A reader on cpuX checks if global flag = writer_waiting. If yes,
> and percpu(refcount) == 0, the reader blocks. if percpu(refcount)!=0,
> the reader increments it and goes ahead,because there are readers 
> in the system.
> 
> This should work, if not for task migration. It may so happen that
> a task has already taken a read lock on cpuX, gets migrated to cpuY
> where percpu(refcount) = 0. Now a writer arrives, sets the global flag.
> The reader tries taking a recursive read lock gets blocked since
> percpu(refcount) on cpuY is 0. 

This could easily block hotplug forever though, if you have lots of
tasks in the system.

> 
> Ingo, I am wondering if lockdep would be of some help here.
> Since lockdep already checks for recursive reads, can I use it in
> the above case and allow the new reader only if it is recursive?
> I don't like the idea of explicitly checking for recursiveness
> in the locking schema. Just that I can't think of a better way now.

Well you would just have a depth count in the task_struct... in fact that
could *be* the read lock (ie. writer traverses all tasks instead of all
CPU locks), and would save a cacheline in the read path...

But I think the point was that we didn't want to add yet another field
to task_struct. Maybe it is acceptable... one day it will be like
page_flags though ;)


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
