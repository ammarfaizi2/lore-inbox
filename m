Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWIGH3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWIGH3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 03:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIGH3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 03:29:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:16501 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750945AbWIGH3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 03:29:18 -0400
Message-ID: <44FFCA4D.9090202@openvz.org>
Date: Thu, 07 Sep 2006 11:29:17 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru>	 <1157478392.3186.26.camel@localhost.localdomain>  <44FED3CA.7000005@sw.ru> <1157579641.31893.26.camel@linuxchandra>
In-Reply-To: <1157579641.31893.26.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:

[snip]
>>> Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?
>>>       
>> no. no new interfaces are required.
>>     
>
> Good to know that. 
>
> Your CPU controller supports guarantee ?
>   
It does, but CPU controller is not so simple as memory one.
> Do you have a i/o controller ?
>
>   
>> BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
>> It was noted that having a separate interfaces for CPU, I/O bandwidth
>>     
>
> But, it will be lot simpler for the user to configure/use if they are
> together. We should discuss this also.
>   
IMHO such unification may only imply that one syscall is used to pass
configuration info into kernel.
Each controller has specific configurating parameters different from the
other ones. E.g. CPU controller must assign a "weight" to each group to
share CPU time accordingly, but what is a "weight" for memory controller?
IO may operate on "bandwidth" and it's not clear what is a "bandwidth" in
Kb/sec for CPU controller and so on.

[snip]
>> The question is - whether web server is multithreaded or not...
>> If it is not - then no problem here, you can change current
>> context and new resources will be charged accordingly.
>>
>> And current BC code is _able_ to handle it with _minor_ changes.
>> (One just need to save bc not on mm struct, but rather on vma struct
>> and change mm->bc on set_bc_id()).
>>
>> However, no one (can some one from CKRM team please?) explained so far
>> what to do with threads. Consider the following example.
>>
>> 1. Threaded web server spawns a child to serve a client.
>> 2. child thread touches some pages and they are charged to child BC
>>    (which differs from parent's one)
>> 3. child exits, but since its mm is shared with parent, these pages
>>    stay mapped and charged to child BC.
>>
>> So the question is:  what to do with these pages?
>> - should we recharge them to another BC?
>> - leave them charged?
>>     
>
> Leave them charged. It will be charged to the appropriate UBC when they
> touch it again.
>   
Do you mean that page must be re-charged each time someone touches it?
