Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbSJXNBu>; Thu, 24 Oct 2002 09:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSJXNBu>; Thu, 24 Oct 2002 09:01:50 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:46100 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265438AbSJXNBs>;
	Thu, 24 Oct 2002 09:01:48 -0400
Message-ID: <3DB7F0C6.5020408@mvista.com>
Date: Thu, 24 Oct 2002 08:08:22 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 4
References: <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024022026.D27739@dikhow> <3DB71A5E.5010907@mvista.com> <20021024131103.E27739@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Wed, Oct 23, 2002 at 04:53:34PM -0500, Corey Minyard wrote:
>  
>
>>>After local_irq_count() went away, the idle CPU check was broken
>>>and that meant that if you had an idle CPU, it could hold up RCU
>>>grace period completion.
>>>
>>Ah, much better.  That seems to fix it.
>>    
>>
>Great! Do you have any latency numbers ? Just curious.
>
Unfortunately not.  3 seconds is well within the realm of human 
observation with printk.

>>>It might just be simpler to use completions instead -
>>>
>>>	call_rcu(&(handler->rcu), free_nmi_handler, handler);
>>>	init_completion(&handler->completion);
>>>	spin_unlock_irqrestore(&nmi_handler_lock, flags);
>>>	wait_for_completion(&handler->completion);
>>>
>>>and do
>>>
>>>	complete(&handler->completion);
>>>
>>>in the  the RCU callback.
>>>
>>>      
>>>
>>I was working under the assumption that the spinlocks were needed.  But 
>>now I see that there are spinlocks in wait_for_completion.  You did get 
>>init_completion() and call_rcu() backwards, they would need to be the 
>>opposite order, I think.
>>    
>>
>
>AFAICS, the ordering of call_rcu() and init_completion should not matter
>because the CPU that is executing them would not have gone
>through a quiescent state and thus the RCU callback cannot happen.
>Only after a context swtich in wait_for_completion(), the callback
>is possible.
>
Yes, I think you are right.  I'm still not used to the RCUs :-).

-Corey


