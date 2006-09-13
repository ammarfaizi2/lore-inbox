Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWIMNGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWIMNGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIMNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:06:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:60560 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750791AbWIMNGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:06:47 -0400
Message-ID: <45080262.8050009@watson.ibm.com>
Date: Wed, 13 Sep 2006 09:06:42 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gatech.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com> <1158151535.2560.20.camel@localhost>
In-Reply-To: <1158151535.2560.20.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Wed, 2006-09-13 at 08:06 -0400, Hubertus Franke wrote:
> 
>>Martin Schwidefsky wrote:
>>
>>>On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
>>>
>>>
>>>>Note that the transition _to_ volatile can also be batched
>>>>and done somewhat lazily.  For frequently mmaped pages that
>>>>could end up saving us the transition the other way, too...
>>>
>>>
>>>That would be helpful, only how to do it? We need some sort of list or
>>>array where to store the pages that should be made volatile. The main
>>>problem that I see is that you have to remove a page that is freed from
>>>the list/array again, otherwise you would end up with a non page-cache
>>>page being made volatile. That makes using per-cpu arrays hard since a
>>>page can be freed on another cpu.
>>>
>>
>>
>>Martin. the point was that pages
>>which are in the hold/cold lists are technically free.
>>However we keep them stable.
>>When the hot/cold list is spilled back to the buddy allocator
>>we make them volatile in buld (i.e. through the array).
> 
> 
> You mean unused.

Yes ...
> 
> 
>>So we only build the array for the duration of the bulk-release
>>to the buddy allocator (and potentially the other way as well).
>>Hence there is no "state" to maintain or track for the array.
>>Pages in the hot/cold lists remain stable.
>>This would not any of the problems you described as long as we hold
>>the lock for the hot/cold list during buld-volatile.
> 
> 
> I was not talking about free pages, and I don't think Rik was either.
> The idea is to be lazy about the make-volatile calls. Put the pages for
> which a make-volatile call should be done to some array/list and do a
> bulk make-volatile. These pages are still in the page/swap cache. The
> trouble is we have to be sure these pages have not been freed in the
> meantime.

Reread Rik's message. First message is about freeing pages.
Second is about "to-volatile".
I agree with you that if we batch "to-volatile" we need to keep
state, which does seem to have the problem you describe.

On the fly design thoughts ..
Let's assume we want to keep in the order of 1K pages to batch.
If we hash the pages that are made logically volatile but have not been
submitted yet, then on free_page we check whether the page is hashed
and if so remove it from the hashtable.
If the hashtable fills up we commit.
The hashtable is global or node specific (can't be per-cpu as you pointed
out).
This can be done reasonable efficient.
But another trouble you have not mentioned is what happens to pages with pending
make-volatile that need to and/or have been made stable in the meantime. They
too need to be removed from this pending list.

-- Hubertus
> 
> The bulk set-unused/set-stable to the buddy allocator should not be to
> problematic. We just have to find new places where to do the calls.
> 


