Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTKIKmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKIKmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:42:13 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:47551 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262331AbTKIKmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:42:08 -0500
Message-ID: <3FAE19C3.7060104@colorfullife.com>
Date: Sun, 09 Nov 2003 11:41:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: prepare_wait / finish_wait question
References: <3FAE0223.7070402@colorfullife.com> <20031109021943.470fc601.akpm@osdl.org>
In-Reply-To: <20031109021943.470fc601.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>Hi Ingo,
>>
>>sysv semaphores show the same problem you've fixed for wait queue with 
>>finish_wait:
>>    
>>
>
>Was me, actually.
>  
>
Ups, sorry.

>It would be neater to remove the task from the list _before_ waking it up. 
>The current code in there is careful to only remove the task if the wakeup
>attempt was successful, but I have a feeling that this is unnecessary - the
>waiting task will do the right thing.  One would need to think about that a
>bit more.
>  
>
Doesn't work: the woken up thread could be woken up by chance through a 
signal, and then the task structure could go out of scope while wake_up 
is still running - oops. Seen on s390 with sysv msg.

>>I wrote a patch for sysv sem and on a 4x Pentium 3, 99.9% of the calls 
>>hit the fast path, but I'm a bit afraid that monitor/mwait could be so 
>>fast that the fast path is not chosen.
>>    
>>
>
>Is it not the case that ia32's reschedule IPI is async?  If the
>architecture's reschedule uses a synchronous IPI then it could indeed be
>the case that the woken CPU gets there first.
>
poll_idle polls the need_resched flag, and next generation pentium 4 
cpus will poll the need_resched flag with the MONITOR/MWAIT 
instructions. We cannot rely on the async IPI.

>>I'm thinking about a two-stage algorithm - what's your opinion?
>>    
>>
>
>Instrumentation on other architectures would be interesting.
>  
>
The patch already contains the instrumentation - it only needs testing.

--
    Manfred

