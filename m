Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUJMPaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUJMPaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUJMPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:30:14 -0400
Received: from blanca.radiantdata.com ([64.207.39.196]:41042 "EHLO
	blanca.peakdata.loc") by vger.kernel.org with ESMTP id S269146AbUJMP3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:29:46 -0400
Message-ID: <416D49FF.10003@radiantdata.com>
Date: Wed, 13 Oct 2004 09:30:07 -0600
From: "Peter W. Morreale" <morreale@radiantdata.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martijn Sipkema <martijn@entmoot.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: waiting on a condition
References: <02bb01c4b138$8a786f10$161b14ac@boromir>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2004 15:31:47.0578 (UTC) FILETIME=[C099E5A0:01C4B139]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you looked at the wait_event() family yet?       Adapting that 
methodolgy might
suit your needs.

I don't know much about preemption yet, however I suspect it would be a 
bug to allow
preemption while the spinlock was held.  In other words, you might need 
to do something like

disable preemption
spinlock
rc = condition
spin_unlock
enable preemption
if (rc)
...

In other words, perform the test on the condition outside of the 
critical region protected by the spin lock.

-PWM


Martijn Sipkema wrote:

>L.S.
>
>I'd like to do something similar as can be done using a POSIX condition
>variable in the kernel, i.e. wait for some condition to become true. The
>pthread_cond_wait() function allows atomically unlocking a mutex and
>waiting on a condition. I think I should do something like:
>(the condition is updated from an interrupt handler)
>
>disable interrupts
>acquire spinlock
>if condition not satisfied
>    add task to wait queue
>    set task to sleep
>release spinlock
>restore interrupts
>schedule
>
>Now, this will only work with preemption disabled within the critical
>section. How would something like this be done whith preemption
>enabled?
>
>
>--ms
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-- 
Peter W. Morreale                            email: morreale@radiantdata.com
Director of Engineering                      Niwot, Colorado, USA
Radiant Data Corporation                     voice: (303) 652-0870 x108 
-----------------------------------------------------------------------------
This transmission may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law. If you are not the
intended recipient, you are hereby notified that any disclosure, copying,
distribution, or use of the information contained herein (including any
reliance thereon) is STRICTLY PROHIBITED. If you received this transmission
in error, please immediately contact the sender and destroy the material in
its entirety, whether in electronic or hard copy format. Thank you.



