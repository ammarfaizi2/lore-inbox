Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWAYTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWAYTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWAYTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:36:16 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:7955 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932140AbWAYTgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:36:15 -0500
Message-ID: <43D7D234.6060005@symas.com>
Date: Wed, 25 Jan 2006 11:32:04 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <43D7CAAB.9070008@yahoo.com.au>
In-Reply-To: <43D7CAAB.9070008@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Howard Chu wrote:
>> The SUSv3 text seems pretty clear. It says "WHEN 
>> pthread_mutex_unlock() is called, ... the scheduling policy SHALL 
>> decide ..." It doesn't say MAY, and it doesn't say "some undefined 
>> time after the call." There is nothing optional or 
>> implementation-defined here. The only thing that is not explicitly 
>> stated is what happens when there are no waiting threads; in that 
>> case obviously the running thread can continue running.
>>
>
> But it doesn't say the unlocking thread must yield to the new mutex
> owner, only that the scheduling policy shall determine the which
> thread aquires the lock.

True, the unlocking thread doesn't have to yield to the new mutex owner 
as a direct consequence of the unlock. But logically, if the unlocking 
thread subsequently calls mutex_lock, it must block, because some other 
thread has already been assigned ownership of the mutex.

> It doesn't say that decision must be made immediately, either (eg.
> it could be made as a by product of which contender is chosen to run
> next).

A straightforward reading of the language here says the decision happens 
"when pthread_mutex_unlock() is called" and not at any later time. There 
is nothing here to support your interpretation.
>
> I think the intention of the wording is that for deterministic policies,
> it is clear that the waiting threads are actually worken and reevaluated
> for scheduling. In the case of SCHED_OTHER, it means basically nothing,
> considering the scheduling policy is arbitrary.
>
Clearly the point is that one of the waiting threads is waken and gets 
the mutex, and it doesn't matter which thread is chosen. I.e., whatever 
thread the scheduling policy chooses. The fact that SCHED_OTHER can 
choose arbitrarily is immaterial, it still can only choose one of the 
waiting threads.

The fact that SCHED_OTHER's scheduling behavior is undefined is not free 
license to implement whatever you want. Scheduling policies are an 
optional feature; the basic thread behavior must still be consistent 
even on systems that don't implement scheduling policies.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

