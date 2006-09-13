Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWIMNff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWIMNff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWIMNff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:35:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:10337 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750798AbWIMNfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:35:34 -0400
Message-ID: <45080922.5060901@openvz.org>
Date: Wed, 13 Sep 2006 17:35:30 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: sekharan@us.ibm.com, balbir@in.ibm.com, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <45011CAC.2040502@openvz.org> <1157730221.26324.52.camel@localhost.localdomain> <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org> <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org> <1158000590.6029.33.camel@linuxchandra> <45069072.4010007@openvz.org> <1158105488.4800.23.camel@linuxchandra> <4507BC11.6080203@openvz.org> <20060913121525.GC7543@in.ibm.com>
In-Reply-To: <20060913121525.GC7543@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Wed, Sep 13, 2006 at 12:06:41PM +0400, Pavel Emelianov wrote:
>> OK. Then limiting must be done this way (unreclaimable limit/total limit)
>> A (15/40)
>> B (25/100)
>> C (35/100)
>
> s/35/30?
Hmmm... No, it must be 35. It IS higher than guarantee you proposed,
but that's OK to have a limit higher than guarantee, isn't it?
>
> Also the different b/n total and unreclaimable limits goes towards
> limiting reclaimable memory i suppose? And 1st limit seems to be a
> hard-limit while the 2nd one is soft?
The first limit (let's call it soft one) is limit for unreclaimable
memory, the second (hard limit) - for booth reclaimable and not.

The ploicy is
1. if BC tries to *mmap()* unreclaimable region (e.g. w/o backed
   file as moving page to swap is not a pure "reclamation") then
   check the soft limit and prohibit mapping in case it is hit;
2. if BC tries to *touch* a page - then check for the hard limit
   and start reclaiming this BC's pages if the limit is hit.

That's how guarantees can be met. Current BC code does perform the
first check and gives you all the levers for the second one - just
the patch(es) with reclamation mechanism is required.
>
>> D (10/100)
>> E (20/50)
>> In this case each group will receive it's guarantee for sure.
>>
>> E.g. even if A, B, E and D will eat all it's unreclaimable memory then
>> we'll have
>> 100 - 15 - 25 - 20 - 10 = 30% of memory left (maybe after reclaiming) which
>> is perfectly enough for C's guarantee.
>
> I agree by carefully choosing these limits, we can provide some sort of
> QoS, which is a good step to begin with.
Sure. As I've said - soft limiting is already done with BC patches, the
hard one is not prohibited by BC (BCs even prepare a good pad for it).
When reclaiming is done we'll have a hard limit described above.

