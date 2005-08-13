Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVHMQ44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHMQ44 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVHMQ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:56:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37880 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932212AbVHMQ4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:56:54 -0400
Message-ID: <42FE25C9.6000805@mvista.com>
Date: Sat, 13 Aug 2005 09:54:33 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] eliminte NMI entry/ exit code
References: <42FD42C1.6040009@mvista.com> <42FD4548.3060204@yahoo.com.au> <42FD4942.8050407@mvista.com> <42FD92E5.4020407@vmware.com>
In-Reply-To: <42FD92E5.4020407@vmware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> George Anzinger wrote:
> 
>> Nick Piggin wrote:
>>
>>> George Anzinger wrote:
>>>
>>>> The NMI entry and exit code fiddles with bits in the preempt count.  
>>>> If an NMI happens while some other code is doing the same, bits will 
>>>> be lost.  This patch removes this modify code from the NMI path till 
>>>> we can come up with something better.
>>>>
>>>
>>> Humour me for a minute here...
>>> NMI restores preempt_count back to its old value upon exit, right?
>>> So what does a race case look like?
>>
>>
>>
>> Normal code                   NMI
>> fetch preempt_count
>> add                   <-----  interrupt here add and store then 
>> subtract and store, darn!
>> store preempt_count
>>
>> Ok, no problem.
>>
>> The problem is in the RT code when PREEMPT_DEBUG is on.  The tests for 
>> reasonable counts fail because of the rather undefined state when NMI 
>> picks up the word.  The failure is on the NMI side... 
> 
> 
> 
> So NMI changing the preempt count and restoring in the middle of a RWM 
> is not the problem.  Thus I don't understand what the issue is.  NMI 
> must undo all side effects.  Does the PREEMPT_DEBUG code check the count 
> somewhere within the NMI handler?  If so, shouldn't the proper fix be to 
> make that code aware that it could be running inside of an NMI and/or 
> ensure that code is not called from within the NMI handler?

Yes that is the problem.  The sanity check in PREEMPT_DEBUG fails when 
called from the NMI handler.
> 


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
