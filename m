Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTJWRCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTJWRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:02:25 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:17826 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S263633AbTJWRCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:02:22 -0400
Date: Thu, 23 Oct 2003 13:00:57 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-reply-to: <Pine.LNX.4.44.0310232127520.2983-100000@raven.themaw.net>
To: Ian Kent <raven@themaw.net>
Cc: Ingo Oeser <ioe-lkml@rameria.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3F980949.1040201@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618
 Debian/1.3.1-3
References: <Pine.LNX.4.44.0310232127520.2983-100000@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:

>On Wed, 15 Oct 2003, Ingo Oeser wrote:
>  
>
>>In your patch you allocate inside the spinlock.
>>    
>>
>
>Do you mean we don't want to sleep under the spin lock?
>Would a GFP_ATOMIC make a difference to the analysis?
>  
>
Yes, sleeping within a spinlock is bad practice because it may 
eventually deadlock.  Pretend that the lock is taken, the call to 
kmalloc is made, the mm system doesn't have any immidiately free memory 
and through some flow of execution requires that a some pseudo-block 
device backed filesystem needs to be mounted -> deadlock.  I have no 
idea if this is currently a likely scenario, however not sleeping within 
a lock is 'The Right Thing' and should be avoided at all costs. 

GFP_ATOMIC should be avoided in most circumstances, particularly in 
environments where the code can be refactored to allow for the sleep.  
It is less likely to find free memory atomically and is thus more likely 
to fail.

>>I would suggest to do sth. like the following:
>>
>>void *local;
>>if (!unamed_dev_inuse) {
>>    local = get_zeroed_page(GFP_KERNEL);
>>
>>    if (!local) 
>>        return -ENOMEM;
>>}
>>
>>spinlock(&unamed_dev_lock);
>>mb();
>>if (!unamed_dev_inuse) {
>>    unamed_dev_inuse = local;
>>
>>    /* Used globally, don't free now */
>>    local = NULL;
>>}
>>
>>/* 
>>  Do the lookup and alloc
>> */
>>
>>spinunlock(&unamed_dev_lock);
>>
>>/* Free page, because of race on allocation. */
>>if (local) 
>>    free_page(local);
>>
>>
>>Which will swap the pointers atomically and still alloc outside the
>>non-sleeping locking.
>>    
>>
>
>As I said please give me a hint about your thinking here.
>And the use of a memory barrier as well ... umm?
>
>  
>

Ingo's patch simply moved the allocation outside the spinlock..  See my 
later patch about moving the allocation to and __init section, which is 
probably the cleaner thing to do and doesn't require grabbing the page 
and using it conditionally.

As for the mb(), I *thought* that a spinlock implied a memory barrier, 
however I think he put it there because it solves the age-old badness of 
double-checked locking (search google for good explanations of the badness).

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


