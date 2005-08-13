Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVHMG2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVHMG2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 02:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVHMG2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 02:28:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23057 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751305AbVHMG2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 02:28:02 -0400
Message-ID: <42FD92E5.4020407@vmware.com>
Date: Fri, 12 Aug 2005 23:27:49 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] eliminte NMI entry/ exit code
References: <42FD42C1.6040009@mvista.com> <42FD4548.3060204@yahoo.com.au> <42FD4942.8050407@mvista.com>
In-Reply-To: <42FD4942.8050407@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Aug 2005 06:27:50.0468 (UTC) FILETIME=[20F22040:01C59FD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:

> Nick Piggin wrote:
>
>> George Anzinger wrote:
>>
>>> The NMI entry and exit code fiddles with bits in the preempt count.  
>>> If an NMI happens while some other code is doing the same, bits will 
>>> be lost.  This patch removes this modify code from the NMI path till 
>>> we can come up with something better.
>>>
>>
>> Humour me for a minute here...
>> NMI restores preempt_count back to its old value upon exit, right?
>> So what does a race case look like?
>
>
> Normal code                   NMI
> fetch preempt_count
> add                   <-----  interrupt here add and store then 
> subtract and store, darn!
> store preempt_count
>
> Ok, no problem.
>
> The problem is in the RT code when PREEMPT_DEBUG is on.  The tests for 
> reasonable counts fail because of the rather undefined state when NMI 
> picks up the word.  The failure is on the NMI side... 


So NMI changing the preempt count and restoring in the middle of a RWM 
is not the problem.  Thus I don't understand what the issue is.  NMI 
must undo all side effects.  Does the PREEMPT_DEBUG code check the count 
somewhere within the NMI handler?  If so, shouldn't the proper fix be to 
make that code aware that it could be running inside of an NMI and/or 
ensure that code is not called from within the NMI handler?

Zach
