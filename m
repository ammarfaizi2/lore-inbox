Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWIKHCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIKHCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIKHCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:02:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40250 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750703AbWIKHCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:02:02 -0400
Message-ID: <450509EE.9010809@openvz.org>
Date: Mon, 11 Sep 2006 11:02:06 +0400
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru>	 <1157478392.3186.26.camel@localhost.localdomain>  <44FED3CA.7000005@sw.ru>	 <1157579641.31893.26.camel@linuxchandra>  <44FFCA4D.9090202@openvz.org>	 <1157656616.19884.34.camel@linuxchandra>  <45011A47.1020407@openvz.org> <1157742442.19884.47.camel@linuxchandra>
In-Reply-To: <1157742442.19884.47.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Fri, 2006-09-08 at 11:22 +0400, Pavel Emelianov wrote:
>   
>> Chandra Seetharaman wrote:
>>
>> [snip]
>>     
>>>>>> The question is - whether web server is multithreaded or not...
>>>>>> If it is not - then no problem here, you can change current
>>>>>> context and new resources will be charged accordingly.
>>>>>>
>>>>>> And current BC code is _able_ to handle it with _minor_ changes.
>>>>>> (One just need to save bc not on mm struct, but rather on vma struct
>>>>>> and change mm->bc on set_bc_id()).
>>>>>>
>>>>>> However, no one (can some one from CKRM team please?) explained so far
>>>>>> what to do with threads. Consider the following example.
>>>>>>
>>>>>> 1. Threaded web server spawns a child to serve a client.
>>>>>> 2. child thread touches some pages and they are charged to child BC
>>>>>>    (which differs from parent's one)
>>>>>> 3. child exits, but since its mm is shared with parent, these pages
>>>>>>    stay mapped and charged to child BC.
>>>>>>
>>>>>> So the question is:  what to do with these pages?
>>>>>> - should we recharge them to another BC?
>>>>>> - leave them charged?
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> Leave them charged. It will be charged to the appropriate UBC when they
>>>>> touch it again.
>>>>>   
>>>>>       
>>>>>           
>>>> Do you mean that page must be re-charged each time someone touches it?
>>>>     
>>>>         
>>> What I meant is that to leave them charged, and if when they are
>>> ummapped and mapped later, charge it to the appropriate BC.
>>>   
>>>       
>> In this case multithreaded apache that tries to serve each domain in
>> separate BC will fill the memory with BC-s, held by pages allocated
>> and mapped in threads.
>>     
>
> I do not understand how the memory will be filled with BCs. Can you
> explain, please.
>   
Sure. At the beginning I have one task with one BC. Then
1. A thread is spawned and new BC is created;
2. New thread touches a new page (e.g. maps a new file) which is charged
to new BC
    (and this means that this BC's must stay in memory till page is
uncharged);
3. Thread exits after serving the request, but since it's mm is shared
with parent
    all the touched pages stay resident and, thus, the new BC is still
pinned in memory.
Steps 1-3 are done multiple times for new pages (new files).
Remember that we're discussing the case when pages are not recharged.
