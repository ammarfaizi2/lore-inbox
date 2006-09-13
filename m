Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWIMMGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIMMGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 08:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWIMMGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 08:06:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12437 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750704AbWIMMGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 08:06:51 -0400
Message-ID: <4507F453.1040809@watson.ibm.com>
Date: Wed, 13 Sep 2006 08:06:43 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gateh.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com> <1158137786.2560.3.camel@localhost>
In-Reply-To: <1158137786.2560.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> 
>>Note that the transition _to_ volatile can also be batched
>>and done somewhat lazily.  For frequently mmaped pages that
>>could end up saving us the transition the other way, too...
> 
> 
> That would be helpful, only how to do it? We need some sort of list or
> array where to store the pages that should be made volatile. The main
> problem that I see is that you have to remove a page that is freed from
> the list/array again, otherwise you would end up with a non page-cache
> page being made volatile. That makes using per-cpu arrays hard since a
> page can be freed on another cpu.
> 


Martin. the point was that pages
which are in the hold/cold lists are technically free.
However we keep them stable.
When the hot/cold list is spilled back to the buddy allocator
we make them volatile in buld (i.e. through the array).
So we only build the array for the duration of the bulk-release
to the buddy allocator (and potentially the other way as well).
Hence there is no "state" to maintain or track for the array.
Pages in the hot/cold lists remain stable.
This would not any of the problems you described as long as we hold
the lock for the hot/cold list during buld-volatile.

I know we did this once. I think we "discarded" the idea
in order to have as many pages volatile as possible.

But this design should be quite easily added and the architecture
can choose whether to be aggressive about this or do it in bulk.

-- Hubertus

