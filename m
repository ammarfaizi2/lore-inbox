Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbTBPUNu>; Sun, 16 Feb 2003 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTBPUNu>; Sun, 16 Feb 2003 15:13:50 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:21183 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267452AbTBPUNs>;
	Sun, 16 Feb 2003 15:13:48 -0500
Message-ID: <3E4FF339.6080609@colorfullife.com>
Date: Sun, 16 Feb 2003 21:23:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
References: <Pine.LNX.4.44.0302161206540.2952-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302161206540.2952-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>What about this minimal patch? The performance critical operation is 
>>signal delivery - we should fix the synchronization between signal 
>>delivery and exec first.
>>    
>>
>
>The patch looks ok, although I'd also remove the locking and testing from
>collect_sigign_sigcatch() once it is done at a higher level.
>
>And yeah, what about signal delivery? Put back the same lock there?
>  
>
I don't know.
Taking read_lock(&tasklist_lock) for send_specific_sig_info might hurt 
scalability. Ingo?

If we do not want a global lock, then we have two options:
- make task_lock an interrupt spinlock.
- add a second spinlock to the task structure, for the signal stuff.

Design question - what's worse? Memory bloat or a few additional 
local_irq_{en,dis}able().
I don't care - no performance critical codepaths.
Additionally many task_lock()/task_unlock users could be replaced with 
spin_unlock_wait(&task->alloc_lock), which would not need the 
local_irq_disable().

--
    Manfred

