Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSLaJXc>; Tue, 31 Dec 2002 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLaJXc>; Tue, 31 Dec 2002 04:23:32 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:10926 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262807AbSLaJXb>;
	Tue, 31 Dec 2002 04:23:31 -0500
Message-ID: <3E116407.6040802@colorfullife.com>
Date: Tue, 31 Dec 2002 10:31:51 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
Subject: Re: question on context of kfree_skb()
References: <3E10C991.4060807@colorfullife.com> <200212310157.06624.oliver@neukum.name>
In-Reply-To: <200212310157.06624.oliver@neukum.name>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>Am Montag, 30. Dezember 2002 23:32 schrieb Manfred Spraul:
>  
>
>>Mulix wrote:
>>    
>>
>>>dev_kfree_skb_any() should be called when you could be either
>>>executing in interrupt context or not.
>>>      
>>>
>>dev_kfree_skb_any() can misdetect the context: You must not use the
>>function if you hold an irq spinlock and you might be running from BH or
>>process context.
>>    
>>
>
>What then shall be used under these circumstances ?
>Could you perhaps summarise the issue ?
>  
>
When a packet is freed, the upper layers must be notified, for example a 
user space process could be waiting for socket buffer space. This can 
happen either immediately, or in the next softirq.

dev_kfree_skb_irq() is always ok, although slower than the other 
functions. The packet is unconditionally queued and processed later.
dev_kfree_skb_any() tries to optimize it a bit: If it thinks that it's 
save to process it now, then the packet is processed immediately. The 
autodetection is usually correct, except for the special case I 
mentioned. Drivers must work around that.
dev_kfree_skb() always processes the packet immediately. Only permitted 
from bottom half context or from process context.

--
    Manfred

