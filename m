Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWB0WJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWB0WJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWB0WJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:09:38 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:31920 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751575AbWB0WJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:09:38 -0500
Date: Mon, 27 Feb 2006 17:09:27 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 5/7]  synchronous block I/O delays
In-reply-to: <p73fym428cf.fsf@verdi.suse.de>
To: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Message-id: <44037897.4050709@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141028448.5785.64.camel@elinux04.optonline.net>
 <p73fym428cf.fsf@verdi.suse.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Shailabh Nagar <nagar@watson.ibm.com> writes:
>
>  
>
>>delayacct-blkio.patch
>>
>>Record time spent by a task waiting for completion of 
>>userspace initiated synchronous block I/O. This can help
>>determine the right I/O priority for the task.
>>    
>>
>
>I think it's a good idea to have such a statistic by default.
>  
>
Besides the paths we're counting and the one's Arjan listed below, are 
there others
you had in mind ?

>Can you add a counter that is summed up in task_struct and reports
>in /proc/*/stat so that it could be displayed by top? 
>
>This way it would be useful even with "normal" user space.
>
>-Andi
>

Arjan van de Ven wrote:

>this misses O_SYNC, msync(), and general throttling.
>I get the feeling this is being measured at the wrong level
>currently.... since the number of entry points that needs measuring at
>the current level is hardly finite...
>  
>

Our intent was to get an idea of user-initiated sync block I/O because
there is some expectation from user space that a higher I/O priority will
result in lower delays for such I/O. General throttling writes wouldn't 
fit in
this category though msync and O_SYNC would.

Are there a lot of other paths you see ? I'll root around more but if you
could just list a few more, it'll help.

As for the level at which the counting is being done, the reason for
choosing this one was to avoid counting time spent waiting for async I/O
completion and also to keep the accounting simple (diff of two 
timestamps without
modifying block I/O structures).

To our usage model, async I/O is also not as useful to be counted since 
userspace has already
taken steps to tolerate the latency and can do useful work (and not be 
"delayed").
However, I would  have liked to capture the time spent within 
sys_io_getevents
when a timeout is specified, since there the user is again going to be 
delayed,
but the mingling of block and network I/O events makes that more complex.


Going further down the I/O processing stack than the current level would
probably require more elaborate mechanisms to keep track of the submitter ?
Or is there a better merging point for sync I/O that I'm missing ?

Your comments would be welcome to improve this code...

--Shailabh
P.S. Sorry if  merging the two responses violates any netiquette :-)

